:- dynamic game/3. % game(where, count, field)

:- include('pole.pl').
:- include('pravidla.pl').
:- include('help.pl').

% pohyb([X, Y], H) -> move to [X, Y] position as player H (o or x)
pohyb(S, H) :- pohyb(S, H, "Manual").
pohyb(S, H, P) :- 
    map(X),
    retract(s(S, ' ')), assert(s(S, H)), nl,
    spoj_text(['(', P, ')'], PF), swrite(['Move to', S, PF]), nl, 
    assert(krok(S, H, X)),
    test_vyhra(H), nl, 
    vypis_pole(), !.

% reset([X, Y]) -> reset coordinate to empty
reset(S) :-
    retract(s(S, _)), assert(s(S, ' ')), nl, 
    swrite(['Reset coordinate on', S]), nl, 
    vypis_pole(), !.

% test_vyhra(player) -> test if player wins
test_vyhra(P) :- 
    s(S1, P), vyherni_kombinace(_, S1, S2, S3, S4, S5), 
    s(S2, P), s(S3, P), s(S4, P), s(S5, P),
    swrite(['Player', P, 'wins on', [S1, S2, S3, S4, S5]]), nl,
    eviduj_hru(P).
test_vyhra(_).

% eviduj_hru(player)
eviduj_hru(x) :- 
    findall([S, F], krok(S, x, F), LK),
    uloz_hru(LK).
eviduj_hru(o) :-
    findall([S, F], krok(S, o, F), LK),
    nahrad(LK, LK1), uloz_hru(LK1).

uloz_hru([]).
uloz_hru([[S, P]|LK]) :- % game exists
    game(S, N, P), N1 is N + 1,
    retract(game(S, N, P)), assert(game(S, N1, P)),
    uloz_hru(LK).
uloz_hru([[S, P]|LK]) :- % game not exists
    not(game(S, _, P)), assert(game(S, 1, P)),
    uloz_hru(LK).

nahrad([], []).
nahrad([[S, P]|LK], [[S, P1]|LKN]) :- nahrad1(P, P1), nahrad(LK, LKN).

nahrad1([], []).
nahrad1([[S, o]|LK], [[S, x]|LKN]) :- nahrad1(LK, LKN).
nahrad1([[S, x]|LK], [[S, o]|LKN]) :- nahrad1(LK, LKN).
nahrad1([[S, H]|LK], [[S, H]|LKN]) :- nahrad1(LK, LKN).

% ============= Hierarchical rules =============

compute :- prav_5x().
compute :- prav_kriz().
compute :- prav_3x().
compute :- prav_nahodne(x).