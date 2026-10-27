#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/nikwi
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# SDL 1.2 is only used for software surfaces. The finished frame goes to the
# display through the device driver; fbcon is still needed so that
# SDL_SetVideoMode() succeeds at all.
export SDL_VIDEODRIVER=fbcon
export SDL_NOMOUSE=1

# The port's own output goes to log.txt in the port folder, ending with an
# exit code line, so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/nikwi.mipsel" < /dev/null > log.txt 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> log.txt
exit "$rc"
