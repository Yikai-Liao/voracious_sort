#!/usr/bin/env python3
"""Validate completion, pairing and frozen source/binary ledgers."""
import csv
import collections
import hashlib
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]


def main():
    source_ref = (ROOT/"source-commit.txt").read_text().strip() if (ROOT/"source-commit.txt").exists() else None
    for name in ["source-sha256.txt", "binary-sha256.txt"]:
        for line in (ROOT/name).read_text().splitlines():
            digest, path = line.split("  ", 1)
            contents = subprocess.check_output(["git", "show", f"{source_ref}:{path}"], cwd=REPO) if name=="source-sha256.txt" and source_ref else (REPO/path).read_bytes()
            assert hashlib.sha256(contents).hexdigest() == digest, path
    measurements = ROOT/"measurements"
    csv_stems = {p.stem for p in measurements.glob("*.csv")}
    json_stems = {p.stem for p in measurements.glob("*.json")}
    assert csv_stems == json_stems, ("incomplete measurements", csv_stems ^ json_stems)
    total = 0
    for meta in sorted((ROOT/"measurements").glob("*.json")):
        data = json.loads(meta.read_text())
        assert data["returncode"] == 0, meta
        assert meta.with_suffix(".stderr").stat().st_size == 0, meta
        cmd = data["command"]
        n, reps = map(int,cmd[4:6])
        methods, cases, layouts = [s.split(",") for s in cmd[6:9]]
        kind, block, seed = cmd[9:12]
        with meta.with_suffix(".csv").open() as f:
            rows = list(csv.DictReader(f))
        assert len(rows) == reps*len(methods)*len(cases)*len(layouts), meta
        seen = set()
        addresses = {}
        execution = collections.defaultdict(list)
        for r in rows:
            assert r["layout"] in layouts and r["case"] in cases, meta
            assert int(r["n"]) == n and r["seed"] == seed and r["block"] == block, meta
            assert r["kind"] == kind and (r["instrumented"]=="true") == (kind=="work"), meta
            slot, rep = int(r["slot"]),int(r["rep"])
            assert methods[slot] == r["method"] and 0<=rep<reps, meta
            key = r["layout"],r["case"],slot,rep
            execution[r["layout"],r["case"],rep].append(slot)
            assert key not in seen, (meta,key)
            seen.add(key)
            addrkey = r["layout"],r["case"]
            if addrkey not in addresses:
                addresses[addrkey] = r["input_address"]
            assert addresses[addrkey] == r["input_address"], meta
            if kind=="time":
                assert int(r["wall_ns"])>0 and int(r["cpu_ns"])>0, meta
            if kind=="work":
                lengths = dict(map(int,pair.split(":")) for pair in r["leaf_lengths"].split(";") if pair)
                assert sum(lengths.values()) == int(r["leaves"]), meta
                assert sum(k*v for k,v in lengths.items()) == int(r["leaf_records"]), meta
        for (_, _, rep), order in execution.items():
            expected_order = [((j if rep % 2 == 0 else len(methods)-1-j) + rep//2) % len(methods) for j in range(len(methods))]
            assert order == expected_order, (meta, rep, order, expected_order)
        total += len(rows)
        print(meta.stem,len(rows),"OK")
    print("all",total,"rows; source/binary hashes OK")


if __name__ == "__main__":
    main()
