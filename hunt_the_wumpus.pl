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
             energy/1,
             target/1,
             pit1/1,
             pit2/1,
             bat1/1,
             bat2/1,
             targetedRooms/1]).

get_input :- readln(Input), get_input(Input), nl.
get_input(Input) :- process_input(Input), get_input.

% move to a different room
process_input([go, NewRoom]) :-
    current_room(Current),
    map_room(NewRoom, ActualRoomNum),
    connected(Current, ActualRoomNum),
    change_room(ActualRoomNum).


% shoot an arrow
process_input([shoot, FirstRoom|OtherRooms]) :-
    current_room(Current),
    map_room(FirstRoom, ActualRoomNum),
    connected(Current, ActualRoomNum),
    shoot_arrow(Current, [FirstRoom|OtherRooms]).
    
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
    retractall(energy(_)),
    retractall(quiver(_)),
    retractall(targetedRooms(_)),
    retractall(current_room(_)),

    retractall(rand_rooms(_)),

    % assign a dummy room at the start
    assertz(current_room(999)),
    assertz(target(999)),

    % 5 = 2 pits + 2 bats + 1 hunter
    rooms_list(R),
    sample_without_replacement(R, 5, Sample),
    %print(Sample), nl,

    % set random room number mapping
    sample_without_replacement(R, 20, RandRooms),
    assertz(rand_rooms(RandRooms)),

    % fill the quiver with arrows
    assertz(quiver(5)),

    % setup bottomless pits
    nth1(1, Sample, P1),
    nth1(2, Sample, P2),
    assertz(pit1(P1)),
    assertz(pit1(P2)),

    % setup bat caves
    nth1(3, Sample, B1),
    nth1(4, Sample, B2),
    assertz(bat1(B1)),
    assertz(bat2(B2)),

    % add location for Wumpus into KB
    nth1(5, Sample, H),
    random_location_for_wumpus(H, W),
    assertz(wumpus(W)),
    % debug
    map_room(MW, W),
    write("Wumpus is actually here: "), print(W), nl,
    write("Wumpus is appears to be here: "), print(MW), nl,
    
    % perform initial room assignment to trigger events/senses
    change_room(H),

    get_input.
