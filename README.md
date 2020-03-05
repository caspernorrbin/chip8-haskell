# CHIP8 emulator in Haskell

CHIP-8 is a simple, interpreted programming language that was originally intended for microcomputers in the late 1970s and early 1980s. It was designed to allow video games to be created faster and more easily. Nowadays the CHIP-8 is implemented for most platforms and in many programming languages due to it’s relatively simple architecture. 
Read more on Wikipedia: [CHIP-8](https://en.wikipedia.org/wiki/CHIP-8)

## Running

In order to run the Emulator, type `cabal run` in the root folder of the program. Cabal will then download any dependencies needed to run the program (if they are not already installed) and then compile and run the program.
The user will then be asked to select one of the listed ROMs they would like to launch. Some ROMs are already included in`roms/`, but additional ROMs can also be added.

## Playing
When running, a new window will pop up with the selected ROM loaded into the emulator and ready to start. To start the emulator, you must left-click on the emulator window.

There are 16  available keyboard input keys for the emulator: 

| 1 | 2 | 3 | 4 |
|---|---|---|---|
| Q | W | E | R |
| A | S | D | F |
| Z | X | C | V |



After launching a ROM it might not be immediately clear what input the program expects (if anything). The input combinations for some of the most common ROMs that are played on the CHIP-8 can be seen in the list below. 

 - *HIDDEN* - Press any key to start the game. Use 2, Q, E & S to move around and W to choose a card
 - *CONNECT4* - Use Q & E to move to the left or to the right and W to drop disc
 - *PONG* - Use 1 & Q to move the left paddle up or down and 4 & R to move the right paddle up or down
 - *TICTAC* - Hold down every key until your X or O has been placed. Use 1, 2, 3 for the first row, Q, W, E for the second row & A, S, D for the third row


If you want to exit the program at any time, press the escape key (ESC).