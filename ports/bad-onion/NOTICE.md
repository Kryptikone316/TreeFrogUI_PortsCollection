# Notice

*Bad Onion* is a freeware game by Outhouse Software (2003). This port is not affiliated with or endorsed by the
author.

* **The game files are the author's, unchanged:** `badonion.dcb`, the graphics (`data00.fpg` to `data13.fpg`),
  the font, the sound effects, the two songs and his readme (`readme.txt`). The readme says the game is freeware
  and asks for it to be passed on.
* **`fxi.mipsel`** is the Fenix 0.80 interpreter (GPL version 2 or later, Jose Luis Cebrian Pague and the Fenix
  team) built for this handheld, with a small layer (in `source/`) that replaces SDL 1.2 and sends the picture,
  sound and controls to the device. The source is in the `source/` submodule, which is also at
  https://github.com/Kryptikone316/bad-onion-port.
* SDL2 and SDL2_mixer (zlib licence), libxmp-lite (MIT), libpng and zlib are linked in. The licence texts are in
  `licenses/`.
* The display, audio and gamepad glue is derived from TreeFrogUI's pico286 SF3000 patch and picoarch's SF3000
  code.
* The box art (a floppy-disk illustration with the game's logo) was supplied by the port author and is used only
  to identify the game.
* This software is provided as-is, without warranty of any kind. Use at your own risk.
