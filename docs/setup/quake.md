# Quake

The Ports Collection includes a TyrQuake Libretro core built for the SF3500
from the [`sf3500` branch](https://github.com/Kryptikone316/tyrquake/tree/sf3500)
of [libretro/tyrquake](https://github.com/libretro/tyrquake). It contains the
engine only. You supply Quake's game files, which are not included here.

## Game files

Copy the files from your own copy of Quake (GOG, Steam, a retail CD) here:

```text
roms/ports/quake/id1/pak0.pak      # required
roms/ports/quake/id1/pak1.pak      # the rest of the full game
```

The free shareware release works too: `pak0.pak` alone starts Episode 1.
Some installers name the files in capitals (`PAK0.PAK`); that is fine on the
SD card.

Find **Quake** in **Games → Ports**. Use this entry rather than the built-in
`Quake` system folder in TreeFrogUI, which starts a different core.

### Music (optional)

If you have the soundtrack as Ogg files, put them in
`roms/ports/quake/id1/music/` named `track02.ogg`, `track03.ogg`, and so on.
Playing music costs some CPU; on slow maps you may prefer to leave it out.

### Mission packs and mods

Put each pack in its own folder next to `id1`:

```text
roms/ports/quake/hipnotic/pak0.pak     # Scourge of Armagon
roms/ports/quake/rogue/pak0.pak        # Dissolution of Eternity
roms/ports/quake/<mod name>/pak0.pak   # a mod, packed into one pak0.pak
```

A mod that ships as loose files (`progs.dat`, `maps/`, and so on) has to be
packed into a `pak0.pak` first; any Quake PAK tool does this, and the folder
name is the game directory name. The mod still needs `id1` for the base game.

To start a pack, create a text file `roms/ports/quake/game.txt` containing one
line with its `.pak` path, for example:

```text
hipnotic/pak0.pak
```

Delete the file (or put `id1/pak0.pak` in it) to go back to Quake. If the path
does not exist, the port starts Quake.

## Controls

The default RetroPad layout is: D-pad up/down to move and left/right to turn,
Y to fire, B to jump, A to cycle weapons, L and R to strafe, L2 and R2 to look
up and down, X for freelook, SELECT to toggle run mode, START for the menu.
You can rebind keys in Quake's own menu; the new bindings are saved per game.

## Performance and limits

The SF3500 has no GPU, so Quake runs on its software renderer at 320×200:
roughly 40 to 60 frames per second on the original maps, with dips on large
ones. Large mods can need more memory, so the port reserves up to half of the
free RAM for the game (32 to 96 MB). Mods built for engines with much larger
limits than the original Quake may not load.

## Problems

Normally the port writes nothing to the SD card. If Quake stops with an error
or crashes, it saves a report as `tyrquake_crash.log` in the SD card root; please
attach it to a bug report. To record a full log of a session, create an empty
file named `tyrquake_debug.txt` in the SD card root; the log is then written to
`tyrquake.log`. Delete the file to turn it off.
