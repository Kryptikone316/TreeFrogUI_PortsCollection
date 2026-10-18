#!/bin/sh
set -eu

PORT_DIR=/mnt/sdcard/roms/ports/openclaw
if ! /mnt/sdcard/cubegm/port_check.sh \
    openclaw \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/openclaw.md \
    /mnt/sdcard/frogui/port-help/openclaw.png \
    "$PORT_DIR" CLAW.REZ; then exit 0; fi
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
exec /mnt/sdcard/cubegm/picoarch \
    "$PORT_DIR/openclaw_libretro.so" \
    "$PORT_DIR/Start Captain Claw.claw"
