#!/usr/bin/env python3
"""Hash the completed evidence bundle or verify its recorded file contents."""
import argparse
import hashlib
import json
from pathlib import Path
import time

ROOT=Path(__file__).resolve().parent
EXCLUDED={".venv","target","__pycache__",".git"}


def digest(path):
    value=hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda:f.read(1024*1024),b""):
            value.update(block)
    return value.hexdigest()


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--verify",action="store_true")
    args=parser.parse_args()
    sums=ROOT/"SHA256SUMS"
    if args.verify:
        rows=[line.split("  ",1) for line in sums.read_text().splitlines()]
        for expected,name in rows:
            assert digest(ROOT/name)==expected,name
        print(f"Verified {len(rows)} files")
        return
    audit=json.loads((ROOT/"data/audit.json").read_text())
    assert audit["time_observations"]==112170
    assert audit["memory_observations"]==56085
    supplement=json.loads((ROOT/"data/supplemental-sqrt-audit.json").read_text())
    assert supplement["time_observations"]==16350
    assert supplement["memory_observations"]==8175
    assert (ROOT/"REPORT.md").is_file()
    assert (ROOT/"qa/README.md").is_file()
    (ROOT/"SEAL.json").write_text(json.dumps({
        "created_utc":time.strftime("%Y-%m-%dT%H:%M:%SZ",time.gmtime()),
        "scope":"All bundle files except regenerable Python/Rust environments, Git internals and SHA256SUMS itself",
        "excluded_directory_names":sorted(EXCLUDED),
        "time_observations":audit["time_observations"],
        "memory_observations":audit["memory_observations"],
        "supplemental_time_observations":supplement["time_observations"],
        "supplemental_memory_observations":supplement["memory_observations"],
        "primary_data_file":"data/primary.jsonl",
        "memory_data_file":"data/memory.jsonl",
    },indent=2)+"\n")
    files=sorted(p for p in ROOT.rglob("*") if p.is_file()
        and not EXCLUDED.intersection(p.relative_to(ROOT).parts)
        and p!=sums)
    sums.write_text("".join(f"{digest(p)}  {p.relative_to(ROOT)}\n" for p in files))
    print(f"Sealed {len(files)} files")


if __name__=="__main__":main()
