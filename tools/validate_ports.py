#!/usr/bin/env python3
import json
import re
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PORTS = ROOT / "ports"
ERRORS = []


def fail(message):
    ERRORS.append(message)


def valid_relative(value):
    path = Path(value)
    return bool(value) and not path.is_absolute() and ".." not in path.parts


def main():
    if not PORTS.is_dir():
        print("ports/ directory is missing", file=sys.stderr)
        return 1
    ids = set()
    launchers = set()
    for directory in sorted(path for path in PORTS.iterdir() if path.is_dir()):
        if directory.name == "source":
            continue
        config_path = directory / "config.json"
        try:
            config = json.loads(config_path.read_text())
        except (OSError, json.JSONDecodeError) as error:
            fail(f"{directory.name}: invalid config.json: {error}")
            continue
        port_id = config.get("id")
        if not isinstance(port_id, str) or not re.fullmatch(r"[a-z0-9][a-z0-9_-]*", port_id):
            fail(f"{directory.name}: invalid id")
            continue
        if port_id != directory.name or port_id in ids:
            fail(f"{port_id}: id must be unique and match its directory")
        ids.add(port_id)
        launcher = config.get("launcher")
        if not isinstance(launcher, str) or not launcher.endswith(".sh") or Path(launcher).name != launcher:
            fail(f"{port_id}: launcher must be a root-level .sh filename")
            launcher = ""
        if launcher in launchers:
            fail(f"{port_id}: duplicate launcher {launcher}")
        launchers.add(launcher)
        run_script = directory / "run.sh"
        if not run_script.is_file() or not run_script.stat().st_mode & 0o111:
            fail(f"{port_id}: run.sh must exist and be executable")
        else:
            script = run_script.read_text(errors="replace")
            if config.get("required_file_sets") and "cubegm/port_check.sh" not in script:
                fail(f"{port_id}: run.sh must use TreeFrogUI's shared required-files checker")
        source = directory / "source"
        gitmodules = ROOT / ".gitmodules"
        if not source.is_dir() or not gitmodules.is_file():
            fail(f"{port_id}: source/ submodule is missing")
        else:
            try:
                stage = subprocess.check_output(
                    ["git", "ls-files", "--stage", str(source.relative_to(ROOT))],
                    cwd=ROOT, text=True,
                )
                if not stage.startswith("160000 "):
                    fail(f"{port_id}: source/ is not recorded as a Git submodule")
            except subprocess.CalledProcessError:
                fail(f"{port_id}: could not inspect source submodule")
        launch = config.get("launch")
        if not isinstance(launch, dict) or launch.get("type") not in {"native", "libretro"}:
            fail(f"{port_id}: launch.type must be native or libretro")
            launch = {}
        binary = launch.get("binary", "")
        if not isinstance(binary, str) or not valid_relative(binary):
            fail(f"{port_id}: launch.binary must be a safe relative path")
        elif not (directory / binary).is_file():
            fail(f"{port_id}: missing port-local launch binary {binary}")
        elif run_script.is_file() and f"$PORT_DIR/{Path(binary).name}" not in run_script.read_text(errors="replace"):
            fail(f"{port_id}: run.sh must launch configured binary from its port directory: {binary}")
        if isinstance(binary, str) and valid_relative(binary) and (directory / binary).is_file():
            header = (directory / binary).read_bytes()[:20]
            if len(header) < 20 or header[:6] != b"\x7fELF\x01\x01" or struct.unpack_from("<H", header, 18)[0] != 8:
                fail(f"{port_id}: launch binary must be a little-endian 32-bit MIPS ELF")
        if launch.get("type") == "libretro" and not str(binary).endswith("_libretro.so"):
            fail(f"{port_id}: Libretro binary must use the _libretro.so suffix")
        if launch.get("type") == "native" and not binary:
            fail(f"{port_id}: native launch requires a binary")
        content = launch.get("content")
        if content and valid_relative(content) and not (directory / content).exists() and not any(
            content in group for group in config.get("required_file_sets", []) if isinstance(group, list)
        ):
            fail(f"{port_id}: launch content is neither packaged nor declared as required game data: {content}")
        file_sets = config.get("required_file_sets")
        if not isinstance(file_sets, list) or any(
            not isinstance(group, list) or not group or
            any(not isinstance(item, str) or not valid_relative(item) for item in group)
            for group in file_sets
        ):
            fail(f"{port_id}: required_file_sets must be arrays of safe relative filenames")
            file_sets = []
        marker = directory / ".requires_game_data"
        if marker.exists() != bool(file_sets):
            fail(f"{port_id}: .requires_game_data must match required_file_sets")
        if run_script.is_file():
            script = run_script.read_text(errors="replace")
            for item in {item for group in file_sets for item in group}:
                if Path(item).name not in script:
                    fail(f"{port_id}: run.sh does not check configured file {item}")
        guide = config.get("setup_guide")
        guide_url = config.get("setup_guide_url")
        if not isinstance(guide, str) or not valid_relative(guide) or not (ROOT / guide).is_file():
            fail(f"{port_id}: setup_guide must name a checked-in guide")
        if not isinstance(guide_url, str) or not guide_url.startswith("https://"):
            fail(f"{port_id}: setup_guide_url must be HTTPS")
        for filename in {item for group in file_sets for item in group}:
            if (directory / filename).exists():
                fail(f"{port_id}: user-provided game data must not be committed: {filename}")
        if not (directory / "boxart.png").is_file():
            fail(f"{port_id}: boxart.png is missing")
    if not ids:
        fail("no ports found")
    if ERRORS:
        print("Port validation failed:", file=sys.stderr)
        for error in ERRORS:
            print(f"- {error}", file=sys.stderr)
        return 1
    print(f"Validated {len(ids)} ports and their launch config, required files, artwork, and source submodules.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
