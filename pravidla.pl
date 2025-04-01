:- ensure_loaded('pole.pl').

% Win position, horizontal
vyherni_kombinace(1, [X,Y], [X1, Y], [X2, Y], [X3, Y], [X4, Y]) :- 
    X1 is X+1, 
    X2 is X+2, 
    X3 is X+3, 
    X4 is X+4.

% Win position, vertical
vyherni_kombinace(2, [X,Y], [X, Y1], [X, Y2], [X, Y3], [X, Y4]) :- 
    Y1 is Y+1, 
    Y2 is Y+2, 
    Y3 is Y+3, 
    Y4 is Y+4.

% Win position, diagonal (bottom left -> top right)
vyherni_kombinace(3, [X,Y], [X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :- 
    X1 is X+1, Y1 is Y+1, 
    X2 is X+2, Y2 is Y+2, 
    X3 is X+3, Y3 is Y+3, 
    X4 is X+4, Y4 is Y+4.

% Win position, diagonal (top left -> bottom right)
vyherni_kombinace(4, [X,Y], [X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]) :-
    X1 is X+1, Y1 is Y-1, 
    X2 is X+2, Y2 is Y-2, 
    X3 is X+3, Y3 is Y-3, 
    X4 is X+4, Y4 is Y-4.

% ----+----+----+----+---- | ---+---+---+---+---
%  S1 | S2 | S3 | S4 | S5  |    | P | P | P | P 
% ----+----+----+----+---- | ---+---+---+---+---
prav_5xA :-
    s(S1, ' '), vyherni_kombinace(_, S1, S2, S3, S4, S5),
    (P = x ; P = o),
    s(S2, P), s(S3, P), s(S4, P), s(S5, P),
    zprava(P, "Complete 5x (A)", "Defence 5x (A)", M),
    pohyb(S1, x, M).

% ----+----+----+----+---- | ---+---+---+---+---
%  S1 | S2 | S3 | S4 | S5  |  P |   | P | P | P 
% ----+----+----+----+---- | ---+---+---+---+---
prav_5xB :-
    s(S1, P), vyherni_kombinace(_, S1, S2, S3, S4, S5),
    (P = x ; P = o),
    s(S2, ' '), s(S3, P), s(S4, P), s(S5, P),
    zprava(P, "Complete 5x (B)", "Defence 5x (B)", M),
    pohyb(S2, x, M).

% ----+----+----+----+---- | ---+---+---+---+---
%  S1 | S2 | S3 | S4 | S5  |  P | P |   | P | P 
% ----+----+----+----+---- | ---+---+---+---+---
prav_5xC :-
    s(S1, P), vyherni_kombinace(_, S1, S2, S3, S4, S5),
    (P = x ; P = o),
    s(S2, P), s(S3, ' '), s(S4, P), s(S5, P),
    zprava(P, "Complete 5x (C)", "Defence 5x (C)", M),
    pohyb(S3, x, M).

% ----+----+----+----+---- | ---+---+---+---+---
%  S1 | S2 | S3 | S4 | S5  |  P | P | P |   | P 
% ----+----+----+----+---- | ---+---+---+---+---
prav_5xD :-
    s(S1, P), vyherni_kombinace(_, S1, S2, S3, S4, S5),
    (P = x ; P = o),
    s(S2, P), s(S3, P), s(S4, ' '), s(S5, P),
    zprava(P, "Complete 5x (D)", "Defence 5x (D)", M),
    pohyb(S4, x, M).

% ----+----+----+----+---- | ---+---+---+---+---
%  S1 | S2 | S3 | S4 | S5  |  P | P | P | P |   
% ----+----+----+----+---- | ---+---+---+---+---
prav_5xE :-
    s(S1, P), vyherni_kombinace(_, S1, S2, S3, S4, S5),
    (P = x ; P = o),
    s(S2, P), s(S3, P), s(S4, P), s(S5, ' '),
    zprava(P, "Complete 5x (E)", "Defence 5x (E)", M),
    pohyb(S5, x, M).

prav_5x :- (prav_5xA ; prav_5xB ; prav_5xC ; prav_5xD ; prav_5xE).

% ----+----+----+----+---- | ---+---+---+---+---
%  S1 | S2 | S3 | S4 | S5  |    | P | P | P |
% ----+----+----+----+---- | ---+---+---+---+---
prav_3x :-
    s(S1, ' '), vyherni_kombinace(_, S1, S2, S3, S4, S5),
    (P = x ; P = o),
    s(S2, P), s(S3, P), s(S4, P), s(S5, ' '),
    zprava(P, "Complete 3x", "Defence 3x", M),
    pohyb(S5, P, M).

%     |    | S9 |    |     |    |   |   |   |   
% ----+----+----+----+---- | ---+---+---+---+---
%     |    | S8 |    |     |    |   | P |   |   
% ----+----+----+----+---- | ---+---+---+---+---
%  S1 | S2 | S3 | S4 | S5  |    | P |   | P |   
% ----+----+----+----+---- | ---+---+---+---+---
%     |    | S7 |    |     |    |   | P |   |   
% ----+----+----+----+---- | ---+---+---+---+---
%     |    | S6 |    |     |    |   |   |   |   
prav_kriz :- 
    s(S1, ' '), vyherni_kombinace(ID1, S1, S2, S3, S4, S5),
    (P = x ; P = o),
    s(S2, P), s(S3, ' '), s(S4, P), s(S5, ' '),
    s(S6, ' '), vyherni_kombinace(ID2, S6, S7, S3, S8, S9), 
    ID1 \= ID2,
    s(S7, P), s(S8, P), s(S9, ' '),
    zprava(P, "Complete Kriz", "Defence Kriz", M),
    pohyb(S3, P, M).

% Random move, if no other rule applies
prav_nahodne(P) :- s(S, ' '), pohyb(S, P, "Random").