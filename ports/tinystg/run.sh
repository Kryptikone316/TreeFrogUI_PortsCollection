#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/tinystg
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# The port's own output goes to log.txt in the port folder, ending with an
# exit code line, so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/TinySTG.mipsel" < /dev/null > log.txt 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> log.txt
exit "$rc"
