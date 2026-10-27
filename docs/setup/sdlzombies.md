# SDL Zombies

SDL Zombies is a small arcade game by Philippe Brochard (2001), based on the old
ZX81 zombies game. You are a penguin chased by zombies, and the only way to
survive is to make them fall into the holes. This port runs it natively on
TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/sdlzombies/tree/sf3500) of the
original 1.0.0 source. It needs no extra game data: everything is included.

Select **SDL Zombies** under **Games → Ports** to start the game. Your options
and sound settings are saved in the port folder:

```text
roms/ports/sdlzombies/
└── sdlzombies.dat    # options and sound setting, created on first run
```

## Controls

| Button | Action |
|--|--|
| D-Pad | Move the penguin, move in menus |
| A | Confirm in menus |
| B | Back to the menu, or quit from the main menu |
| Start | Pause / resume |
| X or L2 | Cycle the map (off, transparent, under, over) |
| Y or R2 | Cycle the sound volume (off, low, medium, high) |
| Select + Start (held together) | Quit immediately |

In the Level options screen (Options, then Level options), picking an entry
opens a number prompt:

| Button | Action |
|--|--|
| D-Pad Up / Down | Change the highlighted digit (shown in a second colour) |
| A | Add the highlighted digit |
| D-Pad Left | Erase the last digit |
| Start | Accept the number |
| B | Cancel |

## Supported devices

The port loads the display and audio driver that TreeFrogUI selects for your
device (it reads it from `/tmp/tfdevice.env`), so one build covers every device
that shows frames through that driver. It is tested on the SF3500. The SF3000,
SF3000 HD, SF3100 and GB350 use the same method and should work, but have not
all been tested. It does **not** run on the R36SX and R36HD, which write to the
framebuffer directly instead.

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an
`EXIT CODE:` line. Its first lines show the device, display mode and driver the
port picked. Include it when reporting a problem. To reset the game to its
original settings, delete `sdlzombies.dat`.

## Source and licenses

The game is licensed under the GNU General Public License, version 2 or later,
by its author; the licence text and credits are in
`roms/ports/sdlzombies/licenses/`. The artwork and sounds in `data/` are the
ones in the author's release, which his page
([hocwp.free.fr/sdlzombies.html](http://hocwp.free.fr/sdlzombies.html)) states
is under the GPL. The source for this port is the pinned `source/` submodule:
the first commit there is the author's unmodified tarball. PNG files are loaded
with stb_image (public domain or MIT). SDL 1.2 comes with the device's firmware
and is not included.
