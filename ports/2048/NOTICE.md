# Notice

This is an unofficial build of the **libretro 2048** core for the Data Frog SF3500 (TreeFrogUI),
run by picoarch. It is not affiliated with or endorsed by Gabriele Cirulli.

* 2048 is a game by Gabriele Cirulli (<https://github.com/gabrielecirulli/2048>, MIT), itself
  based on 1024 by Veewo Studio and Threes by Asher Vollmer.
* The core is by the libretro team and contributors: <https://github.com/libretro/libretro-2048>.
  It is released into the public domain under the Unlicense (`LICENSE-LIBRETRO-2048`).
  The binary is built from that source **unmodified** by `build.sh`; nothing in the game was changed for the SF3500.
  The `source/` submodule is <https://github.com/Kryptikone316/2048-port>: libretro-2048 with its full history
  (up to commit `39333f7`) and one added commit with the build script and a README (and without upstream's CI files).
* The core compiles in a few files of libretro-common (the RetroArch team, MIT); see
  `licenses/THIRD-PARTY.txt`.
* The core's built-in text font (`noncairo/font2.c`) is a table of Apple IIgs character
  shapes taken from an emulator, as shipped upstream; the upstream source does not state a
  licence for it, and it is listed in `licenses/THIRD-PARTY.txt`.
* The box art is a floppy-disk icon made by the port author (AI-assisted fan art).
* This software is provided as-is, without warranty of any kind. Use at your own risk.
