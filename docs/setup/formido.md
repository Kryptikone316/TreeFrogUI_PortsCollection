# Formido

Formido is a top-down shooter: you, a gun, and endless waves of big, ugly alien insects. Kill as many as you can; they
will overcome you in the end, so the point is how long you hold out.

This is Mika Halttunen's game (2002-2003, [mhgames.org/formido](https://mhgames.org/formido/), GPL) ported to the
Datafrog SF3500, with a gamepad control scheme and a second game mode, the **enhanced game**, on top of the
original, which is still there as the **classic game**.

Select **Formido** under **Games → Ports** to start. Everything needed to play is included; nothing has to be downloaded.

## Controls

Menus: D-pad chooses, **A** or **Start** selects, **B** or **Select** goes back.

In a match the controls are twin-stick style. The handheld has no right stick (it is wired to the A / B / X / Y
buttons), so holding **L1** turns those buttons into the aiming stick:

| Buttons | Action |
|---|---|
| D-pad | walk in the direction pressed (8 ways) |
| L1 + X / A / B / Y | aim and fire up / right / down / left (two together aim diagonally) |
| A (alone) | fire the way you are aiming |
| B (alone) | throw the power-up you are holding |
| R1 | enhanced game: deploy the bunker (and step out of it) |
| R2 | enhanced game: lay a trap |
| L2 | enhanced game: show the legend of what every icon means |
| Start | pause |
| Select | end the match |
| Select + Start | leave the game at once, from anywhere |

If you prefer the original tank controls (Left/Right turn, Up/Down walk, A fire), choose **classic** under
*controls* in the game settings.

High-score names are entered with the D-pad: Up/Down change the letter, Right takes it, Left or B steps back, A finishes.

## The classic game

The original game, as Mika made it: one screen, bugs from every side, and power-ups (health, bombs, mines and a
mushroom that warps the screen) to help you along.

## The enhanced game

The same bugs and the same gun, but the hive plays back. The match is built to be unwinnable, so the question is how long you
last and what you do with the time.

- **A map shaped like a cross.** The stone platform is in the middle. Walk off any side to reach a wasteland to the north,
  east, south or west. A small map in the corner shows where you are and which screens have bugs in them.
- **Power cells and the platform.** Each wasteland holds a power cell guarded by a warden and its escorts. Beat them, carry the
  cell to the platform, and the four pylons change what they do: a turret, a supply of bombs and mines, a medbay that heals
  fast, or a slowing field. Cells come back after a while, in a new place, with new guards.
- **Healing.** The platform mends you whenever you are hurt and standing on it, even while bugs bite. Rare green healing plants
  grow out in the wastelands, and red plants are thorns that only scratch.
- **Bugs.** Drones (the classic bug), runners (small and fast, in packs), strikers (tough) and brutes (huge and slow) arrive
  as the match goes on, each a little different from the next. Burrowers hide under the sand of the wastelands and
  erupt where you stand, so keep moving. The hive notices how you play and adapts: stand still and it sends heavier bugs.
- **The Hive Tyrant.** After 5 minutes the ground trembles and a giant boss walks in, with a mutation or two. Slay it
  and you are healed and strengthened for a while, but the hive comes back tougher, and so do the burrowers: some stun you.
- **Pick-ups from the wastelands.** Special rounds (extra damage to one kind of bug), trap discs (R2: napalm, spikes or glue,
  which hurt you as well, so stay off them), a bunker kit (R1: a shelter to fight from; step out with R1 to collect
  pick-ups, step back in to use it again) and, after a long run of kills, a flamethrower canister: a short, fiery cone of
  heavy damage for a few seconds, then the usual gun returns.
- **Rank.** Every 15 kills without taking damage earns a rank (rookie up to commando), each worth a small damage bonus, shown
  as stripes over your head and as text at the top left. Any hit you take starts it over, and the more wounded you are
  the less of the bonus counts. Sticking in the thick of it, unhurt, pays off.
- **Aids.** Every third round of your gun is a glowing tracer. A thin red laser sight shows where you are aiming (settings: off,
  enhanced game only, or always). Press **L2** for the legend.

The two games keep separate Hall of Fame lists (left/right switches between them). Every mechanic and its numbers are in
[docs/ENHANCED-GAME-DETAILS.md](https://github.com/Kryptikone316/formido-port/blob/main/docs/ENHANCED-GAME-DETAILS.md) in the source repository.

## Settings

Under **game settings** in the main menu (left/right or the select button change a row):

| Row | What it does |
|---|---|
| controls | twin stick (default) or the original tank controls |
| laser sight | off, enhanced (default) or always |
| frame limit | 20, 30 (default), 40 or 45 frames a second. 30 is steady everywhere; 40 and 45 ran well on the SF3500 and are meant for higher-end devices (untested elsewhere) |
| credits on exit | show the credits when you quit from the menu |
| reset hall of fame | press select twice to erase both lists |
| music volume | the slider |

Settings and high scores are kept in the port folder (`.formido`).

### Making the enhanced game easier or harder

The enhanced game's numbers (bug health and speed, how fast the hive spawns, how much healing the platform gives, when the Tyrant
comes, what the flamethrower does, and about seventy more) are in **`formido_tuning.cfg`** in the port folder. It appears the first time
you start an enhanced game. Each line says what it does and what values are allowed. Edit it with a text editor and start a new
game to try a change; delete it to get the defaults back.

## What is in the port folder

```text
roms/ports/formido/
├── formido.mipsel        # the game
├── data/                 # pictures, sounds and music
├── formido.cfg           # the default settings
├── formido_tuning.cfg    # the enhanced game's numbers (appears after the first enhanced game)
├── .formido/             # your settings and Hall of Fame (delete it to start fresh)
└── log.txt               # what the game printed on its last run
```

## Credits and licence

Game design, programming and artwork by **Mika Halttunen** ([mhgames.org/formido](https://mhgames.org/formido/)); music
by **Josh Schroeder**. Formido is free software under the **GNU General Public License, version 2 or later**, and so is
this port (`licenses/`, `NOTICE.md`; the full source is the pinned `source/` submodule, from
[Kryptikone316/formido-port](https://github.com/Kryptikone316/formido-port)). The SF3500 port, the enhanced game and its
sounds are by AthruZ; the display, audio and gamepad glue is derived from TreeFrogUI's pico286 SF3000 patch.
