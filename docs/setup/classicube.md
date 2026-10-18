# ClassiCube

The Ports Collection ships the SF3000 port from [FroggyCraft](https://github.com/tzubertowski/FroggyCraft).

Launch **ClassiCube** from **Games → Ports**. Its data lives in the hidden port
folder:

```text
roms/ports/classicube/
├── texpacks/default.zip   # shipped texture pack
├── audio/default.zip      # shipped audio pack
└── *.cw                   # your ClassicWorld maps
```

On first boot, TreeFrogUI migrates files from the old `roms/classicube/` folder
into this directory. Maps, options, saves, and custom files are retained. The
collection release's current texture/audio packs win on filename conflicts; the old folder
is removed only after the migration completes successfully.

The port accepts `.cw` ClassicWorld maps. It starts a single-player world and
saves the generated world/player state in `roms/ports/classicube/`. The
console port has no networking; sound effects use the included audio pack.

The default software-rendering settings are conservative for the SF3000 CPU;
view distance and rendering options can be changed from the in-game menu.
