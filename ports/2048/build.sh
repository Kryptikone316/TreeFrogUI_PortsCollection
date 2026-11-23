#!/bin/sh
# SPDX-License-Identifier: Unlicense
# Builds 2048_libretro.so for the Data Frog SF3500 from the source/ submodule (libretro-2048, unmodified, plus a build script).
#
#   MIPS_PREFIX=/path/to/mips-mti-linux-gnu- SYSROOT=/path/to/sysroot ./build.sh
set -eu
PORT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
: "${MIPS_PREFIX:?Set MIPS_PREFIX to the target MIPS Linux toolchain prefix, including the trailing dash}"
( cd "$PORT_DIR/source" && ./build_sf3500.sh )
cp "$PORT_DIR/source/out/2048_libretro.so" "$PORT_DIR/2048_libretro.so"
chmod +x "$PORT_DIR/2048_libretro.so"
rm -rf "$PORT_DIR/source/out"
echo "built $PORT_DIR/2048_libretro.so"
