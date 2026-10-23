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
and control Sonic; A/B jump or confirm; Start pauses; Select is mapped as the
secondary menu button. Shoulder buttons are available as extra game actions.

## Upstream project

Original project: [Synaps33/FroggyMania](https://github.com/Synaps33/FroggyMania).
TreeFrogUI build: [tzubertowski/TreeFrogUI_FroggyMania](https://github.com/tzubertowski/TreeFrogUI_FroggyMania/tree/treefrogui).

The upstream release documents GB300 V2 testing. The TreeFrogUI build uses its
own libretro front end and RSDK backend adapter. On the tested R36SX card, the
game reaches the menu, but display placement and audio are not yet correct.
