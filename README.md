# TreeFrogUI Ports Collection

This repository holds port launchers, their per-port binaries and artwork, and
the source repositories pinned as Git submodules. Each directory under `ports/`
is self-contained. Libretro cores and native game executables stay inside their
port directory; general-purpose emulator cores such as OpenBOR stay in the
TreeFrogUI core collection.

Each port has a `config.json`. `required_file_sets` lists alternative sets of
user-provided files. The presence of `.requires_game_data` must match whether
that list is non-empty. Copyrighted game data is never included. `run.sh`
delegates missing-file reporting to TreeFrogUI's shared `port_check.sh`.

## Build and validate

```sh
git clone --recurse-submodules git@github.com:tzubertowski/TreeFrogUI_PortsCollection.git
python3 tools/validate_ports.py
python3 tools/build_release.py
```

The release build creates exactly two archives in `dist/`:

- `TreeFrogUI-Ports-standalone.zip`
- `TreeFrogUI-Ports-requiring-game-data.zip`

Both preserve the SD card `roms/ports/` layout. Each visible root `.sh` entry
delegates to `ports/<id>/run.sh`; port-specific executables and Libretro cores
are installed inside `roms/ports/<id>/`.

Pull requests and pushes run validation. Every push to `main` also creates a
GitHub release with the two validated archives.
