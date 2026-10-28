#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/watercloset
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# The game keeps its saves and settings under $HOME/.local/share/waterCloset.
# Point HOME at a folder inside the port so they stay with it.
export HOME="$PORT_DIR/home"
mkdir -p "$HOME/.local/share/waterCloset"

# This device has no real SDL video or audio device. SDL's dummy drivers let SDL
# start; the finished frames and the mixed audio are sent to the device drivers
# directly (see sf3500/ in the source).
export SDL_VIDEODRIVER=dummy
export SDL_AUDIODRIVER=dummy

# The port's own output goes to log.txt in the port folder, ending with an exit
# code line, so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/waterCloset.mipsel" < /dev/null > log.txt 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> log.txt
exit "$rc"
