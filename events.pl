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
    write("Noone can outwit the Wumpus. You have succumbed to his prowess..."), nl.

defeat_wumpus :-
    wumpus(Aim),
    target(Aim),
    write("You were lucky this time..."), nl.

empty_quiver :-
    quiver(0),
    write("You are as good as dead without arrows."), nl.

game_over_check :-
    meet_wumpus,
    write("Game Over"), nl,
    abort;
    fall_into_pit,
    write("Game Over"), nl,
    abort;
    empty_quiver,
    write("Game Over"), nl,
    abort;
    defeat_wumpus,
    write("Victory is Yours"), nl,
    abort.

