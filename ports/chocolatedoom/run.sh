#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/chocolatedoom
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# Self-contained config and saved games: Chocolate Doom keeps them under
# $HOME/.local/share/chocolate-doom/.
export HOME="$PORT_DIR/home"
mkdir -p "$HOME"
# Where the game looks for its game files.
export DOOMWADDIR="$PORT_DIR/gamedata"
# This device has no real SDL video or audio device. SDL's dummy drivers let
# SDL start; the finished frames and the mixed audio are taken from the game
# and sent to the device drivers directly (see src/sf3500 in the source).
export SDL_VIDEODRIVER=dummy
export SDL_AUDIODRIVER=dummy

# Music: the game plays the music stored in the game file. An optional folder
# of WAV tracks named music_pack in this folder replaces it when present (see
# the setup guide). The game reads that folder in place; nothing is copied.
export SF3500_MUSIC_PACK="$PORT_DIR/music_pack"
if ls music_pack/*.wav >/dev/null 2>&1; then
    echo "run.sh: music pack found, using it" >log.txt
else
    echo "run.sh: no music pack, using the music in the game file" >log.txt
fi
# Settings (loudness of the built-in music): doom.txt.
opl_gain=1
opl_diag=0
[ -f ./doom.txt ] && . ./doom.txt
export SF3500_OPL_GAIN="$opl_gain"
[ "$opl_diag" = "1" ] && export SF3500_OPL_DIAG=1

# WAD loader: lets the player pick the game file (iwad) and an optional add-on
# (pwad) from gamedata/, and saves the choice in wad.txt. It shows nothing when
# there is only the shareware game and no add-ons. Exit status 10 means the
# player chose Exit (or Select + Start).
if [ -x ./wadloader.mipsel ]; then
    ./wadloader.mipsel gamedata wad.txt >>log.txt 2>&1
    if [ $? -eq 10 ]; then
        echo "EXIT CODE: 0" >>log.txt
        exit 0
    fi
fi
iwad=""
pwad=""
[ -f ./wad.txt ] && . ./wad.txt
# Only use choices whose files are still there.
[ -n "$iwad" ] && [ ! -f "gamedata/$iwad" ] && iwad=""
set --
[ -n "$iwad" ] && set -- "$@" -iwad "$iwad"
for f in $pwad; do
    [ -f "gamedata/$f" ] && set -- "$@" -file "gamedata/$f"
done

# The game's own output goes to log.txt in the port folder, ending with an exit
# code line, so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/chocolate-doom.mipsel" "$@" < /dev/null >> log.txt 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> log.txt
exit "$rc"
