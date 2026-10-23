#!/bin/sh
set -eu
PORT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
exec "$PORT_DIR/source/treefrogui/build.sh" "$PORT_DIR/froggymania_libretro.so"
