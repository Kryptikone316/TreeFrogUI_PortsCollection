#!/bin/sh
set -eu

PORT_DIR=/mnt/sdcard/roms/ports/classicube
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
exec /mnt/sdcard/cubegm/picoarch \
	"$PORT_DIR/classicube_libretro.so" \
    "$PORT_DIR/ClassiCube.classicube"
