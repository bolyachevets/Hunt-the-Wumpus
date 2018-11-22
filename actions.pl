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
    assertz(energy(5)),
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
    connected(PreviousTarget, Aim),
    write("arrow is flying through room "),
    print(Aim), nl,
    (check_room_for_hit(Aim);
    (list_empty(NextTargets, false),
    ArrowEnergy > 0,
    arrow_pass_through(Aim, NextTargets))).
    
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
