Psychosomnium for the Datafrog SF3500
=====================================

An unofficial port of Psychosomnium, the 2008 puzzle platformer by Cactus
(game by Cactus, music by Zabutom, splash by Cow). The game logic is
re-implemented for this handheld; it plays like the original.


SETUP
-----
This port does not include the game. It reads everything (pictures, sounds,
music, text and levels) from your own copy:

  1. Get the game: psycho.exe (or the download psycho1.zip, 2008 release).
     It is a free download, for example from caiman.us (search for
     "Psychosomnium").
  2. Put psycho.exe (or psycho1.zip, unopened) into the "gamedata" folder
     of this port, next to this README.
  3. Start the port. The first start unpacks the game data into
     gamedata/cache/ (a few seconds). After that the exe is no longer needed.

If the file is missing or is a different version, the port says so on screen.
To unpack again, delete gamedata/cache/.


LAUNCHER
--------
The port opens with a small menu: Play Game, Settings, Exit Game (D-pad up/down, A or START to choose,
B to go back). The first row of Settings is the language (the 12 languages of TreeFrogUI: English, Deutsch,
Español, Français, Italiano, Polski, Português, Türkçe, Russian, Japanese, Chinese, Arabic): the menus, the
pause and end screens and the game's dialogue all switch to it. The language packs are in the lang folder;
X Settings also has the readability and control tweaks,
and Language style: Family-friendly swaps the
game's strong language for mild words (damn is darn, hell is heck); Cuss-friendly keeps the game's own words. Changes are saved at once in
gamedata/psychosomnium.cfg and used when you press Play Game.


HOW TO PLAY
-----------
There are no enemies. You reach the end by "dream logic": when you are stuck,
try something strange. Spikes and falling will send you back to the last
checkpoint; talk to everyone.

  D-pad left / right   walk (fly)
  D-pad up, B or Y     jump (press again for each jump; hold for a higher jump)
  D-pad down           (flying rooms) sink
  A or X               action: punch (for the big guy), next line of text
  START                start the game on the title screen; in the game: pause / resume
  SELECT + START       quit (on the "THE END" screen, START alone leaves the game)

Text boxes: A skips to the end of a line, then moves on to the next.
Some rooms have a checkpoint marker: touch it and you restart in that room.


SETTINGS
--------
gamedata/psychosomnium.cfg (made on the first start; delete it to reset):
  jump=press      a jump needs a new press of the button (precise). jump=held is the
                  original behaviour: holding the button keeps jumping.
  text=original   dialogue in the game's own letters (the unreadable M, N, W redrawn); clear = a plain
                  larger typeface (always used for the other languages); bubble = the old pink text.
  flight=fine     finer control of the bee (the flying rooms): hold Up (or B/Y) to climb, hold
                  Down to sink, a quick tap is a small nudge. flight=original is the game's
                  one-big-flap-per-press.
  drain=on        when the display has pictures queued up (screen lag), skip one now and then to
                  catch up; game speed is not affected. drain=off never skips.
  buffer=8        a jump pressed up to about 7 frames (117 ms) before touching the ground
                  still counts when you land. Default 8 (was 6).
  lang=en         en de es fr it pl pt tr ru ja zh ar
  language=original  original = Cuss-friendly (the game's own words); family = Family-friendly (mild words)
  ledge=0         frames after walking off an edge in which a jump still works (off by default)
                  (forgives the pad's delay at ledges). 0 = off, the original behaviour.
  bunnies=high    higher bunny hops with a little hang time at the top (easier to run
                  under them). bunnies=original is the game's own hop.
  debounce=25     milliseconds a button counts as still held after the pad lets go
                  (swallows contact chatter that could turn one press into two). 0 = off.


TIMING LOG
----------
log.txt gets a "perf:" line every 10 seconds of play (frame time, time spent presenting,
the game's own work, skipped pictures) and one on exit. If the game feels laggy, send
that file.


FILES
-----
  gamedata/psycho.exe       your copy of the game (you supply it)
  gamedata/cache/           the unpacked data, made on the first start
  log.txt                   what the program printed on its last run


CREDITS
-------
Psychosomnium: Cactus (game), Zabutom (music), Cow (splash screen).
Port: the port author. Music playback uses jar_xm (WTFPL, derived from
libxm by Romain Dalmaso); zlib decoding from stb_image (public domain);
on-screen messages use font8x8 (public domain); the readable dialogue uses
DejaVu Sans Condensed Bold (free licence). See NOTICE.md.
