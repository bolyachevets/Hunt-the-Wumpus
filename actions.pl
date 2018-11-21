change_room(NewRoom) :-
    current_room(Current),
    retract(current_room(Current)),
    assertz(current_room(NewRoom)),
    events; senses_check.

shoot_arrow(Aim) :-
    % update target
    target(Old),
    retract(target(Old)),
    assertz(target(Aim)),
    % update arrow count
    quiver(Arrows),
    decr(Arrows, DecArrows),
    retract(quiver(Arrows)),
    assertz(quiver(DecArrows)),
    events.

