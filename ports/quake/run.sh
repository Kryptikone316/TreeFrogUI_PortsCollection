#!/bin/sh
set -eu

PORT_DIR=/mnt/sdcard/roms/ports/quake
if ! /mnt/sdcard/cubegm/port_check.sh \
    quake \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/quake.md \
    /mnt/sdcard/frogui/port-help/quake.png \
    "$PORT_DIR" id1/pak0.pak; then exit 0; fi
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt

# game.txt (optional): one line with the .pak to start, relative to this folder, such as
# hipnotic/pak0.pak, rogue/pak0.pak or a mod packed into <modname>/pak0.pak.
GAME=id1/pak0.pak
if [ -f "$PORT_DIR/game.txt" ]; then
    want=
    read -r want < "$PORT_DIR/game.txt" || true
    want=$(printf '%s' "$want" | tr -d '\r')
    case "$want" in
        ''|/*|*..*) ;;
        *) if [ -f "$PORT_DIR/$want" ]; then GAME=$want; fi ;;
    esac
fi
exec /mnt/sdcard/cubegm/picoarch \
    "$PORT_DIR/tyrquake_libretro.so" \
    "$PORT_DIR/$GAME"
