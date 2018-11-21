% ah, all the things that can happen to a traveler underground
events :- game_over_check; bat_attack.

bat_attack :-
    bat_cave(Current),
    current_room(Current),
    write("The bats have lifted you off the ground..."), nl,
    random_between(1, 20, X),
    change_room(X).

fall_into_pit :-
    bottomless_pit(Current),
    current_room(Current),
    write("You have fallen into the bottomless pit..."), nl.

meet_wumpus :-
    wumpus(Current),
    current_room(Current),
    write("Noone can outwit the Wumpus..."), nl.

game_over_check :-
    meet_wumpus,
    write("Game Over"), nl,
    abort;
    fall_into_pit,
    write("Game Over"), nl,
    abort.
