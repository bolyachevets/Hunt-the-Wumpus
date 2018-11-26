% trust your feelings...

next_to_pit(yes) :-
    current_room(Current),
    connected(Current, X),
    bottomless_pit(X).
next_to_pit(no).

next_to_bat_cave(yes) :-
    current_room(Current),
    connected(Current, X),
    bat_cave(X).
next_to_bat_cave(no).

next_to_wumpus(yes) :-
    current_room(Current),
    connected(Current, X),
    wumpus(X).
next_to_wumpus(no).

% permute all the troubles
senses_check :-

   next_to_wumpus(yes),
   next_to_pit(yes),
   next_to_bat_cave(yes),
   write("I am doomed!!! Wumpus, bats and pit are near..."), nl,
   print_room;

   next_to_wumpus(yes),
   next_to_pit(yes),
   write("Double trouble!!! Both Wumpus and pit nearby..."), nl,
   print_room;

   next_to_wumpus(yes),
   next_to_bat_cave(yes),
   write("Double trouble!!! Both Wumpus and bats nearby..."), nl,
   print_room;

   next_to_pit(yes),
   next_to_bat_cave(yes),
   write("Double trouble!!! Both bats and pit nearby..."), nl,
   print_room;

   next_to_wumpus(yes),
   write("This stench is unbearable..."), nl,
   print_room;

   next_to_pit(yes),
   write("I feel a breeze..."), nl,
   print_room;

   next_to_bat_cave(yes),
   write("I hear'em flapping..."), nl,
   print_room;

   print_room.

