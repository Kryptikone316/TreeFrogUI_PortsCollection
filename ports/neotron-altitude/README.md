# Altitude (SF3500 port)

*Altitude* is a free game by Daniel "Imerion" Eriksson (NeoTron Games). You are a space miner flying
through tunnels full of hazards, collecting crystals. Gravity pulls you down, so you keep your engine
firing to stay in the air. There are seven levels, power-ups, and a high score.

This is a port for the Datafrog SF3500 handheld. It is part of a small tribute to NeoTron Games' free
games, which have mostly disappeared from the web.

## What is in this port

The game itself is the author's, unchanged. The port adds four things around it, none of which
alter the game's files:

* **A runtime** for the SF3500's MIPS processor (`bgdi.mipsel`). The game was written for the Fenix
  engine, so it is run with BennuGD, a descendant of Fenix.
* **A launcher** that starts first: Play Game, Options, How to Play, Exit.
* **A computer opponent** (a mod) that flies Player 2 in the two-player modes.
* **A pause**: Start stops a level you are flying, and Start again carries on. The game has none of its own.

## Controls

| Button | In the game | In the launcher |
|---|---|---|
| A | fly up (also confirms in the game's menus) | confirm |
| B | thruster, forward (needs the yellow crystal) | back |
| Y | push down (needs the green or blue crystal) | |
| D-pad | up, down, left, right | choose |
| Start | pause and resume while flying; confirm in the game's menus | confirm |
| Select + Start | quit to the launcher | quit to the front-end |

**Pause:** press Start while you are flying. The game stands still, the music and sounds hold, and the last
frame stays on screen with PAUSED over it; press Start again to carry on from the same moment. It works only in
flight, while your own ship is flying: not on the menus, not on a level-complete or game-over banner (Start
confirms there as before), and not after your ship has crashed in a two-player match while the other pilot flies
on. Select + Start still quits from the pause screen.

Player 2's keys are not mapped: the handheld has one set of controls. Use the computer opponent
(below) for the two-player modes.

## The launcher

* **Play Game** starts Altitude. When the game ends (including Select + Start), you return to the
  launcher.
* **Options**
  * *Screen*: *Original shape* keeps the game's 4:3 picture with black bars at the sides; *Fill screen*
    stretches it to the whole panel.
  * *Menu music*: the launcher's music on or off. The game has its own sound setting.
  * *Computer opponent*: Off, Easy, Normal or Hard (see below).
  * *Reset high scores*: sets your best score back to 0 and puts the game's high score back to Imerion's (see
    below). It asks for a second press of A to confirm.
  * Settings are saved in `options.cfg` and apply the next time the game starts.
* **How to Play** is a five-page guide: the mission, controls, power-ups, game modes, and tips.
* **Exit** returns to the front-end.

## High scores

The game remembers one high score, and it ships with the author's own (33781), which is very hard to beat.
So the launcher keeps two numbers and shows them on its first screen: **Yours** (your best score in any mode,
kept by the port) and **Imerion** (his, fixed), for example `Yours: 2,981   Imerion: 33,781`. Your best is
recorded even when it is below his, so you can watch it climb; when you pass him, the game itself starts showing your score as its high score, as it always did.

*Options > Reset high scores* sets Yours back to 0 and puts the game's high score back to Imerion's, so there is
a score to beat again. Only Player 1's score counts as yours; the computer opponent's never does.

## The computer opponent

In **2P Battle** and **2P Arcade**, turn on *Options > Computer opponent* to race a computer pilot as
Player 2. In Arcade and Training it is not used.

The opponent reads the game's running state, simulates about a second ahead using the game's own
flight rules, and presses Player 2's keys. It never edits the game or its data.

| Level | Behaviour |
|---|---|
| Easy | short look-ahead, slow reactions, occasional slips |
| Normal | looks about a second ahead, an occasional slip |
| Hard | longer look-ahead, replans every frame, goes for the bigger crystals |

It collects crystals and takes the fire shield when it can. Fire pillars are very hard to avoid in
some places, so the computer, like you, does best when it has the shield.

## Files

Everything in the game folder is the author's original, byte for byte, except these:

| File | What it is |
|---|---|
| `altitude.dcb` | The author's `altitude.prg`, compiled for BennuGD (the original compiled file is for Fenix, which does not run here). The script text is unchanged; see `source/` |
| `bgdi.mipsel` | The runtime: BennuGD with SF3500 display, audio and input, tracker-music playback, the computer opponent, the pause, and the tracker of your best score |
| `launcher.dcb`, `launcher.prg`, `ui/` | The launcher (its source and fonts) |
| `run.sh`, `boxart.png` | The start script and the box art |
| `options.cfg`, `score-player.dat`, `log.txt` | Created when you run it: your settings, your best score, and a log of the last session |

Unchanged originals: `altitude.fpg` (graphics), `alt1.mod`, `alt2.mod` (music), the `.wav` sounds,
`score.dat` (it starts as the author's own high score; the game replaces it when it is beaten and
*Reset high scores* puts it back), `score-creator.dat` (an untouched copy of it) and `Readme-altitude.txt`
(the author's readme).

`source/` holds the source: the author's `altitude.prg` unmodified, and `make-bennu-prg.sh`, the only step
between it and `altitude.dcb`. BennuGD requires `import` lines after the first line of a script, which Fenix did
not, so the script generates a compile copy with those lines inserted. The shipped `altitude.prg` is never
edited. (On the card this folder has just those files; in the Ports Collection it is the port's whole source
repository, where they are `game/altitude.prg` and `tools/make-bennu-prg.sh`.) `make-fonts.py` generates the
launcher's fonts from DejaVu Sans.

## If something goes wrong

Send `log.txt` from the game folder. It records the launcher and game output, an exit code after each,
and, when the computer opponent is on, its timing and a one-line result for each of its flights.

## Licences and credits

* **Altitude**: copyright Daniel "Imerion" Eriksson. Free to share; the content must not be changed and
  it must not be sold (`Readme-altitude.txt`). This port keeps to that: the game files are unchanged,
  and everything added lives beside them. If you like his work, he accepts donations (see his readme).
* **BennuGD / Fenix** runtime: zlib licence, copyright SplinterGU and the Fenix team, via the Vita SoRR
  port by Sarcastic Cat. `bgdi.mipsel` is a **modified version** of that software, not the original:
  it adds the SF3500 display, audio and input support, a rotation-aware 16-bit video path for the
  game's 8-bit mode, tracker-music playback, the computer opponent, the pause, and the tracker of your best
  score.
* **SDL2**, **SDL2_mixer**, **zlib** (zlib licence), **libpng** (libpng licence), **libxmp-lite**
  (MIT, for the tracker music), **DejaVu fonts** (Bitstream Vera licence, for the launcher text). The
  licence texts are in `licenses/`.
* The launcher, the computer opponent, the pause and the score tracker were written for this port (Unlicense). `licenses/CREDITS.txt` says who wrote what.
