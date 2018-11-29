# Hunt-the-Wumpus
Hunt the Wumpus in Prolog: a group project for cpsc 312

To start type: play.

Game control: type 'go' followed by room number to move to adjacent room; type 'shoot' followed by a sequence of connected rooms to shoot an arrow.

The rules of the game can be found at: https://www.atariarchives.org/bcc1/showpage.php?page=247

In a nutshell, we are controlling a hunter via text input. At each turn the player can take the following actions:

move to an adjacent room
shoot an arrow in the direction of the adjacent rooms
The hunter is facing 3 hazards and will be notified of the proximity to each via text output.

In case of a bottomless pit you will 'feel a breeze nearby'. For a colony of bats that will pick you up and drop you in a random space you will 'hear flapping nearby'. For the ultimate danger of wumpus you will smell the unbearable stench.

Some additional rules are:

The wumpus is too heavy to be carried by bats and is covered in suckers - he can’t fall down the pit.
Shooting an arrow that does not hit the wumpus will startle it.
The player has a total of 5 arrows. An extra arrow can be found in one of the rooms. Running out of arrows is one of losing conditions.
