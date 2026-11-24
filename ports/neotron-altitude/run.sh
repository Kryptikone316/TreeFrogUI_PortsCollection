#!/bin/sh
# SPDX-License-Identifier: Unlicense
set -u

PORT_DIR=/mnt/sdcard/roms/ports/neotron-altitude
cd "$PORT_DIR"
rm -f /mnt/sdcard/cubegm/port_error.txt
export LD_LIBRARY_PATH=/mnt/sdcard/cubegm/lib:/mnt/sdcard/cubegm/usr/lib:${LD_LIBRARY_PATH:-}

# The runtime's executable name must start with "bgdi": the engine uses that to read the game
# from the file named on the command line instead of expecting it appended to the executable.
# Altitude asks for 8bpp; the runtime promotes it to 16bpp internally.
export VIDEO_DEPTH=16
# Video goes to the device's display driver and audio is tapped from SDL_mixer's output
# (see the runtime), so SDL's own video and audio devices are the dummy ones. Without
# SDL_VIDEODRIVER=dummy SDL finds no video device at all.
export SDL_VIDEODRIVER=dummy
export SDL_AUDIODRIVER=dummy
export SF3500_MIX_RATE=44100

# Everything the launcher and the game print goes to log.txt, with an exit code line after each run.
: > "$PORT_DIR/log.txt"

# The launcher (launcher.dcb) comes first: Play Game, Options, How to Play, Exit. It saves its
# settings in options.cfg and tells this script what to do next in launcher_action.txt.
# After the game ends (including Select + Start in the game) we return to the launcher.
rc=0
# Reads the Screen setting from options.cfg (written with CRLF line endings; only known values
# are accepted). "original" pads the picture to the panel's 16:9 so the game's 4:3 art is not
# stretched; "fill" leaves it to the driver to stretch it.
apply_screen_setting() {
    aspect=original
    if [ -f options.cfg ]; then
        case "$(tr -d '\r' < options.cfg | sed -n 's/^ASPECT=//p' | head -n 1)" in
            fill) aspect=fill ;;
        esac
    fi
    if [ "$aspect" = original ]; then export SF3500_ASPECT=16:9; else unset SF3500_ASPECT; fi
}

# Computer opponent for Player 2 in the two-player modes (Options > Computer opponent): off, easy,
# normal or hard. The runtime reads SF3500_BOT; unset means no computer pilot.
apply_bot_setting() {
    bot=off
    if [ -f options.cfg ]; then
        case "$(tr -d '\r' < options.cfg | sed -n 's/^BOT=//p' | head -n 1)" in
            easy) bot=easy ;;
            normal) bot=normal ;;
            hard) bot=hard ;;
        esac
    fi
    if [ "$bot" = off ]; then unset SF3500_BOT; else export SF3500_BOT=$bot; fi
}

while :; do
    apply_screen_setting
    rm -f launcher_action.txt
    rc=0
    # The launcher draws at 480x360: padded to 16:9 that is 640x360, within the display driver's
    # 640x480 frame limit. The engine must be told the size at start-up so that the script's
    # set_mode() call is not a size change.
    VIDEO_WIDTH=480 VIDEO_HEIGHT=360 SF3500_PADMAP=launcher "$PORT_DIR/bgdi.mipsel" launcher.dcb < /dev/null >> "$PORT_DIR/log.txt" 2>&1 || rc=$?
    echo "LAUNCHER EXIT CODE: $rc" >> "$PORT_DIR/log.txt"

    action=""
    [ -f launcher_action.txt ] && action=$(tr -d '\r\n' < launcher_action.txt)
    # Anything but "play" (Exit, Select + Start, or a launcher failure) leaves for the front-end.
    [ "$action" = play ] || break

    # Read the settings again: they may have been changed in the launcher just now.
    apply_screen_setting
    apply_bot_setting
    # One-player pad layout: A = up + confirm, B = thruster, Y = down (see the runtime input hook).
    grc=0
    SF3500_PADMAP=altitude "$PORT_DIR/bgdi.mipsel" altitude.dcb < /dev/null >> "$PORT_DIR/log.txt" 2>&1 || grc=$?
    echo "GAME EXIT CODE: $grc" >> "$PORT_DIR/log.txt"
done
rm -f launcher_action.txt
exit "$rc"
