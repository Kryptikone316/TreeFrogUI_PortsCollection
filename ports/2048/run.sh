#!/bin/sh
# SPDX-License-Identifier: Unlicense
set -eu

PORT_DIR=/mnt/sdcard/roms/ports/2048
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt

# 2048 is a libretro core run by picoarch. The core needs no game files, but picoarch wants a
# content path, so 2048.dat is a tiny placeholder. The folder name ("2048") also names picoarch's
# save folder, /mnt/sdcard/picoarch/2048, which holds the game state and the best score.
exec /mnt/sdcard/cubegm/picoarch \
    "$PORT_DIR/2048_libretro.so" \
    "$PORT_DIR/2048.dat"
