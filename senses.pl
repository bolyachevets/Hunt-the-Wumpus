% trust your feelings...

next_to_pit :-
    current_room(Current),
    connected(Current, X),
    bottomless_pit(X).

next_to_bat_cave :-
    current_room(Current),
    connected(Current, X),
    bat_cave(X).

senses_check :-
   next_to_pit,
   next_to_bat_cave,
   write("Double trouble!!! Both bats and pit nearby..."), nl,
   print_room;
   next_to_pit,
   write("I feel a breeze..."), nl,
   print_room;
   next_to_bat_cave,
   write("I hear'em flapping..."), nl,
   print_room.

