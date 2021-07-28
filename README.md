# Coconut Crack

A simulator for the playground game 'Coconut Crack'.

Prints the players in the order that lose.

## Rules

Players stand in a circle and put 2 fists together into a 'coconut' while a leader bumps their coconut round the circle chanting "Coconut, coconut, coconut, crack".

If the coconut lands on yours on the 'crack' then it cracks into 2 separated fists. A single fist goes behind the back when cracked. If all your coconut pieces are cracked then you're out, and the last person standing wins.

## Usage

`coconut-crack-exe.exe PLAYERS [-c|--coconuts INT] [-p|--pieces INT]`

Available options:

- `PLAYERS` - No. of players in the game
- `-c`, `--coconuts INT` - No. of coconuts before a crack (default: 3)
- `-p`, `--pieces INT` - No. of pieces a coconut cracks into
  
  0 means the coconut is destroyed on the 1st crack (default: 2)

## Compiling

Run `stack build` and the executable will be somewhere in `.stack-work/install`.
