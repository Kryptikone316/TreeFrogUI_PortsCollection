#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/skifree
if ! /mnt/sdcard/cubegm/port_check.sh \
    skifree \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/skifree.md \
    /mnt/sdcard/frogui/port-help/skifree.png \
    "$PORT_DIR" gamedata/ski32.exe; then exit 0; fi
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# The program reads ski32.exe, the settings (skifree.txt) and any custom sounds from the
# current folder, and writes the settings there, so run it from gamedata/. Everything the
# player supplies or the game creates then stays out of the files the port ships. The port's
# own launcher backdrop, sounds and sprite packs are found through SKI_ASSETS.
export SKI_ASSETS="$PORT_DIR"
cd "$PORT_DIR/gamedata"

# No real SDL video or audio device on this hardware: SDL's dummy drivers let SDL start,
# the frames and the sound go to the device driver directly (see sf3500/ in the source).
export SDL_VIDEODRIVER=dummy
export SDL_AUDIODRIVER=dummy

# The port's own output goes to log.txt in the port folder, with an exit code line per run.
# Exit code 10 means "back to the launcher menu" (SELECT+START while skiing): start again.
: > "$PORT_DIR/log.txt"
rc=0
while :; do
    rc=0
    "$PORT_DIR/skifree.mipsel" < /dev/null >> "$PORT_DIR/log.txt" 2>&1 || rc=$?
    echo "EXIT CODE: $rc" >> "$PORT_DIR/log.txt"
    [ "$rc" -eq 10 ] || break
done
exit "$rc"
