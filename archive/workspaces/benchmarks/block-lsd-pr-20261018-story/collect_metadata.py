#!/usr/bin/env python3
"""Record the actual analysis environment and unchanged repository state."""
import hashlib
import json
from pathlib import Path
import platform
import re
import subprocess
import sys
import time

import matplotlib
from matplotlib import font_manager
import numpy

ROOT = Path(__file__).resolve().parent
REPOSITORY = Path("/root/code/voracious_sort")


def command(args, cwd=None):
    result = subprocess.run(args, cwd=cwd, capture_output=True, text=True)
    assert result.returncode == 0, (args, result.stderr)
    return dict(command=args, returncode=result.returncode, stdout=result.stdout, stderr=result.stderr)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    collected = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    font = Path(font_manager.findfont("DejaVu Sans"))
    libraries = {}
    dependencies = {}
    for name in ["benchmark-time", "benchmark-memory"]:
        result = command(["ldd", str(ROOT / "validation" / name)])
        dependencies[name] = result
        for match in re.findall(r"(?:=>\s+|^\s*)(/\S+)", result["stdout"], re.MULTILINE):
            path = Path(match).resolve()
            libraries[str(path)] = sha(path)
    environment = dict(collected_utc=collected, python=sys.version, platform=platform.platform(),
                       numpy=numpy.__version__, matplotlib=matplotlib.__version__,
                       font=dict(path=str(font), sha256=sha(font)),
                       cpu=command(["lscpu", "--json"]),
                       rustc=command(["/root/.cargo/bin/rustc", "-Vv"]),
                       cargo=command(["/root/.cargo/bin/cargo", "-V"]),
                       cpp=command(["c++", "--version"]),
                       dynamic_libraries=dependencies, library_sha256=libraries,
                       cache_geometry=json.loads((ROOT / "fits/cache-geometry.json").read_text()))
    (ROOT / "environment-final.json").write_text(json.dumps(environment, indent=2) + "\n")
    checks = [command(args, cwd=REPOSITORY) for args in [
        ["git", "rev-parse", "HEAD"], ["git", "status", "--porcelain=v1"],
        ["git", "rev-list", "--left-right", "--count", "upstream/master...HEAD"],
        ["git", "diff", "--exit-code", "upstream/master", "--", "Cargo.toml", "Cargo.lock", "LICENSE"],
    ]]
    manifest = json.loads((ROOT / "validation/manifest.json").read_text())
    assert checks[0]["stdout"].strip() == manifest["candidate_commit"]
    assert checks[1]["stdout"] == "", "Review uncommitted repository changes before sealing"
    (ROOT / "qa/repository-state.json").write_text(json.dumps(dict(
        repository=str(REPOSITORY), checked_utc=collected, checks=checks), indent=2) + "\n")
    print("Recorded environment, font/library hashes and clean repository state")


if __name__ == "__main__":
    main()
