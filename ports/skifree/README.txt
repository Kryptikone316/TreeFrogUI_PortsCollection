SkiFree for the Datafrog SF3500
===============================

An unofficial port of SkiFree, the 1991 skiing game by Chris Pirih, for the
SF3500 handheld. The game logic is the original, running through an SDL
conversion of a decompiled copy of version 1.04, with a launcher, sounds and
a few ways to dress it up. It plays like the game you remember.


SETUP
-----
This port does not include the game's artwork. It reads it from your own copy
of the game:

  1. Get ski32.exe (version 1.04) from the official SkiFree site,
     https://ski.ihoc.net/
  2. Put it in the gamedata folder: roms/ports/skifree/gamedata/ski32.exe

If it is missing or the wrong version, the port tells you on screen.


THE LAUNCHER
------------
  Play Game        Start skiing.
  How To Play      The rules and the buttons, a few short pages.
  Audio / Video    Sound, volume, screen size and frame rate.
  Gameplay         Frame timing, yeti distance, game speed.
  Exit             Back to the front-end.

Your choices are saved in gamedata/skifree.txt (plain lines, editable by hand).

L1 / R1 on the launcher menu change the theme:
  Classic, Modern (16-bit), Modern (8-bit) and TI-92.
A small plate names the theme whenever it changes. The theme also sets how the
game itself looks when you press Play. L1 / R1 do nothing while skiing.

SELECT + START while skiing returns to the launcher.


EXTRAS (all optional)
---------------------
  gamedata/sounds/custom/   Drop your own .wav files here to replace the
                            built-in sounds. See the README in that folder.
  sounds/                   The built-in sounds, made for this port.
  sprites16/                Art for the Modern (16-bit) theme.
  sprites8/                 Art for the Modern (8-bit) theme.

Anything you leave out of sounds/, sprites16/ and sprites8/ falls back to the
game's own art and the built-in sounds, so you can delete or replace files
freely. Each of the three is also a separate zip on the releases page,
https://github.com/Kryptikone316/skifree_sdl/releases, for a smaller install
or to put one back: unzip it into this folder.

Everything you add or the game saves (ski32.exe, skifree.txt, your own
sounds) lives in gamedata/, away from the files the port ships.


A WORD FROM THE MANAGEMENT
--------------------------
By downloading, running, or otherwise standing near this software you
acknowledge the following, which is not a complete list, and which the
management would rather you discovered on your own:

  * Trees are rooted in the community, but not always in the ground. The
    management makes no promises about any particular tree's commitment to
    staying where you last saw it.

  * Dogs may be present. Dogs are known to be easily startled. What startles
    them, and what they do about it, is a matter of ongoing research. Keep
    your skis dry.

  * Dry-looking vegetation is not to be trusted.

  * Wandering far from the lodge may attract attention. The management
    declines to say whose.

  * Snowboarders are provided at no extra charge and are not taking questions.

  * Falling over is not a defect. It is a feature of the sport, and of this
    software.

  * Other skiers have their own plans for the afternoon. Their poles are their
    own business.

  * Side effects may include "just one more run".

The management accepts no responsibility for lost time, lost dignity, or
anything lost to a large hairy gentleman. Results may vary. Ski responsibly.


CREDITS
-------
  SkiFree                 Chris Pirih, 1991
  Decompilation           Eric Fry (skifree_decomp)
  SDL conversion          jeff-1amstudios (skifree_sdl)
  SF3500 port             launcher, sound, themes, sprite packs, display and
                          input glue
  Text font               font8x8, public domain (Daniel Hepper)

The artwork in the Modern themes and the built-in sounds were drawn and
synthesised for this port. The Classic theme's launcher backdrop is original
artwork made for it as well. These assets are released under the MIT license (see
licenses/LICENSE-ASSETS.txt). The box art is by the port author and is used only
to identify the game; it shows SkiFree's own logo and characters.

A special mention goes to Michael Holt (psigoo), http://calc.psigoo.com, whose
SkiFree for the TI-89 / TI-92 Plus inspired the TI-92 theme. None of his work
is used here, but this port would not have had that theme without stumbling
across his.
