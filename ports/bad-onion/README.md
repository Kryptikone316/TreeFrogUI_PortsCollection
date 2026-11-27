# Bad Onion (SF3500 port)

*Bad Onion* (悪いタマネギ) is a 2003 freeware platformer by Outhouse Software, made with the Fenix game
engine. You guide a bad-tempered onion through levels full of cannons, spikes and drops, collecting
gems and avoiding everything that wants to hurt it.

The game is exactly as the author published it. Only the Fenix interpreter that runs it is new: the
original Windows interpreter cannot run on this handheld, so this port builds the same Fenix 0.80
interpreter for the SF3500's processor.

## Controls

| Button | Action |
|---|---|
| D-pad | Walk left and right |
| A or B | Jump |
| Start or X | Start the game |
| Select | Back to the title screen; from the title screen, leave the game |
| Select + Start | Leave the game at any time |

The game's own cheat keys (L for the next level, K for an extra life, J for extra emeralds) are not mapped.

## Notes

* The picture keeps the game's 4:3 shape with black bars at the sides. To fill the screen instead, delete the line
  `export SF3500_ASPECT=16:9` in `run.sh`.
* `log.txt` holds what the game printed on its last run. The message `File badonion.prg not found` is
  normal: the compiled game mentions its source file, which the author did not publish.
* `readme.txt` is the author's own readme (Windows instructions; the keys differ here).
* The source, build instructions and licences: https://github.com/Kryptikone316/bad-onion-port
