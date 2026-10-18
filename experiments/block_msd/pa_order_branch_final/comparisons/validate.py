#!/usr/bin/env python3
"""Check source, ELF, command metadata, raw rows, and reviewed cells."""
import csv
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[3]
ELF = REPO / "experiments/block_msd/target/pa-comparator/time"


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def main():
    source_commit = (ROOT / "source-commit.txt").read_text().strip()
    assert len(source_commit) == 40, source_commit
    source_path = "experiments/block_msd/src/bin/frontier_experiment.rs"
    frozen_source = subprocess.check_output(
        ["git", "show", f"{source_commit}:{source_path}"], cwd=REPO
    )
    settings = json.loads((ROOT / "build-settings.json").read_text())
    assert settings["source_commit"] == source_commit
    assert settings["source_sha256"] == sha256(frozen_source)
    assert sha256(ELF.read_bytes()) == settings["binary_sha256"]
    recorded_binary, recorded_path = (ROOT / "binary-sha256.txt").read_text().split(maxsplit=1)
    assert recorded_binary == sha256(ELF.read_bytes())
    assert recorded_path.strip() == str(ELF.relative_to(REPO))
    assert (Path(str(ELF) + ".sha256").read_text().strip() == recorded_binary)

    files = sorted((ROOT / "measurements").glob("final-*.csv"))
    assert len(files) == 11, len(files)
    row_count = 0
    for path in files:
        metadata = json.loads(path.with_suffix(".json").read_text())
        assert metadata["returncode"] == 0, path.name
        assert metadata["source_commit"] == source_commit, path.name
        assert metadata["binary_sha256"] == recorded_binary, path.name
        assert metadata["command"][0:3] == ["taskset", "-c", "2"], path.name
        assert not path.with_suffix(".stderr").read_bytes(), path.name
        with path.open(newline="") as stream:
            row_count += sum(1 for _ in csv.DictReader(stream))
    assert row_count == 7416, row_count
    with (ROOT / "review-comparison.csv").open(newline="") as stream:
        reviewed = list(csv.DictReader(stream))
    assert len(reviewed) == 103, len(reviewed)
    summary = json.loads((ROOT / "summary.json").read_text())
    expected = {"Fa": 102, "Rollercoaster": 76, "L_frozen": 91, "stable_msd": 100}
    for baseline, faster in expected.items():
        assert summary[baseline]["faster_cells"] == faster
    print(f"source {source_commit} and ELF {recorded_binary}: PASS")
    print(f"{len(files)} CSVs, {row_count} timed rows, 103 reviewed cells: PASS")
    print("all command metadata, CPU pinning, stderr, and summaries: PASS")


if __name__ == "__main__":
    main()
