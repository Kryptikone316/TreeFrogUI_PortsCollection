# Duke Nukem 3D

The Ports Collection includes an experimental SF3000-family libretro port from [Synaps33/FroggyDuke](https://github.com/Synaps33/FroggyDuke). Install the appropriate archive; it provides the core and launcher entry, but not the commercial game data.

Copy the legally owned game data into `roms/ports/duke3d/`:

```text
roms/ports/duke3d/DUKE3D.GRP
roms/ports/duke3d/DUKE.RTS
```

Copy your legally obtained `DUKE3D.GRP` (Atomic Edition v1.5 or Shareware v1.3d) and `DUKE.RTS` into `roms/ports/duke3d/` on the SD card, then select **Duke Nukem 3D** from **Games → Ports**.

The R36HD port is experimental. Audio pacing has been optimized in the current local build, but the change has not yet been verified on hardware; sound may still be slow or choppy.

The open-source EDuke32 BUILD dependency is fetched at the pinned revision during the build and is not bundled into TreeFrogUI.
