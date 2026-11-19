Custom sounds for SkiFree (optional)
====================================

Drop .wav files in this folder (roms/ports/skifree/gamedata/sounds/custom) to replace the built-in sounds. Anything you
leave out keeps its built-in sound. In the launcher menu, Audio / Video >
"Sound set" switches between "Custom if found" and "Built-in only", and
"Sound: Off" turns every sound off, custom ones included.

File names, and when each sound plays:

  crash.wav    you hit a tree or a rock
  land.wav     you land after a jump
  jump.wav     you launch off a ramp or a bump
  bump.wav     you run into another skier
  woof.wav     you run into a dog
  piddle.wav   a dog leaves its mark
  board.wav    a snowboarder takes a jump
  gobble.wav   the yeti catches you
  roar.wav     the yeti is chasing you (it will not repeat more than once every 1.5 s)

Format: PCM .wav, 8 or 16 bit, mono or stereo, any sample rate (it is converted
when the game starts). Keep each one short, 8 seconds at most. A file the game
cannot read is skipped and the built-in sound plays instead (see log.txt).

The author's page, ski.ihoc.net, has two sound files you can download yourself
(gobble.wav and argh.wav). They are not included here. Rename them to the event
they suit, for example gobble.wav for gobble and argh.wav for crash or roar.
