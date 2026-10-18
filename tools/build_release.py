#!/usr/bin/env python3
import json
import shutil
import subprocess
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "dist"


def add_file(archive, source, name):
    info = zipfile.ZipInfo(name)
    info.compress_type = zipfile.ZIP_DEFLATED
    mode = source.stat().st_mode & 0o777
    info.external_attr = (0o100000 | mode) << 16
    archive.write(source, name)


def package(archive, ports):
    for port in ports:
        directory = ROOT / "ports" / port["id"]
        launcher = port["launcher"]
        for source in sorted(directory.rglob("*")):
            relative = source.relative_to(directory)
            if relative.parts[0] == "source" or not source.is_file():
                continue
            add_file(archive, source, (Path("roms/ports") / port["id"] / relative).as_posix())
        wrapper = (
            "#!/bin/sh\n"
            "set -eu\n"
            f"exec /mnt/sdcard/roms/ports/{port['id']}/run.sh \"$@\"\n"
        )
        name = f"roms/ports/{launcher}"
        info = zipfile.ZipInfo(name)
        info.compress_type = zipfile.ZIP_DEFLATED
        info.external_attr = (0o100755) << 16
        archive.writestr(info, wrapper.encode())
        art = directory / "boxart.png"
        add_file(archive, art, f"roms/ports/.res/{Path(launcher).stem}.png")
        install_art = directory / "install.png"
        if install_art.is_file():
            add_file(archive, install_art, f"frogui/port-help/{port['id']}.png")


def main():
    validator = ROOT / "tools/validate_ports.py"
    result = subprocess.run([sys.executable, str(validator)], cwd=ROOT)
    if result.returncode:
        return result.returncode
    if OUT.exists():
        shutil.rmtree(OUT)
    OUT.mkdir(parents=True)
    ports = []
    for directory in sorted(path for path in (ROOT / "ports").iterdir() if path.is_dir()):
        if directory.name == "source":
            continue
        ports.append(json.loads((directory / "config.json").read_text()))
    standalone = [port for port in ports if not (ROOT / "ports" / port["id"] / ".requires_game_data").exists()]
    requires_data = [port for port in ports if (ROOT / "ports" / port["id"] / ".requires_game_data").exists()]
    packages = (
        ("TreeFrogUI-Ports-standalone.zip", standalone),
        ("TreeFrogUI-Ports-requiring-game-data.zip", requires_data),
    )
    for filename, group in packages:
        with zipfile.ZipFile(OUT / filename, "w") as archive:
            package(archive, group)
    print(f"Created {len(packages)} port archives in {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
