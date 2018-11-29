change_room(NewRoom) :-
    current_room(Current),
    retract(current_room(Current)),
    assertz(current_room(NewRoom)),
    move_events; senses_check.
    
shoot_arrow(Current, Targets) :-
    % update arrow count
    quiver(Arrows),
    decr(Arrows, DecArrows),
    retract(quiver(Arrows)),
    assertz(quiver(DecArrows)),
    retractall(targetedRooms(_)),
    retractall(energy(_)),
    assertz(energy(6)),
    arrow_pass_through(Current, Targets),
    quiver_check,
    wumpus_listen_for_arrow.
    
arrow_pass_through(PreviousTarget, Targets) :-
    % update target
    energy(ArrowEnergy),
    decr(ArrowEnergy, EnergyLeft),
    retract(energy(ArrowEnergy)),
    assertz(energy(EnergyLeft)),
    resolve_arrow(PreviousTarget, Targets).
    
resolve_arrow(PreviousTarget, [Aim|NextTargets]) :- 
    energy(ArrowEnergy),
    ArrowEnergy > 0,
    map_room(Aim, ActualAim),
    connected(PreviousTarget, ActualAim),
    (
        write("Arrow is flying through room "),
        print(Aim), nl,
        (   
            check_room_for_hit(ActualAim);
            
            (list_empty(NextTargets, false),
            arrow_pass_through(ActualAim, NextTargets));
        
        write("Arrow missed the Wumpus."), nl
        )
    ),
    assertz(targetedRooms(ActualAim)),!.
    
resolve_arrow(PreviousTarget, [Aim|_]) :-
    energy(ArrowEnergy),
    ArrowEnergy > 0,
    map_room(Aim, ActualAim),
    \+ connected(PreviousTarget, ActualAim),
    write("You hear the arrow slam into a wall."), nl,!.
    
resolve_arrow(_, _) :-
    energy(ArrowEnergy),
    ArrowEnergy is 0, 
    write("Arrow ran out of kinetic energy and crashed into the ground."), nl.
    
check_room_for_hit(Aim) :-
    current_room(Current),
    Aim = Current,
    write("You are so bad you managed to kill yourself..."), nl,
    abort.

check_room_for_hit(Aim) :-
    target(Old),
    retract(target(Old)),
    assertz(target(Aim)),
    defeat_wumpus_check.

list_empty([], true).
list_empty([_|_], false).
