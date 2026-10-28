#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/sorr
cd "$PORT_DIR"
if ! /mnt/sdcard/cubegm/port_check.sh \
    sorr \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/sorr.md \
    /mnt/sdcard/frogui/port-help/sorr.png \
    "$PORT_DIR" gamedata/SorR.dat gamedata/mod/system.txt gamedata/palettes/chars/adam1.pal; then exit 0; fi
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# The game finds mod/ and palettes/ in the current folder, and writes its
# saves and settings there too, so run it from gamedata/. Everything the
# player supplies or the game creates then stays out of the files the port
# ships.
cd "$PORT_DIR/gamedata"

# The engine's own main.c checks strncmpi(appexename,"bgdi",4) to choose
# "standalone" mode (read the data file named on the command line) over
# "embedded" mode (data appended to the executable), so the binary must keep
# a name starting with bgdi.
export VIDEO_DEPTH=16
# Audio is tapped from SDL_mixer's mixed output and sent to the device
# driver directly (see mod_sound.c), so SDL's own audio and video devices
# are the dummy ones.
export SDL_VIDEODRIVER=dummy
export SDL_AUDIODRIVER=dummy
# The mixer runs at 44100 Hz, the rate the game's music is stored in, and the
# output is converted to the device's 48000 Hz with a cheap interpolation.
# Music that was re-encoded to 48000 Hz needs SF3500_MIX_RATE=48000 instead.
export SF3500_MIX_RATE=44100

# The port's own output goes to log.txt in the port folder, ending with an
# exit code line, so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/bgdi.mipsel" SorR.dat < /dev/null > "$PORT_DIR/log.txt" 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> "$PORT_DIR/log.txt"
exit "$rc"
