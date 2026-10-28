# Water Closet

Water Closet is a platform game by Stephen and Richard Sweeney (Parallel Realities) where the
goal of each stage is to escape down a toilet. It won first place for overall fun factor and for
completeness of experience in itch.io's Linux Game Jam 2019. This port runs it natively on
TreeFrogUI devices, built from the
[SF3500 branch](https://github.com/Kryptikone316/waterCloset/tree/sf3500) of the author's
[source](https://github.com/stephenjsweeney/waterCloset) (version 1.0). Everything is included, so
it is ready to play.

Select **Water Closet** under **Games → Ports** to start the game.

## Controls

| Button | Action |
|--|--|
| D-Pad | Move, navigate menus |
| A | Jump |
| B | Interact / use |
| X | Create a clone and reset the stage |
| Y | Restart the stage |
| Start | Pause |
| Select + Start (held together) | Quit immediately |

## Saves and settings

The game keeps its saves and settings inside the port folder, so everything stays in one place:

```text
roms/ports/watercloset/home/.local/share/waterCloset/
```

To start over, delete that folder.

## Supported devices

The port loads the display and audio driver that TreeFrogUI selects for your device (it reads it
from `/tmp/tfdevice.env`), so one build covers every device that shows frames through that driver.
It is tested on the SF3500. The SF3000, SF3000 HD, SF3100 and GB350 use the same method and should
work, but have not all been tested. It does **not** run on the R36SX and R36HD, which write to the
framebuffer directly instead.

## If something goes wrong

Every launch writes `log.txt` in the port folder and ends it with an `EXIT CODE:` line. Its first
lines show the device, display mode and driver the port picked. Include it when reporting a problem.

## Source and licenses

The game's source code is under the GNU General Public License 3.0. Its graphics and data are
under Creative Commons BY-NC-SA 3.0, which allows use and sharing for **non-commercial** purposes
with credit, and the music and sound effects have their own licences, listed file by file in
`roms/ports/watercloset/licenses/CREDITS.txt` together with the licence texts. One sound effect is
credited upstream only as "Copyright www.freesfx.co.uk", whose terms allow its use inside a game
with credit; it is shipped only as part of the game. The source for this port is the pinned
`source/` submodule. SDL2, SDL2_image and FreeType come with the device's firmware and are not
included.
