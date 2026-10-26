#!/bin/sh
set -eu

PORT_DIR=/mnt/sdcard/roms/ports/hcl
if ! /mnt/sdcard/cubegm/port_check.sh \
    hcl \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/hcl.md \
    /mnt/sdcard/frogui/port-help/hcl.png \
    "$PORT_DIR" gamedata/data/bmp.qda gamedata/data/en.dat gamedata/data/jp.dat; then exit 0; fi

# The game looks for data/, and writes its saves and settings, in the current
# directory. Run it from gamedata/ so everything the player supplies or the
# game creates stays out of the files the port ships.
cd "$PORT_DIR/gamedata"
rm -f /mnt/sdcard/cubegm/port_error.txt

# The port's own output goes to log.txt in the port folder, ending with an
# exit code line, so a problem can be diagnosed from the card.
rc=0
"$PORT_DIR/hcl.mipsel" < /dev/null > "$PORT_DIR/log.txt" 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> "$PORT_DIR/log.txt"
exit "$rc"
