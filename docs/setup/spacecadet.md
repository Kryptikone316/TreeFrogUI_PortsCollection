# Space Cadet Pinball

Space Cadet Pinball is a Libretro port of the 3D Pinball: Space Cadet game.
The engine is open source, but the original game data is external and is not
included in the Ports Collection. Get it from the upstream project's
[v1.0.0 release](https://github.com/Synaps33/FroggySpacePinbal/releases/tag/v1.0.0)
or visit the [original repository](https://github.com/Synaps33/FroggySpacePinbal).

From the release, add these files to `roms/ports/spacecadet/` on the SD card:

- `PINBALL.DAT` — required table, graphics, and game data.
- `PINBALL2.MID` — required font data.
- `PINBALL.MID` — optional music data.

For sound effects, download `spacecadet-data.zip` from the same release and
copy all of its `SOUND*.WAV` files into that same folder. The port can launch
without the WAV files, but sound effects will be silent.

The shared missing-files screen checks for the two required files and links to
this guide. Select **Space Cadet Pinball** from **Games → Ports** after setup.
