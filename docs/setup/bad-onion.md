# Bad Onion

*Bad Onion* (悪いタマネギ) is a 2003 freeware platformer by Outhouse Software. You guide a bad-tempered onion
through levels full of cannons, spikes and drops, collecting gems and avoiding everything that wants to hurt
it. Everything needed to play is included and nothing has to be downloaded; the game's files are the author's,
unchanged.

Select **Bad Onion** under **Games → Ports** to start. The game's own title screen comes first; press
Start to begin.

```text
roms/ports/bad-onion/
├── badonion.dcb, data00.fpg ... data13.fpg, ...   # the game, as the author published it
├── fxi.mipsel                                     # the Fenix 0.80 interpreter, built for this device
├── run.sh                                         # starts the game; delete its SF3500_ASPECT line to fill the screen
└── log.txt                                        # what the game printed on its last run
```

## Controls

| Button | Action |
|--|--|
| D-pad | Walk left and right |
| A or B | Jump |
| Start or X | Start the game |
| Select | Back to the title screen; from the title screen, leave the game |
| Select + Start | Leave the game at any time |

## Notes

* The picture keeps the game's 4:3 shape with black bars at the sides. To fill the screen instead, delete the
  line `export SF3500_ASPECT=16:9` in `run.sh`.
* `log.txt` may say `File badonion.prg not found`; that is normal (the compiled game names a source file the
  author did not publish).
* The game's own cheat keys are not mapped.
