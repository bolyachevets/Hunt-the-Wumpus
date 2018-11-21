:- [maze].
:- [obstacles].
:- [events].
:- [senses].
:- [printer].
:- [actions].
:- use_module(library(random)).

:- prompt(_, 'Pick an adjacent room to explore: ').
:- dynamic ([current_room/1,
             wumpus/1,
             quiver/1,
             target/1]).

get_input :- read(Input), get_input(Input), nl.
get_input(Input) :- process_input(Input), get_input.

process_input(NewRoom) :-
    current_room(Current),
    connected(Current, NewRoom),
    change_room(NewRoom).

process_input(_) :- print_room, nl.

play :-
    retractall(current_room(_)),
    % assign a dummy room at the start
    assertz(current_room(999)),
    assert(target(999)),
    % generate random starting point
    random_between(1, 20, X),
    % pseudo random number for Wumpus, 'using' LCG algorithm
    % make sure that Wumpus does not start in the same room
    W is (mod(X*37, 20) + 1),
    % add location for Wumpus into KB
    assert(wumpus(W)),
    % fill the quiver with arrows
    assert(quiver(5)),
    % perform initial room assignment to trigger events/senses
    change_room(X),
    % debug info -----
    %wumpus(W),
    %write("Wumpus: "),
    %print(W), nl,
    % ----------------
    get_input.
