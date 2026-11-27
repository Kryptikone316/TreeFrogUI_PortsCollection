# Notices

This port is an engine for Psychosomnium (Cactus, 2008). It contains **no** artwork, sound, music, text or level data
from the game: all of that is read from the player's own `psycho.exe` on the first start (and cached next to it).
The game rules in `game.c` are an independent re-implementation of how the original behaves.

Third-party code included:

* **jar_xm** (XM module player), derived from libxm by Romain "Artefact2" Dalmaso, repackaged by Joshua Adam Reisenauer.
  Licence: WTFPL v2 (see licenses/WTFPL.txt).
* **stb_image** (only its zlib decoder is used), Sean Barrett. Public domain / MIT (see licenses/stb-LICENSE.txt).
* **font8x8_basic** (on-screen messages), Daniel Hepper, from the font by Marcel Sondaar / IBM PC. Public domain.
* **DejaVu Sans Condensed Bold** (readable dialogue and pause screen; glyph shapes baked into `clearfont.h`), Bitstream Vera / DejaVu fonts licence (see licenses/DejaVu-LICENSE.txt).
* **Noto Sans CJK** (Japanese and Chinese menu text and the language names, glyph shapes baked into `lang/ja.pak`, `lang/zh.pak` and `clearnames.h`), SIL Open Font License 1.1 (see licenses/Noto-CJK-copyright.txt).
* **Language packs** (`lang/*.pak`): menu texts in 11 languages written for this port (machine-quality translations, not reviewed by native speakers) and the glyphs they need.
  The game's dialogue translations are NOT part of this package: they are an unofficial fan translation of Cactus's text (a derivative of it), published separately as the optional
  download `psychosomnium-dialogue-translations.zip` with credit to the original authors and a promise to remove them if asked. The launcher reads that zip from the `lang` folder.
* Platform glue (display, pad, audio mixer for the SF3500) shared with the other ports by the same author.

Box art: the port author's floppy-disk design, used to identify the game.
