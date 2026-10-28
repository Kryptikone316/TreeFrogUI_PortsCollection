# Chocolate Doom

[Chocolate Doom](https://github.com/chocolate-doom/chocolate-doom) is a source
port that plays id Software's Doom the way the original DOS game did. This port
runs version 3.1.1 natively on TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/chocolate-doom/tree/sf3500) of
upstream's source. The shareware episode of Doom is included, so it is ready to
play; the full games and add-on levels are optional and use your own files.

Select **Chocolate Doom** under **Games → Ports** to start the game.

## Controls

| Key | Action |
|--|--|
| D-Pad | Move / turn, menu navigation |
| A | Fire, menu select |
| B | Use / open doors, menu back |
| X | Strafe (hold with D-Pad left / right) |
| Y | Run |
| L1 | Previous weapon; "No" in confirmation prompts |
| R1 | Next weapon; "Yes" in confirmation prompts |
| Start | Menu (Esc) |
| Select | Automap (Tab) |
| Select + Start | Quit immediately |

**Switching weapons.** The number keys are not on a gamepad, so L1 and R1 step through the weapons you currently have: R1 moves to the next one, L1 to the previous one, and either wraps around at the end. Weapons you have not picked up yet are skipped, so pressing R1 a few times always lands on one you can use. The order is the usual one: fist, chainsaw, pistol, shotgun, super shotgun (Doom II), chaingun, rocket launcher, plasma rifle, BFG 9000.

## Setup

The shareware episode (`DOOM1.WAD`, the first episode of Doom) is included in the `gamedata` folder and is ready to play.

## Playing the full games

The full games are not included, because only the shareware episode may be freely distributed. If you own them, you can copy the game files from your own copy:

| Game | File |
|--|--|
| Ultimate Doom (Doom) | `DOOM.WAD` |
| Doom II | `DOOM2.WAD` |
| Final Doom: Plutonia | `PLUTONIA.WAD` |
| Final Doom: TNT | `TNT.WAD` |

Copy the files into `roms/ports/chocolatedoom/gamedata`, next to `DOOM1.WAD`. File name capitals do not matter. They must be the original versions of the games (the DOS-era 1.9 files). There is no renaming or other setup.

**Where to find the files.** If you bought the games on Steam, the product is *DOOM + DOOM II* (App ID 2280). In its install folder (`steamapps/common/Ultimate Doom`), the `base` folder holds the original files: `DOOM.WAD`, `doom2/DOOM2.WAD`, `plutonia/PLUTONIA.WAD` and `tnt/TNT.WAD`. Do not use the `rerelease` folder: those are the 2024 remastered versions, made for a different engine. To download the files without running the game, install it from the Steam client (on Linux this needs Steam Play enabled), or use SteamCMD:

```sh
steamcmd +@sSteamCmdForcePlatformType windows +login <your user name> +force_install_dir <folder> +app_update 2280 validate +quit
```

Copies from the original CDs or another store work the same way, as long as they are the original `.WAD` files.

## Choosing the game and add-ons

When there is more than one game file, or any add-on level files, a small loader screen appears before the game starts. It reads the `gamedata` folder, checks each `.wad` file's header, and lists only valid ones: the game files in the **Game** drop-down and add-on level files in the **Add-on** drop-down (**None** is the default). It uses the game's own font, logo and skull, taken from the game file at run time.

- D-Pad Up and Down move between the drop-downs and the buttons; A opens a drop-down, Up and Down pick an entry, A accepts and B closes it.
- **Set WAD** saves your choice in `wad.txt` and starts the game. The same choice is used next time, so the loader just shows it again.
- **Cancel** ignores any changes and starts the game with whatever was saved before.
- **Exit**, or Select + Start, leaves without starting the game.

With only the shareware `DOOM1.WAD` and no add-ons, the loader does not appear and the game starts straight away.

**Add-on levels.** Copy the add-on `.wad` files (the ones that need a base game) into `gamedata` too. The list tags each one `Doom 1 maps` or `Doom II maps`, and Set WAD refuses a combination that cannot work, for example a Doom II add-on with the first Doom. Chocolate Doom runs what the original 1990s engine ran: levels and mods made for Doom or Doom II, including many classic map packs. Mods that need a newer engine (Boom, MBF, ZDoom or GZDoom features, such as scripting, new monsters or high-resolution textures) are not supported and may fail to start or look wrong. Only file names with letters, digits, dots, dashes and underscores are listed. `wad.txt` can also be edited by hand (`iwad="DOOM2.WAD"`, `pwad="mymap.wad"`).

## Music

The game plays its original music, the tracks stored inside the game file, using the built-in FM synthesiser. The in-game music slider and the device's volume buttons both control it.

`doom.txt` in the port folder has one setting for it, `opl_gain`. The synthesiser's output is quiet on this device's speaker, so the default is `3` (three times the original level); `1` leaves it unchanged, and very high values distort. Edit the file and relaunch. Slider and key settings you change in the game are saved when you quit, either from the game's menu or with Select + Start.

### Using your own music (optional)

You can replace the music with recordings you own, for example a soundtrack you bought. Such tracks are copyrighted, so none are included, and the port does not need them.

1. Create a folder named `music_pack` in `roms/ports/chocolatedoom`.
2. Put WAV files in it, each named after the song it replaces. For the shareware episode these are `d_e1m1.wav` to `d_e1m9.wav` (the levels), `d_intro.wav` (title), `d_inter.wav` (between levels) and `d_victor.wav` (end of the episode). Doom II and the other episodes use the same pattern (`d_runnin.wav`, `d_stalks.wav`, `d_e2m4.wav` and so on); the Dev Notes list every name the game recognises.
3. The files must be WAV, 16-bit, stereo, 48000 Hz. Other formats are not read, and other sample rates play at the wrong speed. To convert a file with [ffmpeg](https://ffmpeg.org):

```sh
ffmpeg -i song.flac -ar 48000 -ac 2 -c:a pcm_s16le d_e1m1.wav
```

4. Launch the game. The first line of `log.txt` says `music pack found` when it is used. Any song without a file in the folder keeps the original music, so a partial pack works.

WAV files are large (about 25 to 40 MB per track), so plan on a few hundred MB for a full set. To go back to the original music, rename or delete the `music_pack` folder.

## Supported devices

The port loads the display and audio driver that TreeFrogUI selects for your
device (it reads it from `/tmp/tfdevice.env`), so one build covers every device
that shows frames through that driver. It is tested on the SF3500. The SF3000,
SF3000 HD, SF3100 and GB350 use the same method and should work, but have not
all been tested. It does **not** run on the R36SX and R36HD, which write to the
framebuffer directly instead.

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an
`EXIT CODE:` line. Its first line says whether a music pack was found, and the
next lines show the device, display mode and driver the port picked. Include it
when reporting a problem.

## Source and licenses

Chocolate Doom is licensed under the GPL (version 2 or later); the text and the
credits are in `roms/ports/chocolatedoom/licenses/`. The source for this port is
the pinned `source/` submodule, which keeps upstream's own history. The
shareware episode (`DOOM1.WAD`) is id Software's unmodified shareware release;
the commercial game files are not included. SDL2 comes with the device's
firmware and is not included.
