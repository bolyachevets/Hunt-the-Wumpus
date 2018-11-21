% trust your feelings...

next_to_pit :-
    current_room(Current),
    connected(Current, X),
    bottomless_pit(X),
    write("I feel a breeze..."), nl.

senses_check :- next_to_pit, print_room.

