#!/usr/bin/env python3
"""Fill only frozen, absent effective candidate calls; retain every observation."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent
STORY = ROOT.parent
sys.path.insert(0, str(STORY / "validation"))
import protocol


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=["time", "memory"])
    mode = parser.parse_args().mode
    manifest = json.loads((ROOT / "manifest.json").read_text())
    for name, digest in manifest["sources"].items():
        assert protocol.sha(STORY / name) == digest, name
    for name, digest in manifest["binaries"].items():
        assert protocol.sha(STORY / "validation" / name) == digest, name
    assert protocol.sha(Path(__file__)) == manifest["driver_sha256"]
    output = ROOT / "data" / (mode + ".jsonl")
    assert not output.exists(), "Refusing to append duplicate measurements"
    reference = json.loads((STORY / "validation/data/reference-input-digests.json").read_text())
    cases = manifest[mode + "_cases"]
    start = time.time()
    for index, case in enumerate(cases, 1):
        methods = [(manifest["candidate"], case["block"])]
        if mode == "time":
            methods += [(name, 512) for name in ["lsd", "std", "timsort"]]
        arguments = ["taskset", "-c", "2", "/usr/bin/time", "-f", "RESOURCE %M %F %W %x",
                     str(STORY / "validation" / ("benchmark-" + mode)), mode, case["kind"], case["dist"],
                     str(case["n"]), str(protocol.SEED), "8", "512", "3",
                     ",".join(f"{name}:{block}" for name, block in methods)]
        before = protocol.vmstat()
        process_start = time.time()
        result = subprocess.run(arguments, capture_output=True, text=True, cwd=ROOT,
                                env={**os.environ, "RAYON_NUM_THREADS": "1"})
        after = protocol.vmstat()
        metadata = dict(case=case, mode=mode, command=arguments, start_unix=process_start,
                        wall_seconds=time.time() - process_start, returncode=result.returncode,
                        stderr=result.stderr, vmstat_delta={key:after[key] - before[key] for key in before})
        with (ROOT / "data" / (mode + "-processes.jsonl")).open("a") as stream:
            stream.write(json.dumps(metadata) + "\n")
        assert result.returncode == 0, (case, result.stderr)
        assert int(re.search(r"VmSwap:\s+(\d+)", result.stderr).group(1)) == 0
        rows = [json.loads(line) for line in result.stdout.splitlines()]
        assert len(rows) == len(methods) * (6 if mode == "time" else 3)
        for row in rows:
            key = "|".join(str(row[field]) for field in ["kind", "dist", "n", "pair"])
            assert row["input_digest"] == reference[key]
            assert row["ordered"] and row["preserved"]
            if row["algorithm"] != "lsd":
                assert row["valid"], row
            if mode == "memory":
                bound = 512 * case["block"] * case["bytes_per_record"] + 9 * (case["n"] // case["block"]) + 66 * 256
                assert row["peak_bytes"] <= bound
            row.update(campaign="missing_effective_candidate_only", group="missing_only")
        with output.open("a") as stream:
            for row in rows:
                stream.write(json.dumps(row) + "\n")
        print(f"{mode} {index}/{len(cases)} {case['kind']} {case['dist']} n={case['n']} elapsed={time.time()-start:.1f}s", flush=True)
    (ROOT / (mode + "-complete.json")).write_text(json.dumps(dict(
        conditions=len(cases), wall_seconds=time.time()-start,
        output_sha256=protocol.sha(output)), indent=2) + "\n")


if __name__ == "__main__":
    main()
