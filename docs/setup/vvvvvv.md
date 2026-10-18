# VVVVVV

The Ports Collection includes a Libretro port adapted from [James O'Farrell's OpenDingux
VVVVVV port](https://github.com/jamesofarrell/VVVVVV). The core outputs 320×240
video at 30 FPS. Game data is not included; use `data.zip` from your legally
obtained VVVVVV copy or the separately distributed Make and Play edition.

Copy `data.zip` from your legally obtained VVVVVV installation into:

```text
roms/ports/vvvvvv/data.zip
```

The archive must include these files:

- `graphics/tiles.png`, `tiles2.png`, `tiles3.png`, `entcolours.png`,
  `sprites.png`, `flipsprites.png`, `font.png`, `fontmask.png`,
  `teleporter.png`, `levelcomplete.png`, `minimap.png`, `covered.png`,
  `elephant.png`, `gamecomplete.png`, `fliplevelcomplete.png`,
  `flipgamecomplete.png`, `site.png`, `site2.png`, `site3.png`,
  `ending.png`, and `site4.png`
- `sounds/jump.wav`
- `vvvvvvmusic.vvv`

The shared required-files screen lists `data.zip` when it is missing and links
to this guide. Select **VVVVVV** from **Games → Ports** after setup. The core
reads the ZIP directly and stores ordinary saves in the frontend's `VVVVVV`
save directory. Libretro save states are not supported. The Ports Collection
archive includes matching box art for the launcher.
