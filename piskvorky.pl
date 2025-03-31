:- include('pole.pl').
:- include('pravidla.pl').
:- include('help.pl').

% pohyb([X, Y], H) -> move to [X, Y] position as player H (o or x)
pohyb(S, H) :- pohyb(S, H, "Manual").
pohyb(S, H, P) :- 
    retract(s(S, ' ')), assert(s(S, H)), nl,
    spoj_text(['(', P, ')'], PF), swrite(['Pohyb na', S, PF]), nl, 
    test_vyhra(H), nl, 
    vypis_pole(), !.

% reset([X, Y]) -> reset coordinate to empty
reset(S) :-
    retract(s(S, _)), assert(s(S, ' ')), nl, 
    swrite(['Reset coordinate on', S]), nl, 
    vypis_pole(), !.

% test_vyhra(player) -> test if player wins
test_vyhra(H) :- 
    s(S1, H), vyherni_kombinace(_, S1, S2, S3, S4, S5), 
    s(S2, H), s(S3, H), s(S4, H), s(S5, H),
    swrite(['Player', H, 'wins on', [S1, S2, S3, S4, S5]]), nl.
test_vyhra(_).

% ============= Hierarchical rules =============

% Complete row of five
compute :- prav_dopln_5xA(x).
compute :- prav_dopln_5xB(x).
compute :- prav_dopln_5xC(x).
compute :- prav_dopln_5xD(x).
compute :- prav_dopln_5xE(x).

% Cross
compute :- prav_kriz(x).

% Random move
compute :- prav_nahodne(x).