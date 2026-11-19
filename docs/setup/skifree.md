# SkiFree

SkiFree is the 1991 skiing game by Chris Pirih: ski down the mountain, dodge trees and rocks,
jump off ramps, and keep ahead of whatever lives up there. This port runs it natively on
TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/skifree_sdl/tree/sf3500) of
[jeff-1amstudios's SDL conversion](https://github.com/jeff-1amstudios/skifree_sdl) of Eric Fry's
[decompilation](https://github.com/yuv422/skifree_decomp) of version 1.04. It adds a launcher with
four themes (Classic, Modern 16-bit, Modern 8-bit and TI-92), sounds, and a few options.

This package does not include the game's artwork. You copy the game file in yourself, and the port
reads the sprites from it.

## Getting the game file

The game file is `ski32.exe` (SkiFree 1.04 for Windows), from the game's own site.

1. Open <https://ski.ihoc.net/> and download SkiFree from the **Download** section. Use the plain
   `ski32.exe` (about 116 KB), or the `ski32.zip` that contains it, not the 16-bit `ski.zip` and not
   the "rebuild" files.
2. On the SD card, open `roms/ports/skifree/gamedata/`. This folder comes with the port and holds
   a placeholder note. Copy `ski32.exe` into it, so the files end up like this:

```text
roms/ports/skifree/
└── gamedata/
    ├── PUT-GAME-DATA-HERE.txt   # the placeholder, can stay
    └── ski32.exe
```

Select **SkiFree** under **Games → Ports** to start the game. If the file is missing or in the wrong
place, TreeFrogUI shows a help screen with a link to this page instead. If the file is not version
1.04, the port says so on screen.

## The launcher

The port opens a menu:

| Entry | What it does |
|--|--|
| Play Game | Start skiing |
| How To Play | The rules and the buttons |
| Audio / Video | Sound, volume, screen size and frame rate |
| Gameplay | Frame timing (smooth, or the original 40 ms steps), yeti distance and game speed |
| Exit | Back to the front-end |

**L1 / R1** on the menu change the theme: Classic, Modern (16-bit), Modern (8-bit) and TI-92. A small plate
names the theme whenever it changes. The theme also sets how the game looks once you press Play.
**Select + Start** while skiing returns to the menu.

## Controls

| Button | Action |
|--|--|
| D-Pad left / right | Turn |
| D-Pad down | Straight downhill |
| D-Pad up | Shuffle uphill when stopped |
| Y / A | Diagonal turns |
| B or R1 | Jump; press again in the air for tricks (also starts a new game after a wipeout) |
| X | Small hop |
| Select | Pause |
| Start | New game |
| Select + Start (held together) | Back to the menu (and out of the port, from the menu) |

In the menu, the D-Pad moves, **A** selects, **B** goes back and **L1 / R1** change the theme.

## Saves, settings and your own sounds

The game runs from the `gamedata` folder, so what you supply and what the game creates stay next to each
other, and the files the port ships are never touched:

```text
roms/ports/skifree/gamedata/
├── ski32.exe          # the game file you copied in
├── skifree.txt        # your settings, written by the menu (plain lines, editable by hand)
└── sounds/custom/     # optional: your own .wav files, see the note inside
```

The port has its own sounds. To replace any of them, drop `.wav` files named as described in
`gamedata/sounds/custom/README.txt`; the **Sound set** option in the menu switches them on and off. To
start over, delete `skifree.txt`.

The sounds and the art for the two Modern looks are already in the port folder (`sounds/`, `sprites16/`, `sprites8/`).
Each is also a separate download on the source's
[release page](https://github.com/Kryptikone316/skifree_sdl/releases/tag/modules-1), to unzip into `roms/ports/skifree/`
for a smaller install or to put one back.

## Supported devices

The port loads the display driver that TreeFrogUI selects for your device (it reads it from
`/tmp/tfdevice.env`), so one build covers every device that shows frames through that driver. It is
tested on the SF3500. The SF3000, SF3000 HD, SF3100 and GB350 use the same method and should work, but
have not all been tested. It does **not** run on the R36SX and R36HD, which write to the framebuffer
directly instead.

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an `EXIT CODE:` line. Include it when
reporting a problem.

## Source and licenses

The source for this port is the pinned `source/` submodule. The credits are in
`roms/ports/skifree/licenses/CREDITS.txt`. SkiFree is by Chris Pirih; the game's site states no licence or
redistribution terms, which is why the game file is not included. The assets made for this port (sounds,
sprite packs, launcher art) are under the MIT license, in `licenses/LICENSE-ASSETS.txt`.
