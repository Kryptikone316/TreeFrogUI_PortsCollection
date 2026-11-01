# Quake II

The Ports Collection includes a vitaquake2 Libretro core built for the SF3500
from the [`sf3500` branch](https://github.com/Kryptikone316/treefrogui_vitaquake2/tree/sf3500)
of TreeFrogUI's [vitaquake2](https://github.com/tzubertowski/treefrogui_vitaquake2).
It contains the engine only. You supply Quake II's game files, which are not
included here.

## Game files

Copy the files from your own copy of Quake II (GOG, Steam, a retail CD) here:

```text
roms/ports/quake2/baseq2/pak0.pak      # required
roms/ports/quake2/baseq2/pak1.pak
roms/ports/quake2/baseq2/pak2.pak
```

The free shareware release works too: its `pak0.pak` alone starts the first
levels. Some installers name files in capitals; that is fine on the SD card.

Find **Quake II** in **Games → Ports**. Use this entry rather than the built-in
`quake2` system folder in TreeFrogUI, which starts a different core.

### Music (optional)

If you have the soundtrack as Ogg files, put them in
`roms/ports/quake2/baseq2/music/` named `02.ogg`, `03.ogg` and so on (or
`track02.ogg`, `track03.ogg`). The core option **Play Music** turns it on and
off; music costs some CPU.

### The official add-ons

Copy each add-on's `pak0.pak` into its own folder:

```text
roms/ports/quake2/xatrix/pak0.pak      # The Reckoning
roms/ports/quake2/rogue/pak0.pak       # Ground Zero
```

When there is more than one game folder, a small loader screen appears before
the game starts and lists them: Quake II, The Reckoning and Ground Zero. D-Pad
Up and Down choose, A starts, B (or SELECT + START) exits. Your choice is
remembered in `roms/ports/quake2/game.txt`, and the loader highlights it next
time. With only Quake II installed, the loader does not appear and the game
starts straight away. You can also edit `game.txt` yourself: one line with the
`.pak` path, for example `xatrix/pak0.pak`.

Mods are not supported: Quake II mods are native game libraries, and this
engine links the base game and the two add-ons into the core.

## Controls

D-Pad Up and Down walk, Left and Right turn. R2 fires, Y selects the next
weapon, L2 jumps, R crouches, L is the run toggle, SELECT shows the help
screen, START opens the menu. In the menus, D-Pad moves, A selects and B goes
back. There is no analog stick, so turning is coarse.

## Performance

The SF3500 has no GPU, so Quake II runs on its software renderer at 320×240:
roughly 25 to 45 frames per second depending on the level, with dips in big
scenes. The game clock and the sound follow real time, so a slow frame rate
does not slow the game down or make the sound stutter. The renderer is built
without `-ffast-math` and the DSP instructions on purpose: with them it
crashed on the device.

## Problems

Normally the port writes nothing to the SD card. If Quake II stops with an
error or crashes, it saves a report as `q2_crash.log` in the SD card root;
please attach it to a bug report. To record a full log of a session, create an
empty file named `q2_debug.txt` in the SD card root; the log is then written
to `q2.log`. Delete the file to turn it off.
