#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/formido
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt

# Settings and the Hall of Fame live in the port folder (.formido); the game reads formido.cfg from there,
# or the shipped default next to the executable the first time.
export HOME="$PORT_DIR"
mkdir -p "$PORT_DIR/.formido"
export LD_LIBRARY_PATH="$PORT_DIR:${LD_LIBRARY_PATH:-}"

# The port's own output goes to log.txt in the port folder, ending with an exit code line,
# so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/formido.mipsel" < /dev/null > log.txt 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> log.txt
exit "$rc"
