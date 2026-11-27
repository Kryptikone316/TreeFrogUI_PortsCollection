#!/bin/sh
set -u

PORT_DIR=/mnt/sdcard/roms/ports/psychosomnium
if ! /mnt/sdcard/cubegm/port_check.sh \
    psychosomnium \
    https://github.com/tzubertowski/TreeFrogUI_PortsCollection/blob/main/docs/setup/psychosomnium.md \
    /mnt/sdcard/frogui/port-help/psychosomnium.png \
    "$PORT_DIR" gamedata/psycho.exe; then exit 0; fi
rm -f /mnt/sdcard/cubegm/port_error.txt
cd "$PORT_DIR"
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# The game file (psycho.exe) and the unpacked copy of its data (gamedata/cache/) live in gamedata/, so
# what the player supplies and what the port creates stay out of the files the port ships. The
# launcher settings (psychosomnium.cfg) are kept there too.
export PSY_GAMEDATA="$PORT_DIR/gamedata"

# No real SDL video or audio device on this hardware: SDL's dummy drivers let SDL start, the frames
# go to the device driver directly and the sound through the software mixer.
export SDL_VIDEODRIVER=dummy
export SDL_AUDIODRIVER=dummy

# The port's own output goes to log.txt in the port folder, with an exit code line per run. The
# previous run's log is kept as log.prev.txt, and the log of any run shorter than 10 seconds (a
# launch that dropped back to the front-end) as log.short.txt.
[ -f log.txt ] && cp log.txt log.prev.txt
: > log.txt
rc=0
t0=$(date +%s)
"$PORT_DIR/psychosomnium.mipsel" < /dev/null >> log.txt 2>&1 || rc=$?
echo "EXIT CODE: $rc" >> log.txt
t1=$(date +%s)
if [ $((t1 - t0)) -lt 10 ]; then cp log.txt log.short.txt; fi
exit "$rc"
