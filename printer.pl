
% prints out current room name and adjacent room names
print_room :-
    % handle current room name
    current_room(Current),
    room(Current, Name),
    write("You are in room "),
    print(Current), nl,
    write("Known as "),
    print(Name), nl,
    write("From here tunnels lead to: "), nl,
    print_choices.

print_choices :-
    % handle current room name
    current_room(Current),
    % handle adjacent room names
    connected(Current, NewRoom1),
    connected(Current, NewRoom2),
    connected(Current, NewRoom3),
    % make sure room names are unique
    dif(NewRoom1, NewRoom2),
    dif(NewRoom2, NewRoom3),
    dif(NewRoom1, NewRoom3),
    print(NewRoom1), nl,
    print(NewRoom2), nl,
    print(NewRoom3), nl.


