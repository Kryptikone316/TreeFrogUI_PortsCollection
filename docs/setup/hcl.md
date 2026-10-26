# Hydra Castle Labyrinth

Hydra Castle Labyrinth is a side-scrolling action platformer by E. Hashimoto
(Buster). This port runs it natively on TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/hydracastlelabyrinth/tree/sf3500)
of [ptitSeb's Linux port](https://github.com/ptitSeb/hydracastlelabyrinth).

This package does not include the game's data (graphics, music, maps and text).
The code is GPLv2, but the data is Buster's original freeware game and its
redistribution terms are not confirmed, so you copy it in yourself.

## Getting the game data

The data is the `data` folder of ptitSeb's repository, which is what this port
is built to use.

1. Download the repository as a ZIP:
   <https://github.com/ptitSeb/hydracastlelabyrinth/archive/refs/heads/master.zip>
   (or open the repository and choose **Code → Download ZIP**).
2. Unzip it on your computer. Inside the unzipped folder, find the `data`
   folder.
3. On the SD card, open `roms/ports/hcl/gamedata/data/`. This folder comes
   with the port and holds a placeholder note. Copy everything inside the
   downloaded `data` folder into it, so the files end up like this:

```text
roms/ports/hcl/
└── gamedata/
    └── data/
        ├── PUT-GAME-DATA-HERE.txt   # the placeholder, can stay
        ├── bmp.qda
        ├── en.dat
        ├── jp.dat
        ├── map/
        ├── midi/
        ├── obj/
        └── wav/
```

Select **Hydra Castle Labyrinth** under **Games → Ports** to start the game.
If the data is missing or in the wrong place, TreeFrogUI shows a help screen
with a link to this page instead.

## Saves and settings

Progress and settings are stored next to the game data, so everything you
supplied or the game created stays in one folder:

```text
roms/ports/hcl/gamedata/
├── data/          # the game data you copied in
├── save.map       # your saved progress
├── save.tmp       # the game's temporary checkpoint for the current session
└── system.ini     # game settings, created on first run
```

## Controls

| Button | Action |
|--|--|
| D-Pad | Move |
| A | Jump (cancel in menus) |
| B | Attack (confirm in menus) |
| X | Use the secondary weapon |
| L1 / R1 | Switch weapon |
| Start / Select | Open the menu |
| Select + Start (held together) | Quit immediately |

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an
`EXIT CODE:` line. Include it when reporting a problem. To start over, delete
`save.map`, `save.tmp` and `system.ini` in `gamedata/`.

## Source and licenses

The port's code is licensed under the GNU General Public License, version 2.
The source for this port is the pinned `source/` submodule, and the license text
and credits are in `roms/ports/hcl/licenses/`. The original game is by
E. Hashimoto (Buster).
