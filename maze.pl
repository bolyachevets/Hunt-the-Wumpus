% reference for dodecahedron vertex numbering scheme:
% https://www.researchgate.net/figure/Numbering-scheme-for-the-vertices-of-the-dodecahedron-graph_fig1_234956394

rooms_list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]).

room(1, 'Ocean of Dreams').
room(2, 'Field of Doom').
room(3, 'The Chasm').
room(4, 'Eternal Oblivion').
room(5, 'Lair').
room(6, 'The Nest').
room(7, 'Green Room').
room(8, 'Red Room').
room(9, 'The Cave').
room(10, 'Vortex').
room(11, 'Shrine of Darkness').
room(12, 'Mourning Fields').
room(13, 'Styx').
room(14, 'Acheron').
room(15, 'Lethe').
room(16, 'Phlegethon').
room(17, 'Cocytus').
room(18, 'Oceanus').
room(19, 'Tartarus').
room(20, 'Elysium').

% for testing
% rand_rooms([13,8,3,6,17,16,1,5,9,7,4,20,2,10,11,19,18,14,15,12]).

%map_room(Rand, Actual) :-
%    rand_rooms(RandRooms),
%    nth1(Actual, RandRooms, Rand).
    
% use this for debugging
map_room(Actual, Actual).
    
connected(X, Y):- connected_to(X, Y).
connected(X, Y):- connected_to(Y, X).

connected_to(1, 6).
connected_to(1, 5).
connected_to(1, 2).
connected_to(2, 3).
connected_to(2, 7).
connected_to(3, 4).
connected_to(3, 8).
connected_to(4, 5).
connected_to(4, 9).
connected_to(5, 10).
connected_to(6, 12).
connected_to(6, 13).
connected_to(7, 11).
connected_to(7, 12).
connected_to(8, 11).
connected_to(8, 15).
connected_to(9, 14).
connected_to(9, 15).
connected_to(10, 13).
connected_to(10, 14).
connected_to(11, 16).
connected_to(12, 17).
connected_to(13, 18).
connected_to(14, 19).
connected_to(15, 20).
connected_to(16, 17).
connected_to(16, 20).
connected_to(17, 18).
connected_to(18, 19).
connected_to(19, 20).
