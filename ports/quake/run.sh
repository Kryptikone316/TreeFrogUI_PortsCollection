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

# Game loader: lets the player pick Quake, a mission pack or a mod (any folder here with a
# pak0.pak) and saves the choice in game.txt. It shows nothing when only Quake is
# installed. Exit status 10 means the player chose Exit (or Select + Start).
if [ -x ./quakeloader.mipsel ]; then
    rc=0
    ./quakeloader.mipsel "$PORT_DIR" game.txt >/dev/null 2>&1 || rc=$?
    if [ "$rc" -eq 10 ]; then exit 0; fi
fi

# game.txt: one line, the .pak to start relative to this folder (id1/pak0.pak by default).
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
