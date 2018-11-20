:- [maze].
:- use_module(library(readln)).
:- use_module(library(random)).

:- prompt(_, 'Pick an adjacent room to explore: ').
:- dynamic current_room/1.

get_input :- read(Input),get_input(Input), nl.
get_input(Input) :- process_input(Input), get_input.

process_input(NewRoom) :-
    current_room(Current),
    connected(Current, NewRoom),
    change_room(NewRoom).

process_input(_) :- print('Pick a valid room number from the 3 listed'), nl.

% prints out current room name and adjacent room names
print_room :-
    % handle current room name
    current_room(Current),
    room(Current, Name),
    print(Name), nl,
    % handle adjacent room names
    write("Tunnels lead to: "), nl,
    connected(Current, NewRoom1),
    connected(Current, NewRoom2),
    connected(Current, NewRoom3),
    % make sure room names are unique
    dif(NewRoom1, NewRoom2),
    dif(NewRoom2, NewRoom3),
    dif(NewRoom1, NewRoom3),
    print(NewRoom1), nl,
    print(NewRoom2), nl,
    print(NewRoom3), nl.


change_room(NewRoom) :-
    current_room(Current),
    retract(current_room(Current)),
    assertz(current_room(NewRoom)),
    print_room.

play :-
    retractall(current_room(_)),
    random_between(1, 20, X),
    assertz(current_room(X)),
    print_room,
    get_input.
