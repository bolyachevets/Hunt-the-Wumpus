:- [maze].
:- [obstacles].
:- [events].
:- [senses].
:- use_module(library(random)).

:- prompt(_, 'Pick an adjacent room to explore: ').
:- dynamic ([current_room/1,
             wumpus/1]).

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

change_room(NewRoom) :-
    current_room(Current),
    retract(current_room(Current)),
    assertz(current_room(NewRoom)),
    events; senses_check.

play :-
    retractall(current_room(_)),
    % assign a dummy room at the start
    assertz(current_room(999)),
    % generate random starting point
    random_between(1, 20, X),
    % pseudo random number for Wumpus, 'using' LCG algorithm
    % make sure that Wumpus does not start in the same room
    W is (mod(X*37, 20) + 1),
    % add location for Wumpus into KB
    assert(wumpus(W)),
    % perform initial room assignment to trigger events/senses
    change_room(X),
    % debug info -----
    %wumpus(W),
    %write("Wumpus: "),
    %print(W), nl,
    % ----------------
    get_input.
