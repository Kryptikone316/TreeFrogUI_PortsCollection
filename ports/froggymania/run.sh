#!/bin/sh
set -eu

PORT_DIR=/mnt/sdcard/roms/ports/froggymania
if ! /mnt/sdcard/cubegm/port_check.sh \
    froggymania \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/froggymania.md \
    /mnt/sdcard/frogui/port-help/froggymania.png \
    "$PORT_DIR" Data.rsdk; then exit 0; fi
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
exec /mnt/sdcard/cubegm/picoarch \
    "$PORT_DIR/froggymania_libretro.so" \
    "$PORT_DIR/Data.rsdk"
