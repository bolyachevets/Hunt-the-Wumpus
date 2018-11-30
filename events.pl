% ah, all the things that can happen to a traveler underground
move_events :- game_over_check; bat_attack; found_arrow.

bat_attack :-
    bat_cave(Current),
    current_room(Current),
    write("The bats have lifted you off the ground..."), nl,
    random_between(1, 20, X),
    change_room(X).

fall_into_pit :-
    bottomless_pit(Current),
    current_room(Current),
    write("You have fallen into the bottomless pit..."), nl.

wumpus_listen_for_arrow :-
    wumpus(WumpusRoom),
    %write("The wumpus is here: "), print(WumpusRoom), nl,
    (
        connected(Current, WumpusRoom),
        current_room(Current),
        write("The Wumpus' keen senses alerted it to your presence and pounced. You have succumbed to his prowess..."),
        nl, write("Game Over"), nl,
        abort
    );
    (
        assertz(targetedRooms(999)),
        retract(targetedRooms(999)),
        targetedRooms(Targeted),
        %write("targed room: "), print(Targeted), nl,
        connected(Targeted, WumpusRoom),
        connected(NewRoom, WumpusRoom),
        dif(NewRoom, Targeted),
        wumpus_move(WumpusRoom, NewRoom)
    ).
    
wumpus_move(OldRoom, NewRoom) :-
    retract(wumpus(OldRoom)),
    assertz(wumpus(NewRoom)),
    write("Startled by an arrow whizzing through a nearby room, the Wumpus skittered over to a new room"), nl,
    %write("Wumpus is now at room: "), print(NewRoom),
    nl.
    
meet_wumpus :-
    wumpus(Current),
    current_room(Current),
    write("Noone can outwit the Wumpus. You have succumbed to his prowess..."), nl.

defeat_wumpus_check :-
    wumpus(Aim),
    target(Aim),
    write("You were lucky this time..."), nl,
    write("Victory is Yours"), nl,
    abort.

quiver_check :-
    quiver(ArrowsLeft),
    ArrowsLeft > 0,
    print(ArrowsLeft),
    write(" arrows left..."), nl,!.
    
quiver_check :-
    lost_arrow(_),
    quiver(ArrowsLeft),
    ArrowsLeft = 0,
    write("You have no more arrows left, maybe you are lucky to find one..."), nl, !.

quiver_check :-
    not(lost_arrow(_)),
    quiver(ArrowsLeft),
    ArrowsLeft < 1,
    write("You are as good as dead without arrows."), nl,
    write("Game Over"), nl,
    abort.

found_arrow :-
    current_room(Current),
    lost_arrow(LA),
    Current = LA,
    quiver(Arrows),
    incr(Arrows, IncArrows),
    retract(quiver(Arrows)),
    assertz(quiver(IncArrows)),
    retractall(lost_arrow(_)),
    senses_check,
    write("You found an arrow!"), nl,
    quiver_check.

game_over_check :-
    meet_wumpus,
    write("Game Over"), nl,
    abort;
    fall_into_pit,
    write("Game Over"), nl,
    abort.

