#!/bin/sh
# SPDX-License-Identifier: Unlicense
set -u

PORT_DIR=/mnt/sdcard/roms/ports/bad-onion
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# fxi.mipsel is the Fenix 0.80 interpreter; its name must start with "fxi" (that is how it knows it
# was started as the interpreter and should take the game from the command line).
# Video goes to the device's display driver and sound is tapped from SDL_mixer's output (see the
# source), so SDL's own devices are not used.
# The game is 4:3; pad it to the panel's 16:9 so it is not stretched. Remove the next line to fill the screen.
export SF3500_ASPECT=16:9

: > "$PORT_DIR/log.txt"
rc=0
"$PORT_DIR/fxi.mipsel" -b badonion.dcb < /dev/null >> "$PORT_DIR/log.txt" 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> "$PORT_DIR/log.txt"
exit "$rc"
