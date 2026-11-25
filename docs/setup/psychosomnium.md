# Psychosomnium

Psychosomnium is a short, strange platform game from 2008 by Cactus (music by Zabutom, splash screen by Cow),
made in Game Maker: you play through a dream, talk to everyone, and try something odd whenever you are stuck.
This port runs it natively on TreeFrogUI devices with its own small engine, which re-implements the Game Maker
behaviours the game uses. The source is at
[Kryptikone316/Psychosomnium-port](https://github.com/Kryptikone316/Psychosomnium-port).

This package does not include any part of the game. You copy the game file in yourself, and the port reads the
pictures, sounds, music, text and levels from it the first time it starts.

## Getting the game file

The game file is `psycho.exe` (2,658,887 bytes), a free download listed on
<https://www.caiman.us/scripts/fw/f3172.html> ("Psychosomnium", freeware, 2008, by Cactus).

1. Download the game from that page. If you get `psycho1.zip`, open it and take `psycho.exe` out.
2. On the SD card, open `roms/ports/psychosomnium/gamedata/`. This folder comes with the port and holds a
   placeholder note. Copy `psycho.exe` into it, so the files end up like this:

```text
roms/ports/psychosomnium/
└── gamedata/
    ├── PUT-GAME-DATA-HERE.txt   # the placeholder, can stay
    └── psycho.exe
```

Select **Psychosomnium** under **Games → Ports** to start. If the file is missing or in the wrong place,
TreeFrogUI shows a help screen with a link to this page instead. The first start shows "Preparing the game
data" for a few seconds while it unpacks the file into `gamedata/cache/`; after that the start is immediate. If
the file is not the 2008 release, the port says so on screen.

## The launcher

The port opens a menu: **Play Game**, **Settings**, **Exit Game** (D-Pad up/down, **A** or **Start** to choose,
**B** to go back). The first row of **Settings** is the **language**. The menus, the pause and end screens and the
settings descriptions are translated into the twelve languages of TreeFrogUI (English, Deutsch, Español,
Français, Italiano, Polski, Português, Türkçe, Русский, 日本語, 简体中文, العربية). The game's own dialogue is
available in the other languages through an optional download, see below. The other settings:

| Setting | What it does |
|--|--|
| Language style | Cuss-friendly (the game's own words) or Family-friendly (mild words: *damn* becomes *darn*, *hell* becomes *heck*) |
| Dialogue text | The game's own letters (the unreadable M, N and W redrawn) or a plain, larger typeface |
| Bunny hops | Higher hops with a little hang time, or the original hop (the bunny room is hard with the pad's input delay) |
| Bee flight | Finer control (hold Up to climb, hold Down to sink) or the original one flap per press |
| Jump | A new press for every jump, or the original (holding the button keeps jumping) |
| Jump buffer, Ledge grace | How early before landing, and how long after leaving an edge, a jump still counts |
| Button smoothing | Ignores very short drop-outs of a held button |
| Screen lag fix | Skips a picture now and then when the display has queued up |

Changes are saved at once in `gamedata/psychosomnium.cfg` and used when you press **Play Game**. The defaults
make the game playable on the handheld; each tweak can be switched back to the original behaviour.

## Controls

| Button | Action |
|--|--|
| D-Pad left / right | Walk (fly, as the bee) |
| D-Pad up, B or Y | Jump (hold for a higher jump); climb, as the bee |
| D-Pad down | Sink, as the bee |
| A or X | Punch (for the big guy), next line of text |
| Start | Start the game on the title screen; pause and resume in the game; leave the game on the "THE END" screen |
| Select + Start (held together for half a second) | Quit |

## Dialogue translations (optional download)

The translations of the game's dialogue are not in this package: they are an unofficial fan translation of Cactus's
script, so they are offered separately, with credit to the original authors, and will be removed if they ask. Download
`psychosomnium-dialogue-translations.zip` from the
[release page](https://github.com/Kryptikone316/Psychosomnium-port/releases/latest) and put it, unopened, into
`roms/ports/psychosomnium/lang/`. Until then the **Language** row says that the dialogue translation is not
installed, and the dialogue stays in English. The translations were written without review by native speakers.

## Saves, settings and logs

The game has no saves. Your settings are in `gamedata/psychosomnium.cfg` (plain lines, editable by hand; delete it
to get the defaults back). To unpack the game file again, delete `gamedata/cache/`.

Every launch writes `log.txt` in the port folder and ends it with an `EXIT CODE:` line; the previous run is kept
as `log.prev.txt`, and a run that lasted less than ten seconds as `log.short.txt`. Include them when reporting a
problem.

## Supported devices

The port loads the display driver that TreeFrogUI selects for your device (it reads it from
`/tmp/tfdevice.env`), so one build covers every device that shows frames through that driver. It is tested on the
SF3500. The SF3000, SF3000 HD, SF3100 and GB350 use the same method and should work, but have not all been tested.
It does **not** run on the R36SX and R36HD, which write to the framebuffer directly instead.
