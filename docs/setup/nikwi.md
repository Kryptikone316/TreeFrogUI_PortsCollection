# Nikwi Deluxe

Nikwi Deluxe is a 2D platform game by Kostas Michalopoulos (Bad Sector,
Slashstone): a platform adventure with a password-based level select. This port
runs it natively on TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/nikwi/tree/sf3500) of the
author's [source release](https://github.com/jbradish/nikwi). It needs no extra
game data: everything is included, except the optional music described below.

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

The original game has no music. This port can play one pre-rendered track per
level, but the tracks are not included: they were rendered from third-party
tracker modules whose licences could not be verified. Without them the game
runs normally with sound effects only.

To add your own, put up to nine files named `bgm0.raw` to `bgm8.raw` in
`roms/ports/nikwi/data/audio/`. Each is raw audio: no header, mono, 48000 Hz,
signed 16-bit little endian, and it loops. For example, with ffmpeg:

```sh
ffmpeg -i song.ogg -ac 1 -ar 48000 -f s16le bgm0.raw
```

Level *n* plays `bgm`*(n mod 8)*`.raw`, so tracks 0 to 7 cover the levels, and
`bgm8.raw` plays on the title and menu screens. Only the files you provide are
played.

## Audio tuning

`hwdsp.txt` in the port folder sets a small bass, treble and master-gain
adjustment for the device's speaker. Edit its values or set `enabled=0` and
relaunch. If the file is missing, neutral defaults are used.

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
author's own history. SDL 1.2 comes with the device's firmware and is not
included.
