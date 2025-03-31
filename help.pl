% swrite([string, string, ...]) - Print joined list of strings
% swrite(['Hello', 'world']) -> Hello world
swrite([]).
swrite([H|T]) :- write(H), write(' '), swrite(T).

% concat([string, string, ...], result) - Concatenate strings
% concat(['Hello', 'world'], R), R = 'Helloworld'
concat([], '') :- !.
concat([H|T], R) :- concat(T, T1), string_concat(H, T1, R).

% pomlcky(pocet, kde) -> pocet(3, R), R = '---+---+---+'
text_pomlcky(0, '') :- !.
text_pomlcky(N, S) :-
    N > 0, N1 is N - 1,
    text_pomlcky(N1, T), string_concat(T, '---+', S).

cisla_pomlcky(0, '') :- !.
cisla_pomlcky(N, S) :-
    N > 0, N1 is N - 1,
    cisla_pomlcky(N1, S1), format(string(S2), ' ~d  ', [N1]), string_concat(S1, S2, S).

% cisla(from, result): -> cisla(5, R), R = [0, 1, 2, 3, 4, 5]
cisla(X, R) :- cisla1(0, X, R).
cisla1(X, X, [X]) :- !.
cisla1(X, Y, [X|R]) :- X1 is X + 1, cisla1(X1, Y, R).

% cisla(from, to, result): -> cisla(2, 5, R), R = [2, 3, 4, 5]
cisla(X, X, [X]) :- !.
cisla(X, Y, [X|R]) :- X < Y, X1 is X + 1, cisla(X1, Y, R).