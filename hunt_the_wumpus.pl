:- use_module(library(random)).
:- use_module(library(readln)).
:- [maze].
:- [obstacles].
:- [events].
:- [senses].
:- [printer].
:- [actions].
:- [math_helpers].

:- prompt(_, 'go/shoot + room number: ').
:- dynamic ([current_room/1,
             wumpus/1,
             quiver/1,
             target/1,
             pit1/1,
             pit2/1,
             bat1/1,
             bat2/1]).


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
    
% shoot a curved arrow (can pass through up to 2 rooms)
process_input([shoot, NewRoom1, NewRoom2]) :-
    current_room(Current),
    connected(Current, NewRoom1),
    connected(NewRoom1, NewRoom2),
    (shoot_arrow(NewRoom1);
    arrow_pass_through(NewRoom2)).

% quit
process_input([q]) :-
    abort.

process_input(_) :-
    write("Either go or shoot in the direction of: "), nl,
    print_choices, nl.

play :-
    % purge the KB
    retractall(pit1(_)),
    retractall(pit2(_)),
    retractall(bat1(_)),
    retractall(bat2(_)),

    retractall(wumpus(_)),
    retractall(target(_)),
    retractall(quiver(_)),
    retractall(current_room(_)),

    % assign a dummy room at the start
    assertz(current_room(999)),
    assertz(target(999)),

    % 7 = 1 hunter + 1 wumpus + 2 pits + 2 bats
    rooms_list(R),
    sample_without_replacement(R, 6, Sample),
    print(Sample), nl,

    % add location for Wumpus into KB
    nth1(1, Sample, W),
    assertz(wumpus(W)),

    % fill the quiver with arrows
    assertz(quiver(5)),

    % setup bottomless pits
    nth1(3, Sample, P1),
    nth1(4, Sample, P2),
    assertz(pit1(P1)),
    assertz(pit1(P2)),

    % setup bat caves
    nth1(5, Sample, B1),
    nth1(6, Sample, B2),
    assertz(bat1(B1)),
    assertz(bat2(B2)),

    % perform initial room assignment to trigger events/senses
    nth1(2, Sample, X),
    change_room(X),

    % debug info -----
    %wumpus(W),
    %write("Wumpus: "),
    %print(W), nl,
    % ----------------
    get_input.
