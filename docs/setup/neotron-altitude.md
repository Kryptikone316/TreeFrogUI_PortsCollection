# Altitude

You are a space miner. Fly through tunnels full of hazards and collect the crystals hidden in them.
Gravity pulls you down all the time, so keep your engine firing to stay in the air. Some of the bigger
crystals give you power-ups. There are seven levels and a high score.

This is *Altitude* by Daniel "Imerion" Eriksson (NeoTron Games), a free game whose makers' site has
long gone. The game's files are his, unchanged. Everything needed to play is included and nothing has
to be downloaded.

Select **Altitude** under **Games → Ports** to start. A menu comes first: **Play Game**, **Options**,
**How to Play** and **Exit**. When the game ends you come back to that menu.

```text
roms/ports/neotron-altitude/
├── options.cfg        # your settings, written by the Options screen (delete it to reset)
├── score.dat          # the game's high score (starts as Imerion's), written by the game
├── score-player.dat   # your best score, kept by the port
├── score-creator.dat  # an untouched copy of Imerion's score, for the reset
└── log.txt            # what the launcher and the game printed on their last run
```

## Controls

| Button | In the game | In the menu |
|--|--|--|
| A | Fly up (also confirms in the game's own menus) | Confirm |
| B | Thruster, forward (needs the yellow crystal) | Back |
| Y | Push down (needs the green or the blue crystal) | |
| D-pad | Up, down, left, right | Choose |
| Start | Pause and resume while flying; confirm in the game's menus | Confirm |
| Select + Start | Quit the game, back to the menu | Leave for the front-end |

Player 2's keys are not mapped: the handheld has one set of controls. See the computer opponent below
for the two-player modes.

## Power-ups

| Crystal | Effect |
|--|--|
| Red | **Fire Shield**: fly through fire |
| Green | **Anti Gravity**: gravity off; up and down both work |
| Blue | **Reverse Gravity**: gravity pulls you up; use down to fly down |
| Yellow | **Thruster**: push forward |
| Small red / small green | 1000 / 10000 points |

The big power-ups run out after about ten seconds; a bar shows the time left. The **How to Play**
screen explains all of this in more detail.

## Options

* **Screen:** *Original shape* keeps the game's 4:3 picture with black bars at the sides; *Fill screen*
  stretches it over the whole panel.
* **Menu music:** the menu's music on or off (the game has its own sound setting).
* **Computer opponent:** *Off*, *Easy*, *Normal* or *Hard*. In **2P Battle** and **2P Arcade** a computer
  pilot flies Player 2, so you can race it. It is not used in Arcade or Training.
* **Reset high scores:** sets *Yours* back to 0 and puts the game's high score back to Imerion's. Press A twice
  to confirm.

Changes apply the next time the game starts.

## The computer opponent

A computer opponent is a mod: it presses Player 2's keys and changes nothing in the game's files. It looks
about a second ahead using the game's own flight rules and dodges hazards, with more look-ahead and fewer
slips on the higher levels. It takes the fire shield when it can, but some of the fire pillars are very hard
to avoid without it, for the computer as for you.

## Notes

* The first screen shows two scores, for example `Yours: 2,981   Imerion: 33,781`: your best in any mode, and the
  author's own high score that the game starts with. Yours is recorded even when it is far below his.
* Start pauses a level while your own ship is flying and resumes it on the next press; Select + Start still quits.
* If something goes wrong, `log.txt` in the port folder says what happened. When the computer opponent is
  on, it also records how long each of its flights lasted.
* The source, build instructions and developer notes are in the submodule and at
  https://github.com/Kryptikone316/Neotron-Altitude-port
