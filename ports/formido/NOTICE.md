# Formido on the Datafrog SF3500

Formido is a top-down shooter against alien insects, written by Mika Halttunen
(code, game design, artwork) with music by Josh Schroeder. Version 1.0.1, released
under the GNU General Public License, version 2 or (at your option) any later
version: `GPL_license.txt`, and the game's own `README`.

Original game: https://mhgames.org/formido/

## What was changed for this port

- The video, gamepad and sound calls go through `sf3500/sf3500_glue.cpp`: SDL runs on its
  dummy video driver and every frame is handed to the handheld's display driver; the gamepad
  becomes key presses; the few SDL_mixer calls the game makes are mixed in software and played
  through the handheld's audio driver; images (PCX/PNG/JPEG/BMP) are decoded without SDL_image.
- Twin-stick controls (D-pad walks, L1 + face buttons aim and fire) as the default; the original tank controls stay available with `controls = 0` in `formido.cfg`.
- High-score names are entered with the D-pad (the original reads a keyboard).
- The settings menu has rows for controls, frame limit and credits instead of the key bindings (the gamepad has a fixed layout); its background `menu2_sf.dat` is upstream's `menu2.dat` with the painted key labels removed.
- An enhanced game (cross-shaped map of five screens, power cells that change what the pylons offer, bug ranks, an adaptive hive; see README.md). Its code is in `src/enhanced.cpp`; the classic game is unchanged.
- Source changes are marked `#ifdef SF3500`; everything else is the upstream 1.0.1 source.

## Libraries and credits

- `stb_image.h`, `stb_vorbis.c` (Sean Barrett): public domain / MIT.
- The display, audio and gamepad glue (`hwdisp`, `hwaudio`, `joykey`, `sf3500_mixer`) is derived from
  TreeFrogUI's pico286 SF3000 patch and is shared by the other SF3500 ports.
- Box art: floppy-disk illustration made for this collection.

## Licences and provenance (audited 2026-11-22)

The whole port is distributed under the GNU General Public License, version 2 or (at your option) any later
version (`LICENSE`, the same text as `GPL_license.txt`). Files that did not already carry a licence notice have
an `SPDX-License-Identifier: GPL-2.0-or-later` line. Where each part comes from, and how sure we are of its terms:

| Part | Origin | Terms | Status |
|---|---|---|---|
| Game code, game design, artwork, fonts | Mika Halttunen, Formido 1.0.1 | GPL v2 or later (the game's `README`, section 1; the author's web page says GPL as well) | stated by the author |
| Music (`data/music*.ogg`, five files) | Josh Schroeder, credited in the `README` and in the game's own credits screen ("MUSIC: josh schroeder", with a credits track of its own) | the author ships it inside his own GPL release (`formido-1.0.1.tar.gz`, "source code and data") and offers it as a separate download; no separate licence text for it was found | **not confirmed**: redistributed unmodified, as upstream does; the game runs without it |
| Port code (`#ifdef SF3500` changes, `src/enhanced.cpp`, `src/tuning.cpp`, `tools/`) | this port | GPL v2 or later | ours |
| Enhanced-game art made by `tools/make_wasteland.py`, `make_center_enh.py`, `make_healplant.py`, `make_menu_clean.py` | generated here from upstream's art plus procedural noise | GPL v2 or later (derived from upstream's art) | ours / derivative |
| Sounds `flame.dat`, `flame_start.dat`, `tyrant_roar.dat` | synthesised by `tools/make_sounds.py`, no samples | GPL v2 or later | ours |
| Display, audio and gamepad glue (`sf3500/hw*.cpp`, `joykey.cpp`, `sf3500_mixer.cpp`) | derived from TreeFrogUI's pico286 SF3000 patch | distributed under GPL-compatible terms with the TreeFrogUI maintainer's agreement; TreeFrogUI's own licence is not GPL-compatible, so nothing else of it is used | agreement recorded, not a formal licence grant |
| `stb_image.h`, `stb_vorbis.h` | Sean Barrett | public domain / MIT (choice of two, stated at the end of each file) | stated in the files |
| SDL 1.2 | libsdl.org | LGPL v2.1; linked dynamically from the device's own library, not shipped | not redistributed |
| Box art (`package-src/boxart.png`) | made for this ports collection | the collection's own art | n/a |

Music pack: the `.ogg` files are the only part whose terms rest on the upstream package alone. If Josh Schroeder or
Mika Halttunen asks for them to be removed, delete `data/music*.ogg`; the game then plays without music.
