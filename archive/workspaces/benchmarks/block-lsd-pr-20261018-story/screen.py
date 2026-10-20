#!/usr/bin/env python3
"""Screen retained policies before freezing the broader validation campaign."""
from collections import defaultdict
import csv
import hashlib
import json
import math
from pathlib import Path
import statistics
import numpy as np

ROOT = Path(__file__).resolve().parent


def read(name):
    with (ROOT / "data" / name).open() as f:
        return list(csv.DictReader(f))


def write(name, rows):
    with (ROOT / "data" / name).open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def geometric(values):
    return math.exp(statistics.mean(math.log(x) for x in values))


def main():
    summaries = read("supplemental-sqrt-summary.csv")
    timing = read("supplemental-sqrt-timing.csv")
    samples = defaultdict(list)
    for r in timing:
        if r["algorithm"].startswith("block_"):
            assert r["valid"] == "True"
            # Every policy takes precisely the same comparison-sort leaf at n<=128.
            block = int(r["block"]) if int(r["n"]) > 128 else 0
            samples[r["kind"], r["dist"], int(r["n"]), block].append(float(r["ns"]))
    config_time = {k: statistics.median(v) for k, v in samples.items()}
    cases = defaultdict(list)
    index = {}
    for r in summaries:
        key = r["kind"], r["dist"], int(r["n"])
        index[(*key, r["algorithm"])] = r
        if r["algorithm"].startswith("block_"):
            block = int(r["block"]) if key[2] > 128 else 0
            cases[key].append((r, config_time[(*key, block)]))
    assert len(cases) == 109
    detailed = []
    grouped = defaultdict(list)
    for case, observations in sorted(cases.items()):
        assert len(observations) == 21
        fastest = min(t for r, t in observations)
        reference = next(t for r, t in observations if r["algorithm"] == "block_fixed_bytes_4096")
        for r, elapsed in observations:
            lsd = index[(*case, "lsd")]
            result = dict(kind=case[0], dist=case[1], n=case[2],
                algorithm=r["algorithm"], family=r["policy_family"], parameter=int(r["policy_parameter"]),
                record_bytes=int(r["bytes_per_record"]), block=int(r["block"]),
                pooled_median_ns=elapsed, pooled_observations=len(samples[(*case, int(r["block"]) if case[2]>128 else 0)]),
                median_peak_bytes=float(r["median_peak_bytes"]),
                fastest_tested_ns=fastest, regret=elapsed/fastest,
                time_vs_fixed_4k=elapsed/reference,
                heap_vs_input=float(r["median_peak_bytes"])/(case[2]*int(r["bytes_per_record"])),
                heap_below_lsd=float(r["median_peak_bytes"]) < float(lsd["median_peak_bytes"]),
                heap_equal_lsd=float(r["median_peak_bytes"]) == float(lsd["median_peak_bytes"]))
            detailed.append(result)
            grouped[r["algorithm"]].append(result)
    ranked = []
    for algorithm, observations in grouped.items():
        regret = [r["regret"] for r in observations]
        worst = max(observations, key=lambda r: r["regret"])
        ranked.append(dict(algorithm=algorithm, family=observations[0]["family"],
            parameter=observations[0]["parameter"], conditions=len(observations),
            gm_regret=geometric(regret), median_regret=statistics.median(regret),
            p90_regret=float(np.quantile(regret, .9)), max_regret=max(regret),
            fraction_within_25pct_fastest=statistics.mean(x<=1.25 for x in regret),
            gm_time_vs_fixed_4k=geometric(r["time_vs_fixed_4k"] for r in observations),
            p90_heap_vs_input=float(np.quantile([r["heap_vs_input"] for r in observations],.9)),
            max_heap_bytes=max(r["median_peak_bytes"] for r in observations),
            heap_below_lsd=sum(r["heap_below_lsd"] for r in observations),
            heap_equal_lsd=sum(r["heap_equal_lsd"] for r in observations),
            worst_kind=worst["kind"], worst_dist=worst["dist"], worst_n=worst["n"]))
    ranked.sort(key=lambda r:(r["p90_regret"],r["max_regret"]))
    winners={}
    for r in ranked:
        winners.setdefault(r["family"],r["algorithm"])
    assert ranked[0]["algorithm"] == "block_balanced_8"
    write("policy-screen-conditions.csv", detailed)
    write("policy-screen-ranking.csv", ranked)
    decision = dict(
        input_conditions=109, policies=21, condition_policy_pairs=len(detailed),
        candidate=ranked[0]["algorithm"], family_finalists=winners,
        rule="Screen by smallest P90 time regret against the fastest tested block configuration; inspect worst regret and heap separately, without combining time and memory into an arbitrary score.",
        duplicate_policy_handling="Pool observations with the same (kind, distribution, n, block elements). At n<=128 all policies use the identical comparison leaf and are pooled regardless of nominal block.",
        oracle_warning="Fastest tested configuration is a post-hoc reference, not a deployable input-aware policy; no significance or universal-optimality claim.",
        candidate_status="Candidate only; broad distribution validation is required before algorithm comparison.",
        validation_scope="All original 1045 conditions, 9 types, 23 distributions, 5 primary lengths plus u64 scaling. Rerun four family finalists and fixed 4 KiB with Stable LSD, Rust stable, TimSort and A/A; pure LSD variants additionally at 1,048,576 elements.",
        sources={name:hashlib.sha256((ROOT/"data"/name).read_bytes()).hexdigest()
            for name in ["supplemental-sqrt-summary.csv","supplemental-sqrt-timing.csv"]},
        ranked=ranked)
    (ROOT/"data/policy-screen-decision.json").write_text(json.dumps(decision,indent=2)+"\n")
    print(json.dumps({k:v for k,v in decision.items() if k!="ranked"},indent=2))


if __name__ == "__main__":
    main()
