#!/usr/bin/env python3
"""Run frozen single-threaded sort comparisons and retain every observation."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import random
import subprocess
import time

ROOT = Path(__file__).resolve().parent
KINDS = ["u32", "u64", "u128", "i32", "i64", "f32", "f64", "record32", "record128"]
DISTS = ["uniform", "uniform_numeric", "uniform_narrow", "skew95", "few_unique", "sqrt_keys",
         "common_prefix", "low_bits_constant", "high_only", "sorted", "reversed",
         "nearly_sorted", "almost_sorted", "reverse_nearly_sorted", "all_equal",
         "late_difference", "alternating", "organ_pipe", "sawtooth", "zipf", "normal",
         "push_front", "push_middle"]
SIZES = [128, 1024, 16384, 262144, 1048576]
SEED = 0x6A09E667F3BCC909


def command(*args):
    return subprocess.check_output(args, text=True, cwd=ROOT).strip()


def vmstat():
    raw = dict(line.split() for line in Path("/proc/vmstat").read_text().splitlines())
    return {k: int(raw[k]) for k in ["pswpin", "pswpout", "pgmajfault", "oom_kill"]}


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def manifest():
    original = Path("/root/code/voracious_sort")
    source = ROOT / "source/pr"
    candidate = "e649c6af49d6bfdde896ca40cad387235fce4bfa"
    upstream = "3dbdd7f46006d4395626f18fda9c135b4ecd9bbb"
    assert subprocess.check_output(["git", "show", candidate+":src/sorts/block_lsd_stable_sort.rs"], cwd=original) == source.joinpath("src/sorts/block_lsd_stable_sort.rs").read_bytes()
    unchanged = [str(p.relative_to(source)) for p in source.joinpath("src").rglob("*.rs")
                 if str(p.relative_to(source)) not in ["src/lib.rs", "src/sorts/mod.rs", "src/sorts/block_lsd_stable_sort.rs"]]
    for name in unchanged:
        before = subprocess.check_output(["git", "show", f"{upstream}:{name}"], cwd=original)
        assert before == (source / name).read_bytes(), name
    result = {
        "created_utc": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "candidate_commit": candidate,
        "upstream_commit": upstream,
        "unchanged_upstream_sources": unchanged,
        "compiler": command("/root/.cargo/bin/rustc", "-Vv"),
        "cpu": command("lscpu"),
        "uname": command("uname", "-a"),
        "cpu_affinity": [2], "threads": 1,
        "rustflags": "-C target-cpu=native",
        "profile": "opt-level=3, codegen-units=1, lto=thin; assertions/debug assertions disabled",
        "timing_boundary": "whole parameterized sort including its allocation/deallocation; input preparation and full-output checks excluded; policy selection excluded",
        "cache_protocol": "one untimed warmup per algorithm/observation; independent precloned buffers; target 3 ms aggregate, cap 64 MiB and 2048 buffers; not a cold-cache benchmark",
        "replicates": "3 deterministic seeds, each measured in an exact forward/reverse algorithm order (6 observations); no inferential p-values",
        "memory_metric": "separate instrumented executable, peak live requested heap bytes during sort; excludes input/harness, RSS, allocator metadata and transient allocator-internal realloc storage",
        "oracle": "stable sort by converted radix key; exact value/bit/payload/order comparison for every warmup and every timed output",
        "seed": SEED, "kinds": KINDS, "distributions": DISTS, "primary_sizes": SIZES,
        "distribution_definitions": {
            "uniform": "SplitMix64-derived full-width entropy; finite f64 bit patterns, -0 normalized to +0",
            "few_unique": "16 possible keys, uniformly selected",
            "common_prefix": "fixed nonzero high bits, 16 variable low bits; finite f64 around +1",
            "sorted": "nondecreasing keys repeated four times",
            "reversed": "nonincreasing keys repeated four times; payload IDs assigned after reversal",
            "nearly_sorted": "sorted repeated-four keys, n/100 deterministic random swaps",
            "all_equal": "one key with distinct payload IDs for record types",
        },
        "files": {str(p.relative_to(ROOT)): sha(p) for p in [ROOT/"src/main.rs", ROOT/"Cargo.toml", ROOT/"Cargo.lock", ROOT/"benchmark-time", ROOT/"benchmark-memory", ROOT/"python-requirements.lock", ROOT/"run.py", ROOT/"build.rs", ROOT/"timsort_bridge.cpp"]},
        "source_files": {str(p.relative_to(source)): sha(p) for p in source.rglob("*") if p.is_file()},
        "timsort_reference_files": {str(p.relative_to(ROOT)): sha(p) for p in (ROOT/"source/cpp-timsort").rglob("*") if p.is_file()},
        "vmstat_start": vmstat(),
        "initial_meminfo": Path("/proc/meminfo").read_text(),
        "policies": {
            "fixed_records": [128, 512, 1024],
            "fixed_bytes_per_block": [1024, 4096, 8192],
            "sqrt_coefficients": [0.5, 1.0, 2.0],
            "sqrt_formula": "max(1, ceil(coefficient * sqrt(9*n/(2*2^radix*record_bytes))))",
            "radix_bits": 8,
        },
        "benchmark_only_visibility_adapter": "source/pr/src/lib.rs reexports existing lsd_radixsort_aux and lsd_radixsort_heu; production repository untouched; all algorithm implementation files match frozen candidate/upstream",
        "comparators": {
            "std": "Rust 1.98.1 slice::sort_by_key; driftsort family; https://doc.rust-lang.org/std/primitive.slice.html#method.sort_by_key",
            "timsort": "gfx::timsort v3.0.1, commit 3f5ebd06264297b8a754ac14b2ba9bad85b8c651; unmodified header; C++20 native comparator on equivalent converted keys; one FFI call per whole sort; https://github.com/timsort/cpp-TimSort/tree/v3.0.1",
            "lsd": "lsd_stable_radixsort, documented stable; measured violations retained",
            "lsd_plain": "lsd_radixsort, documented unstable",
            "lsd_core": "lsd_radixsort_aux without Verge, heuristic=false, min_cs2=0; small fallback unstable",
            "lsd_heuristic": "lsd_radixsort_heu, min_cs2=100000; primitive types only because counting conversion is unavailable for opaque records",
            "dlsd": "dlsd_radixsort; unstable fallback/diversion",
            "thiel": "thiel_radixsort; documented unstable and unsupported for u128/i128",
            "dedicated": "lsd_u32 or lsd_f32, applicable primitive type only",
            "lsd_aa": "identical function/code path to lsd, repeated within block",
        },
        "cpp_compiler": command("g++", "--version"),
        "cpp_flags": "-O3 -march=native -std=c++20 -DNDEBUG -fPIC",
        "cpp_memory_accounting": "instrumented build reports requested C++ operator-new allocation bytes into the same live-allocation meter; matching delete verified and live=0 required; wrapper bookkeeping excluded",
    }
    (ROOT/"manifest.json").write_text(json.dumps(result, indent=2)+"\n")


def primary_cases():
    cases = [dict(kind=k, dist=d, n=n, group="primary") for k in KINDS for d in DISTS for n in SIZES]
    for n in [256, 4096, 65536, 131072, 250000, 524288, 2097152, 4194304, 8388608, 16777216]:
        cases.append(dict(kind="u64", dist="uniform", n=n, group="scaling"))
    return cases


def execute(case, mode, stem, observations):
    exe = ROOT / ("benchmark-time" if mode == "time" else "benchmark-memory")
    args = ["taskset", "-c", "2", "/usr/bin/time", "-f", "RESOURCE %M %F %W %x",
            str(exe), mode, case["kind"], case["dist"], str(case["n"]), str(SEED),
            str(case.get("radix", 8)), str(case.get("block", 512)), str(observations), case.get("only", "all")]
    start = time.time()
    before = vmstat()
    p = subprocess.run(args, text=True, capture_output=True, cwd=ROOT, env={**os.environ, "RAYON_NUM_THREADS": "1"})
    after = vmstat()
    meta = {"case": case, "mode": mode, "command": args, "start_unix": start,
            "wall_seconds": time.time()-start, "returncode": p.returncode,
            "vmstat_delta": {k: after[k]-before[k] for k in before}, "stderr": p.stderr}
    with (ROOT/"data"/(stem+"-processes.jsonl")).open("a") as f:
        f.write(json.dumps(meta)+"\n")
    if p.returncode:
        (ROOT/"data"/(stem+"-failed-stdout.txt")).write_text(p.stdout)
        raise RuntimeError(f"{case}: {p.stderr[-2000:]}")
    rows = [json.loads(line) for line in p.stdout.splitlines()]
    kind = case["kind"]
    expected_algorithms = (16 + (kind != "u128") + (not kind.startswith("record")) + (kind in ["u32", "f32"])) if case.get("only", "all") == "all" else 1
    assert len(rows) == expected_algorithms * observations * (2 if mode == "time" else 1)
    for row in rows:
        row["group"] = case["group"]
        if "policy" in case:
            row["algorithm"] = case["policy"]
            row["policy_parameter"] = case["parameter"]
    with (ROOT/"data"/(stem+".jsonl")).open("a") as f:
        for row in rows:
            f.write(json.dumps(row)+"\n")
    assert "VmSwap:\t       0 kB" in p.stderr or "VmSwap:\t       0" in p.stderr, p.stderr
    assert all(r["valid"] for r in rows if r["algorithm"].startswith("block_") or r["algorithm"] in ["std", "timsort"])
    return rows


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("stage", choices=["pilot", "primary", "memory"])
    args = parser.parse_args()
    if args.stage == "pilot":
        manifest()
        cases = [dict(kind=k, dist=d, n=16384, group="pilot") for k in KINDS for d in DISTS]
        for i,c in enumerate(cases):
            rows = execute(c, "time", "preflight-v2", 1)
            failures = sorted({r["algorithm"] for r in rows if not r["valid"]})
            print(f"pilot {i+1}/{len(cases)} {c['kind']} {c['dist']} comparator_failures={failures}", flush=True)
        execute(dict(kind="u64", dist="uniform", n=1048576, group="pilot"), "memory", "preflight-v2-memory", 1)
        return
    cases = primary_cases()
    random.Random(20261018).shuffle(cases)
    mode = "time" if args.stage == "primary" else "memory"
    stem = args.stage
    if (ROOT/"data"/(stem+".jsonl")).exists():
        raise RuntimeError("refusing to append a duplicate campaign")
    (ROOT/"data"/(stem+"-schedule.json")).write_text(json.dumps(cases, indent=2)+"\n")
    start = time.time()
    for i, c in enumerate(cases):
        execute(c, mode, stem, 3)
        print(f"{stem} {i+1}/{len(cases)} {c['kind']} {c['dist']} n={c['n']} elapsed={time.time()-start:.1f}s", flush=True)
    m = json.loads((ROOT/"manifest.json").read_text())
    m[stem+"_wall_seconds"] = time.time()-start
    m[stem+"_vmstat_end"] = vmstat()
    (ROOT/"manifest.json").write_text(json.dumps(m, indent=2)+"\n")


if __name__ == "__main__":
    main()
