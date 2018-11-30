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
             targetedRooms/1,
             lost_arrow/1]).

get_input :- readln(Input), get_input(Input), nl.
get_input(Input) :- process_input(Input), get_input.

% move to a different room
process_input([go, NewRoom]) :-
    current_room(Current),
    map_room(NewRoom, ActualRoomNum),
    connected(Current, ActualRoomNum),
    change_room(ActualRoomNum).


% shoot an arrow
process_input([shoot, _]) :-
    quiver(ArrowsLeft),
    lost_arrow(_),
    ArrowsLeft = 0,
    write("You have no arrows. Maybe you are lucky to find one..."), nl,
    process_invalid_input.
    

process_input([shoot, FirstRoom|OtherRooms]) :-
    current_room(Current),
    map_room(FirstRoom, ActualRoomNum),
    connected(Current, ActualRoomNum),
    shoot_arrow(Current, [FirstRoom|OtherRooms]).
    
% quit
process_input([q]) :-
    abort.

process_input(_) :-
    process_invalid_input.

process_invalid_input :-
    write("Either go or shoot in the direction of: "), nl,
    print_choices, nl.

play :-
    write("You are a brave hunter aiming to take down the fearsome Wumpus."), nl,
    write("You will need to seek it out in this twisting maze."), nl,
    write("enter 'go x' where x is one of the adjacent room numbers to explore."), nl, nl,
    
    write("Be wary of not only the Wumpus but also of giant bats and bottomless pits."), nl,
    write("Trust your senses, they will alert you when danger is near."), nl, nl,
    
    write("You have your trusty bow and 5 arrows in your quiver, use them wisely."), nl,
    write("You also have the special skill of shooting arrows through a curved path of up to five connected rooms."), nl,
    write("To do so, enter 'shoot a b c d e' where a b c d and e are adjacent room numbers."), nl, nl,
    
    write("The Wumpus is cunning. If you fire an arrow and miss your target:"), nl,
    write("   If the Wumpus is nearby, it will hunt you down."), nl,
    write("   If the Wumpus is far away but hears the arrow, it will escape to another room."), nl,
    write("Best of luck, and happy hunting!"), nl, nl,
    
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
    retractall(lost_arrow(_)),

    retractall(rand_rooms(_)),

    % assign a dummy room at the start
    assertz(current_room(999)),
    assertz(target(999)),

    % 6 = 2 pits + 2 bats + 1 hunter + 1 lost arrow
    rooms_list(R),
    sample_without_replacement(R, 6, Sample),
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

    % setup lost arrow location
    nth1(6, Sample, LA),
    assertz(lost_arrow(LA)),

    % uncomment the "map_room" and "write" calls below for debugging purposes
    %map_room(MW, W),
    %map_room(MLA, LA),
    %write("Wumpus is actually here: "), print(W), nl,
    %write("Wumpus appears to be here: "), print(MW), nl,
    %write("Lost arrow is here: "), print(MLA), nl,
    
    % perform initial room assignment to trigger events/senses
    change_room(H),

    get_input.
