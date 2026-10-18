#!/usr/bin/env python3
"""Run the frozen comparison ELF and preserve each invocation's metadata."""
import argparse
import json
import os
from pathlib import Path
import resource
import subprocess
import time

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[3]
BIN = REPO / "experiments/block_msd/target/pa-comparator"
ALL = (
    "Pa_unified_groups_t16777216,Fa,Rollercoaster,L_frozen,"
    "stable_msd,Pa_unified_groups_t16777216"
)
CASES = "uniform,sorted,reverse,equal,few,common_high,deep_skew,multi_heavy,majority_prefix,outlier_first,sparse,comb"
LAYOUTS = "u8,u16,u32,u64,u128,u8_id8,u16_id8,small8,wide32,large128"


def main():
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument("name")
    parser.add_argument("--n", type=int, default=1048576)
    parser.add_argument("--reps", type=int, default=12)
    parser.add_argument("--methods", default=ALL)
    parser.add_argument("--cases", default=CASES)
    parser.add_argument("--layouts", default=LAYOUTS)
    parser.add_argument("--kind", choices=["time", "memory", "work"], default="time")
    parser.add_argument("--block", type=int, default=64)
    parser.add_argument("--seed", type=int, default=0x123456789ABCDEF)
    args = parser.parse_args()

    output = ROOT / "measurements" / f"{args.name}.csv"
    output.parent.mkdir(exist_ok=True)
    if output.exists():
        raise SystemExit(f"refusing to replace {output}")
    executable = BIN / ("work" if args.kind == "work" else "time")
    command = [
        "taskset", "-c", "2", str(executable), str(args.n), str(args.reps),
        args.methods, args.cases, args.layouts, args.kind, str(args.block),
        str(args.seed),
    ]
    metadata = {
        "command": command,
        "started_ns": time.time_ns(),
        "pid": os.getpid(),
        "binary": str(executable),
        "binary_sha256": Path(str(executable) + ".sha256").read_text().strip(),
        "source_commit": (ROOT / "source-commit.txt").read_text().strip(),
        "meminfo_before": Path("/proc/meminfo").read_text(),
        "load_before": Path("/proc/loadavg").read_text(),
    }
    with output.open("w") as stdout, output.with_suffix(".stderr").open("w") as stderr:
        result = subprocess.run(command, cwd=REPO, stdout=stdout, stderr=stderr)
    metadata.update(
        ended_ns=time.time_ns(),
        returncode=result.returncode,
        meminfo_after=Path("/proc/meminfo").read_text(),
        load_after=Path("/proc/loadavg").read_text(),
    )
    usage = resource.getrusage(resource.RUSAGE_CHILDREN)
    metadata["child_usage"] = {
        key: getattr(usage, key)
        for key in ["ru_utime", "ru_stime", "ru_maxrss", "ru_minflt", "ru_majflt", "ru_nvcsw", "ru_nivcsw"]
    }
    output.with_suffix(".json").write_text(json.dumps(metadata, indent=2) + "\n")
    print(output.name, result.returncode, round((metadata["ended_ns"] - metadata["started_ns"]) / 1e9, 2), flush=True)
    result.check_returncode()


if __name__ == "__main__":
    main()
