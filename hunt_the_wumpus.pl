:- [maze].
:- [obstacles].
:- [events].
:- [senses].
:- [printer].
:- [actions].
:- [math_helpers].
:- use_module(library(random)).
:- use_module(library(readln)).

:- prompt(_, 'go/shoot + room number: ').
:- dynamic ([current_room/1,
             wumpus/1,
             quiver/1,
             target/1]).

get_input :- readln(Input), get_input(Input), nl.
get_input(Input) :- process_input(Input), get_input.

% move to a different room
process_input([go, NewRoom]) :-
    current_room(Current),
    connected(Current, NewRoom),
    change_room(NewRoom).

% shoot an arrow
process_input([shoot, NewRoom]) :-
    current_room(Current),
    connected(Current, NewRoom),
    shoot_arrow(NewRoom).

% quit
process_input([q]) :-
    abort.

process_input(_) :-
    write("Either go or shoot in the direction of: "), nl,
    print_choices, nl.

play :-
    % purge the KB
    retractall(wumpus(_)),
    retractall(target(_)),
    retractall(quiver(_)),
    retractall(current_room(_)),

    % assign a dummy room at the start
    assertz(current_room(999)),
    assertz(target(999)),
    % generate random starting point
    random_between(1, 20, X),
    % make sure that Wumpus does not start in the same room
    random_location(X, W),
    % add location for Wumpus into KB
    assertz(wumpus(W)),
    % fill the quiver with arrows
    assertz(quiver(5)),
    % perform initial room assignment to trigger events/senses
    change_room(X),
    % debug info -----
    wumpus(W),
    write("Wumpus: "),
    print(W), nl,
    % ----------------
    get_input.
