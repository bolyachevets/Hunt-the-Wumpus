change_room(NewRoom) :-
    current_room(Current),
    retract(current_room(Current)),
    assertz(current_room(NewRoom)),
    events; senses_check.

shoot_arrow(Current, Targets) :-
    % update arrow count
    quiver(Arrows),
    decr(Arrows, DecArrows),
    retract(quiver(Arrows)),
    assertz(quiver(DecArrows)),
    print(DecArrows),
    write(" arrows left..."), nl,
    retractall(energy(_)),
    assertz(energy(6)),
    arrow_pass_through(Current, Targets).
    
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
    (connected(PreviousTarget, ActualAim),
        write("arrow is flying through room "),
        print(Aim), nl,
        (check_room_for_hit(ActualAim);
        
        (list_empty(NextTargets, false),
        arrow_pass_through(ActualAim, NextTargets));
        
        write("arrow ran out of kinetic energy and crashed into the ground"), nl)
    );
        write("you hear the arrow slam into a wall"), nl.
    
resolve_arrow(_, _) :-
    energy(ArrowEnergy),
    ArrowEnergy is 0, 
    write("arrow ran out of kinetic energy and crashed into the ground"), nl.
    
check_room_for_hit(Aim) :-
    target(Old),
    retract(target(Old)),
    assertz(target(Aim)),
    events.
    
list_empty([], true).
list_empty([_|_], false).
