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
             bat2/1]).

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

setup_game :-
    % purge the KB
    retractall(pit1(_)),
    retractall(pit2(_)),
    retractall(bat1(_)),
    retractall(bat2(_)),

    retractall(wumpus(_)),
    retractall(target(_)),
    retractall(quiver(_)),
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
    %write("Wumpus is here: "), print(W), nl,

    % perform initial room assignment to trigger events/senses
    change_room(H).


play :-
    setup_game,
    get_input.

retractall_solver :-
    retractall(has_bats(_, _)),
    retractall(has_wumpus(_, _)),
    retractall(has_pit(_, _)).

solve :-
    setup_game,
    retractall_solver,
    current_room(Current),
    make_step([Current]).

make_step(Visited) :- 
    write("Visited list is "), print(Visited), nl,
    udpate_kb, !,

    (get_next_step(Visited, Room, go),
     write("\nNext step is go "), print(Room), nl, nl,
     change_room(Room),
     make_step([Room|Visited]);
     
     get_next_step(Visited, Room, shoot),
     write("\nNext step is shoot "), print(Room), nl, nl,
     current_room(Current),
     shoot_arrow(Current, [Room]),
     events,
     maybe_wumpus(no, Room),
     make_step(Visited)).

get_next_step(Visited, Room, shoot) :- 
    current_room(Current),
    connected(Room, Current),
    dif(Current, Room),

    has_wumpus(yes, Room),
    \+ member(Room, Visited).

get_next_step(Visited, Room, go) :-
    current_room(Current),
    connected(Room, Current),
    dif(Current, Room),

    has_wumpus(no, Room),
    has_pit(no, Room),
    \+ member(Room, Visited).

udpate_kb :-
    current_room(Current),
    room_choices(Current, RoomNum1, RoomNum2, RoomNum3),

    next_to_pit(Pit),
    next_to_wumpus(Wumpus),
    next_to_bat_cave(Bats),

    write("[Pit, Wumpus, Bats] = "), print([Pit, Wumpus, Bats]), nl,

    update_solver_perceptions(Pit, Wumpus, Bats, RoomNum1),
    update_solver_perceptions(Pit, Wumpus, Bats, RoomNum2),
    update_solver_perceptions(Pit, Wumpus, Bats, RoomNum3).

update_solver_perceptions(Pit, Wumpus, Bats, RoomNum) :-
    maybe_wumpus(Wumpus, RoomNum),
    maybe_bats(Bats, RoomNum),
    maybe_pit(Pit, RoomNum).

maybe_wumpus(no, Room) :-
    retractall(has_wumpus(_, Room)),
    assertz(has_wumpus(no, Room)).

maybe_wumpus(yes, Room) :-
    retractall(has_wumpus(_, Room)),
    assertz(has_wumpus(yes, Room)).

maybe_pit(yes, Room) :-
    retractall(has_pit(_, Room)),
    assertz(has_pit(yes, Room)).

maybe_pit(no, Room) :-
    retractall(has_pit(_, Room)),
    assertz(has_pit(no, Room)).

maybe_bats(yes, Room) :-
    retractall(has_bats(_, Room)),
    assertz(has_bats(yes, Room)).

maybe_bats(no, Room) :-
    retractall(has_bats(_, Room)),
    assertz(has_bats(no, Room)).
