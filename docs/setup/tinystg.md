# TinySTG

TinySTG is a compact vertical bullet-hell shooter by kuran_kuran (2022). This
port runs it natively on TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/TinySTG/tree/sf3500) of the
[upstream project](https://github.com/kuran-kuran/TinySTG). It needs no extra
game data: everything is included.

Select **TinySTG** under **Games → Ports** to start the game. Your progress is
saved in the port folder:

```text
roms/ports/tinystg/
└── TinySTG/
    └── TinySTG.sav    # your high score and settings, created on first save
```

## Controls

| Button | Action |
|--|--|
| D-Pad | Move |
| A | Shoot |
| B | Bomb |
| Select + Start (held together) | Quit immediately |

## Picture settings

`video.txt` in the port folder controls how the picture is drawn. Edit it and
relaunch; no rebuild is needed. The game draws a very small 80x64 image, so it
is enlarged in software and then smoothed by the device's display driver.

| Setting | Meaning |
|--|--|
| `out_w`, `out_h` | Size of the enlarged frame. The default 320x240 runs at about 59 frames per second on the SF3500. 480x360 and 640x480 are sharper (the driver accepts at most 640x480) but cost more time per frame. |
| `fit` | `stretch` fills the frame, `integer` keeps whole-number pixels with black borders. |
| `contrast`, `saturation`, `gamma` | Colour adjustments; 1.00 leaves a value unchanged. The game's art has only 256 colours, so these make it punchier but cannot add colours. |
| `scanlines`, `grid` | Optional darker pixel edges (0 is off, up to 80 percent). |

After changing a setting, check `log.txt`: the `tinystg loop` lines end with the
frame rate. Staying at 50 or above leaves comfortable headroom.

## Audio tuning

`hwdsp.txt` sets a small bass, treble and master-gain adjustment for the
device's speaker. Edit its values and relaunch. If the file is missing,
neutral defaults are used.

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
port picked. Include it when reporting a problem. To reset your saved progress,
delete `TinySTG/TinySTG.sav`.

## Source and licenses

The game is licensed under the MIT license; the licence text and credits are in
`roms/ports/tinystg/licenses/`. The source for this port is the pinned
`source/` submodule. The background music file `TinySTG/bgm.adp` is the one
shipped in the upstream repository.
