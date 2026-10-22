#!/bin/sh
set -eu

PORT_DIR=/mnt/sdcard/roms/ports/spacecadet
if ! /mnt/sdcard/cubegm/port_check.sh \
    spacecadet \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/spacecadet.md \
    /mnt/sdcard/frogui/port-help/spacecadet.png \
    "$PORT_DIR" PINBALL.DAT PINBALL2.MID; then exit 0; fi
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
exec /mnt/sdcard/cubegm/picoarch \
    "$PORT_DIR/spacecadet_libretro.so" \
    "$PORT_DIR/PINBALL.DAT"
