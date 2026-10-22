#!/bin/sh
set -eu

PORT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SOURCE_DIR="$PORT_DIR/source"
: "${MIPS_PREFIX:?Set MIPS_PREFIX to the MIPS Linux toolchain prefix, including the trailing dash}"
: "${SYSROOT:?Set SYSROOT to the target Linux sysroot}"
CXX="${MIPS_PREFIX}g++"
STRIP="${MIPS_PREFIX}strip"

"$CXX" \
    -std=c++11 -O2 -fPIC \
    -mips32r2 -mtune=74kc -mhard-float -mfp32 -EL \
    --sysroot="$SYSROOT" \
    -I"$SOURCE_DIR/include" -I"$SOURCE_DIR/src" \
    -shared -Wl,--no-undefined \
    -o "$PORT_DIR/spacecadet_libretro.so" \
    "$SOURCE_DIR"/src/*.cpp -lm
"$STRIP" "$PORT_DIR/spacecadet_libretro.so"
