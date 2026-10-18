# OpenLara (Tomb Raider I)

The Ports Collection includes the SF3000 libretro port from
[tzubertowski/TreeFrogUI_OpenLara](https://github.com/tzubertowski/TreeFrogUI_OpenLara),
based on [XProger/OpenLara](https://github.com/XProger/OpenLara).

You must provide your own legally obtained Tomb Raider I data. From the game
disc or disc image, open the `DATA` folder and copy **all files ending in
`.PHD`** into this folder on the SD card:

```text
roms/ports/openlara/
```

For a `.nrg` disc image, 7-Zip can open it directly: open the image, enter
`DATA`, select the `.PHD` files, and extract them directly into
`roms/ports/openlara/` (not into a nested `DATA` folder). The folder must contain
`LEVEL1.PHD`; copying all the `.PHD` files also provides the title, training,
cutscene, and other level data.

Keep the archive-provided
`Start OpenLara.gba` marker and root-level `OpenLara.sh` launcher in place. The
marker is not game data; it tells the core to load `LEVEL1.PHD` from the same
folder.

Launch **OpenLara** from **Games → Ports**. The game files are not included in
TreeFrogUI.
