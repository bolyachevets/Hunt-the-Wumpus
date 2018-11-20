# Hunt-the-Wumpus
Hunt the Wumpus in Prolog: a group project for cpsc 312

To start type: play.

For now you can traverses the adjacent vertices of dodecahedron by selecting an appropriate room number from the 3 listed, followed by a period.

TODO (feel free to add new items and break existing ones into more steps):

- Handle erroneous input, e.g, room number not followed by a period
- When shutting down Prolog SWI, program crashes, if we has not exited first -- perhaps game loop needs to be reworked

- Figure out how to randomize obstacle location on new instance of the game
- i.e., Randomize pit, bat, wumpus locations

- Add bats
- add senses for hunter (e.g, 'i hear a flapping' when close to bats, or 'i feel a breeze' when close to a pit).

- add wumpus (wumpus should be randomly assigned to a room on start and be startled by nearby shot, i.e., move towards the hunter)and bow&arrows

- introduce projectile control for arrows

- do an AI solver
