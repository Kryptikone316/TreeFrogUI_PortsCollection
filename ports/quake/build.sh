#!/bin/sh
set -eu

PORT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
: "${MIPS_PREFIX:?Set MIPS_PREFIX to the target MIPS Linux toolchain prefix, including the trailing dash}"

# The QuakeC interpreter is deliberately built at -O1; see source/README-SF3500.md.
( cd "$PORT_DIR/source" && ./build_sf3500.sh )
cp "$PORT_DIR/source/tyrquake_libretro.stripped.so" "$PORT_DIR/tyrquake_libretro.so"
chmod +x "$PORT_DIR/tyrquake_libretro.so"
