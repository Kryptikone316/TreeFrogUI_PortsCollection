#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/hexahop
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt

# Saves go to $HOME/.hex-a-hop, so point HOME at the port folder. The bundled
# SDL_ttf lives next to the executable.
export HOME="$PORT_DIR"
export LD_LIBRARY_PATH="$PORT_DIR:${LD_LIBRARY_PATH:-}"
export SDL_VIDEODRIVER=fbcon
export SDL_NOMOUSE=1

# The port's own output goes to log.txt in the port folder, ending with an
# exit code line, so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/hex-a-hop.mipsel" < /dev/null > log.txt 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> log.txt
exit "$rc"
