# Streets of Rage Remake

Streets of Rage Remake is a fan-made side-scrolling beat 'em up in the style of the
classic Streets of Rage games. It runs on the BennuGD engine, and this port runs that
engine natively on TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/sorr-vita/tree/sf3500) of
[isage's sorr-vita](https://github.com/isage/sorr-vita).

This package does not include the game. You bring your own copy of Streets of Rage Remake
(version 5.2) and copy three items from it onto the SD card.

## Getting the game files

This page does not host or link the game files. Version 5.2, released in 2020, appears to be the
latest version, so it is best to look for it on the game's own community
rather than on a download site that has copied it. Searching the web for **Streets of Rage Remake
5.2 download** should lead to the community's release announcement for version 5.2, which links
the download. Make sure the version number is 5.2; this port was built and tested against it.

1. Download and unpack Streets of Rage Remake 5.2 on your computer. Inside the unpacked
   folder, find these three items: `SorR.dat`, the `mod` folder and the `palettes` folder.
   The rest of the download is for Windows (for example the `.dll` files inside `mod`) and is
   not used here; leaving it in does no harm.
2. On the SD card, open `roms/ports/sorr/gamedata/`. This folder comes with the port and holds
   a placeholder note. Copy the three items into it so the files end up like this:

```text
roms/ports/sorr/
└── gamedata/
    ├── PUT-GAME-DATA-HERE.txt   # the placeholder, can stay
    ├── SorR.dat
    ├── mod/
    └── palettes/
```

3. **Leave the music as it came.** The game's music files are stored at 44100 Hz and the port
   plays them as they are. Do not re-encode them.

Select **Streets of Rage Remake** under **Games → Ports** to start the game. If the files are
missing or in the wrong place, TreeFrogUI shows a help screen with a link to this page instead.
The game file is about 320 MB, and the music takes about 300 MB more, so allow some copying time.

## Saves and settings

The game runs from the `gamedata` folder, so anything it saves or changes is written there too,
next to the files you copied in, and the files the port ships are never touched.

## Controls

The pad is wired to the game's default keyboard keys:

| Button | Key |
|--|--|
| D-Pad | Arrow keys |
| A | V |
| B | C |
| X | X |
| Y | A |
| L1 | B |
| R1 | D |
| Start | Enter |
| Select | Esc |
| Select + Start (held together) | Quit immediately |

What each key does is shown in the game's own options and controls screen.

## Supported devices

The port loads the display and audio driver that TreeFrogUI selects for your device (it reads
it from `/tmp/tfdevice.env`), so one build covers every device that shows frames through that
driver. It is tested on the SF3500. The SF3000, SF3000 HD, SF3100 and GB350 use the same method
and should work, but have not all been tested. It does **not** run on the R36SX and R36HD, which
write to the framebuffer directly instead.

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an `EXIT CODE:` line. Its first
lines show the device, display mode and driver the port picked. Include it when reporting a
problem. If the audio crackles, check that you did not re-encode the music.

## Source and licenses

The runtime is zlib-licensed, with the credits of its authors (BennuGD, Fenix and the Vita port)
in `roms/ports/sorr/licenses/`. The source for this port is the pinned `source/` submodule. It
includes a small patch to SDL2 (`sf3500/sdl2-2.0.14-sf3500.patch`) that paces the audio thread
accurately, with a build script that applies it to the stock SDL2 release. SDL2 and SDL2_mixer are
linked into the program, and libpng and zlib come with the device's firmware. The game itself is
the work of its own authors and is not part of this package.
