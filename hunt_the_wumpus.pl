:- [maze].
:- [obstacles].
:- use_module(library(random)).

:- prompt(_, 'Pick an adjacent room to explore: ').
:- dynamic current_room/1.

get_input :- read(Input), get_input(Input), nl.
get_input(Input) :- process_input(Input), get_input.

process_input(NewRoom) :-
    current_room(Current),
    connected(Current, NewRoom),
    change_room(NewRoom).

process_input(_) :- print_room, nl.

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

generate_pits :- random_between(1, 20, Y),
    bottomless_pit(Y).

change_room(NewRoom) :-
    current_room(Current),
    retract(current_room(Current)),
    assertz(current_room(NewRoom)),
    game_over_check.

fall_into_pit :-
    bottomless_pit(Current),
    current_room(Current),
    write("You have fallen into the bottomless pit..."), nl.

game_over_check :-
    fall_into_pit,
    write("Game Over"), nl,
    abort.

play :-
    retractall(current_room(_)),
    % generate random starting point
    random_between(1, 20, X),
    assertz(current_room(X)),
    print_room,
    get_input.
