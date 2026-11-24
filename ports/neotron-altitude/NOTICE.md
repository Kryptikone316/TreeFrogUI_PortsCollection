# Notice

Altitude is a free game by Daniel "Imerion" Eriksson (NeoTron Games). This port is a tribute to NeoTron
Games, whose free games have mostly disappeared from the web. It is not affiliated with or endorsed by
the author.

* **The game files are the author's, unchanged.** The graphics (`altitude.fpg`), the two songs (`alt1.mod`,
  `alt2.mod`), the sound files, the starting high-score file (`score.dat`, and `score-creator.dat`, an untouched second copy the launcher uses for *Reset high scores*) and his readme
  (`Readme-altitude.txt`) are byte for byte as he published them. His licence allows the game to be spread
  freely; the content must not be changed and the game must not be sold (`Readme-altitude.txt`).
* **`altitude.dcb`** is his script (`altitude.prg`, unmodified, kept in `source/game/`) compiled with BennuGD,
  because the compiled file he published is for the Fenix engine, which does not run on this device. The
  script text is not edited; `source/tools/make-bennu-prg.sh` only adds the `import` lines that BennuGD
  requires to a temporary compile copy.
* **The launcher, the computer opponent, the pause and the score tracker are mods.** The launcher
  (`launcher.dcb`) and the other three (inside `bgdi.mipsel`) sit beside the game and leave its files alone. They were written for this
  port and are released under the Unlicense (`source/LICENSE`).
* **The runtime** (`bgdi.mipsel`) is BennuGD (zlib licence, SplinterGU and the Fenix team), by way of the
  Vita SoRR port by Sarcastic Cat. It is changed here, so it is a modified version and not the original
  software. SDL2, SDL2_mixer (zlib licence), libpng, zlib and libxmp-lite (MIT) are linked in. The text of
  the launcher is rendered from DejaVu Sans glyphs (Bitstream Vera licence). The licence texts are in
  `licenses/`.
* The display, audio and gamepad glue is derived from TreeFrogUI's pico286 SF3000 patch and picoarch's
  SF3000 code.
* The box art (a floppy-disk illustration carrying the game's own logo and a screenshot) was supplied by the
  port author and is used only to identify the game.
* This software is provided as-is, without warranty of any kind. Use at your own risk.
