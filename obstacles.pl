% hardcoded pits and bat caves
% TODO: make their locations random

bottomless_pit(X) :-
    pit1(X); pit2(X).

bat_cave(X) :-
    bat1(X); bat2(X).
