# Notices for the SF3500 port

## What is whose

| Part | Author | Terms |
|--|--|--|
| SkiFree (the game, its art and sounds) | Chris Pirih, 1991 | The game's site, https://ski.ihoc.net/, states no licence or redistribution terms. **None of the game's art is distributed here.** The port reads it from the player's own `ski32.exe` (version 1.04) when it starts. |
| Decompiled source | Eric Fry, [skifree_decomp](https://github.com/yuv422/skifree_decomp) | No licence file upstream. |
| SDL conversion | jeff-1amstudios, [skifree_sdl](https://github.com/jeff-1amstudios/skifree_sdl) | No licence file upstream. |
| Text font (`sf3500/ttfshim.c`) | Daniel Hepper, [font8x8](https://github.com/dhepper/font8x8) | Public domain. |
| SF3500 display, audio, pad and mixer modules (`sf3500/hwdisp.*`, `hwaudio.*`, `joykey.*`, `sf3500_mixer.*`, `tfenv.h`) | glue code derived from TreeFrogUI's pico286 SF3000 patch | Used with the TreeFrogUI maintainer's permission to distribute it under GPL-compatible terms. It is shared with the other SF3500 ports. |
| The rest of the SF3500 port code (`sf3500/`, the patches under `src/` marked `SF3500`, the scripts in `sf3500/tools/`) | this fork | No licence stated yet: the upstream projects state none, and nothing here changes that. |
| Assets made for this port (listed below) | the port author | MIT, see `sf3500/LICENSE-ASSETS` |
| Box art (`sf3500/assets/boxart.png`) | the port author | Made for this port and used to identify the game. It shows SkiFree's own logo and characters, which remain Chris Pirih's. |

## Assets made for this port (MIT)

- the Modern (16-bit) sprite pack, `sprites16/` (drawn by `sf3500/tools/make_sprites16.py` and `sprites16_chars.py`)
- the Modern (8-bit) sprite pack, `sprites8/` (derived from it by `sf3500/tools/make_sprites8.py`)
- the built-in sounds, `sounds/` (synthesised by `sf3500/tools/make_sounds.py`)
- the launcher artwork: the Classic backdrop (`sf3500/assets/launcher-backdrop.png`), the 16-bit and 8-bit launcher scene
  (drawn in `sf3500/theme16.c`) and the TI-92 and 16-bit menu looks
- the box art, `sf3500/assets/boxart.png` (the game's own logo and characters in it stay Chris Pirih's)

The ChatGPT concept images that guided the Modern themes' style were reference only; none of their pixels are used.

## Credit where it is due

- **Michael Holt (psigoo)**, http://calc.psigoo.com: his SkiFree for the TI-89 / TI-92 Plus inspired the TI-92 theme. None of
  his work is used.
