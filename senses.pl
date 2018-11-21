% trust your feelings...

next_to_pit :-
    current_room(Current),
    connected(Current, X),
    bottomless_pit(X),
    write("I feel a breeze..."), nl.

next_to_bat_cave :-
    current_room(Current),
    connected(Current, X),
    bat_cave(X),
    write("I hear'em flapping..."), nl.

senses_check :-
    next_to_pit,
    next_to_bat_cave,
    print_room;
    next_to_pit,
    print_room;
    next_to_bat_cave,
    print_room.

