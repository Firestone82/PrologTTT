:- include('pole.pl').
:- include('pravidla.pl').
:- include('help.pl').

% tah(X, Y) -> make a move on X, Y position
% player - O, computer - X
tah(X, Y) :- s([X, Y], ' '), pohyb([X, Y], o), !.
tah(_, _) :- write('Nelze provest tah!'), nl.

% pohyb([X, Y], H) -> move to [X, Y] position as player H (o or x)
pohyb(S, H) :- pohyb(S, H, "Manual").
pohyb(S, H, P) :- 
    retract(s(S, ' ')), assert(s(S, H)), nl,
    concat(['(', P, ')'], PF), swrite(['Pohyb na', S, PF]), nl, 
    test_win(H), nl, 
    vypis_pole, !.

% reset([X, Y]) -> reset coordinate to empty
reset(S) :-
    retract(s(S, _)), assert(s(S, ' ')), nl, 
    swrite(['Reset coordinate on', S]), nl, 
    vypis_pole, !.

% test_win(player) -> test if player wins
test_win(H) :- 
    s(S1, H), win_position(_, S1, S2, S3, S4, S5), 
    s(S2, H), s(S3, H), s(S4, H), s(S5, H),
    swrite(['Player', H, 'wins on', [S1, S2, S3, S4, S5]]), nl.
test_win(_).

% ============= Hierarchical rules =============

% Complete row of five
tah_computer :- prav_dopln_5xA(x).
tah_computer :- prav_dopln_5xB(x).
tah_computer :- prav_dopln_5xC(x).
tah_computer :- prav_dopln_5xD(x).
tah_computer :- prav_dopln_5xE(x).

% Cross
tah_computer :- prav_kriz(x).

% Random move
tah_computer :- prav_nahodne(x).