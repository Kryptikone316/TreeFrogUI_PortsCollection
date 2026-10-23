# FroggyMania

FroggyMania is an experimental Sonic Mania libretro port for TreeFrogUI. It
needs the original game data, which this port does not include. The bundled
core is built for the TreeFrogUI MIPS32r2 hard-float ABI; it is not the upstream
SF2000/GB300 soft-float firmware build.

## Required file

Use your own copy of **Sonic Mania Plus for PC, version 1.06.0503**. Copy the
`Data.rsdk` file into this folder on the SD card:

```text
roms/ports/froggymania/Data.rsdk
```

Select **FroggyMania** under **Games → Ports** to start the game. The core
checks for the required file and the missing-files screen links back to this
guide.

## Controls

The game uses the handheld's gamepad. Directional buttons move through menus
and control Sonic; A/B jump or confirm; Start pauses. SELECT no longer opens
the in-game telemetry overlay.

Set **Frameskip** under **Options → Emulator options**:

- **Auto (audio)** is the default. It skips at most every other display update
  when PicoArch reports an audio underrun risk; game logic and audio still run
  on every frame.
- **Disabled** always displays each frame.
- **Skip 1 of 2** and **Skip 2 of 3** set a fixed display cadence.

## Upstream project

Original project: [Synaps33/FroggyMania](https://github.com/Synaps33/FroggyMania).
TreeFrogUI build: [tzubertowski/TreeFrogUI_FroggyMania](https://github.com/tzubertowski/TreeFrogUI_FroggyMania/tree/treefrogui).

The upstream release documents GB300 V2 testing. The TreeFrogUI build uses its
own libretro front end and RSDK backend adapter. On R36SX, native 424×240 game
frames are presented on the 4:3 screen. Auto frameskip trades display updates
for steadier audio when the frontend reports underrun risk. Install the matching
PicoArch R36SX update from the same TreeFrogUI release to get its frame pacing
fix; the game data remains user-supplied.
