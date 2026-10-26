# Hex-a-hop

Hex-a-hop is a puzzle game by Tom Beaumont. You hop across a hexagonal grid
whose tiles crumble behind you, so every level is a puzzle about which tiles
you can still afford to visit. This port runs it natively on TreeFrogUI
devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/hex-a-hop/tree/sf3500) of the
upstream 1.1.0 source. It needs no extra game data: everything is included.

Select **Hex-a-hop** under **Games → Ports** to start the game. Progress is
saved in the port folder:

```text
roms/ports/hexahop/
└── .hex-a-hop/    # your saved progress, created on first save
```

## Controls

| Button | Action |
|--|--|
| D-Pad | Move (up, down, lower-left, lower-right) |
| L1 | Move upper-left |
| R1 | Move upper-right |
| A | Confirm |
| B / L2 | Undo |
| Start | Pause |
| Select + Start (held together) | Quit immediately |

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an
`EXIT CODE:` line. Include it when reporting a problem. To start over, delete
the `.hex-a-hop` folder.

## Source and licenses

The game is licensed under the GNU General Public License, version 2. The
source for this port is the pinned `source/` submodule. The port also bundles
SDL_ttf (zlib license) and stb_vorbis (public domain / MIT).

Most music and sound effects are the original author's own free assets. The
files marked `-nonfree` in `data/` (three music tracks and several sound
effects) are third-party Creative Commons works (BY-NC-SA 3.0 and Sampling
Plus 1.0), redistributed on the same non-commercial terms as the upstream
release. Their attribution is in `roms/ports/hexahop/licenses/`.
