# Nikwi Deluxe

Nikwi Deluxe is a 2D platform game by Kostas Michalopoulos (Bad Sector,
Slashstone): a platform adventure with a password-based level select. This port
runs it natively on TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/nikwi/tree/sf3500) of the
author's [source release](https://github.com/jbradish/nikwi). It needs no extra
game data: everything is included, and an optional music pack is described below.

Select **Nikwi Deluxe** under **Games → Ports** to start the game.

## Controls

| Button | Action |
|--|--|
| D-Pad | Move (Up also jumps) |
| A | Jump during gameplay, confirm elsewhere |
| B | Pause / back |
| Start | Menu confirm |
| X | Backspace (password screen) |
| Select + Start (held together) | Quit immediately |

On the password screen, Up and Down cycle through the letters, A adds the
highlighted letter, X erases the last one and Start accepts the password.

## Music

The original game has no music. An optional music pack adds six tracks: five
for the levels and one for the title and menu screens. They were arranged
specifically for this title and are released under CC0. The pack is a separate
download (7 MB) so the port itself stays small:

1. Download [nikwi-music-pack.zip](https://github.com/Kryptikone316/nikwi/releases/download/music-pack-1/nikwi-music-pack.zip).
2. Unzip it and copy the contents of its `data` folder into
   `roms/ports/nikwi/data/`, so that `bgm0.ogg` to `bgm4.ogg` and `bgm8.ogg`
   end up in `roms/ports/nikwi/data/audio/`.
3. Start the game. The title screen plays `bgm8`, and the levels play the level
   tracks in turn.

A track is decoded in the background while it plays, so the first second or two
can be silent; the `music:` lines in `log.txt` show how long each one took.
Delete the files to remove the music again.

To use your own music instead, name the files `bgm0` to `bgm7` for the levels
(any number from one to eight, starting at `bgm0`; the game plays them in turn)
and `bgm8` for the title screen. They can be Ogg Vorbis (`.ogg`, mono or stereo,
48000 Hz) or raw audio (`.raw`: no header, mono, 48000 Hz, signed 16-bit little
endian). For example, with ffmpeg:

```sh
ffmpeg -i song.mp3 -ac 1 -ar 48000 -c:a libvorbis -q:a 4 bgm0.ogg
```

## Audio tuning

`hwdsp.txt` in the port folder sets a small bass, treble and master-gain
adjustment for the device's speaker. Edit its values or set `enabled=0` and
relaunch. If the file is missing, neutral defaults are used.

## Frame rate

`nikwi.txt` in the port folder holds one setting, `fps`. The game moves its
characters 50 times a second, so the default of `fps=50` gives every frame
exactly one step of movement and leaves the processor idle between frames. Set
`fps=0` to remove the limit. Edit the file and relaunch; no rebuild is needed.

## Supported devices

The port loads the display and audio driver that TreeFrogUI selects for your
device (it reads it from `/tmp/tfdevice.env`), so one build covers every device
that shows frames through that driver. It is tested on the SF3500. The SF3000,
SF3000 HD, SF3100 and GB350 use the same method and should work, but have not
all been tested. It does **not** run on the R36SX and R36HD, which write to the
framebuffer directly instead.

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an
`EXIT CODE:` line. Its first lines show the device, display mode and driver the
port picked. Include it when reporting a problem.

## Source and licenses

The game's source is under the zlib licence and everything else (graphics,
scripts, sounds and levels) under the WTFPL, as stated by the author; the texts
and credits are in `roms/ports/nikwi/licenses/`. The tile and object files in
`data/` are converted from the author's own images with his `bmp2ut` tool. The
source for this port is the pinned `source/` submodule, which keeps the
author's own history. Music is decoded with stb_vorbis (public domain). SDL 1.2
comes with the device's firmware and is not included.
