% trust your feelings...

next_to_pit :-
    current_room(Current),
    connected(Current, X),
    bottomless_pit(X).

next_to_bat_cave :-
    current_room(Current),
    connected(Current, X),
    bat_cave(X).

next_to_wumpus :-
    current_room(Current),
    connected(Current, X),
    wumpus(X).

% permute all the troubles
senses_check :-

   next_to_wumpus,
   next_to_pit,
   next_to_bat_cave,
   write("I am doomed!!! Wumpus, bats and pit are near..."), nl,
   print_room;

   next_to_wumpus,
   next_to_pit,
   write("Double trouble!!! Both Wumpus and pit nearby..."), nl,
   print_room;

   next_to_wumpus,
   next_to_bat_cave,
   write("Double trouble!!! Both Wumpus and bats nearby..."), nl,
   print_room;

   next_to_pit,
   next_to_bat_cave,
   write("Double trouble!!! Both bats and pit nearby..."), nl,
   print_room;

   next_to_wumpus,
   write("This stench is unbearable..."), nl,
   print_room;

   next_to_pit,
   write("I feel a breeze..."), nl,
   print_room;

   next_to_bat_cave,
   write("I hear'em flapping..."), nl,
   print_room.

