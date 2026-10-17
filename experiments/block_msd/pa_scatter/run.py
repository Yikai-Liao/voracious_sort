#!/usr/bin/env python3
"""Run immutable timed/work executables sequentially on one CPU."""
import argparse
import json
import os
from pathlib import Path
import resource
import subprocess
import time

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
BIN = REPO / "experiments/block_msd/target/pa-scatter"
ALL = "Pa,Pa_unified_prepared_t16777216,Pa_unified_fixed_t16777216,Pa_unified_preload_t16777216,Pa_unified_backend_t16777216,L_frozen,stable_msd,Pa"
CASES = "uniform,sorted,reverse,equal,few,common_high,deep_skew,multi_heavy,majority_prefix,outlier_first,sparse,comb"
LAYOUTS = "u8,u16,u32,u64,u128,u8_id8,u16_id8,small8,wide32,large128"


def main():
    p = argparse.ArgumentParser(__doc__)
    p.add_argument("name")
    p.add_argument("--n", type=int, default=1048576)
    p.add_argument("--reps", type=int, default=12)
    p.add_argument("--methods", default=ALL)
    p.add_argument("--cases", default=CASES)
    p.add_argument("--layouts", default=LAYOUTS)
    p.add_argument("--kind", choices=["time", "memory", "work"], default="time")
    p.add_argument("--block", type=int, default=64)
    p.add_argument("--seed", type=int, default=0x123456789ABCDEF)
    args = p.parse_args()
    dest = ROOT / "measurements" / f"{args.name}.csv"
    dest.parent.mkdir(exist_ok=True)
    if dest.exists():
        raise SystemExit(f"refusing to replace {dest}")
    executable = BIN / ("work" if args.kind == "work" else "time")
    cmd = ["taskset", "-c", "2", str(executable), str(args.n), str(args.reps),
           args.methods, args.cases, args.layouts, args.kind, str(args.block), str(args.seed)]
    metadata = {"command": cmd, "started_ns": time.time_ns(), "pid": os.getpid(),
                "meminfo_before": Path("/proc/meminfo").read_text(),
                "load_before": Path("/proc/loadavg").read_text()}
    with dest.open("w") as out, dest.with_suffix(".stderr").open("w") as err:
        result = subprocess.run(cmd, cwd=REPO, stdout=out, stderr=err)
    metadata.update(ended_ns=time.time_ns(), returncode=result.returncode,
                    meminfo_after=Path("/proc/meminfo").read_text(),
                    load_after=Path("/proc/loadavg").read_text())
    usage=resource.getrusage(resource.RUSAGE_CHILDREN)
    metadata["child_usage"]={name:getattr(usage,name) for name in
        ["ru_utime","ru_stime","ru_maxrss","ru_minflt","ru_majflt","ru_nvcsw","ru_nivcsw"]}
    dest.with_suffix(".json").write_text(json.dumps(metadata, indent=2) + "\n")
    print(dest.name, result.returncode, round((metadata["ended_ns"]-metadata["started_ns"])/1e9, 2), flush=True)
    result.check_returncode()


if __name__ == "__main__":
    main()
