# Defense Mania

Defense Mania is a tower defense game by Kris Siepert. Enemies walk a path across a map, and you
build, upgrade and repair towers to stop them before they reach the end. This port runs the game
natively on TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/defense-mania/tree/sf3500) of the upstream source.
It needs no extra game data: all seven maps are included (five from the original game, plus The
Swamp and The Tundra made for this port), with sound effects. Background music is an optional
separate download.

Select **Defensemania** under **Games → Ports** to start the game. Your scores, settings and the
progress through the difficulties are saved in the port folder:

```text
roms/ports/defensemania/
├── defensemania.cfg           # picture, volume and speed settings (edit it, then relaunch)
├── .defensemania_settings     # the options you set in the game
├── .defensemania_scores       # best scores and which difficulties you have won
└── music/                     # optional music pack (see below)
```

## Controls

| Button | Action |
|--|--|
| D-Pad | Move the cursor (faster the longer you hold; at the screen edge it scrolls the map); move through menus |
| A | On an empty build spot: open the build menu. On a tower: open its menu (repair, upgrade, sell). Confirm in menus |
| B | Close a menu or go back |
| X | Show or hide the green build areas |
| R1 or R2 | Switch between normal speed and fast forward (x2) |
| Start | Pause |
| Select | Quit the match (you are asked to confirm) |
| Select + Start (held together) | Quit from the menus immediately |

In the build and tower menus the D-Pad picks an entry, **A** takes it and **B** cancels. The first
tower you build starts the game.

## Maps, difficulties and endless mode

Pick **Play**, choose a map with Up/Down and a difficulty with **L1** (easier) and **R1** (harder).
You start on **Easy**: win a map on Easy to unlock Normal on that map, and win it on Normal to
unlock Hard. Winning a map without losing a single life counts as perfect; when all three
difficulties of a map are perfect, **X** on the map list switches to that map's **Endless** mode,
where the waves keep coming and growing tougher.

**Scores** lists the best score, wave and perfect marks for each map (**Left/Right** or
**Up/Down** change the map, **X** switches between normal and endless). **Y** clears the scores of
the map you are looking at, after a confirmation; this also takes the endless mode of that map away
again.

## Music (optional)

Without a music pack the game is silent apart from the sound effects. The pack is a separate
download of 16 tracks (about 50 MB, CC0), one or two per map: get `DefenseMania-MusicPack.zip` from
the [Releases page of the source repository](https://github.com/Kryptikone316/defense-mania/releases)
and unzip it onto the card root, so that you end up with `roms/ports/defensemania/music/`. Each map
plays a random track from its own folder, then another when it ends. You can add your own Ogg Vorbis
files to any folder. Music and its volume are set under **Options**.

## Settings

**Options** on the title screen sets the overall volume, the music volume, the effects volume, the
HQ graphics overlay (a light overlay on the maps that costs speed; off by default) and an on-screen
frame rate counter.

`defensemania.cfg` holds brightness, contrast, saturation and gamma for the picture, with an
override per map (for example `woods_contrast`), the volumes, the frame cap and the growth of the
endless mode. Edit it, then relaunch the game. Every line has a comment. The game sends at most
30 frames a second by default (`fps_cap`), which keeps the picture and sound steady on this device.

## Notes

* A rare one-frame glitch (a tower drawn in the wrong place for a moment) has been seen on this
  device and its cause is not known. `slot_check = 1` in the cfg turns on a diagnostic that writes
  to `log.txt`; leave it off for normal play.
* The game writes `log.txt` in the port folder, which helps when something goes wrong.
* The original game asks for the fonts Arial and Arial Black, which are not free to redistribute;
  the Bitter and DejaVu fonts are used instead.
