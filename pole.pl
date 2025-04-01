:- dynamic s/2. % s(cords, player) cords = [X, Y]
:- dynamic krok/3. % krok(where, player, game_field)

:- include('help.pl').

% pole(maxX, maxY) -> Create field of [maxX, maxY] size
pole(MX, MY) :-
    retractall(s([_, _], _)),  retractall(krok(_, _, _)), retractall(game(_, _, _)),
    MAX_X is MX - 1, MAX_Y is MY - 1,
    MID_X is MAX_X // 2, MID_Y is MAX_Y // 2,
    cisla_center(0, MAX_X, MID_X, X),
    cisla_center(0, MAX_Y, MID_Y, Y),
    generuj(X, Y), 
    vypis_pole(), !.

cisla_center(Min, Max, Center, List) :-
    findall(N, between(Min, Max, N), Full),
    sort(0, @=<, Full, Sorted),   % Just to be safe
    map_list_to_pairs({Center}/[X,Y]>>(D is abs(X - Center), Y = D), Sorted, Pairs),
    keysort(Pairs, SortedPairs),
    pairs_values(SortedPairs, List).

generuj([], _).
generuj([H|LX], LY) :- generuj1(H, LY), generuj(LX, LY).

generuj1(_, []).
generuj1(H, [H1|LY]) :- assert(s([H, H1], ' ')), generuj1(H, LY).

% obarvi_text(H) -> Colorize text based on value of H
% H = x -> red, H = o -> green, otherwise -> default color
obarvi_text(x) :- write('\033[31m'), write('x'), write('\033[0m').
obarvi_text(o) :- write('\033[32m'), write('o'), write('\033[0m').
obarvi_text(H) :- 
    H \= x, H \= o,
    write(H).

% souper -> If Im x then o, if o then x
souper(x, o).
souper(o, x).
souper(H, H) :- H \= x, H \= o.

% map(X) -> Map game field into list
map(X) :- findall([S, H], s(S, H), LX), sort(LX, X).

% vypis_radek(Y) -> Write row to console
% X - nutné mít, protože slouží pro sort. Nové záznamy se totiž vkládají na konec seznamu.
vypis_radek(Y) :- 
    findall([X,H], s([X, Y], H), LXH), sort(LXH, SLXH), 
    write(Y), write(' | '),
    vypis_sloupce_radku(SLXH), nl.

vypis_sloupce_radku([]).
vypis_sloupce_radku([[_,H]|L]) :-
    obarvi_text(H), write(' | '),
    vypis_sloupce_radku(L).

% vypis_pole() -> Print whole game matrix
vypis_pole :- 
    write('  +'), text_pomlcky(10, P), write(P), nl,
    findall(Y, s([_, Y], _), LY), sort(LY, SLY), reverse(SLY, RLY),
    vypis_radky_pole(RLY),
    write('   '), cisla_pomlcky(10, CP), write(CP), nl.

vypis_radky_pole([]).
vypis_radky_pole([Y|LY]) :- 
    vypis_radek(Y),
    write('  +'), text_pomlcky(10, P), write(P), nl,
    vypis_radky_pole(LY).