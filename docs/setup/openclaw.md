# Captain Claw / OpenClaw

The Ports Collection includes the OpenClaw libretro core for playing Captain Claw on
supported MIPS devices.

## Installation

Copy `CLAW.REZ` into the SD card's `roms/ports/openclaw/` directory:

```text
roms/ports/openclaw/
├── CLAW.REZ
├── ASSETS.ZIP
├── clacon.ttf
```

The requiring-game-data archive already supplies `ASSETS.ZIP` and `clacon.ttf` in that data folder,
and `roms/ports/Captain Claw.sh` as the visible launcher. Obtain `CLAW.REZ` from
a legally owned Captain Claw installation, or from the matching asset package in the original
[FroggyClaw repository](https://github.com/Synaps33/FroggyClaw).

Do not rename `CLAW.REZ`; the core looks for that exact filename. Start the
game by selecting **Games → Ports → Captain Claw**.

## Notes

- The core is currently an experimental SF3000/R36HD port.
- Saves are stored under the OpenClaw content directory on the SD card.
- The core renders the 640×480 game window into the device's panel while
  preserving the game's aspect ratio.

## Porting notes

OpenClaw is not a drop-in desktop build on these devices. This TreeFrogUI
integration is based on [Synaps33's original FroggyClaw port](https://github.com/Synaps33/FroggyClaw).
The SF3000 port must
use the same little-endian MIPS32r2 ABI and PIC/`-G0` settings as the other
working libretro cores. It also needs to link its SDL compatibility layer with
`-Wl,-Bsymbolic`; otherwise PicoArch's host SDL symbols can interpose on the
core and leave SDL's event subsystem uninitialised. Firmware-only timing and
display symbols must be implemented by the port rather than left as unresolved
runtime dependencies. These details are part of the build, not files users
need to copy to the SD card.
