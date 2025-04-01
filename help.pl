% swrite([string, string, ...]) - Print joined list of strings
% swrite(['Hello', 'world']) -> Hello world
swrite([]).
swrite([H|T]) :- write(H), write(' '), swrite(T).

% spoj_text([string, string, ...], result) - Concatenate strings
% spoj_text(['Hello', 'world'], R), R = 'Helloworld'
spoj_text([], '') :- !.
spoj_text([H|T], R) :- spoj_text(T, T1), string_concat(H, T1, R).

% text_pomlcky(pocet, vysledek) -> text_pomlcky(3, R), R = '---+---+---+'
text_pomlcky(0, '') :- !.
text_pomlcky(N, S) :-
    N > 0, N1 is N - 1,
    text_pomlcky(N1, T), string_concat(T, '---+', S).

% cisla_pomlcky(pocet, vysledek) -> cisla_pomlcky(3, R), R = ' 0  1  2  3  4 '
cisla_pomlcky(0, '') :- !.
cisla_pomlcky(N, S) :-
    N > 0, N1 is N - 1,
    cisla_pomlcky(N1, S1), format(string(S2), ' ~d  ', [N1]), string_concat(S1, S2, S).

% zprava(who, msg1, msg2, result) - who is x -> msg1, otherwise msg2
zprava(P, M1, M2, R) :- ( P = x -> R = M1 ; R = M2).

vypis([]).
vypis([X|Y]) :- write(X), nl, vypis(Y).