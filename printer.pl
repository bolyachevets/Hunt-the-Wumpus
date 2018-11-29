% prints out current room name and adjacent room names
print_room :-
    % handle current room name
    current_room(Current),
    map_room(RoomNum, Current),
    room(RoomNum, Name),
    write("You are in room "),
    print(RoomNum), nl,
    % uncomment the line below to print the actual room number
    % write("Actual room num: "), print(Current), nl
    write("Known as "),
    print(Name), nl,
    write("From here tunnels lead to: "), nl,
    print_choices, nl.

print_choices :-
    % handle current room name
    current_room(Current),
    % handle adjacent room names
    connected(Current, RoomNum1),
    connected(Current, RoomNum2),
    connected(Current, RoomNum3),
    % make sure room names are unique
    dif(RoomNum1, RoomNum2),
    dif(RoomNum2, RoomNum3),
    dif(RoomNum1, RoomNum3),

    map_room(NewRoom1, RoomNum1),
    map_room(NewRoom2, RoomNum2),
    map_room(NewRoom3, RoomNum3),

    % uncomment the line below to print the actual room numbers
    % write("Actual choices: "), print([RoomNum1, RoomNum2, RoomNum3]), nl,

    print(NewRoom1), nl,
    print(NewRoom2), nl,
    print(NewRoom3), nl.


