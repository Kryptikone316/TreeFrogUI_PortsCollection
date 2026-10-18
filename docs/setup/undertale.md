# Undertale

The Ports Collection includes the Butterscotch libretro core from [FroggyTale](https://github.com/Synaps33/FroggyTale). Its requiring-game-data archive includes the core and a small launcher marker only. It does not include Undertale's game data or texture atlas files.

Copy files from your legally obtained Undertale 1.08 installation either into the port folder or its hidden `.data/` subfolder (the launcher detects both layouts):

```text
roms/ports/Undertale.sh
roms/ports/undertale/.data/   # or place these files directly in roms/ports/undertale/
├── game.unx
├── ATLAS.BIN
├── ATLAS.RGBA4444
└── *.ogg       (Steam audio tracks; copy all of them for music and SFX)
```

TreeFrogUI shows **Undertale** in **Games → Ports**. The launcher passes the core's marker from the hidden port data folder; the core reads `.data/` and keeps save data alongside it.

The atlas files must match your game version. FroggyTale's prebuilt atlas targets Undertale 1.08; consult the [FroggyTale setup guide](https://github.com/Synaps33/FroggyTale) to build a matching atlas when needed. Copy all `.ogg` files from Steam's `Undertale/assets/` folder beside `game.unx` to enable music and sound effects.
