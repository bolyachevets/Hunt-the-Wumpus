% reference for dodecahedron vertex numbering scheme:
% https://www.researchgate.net/figure/Numbering-scheme-for-the-vertices-of-the-dodecahedron-graph_fig1_234956394

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


connected(1, 6).
connected(6, 1).
connected(1, 5).
connected(5, 1).
connected(1, 2).
connected(2, 1).

connected(12, 17).
connected(17, 12).
connected(12, 6).
connected(6, 12).
connected(12, 7).
connected(7, 12).

connected(16, 11).
connected(11, 16).
connected(16, 20).
connected(20, 16).
connected(16, 17).
connected(17, 16).

connected(11, 8).
connected(8, 11).
connected(11, 7).
connected(7, 11).

connected(2, 7).
connected(7, 2).
connected(2, 3).
connected(3, 2).

connected(8, 3).
connected(3, 8).
connected(3, 4).
connected(4, 3).

connected(20, 15).
connected(15, 20).
connected(8, 15).
connected(15, 8).
connected(9, 15).
connected(15, 9).

connected(19, 14).
connected(14, 19).
connected(19, 18).
connected(18, 19).
connected(19, 20).
connected(20, 19).

connected(13, 18).
connected(18, 13).
connected(13, 10).
connected(10, 13).
connected(13, 6).
connected(6, 13).

connected(18, 17).
connected(17, 18).

connected(10, 14).
connected(14, 10).
connected(10, 5).
connected(5, 10).

connected(9, 14).
connected(14, 9).
connected(9, 4).
connected(4, 9).

connected(4, 5).
connected(5, 4).










