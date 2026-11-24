#!/bin/sh
# SPDX-License-Identifier: Unlicense
# Builds the shipped binaries (bgdi.mipsel, altitude.dcb, launcher.dcb, ui/*.fnt) from the source/ submodule.
# The build starts from three upstream tarballs (SDL2, SDL2_mixer, libxmp-lite; see source/README.md) and is
# reproducible: the same sources give the same bytes wherever they are checked out.
#
#   SF3500_TC=/path/to/toolchain/host DEPS=/path/to/tarballs ./build.sh
#
# See the header of source/build_sf3500.sh for the other settings (QEMU, PY, FONT_DIR).
set -eu
PORT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
: "${SF3500_TC:?Set SF3500_TC to the SF3500 MIPS toolchain host directory}"
( cd "$PORT_DIR/source" && ./build_sf3500.sh )
B="$PORT_DIR/source/build-sf3500"
cp "$B/bgdi.mipsel" "$B/altitude.dcb" "$B/launcher.dcb" "$PORT_DIR/"
rm -rf "$PORT_DIR/ui"; cp -r "$B/ui" "$PORT_DIR/ui"
chmod +x "$PORT_DIR/bgdi.mipsel"
rm -rf "$B"
echo "built the binaries in $PORT_DIR"
