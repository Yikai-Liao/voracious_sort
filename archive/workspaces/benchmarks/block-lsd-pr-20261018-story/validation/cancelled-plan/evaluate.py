#!/usr/bin/env python3
"""Derive frozen policies from exactly equal measured calls after validation."""
from collections import defaultdict
import csv
import hashlib
import json
import math
from pathlib import Path
import statistics

import numpy as np

ROOT = Path(__file__).resolve().parent
VALIDATION = ROOT / "validation"
KINDS = ["u32", "u64", "u128", "i32", "i64", "f32", "f64", "record32", "record128"]
DISTS = ["uniform", "uniform_numeric", "uniform_narrow", "skew95", "few_unique", "sqrt_keys", "common_prefix", "low_bits_constant", "high_only", "sorted", "reversed", "nearly_sorted", "almost_sorted", "reverse_nearly_sorted", "all_equal", "late_difference", "alternating", "organ_pipe", "sawtooth", "zipf", "normal", "push_front", "push_middle"]
PRIMITIVES = ["block_balanced_4", "block_balanced_8", "block_fixed_128", "block_fixed_bytes_1024", "block_normalized_2", "block_fixed_bytes_4096"]
DERIVED = [f"block_balanced_{c}__floor_{floor}" for c in [4, 8] for floor in ["bytes_1024", "bytes_4096", "128"]]
POLICIES = PRIMITIVES + DERIVED
CANDIDATE = "block_balanced_4__floor_bytes_1024"
KEY = ("kind", "dist", "n")


def write(name, rows):
    fields = list(dict.fromkeys(k for r in rows for k in r))
    with (ROOT / "data" / name).open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def geometric(values):
    values = list(values)
    assert values and all(x > 0 for x in values)
    return math.exp(statistics.mean(math.log(x) for x in values))


def load_raw(stem):
    with (VALIDATION / "data" / (stem + ".jsonl")).open() as stream:
        return [json.loads(line) for line in stream]


def main():
    audit = json.loads((VALIDATION / "data/audit.json").read_text())
    assert audit["input_conditions"] == 1045 and audit["all_block_rust_std_and_timsort_outputs_match"]
    timing, memory = load_raw("time"), load_raw("memory")
    assert len(timing) == 68772 and len(memory) == 34386
    cases = defaultdict(list)
    by_algo = defaultdict(list)
    config = defaultdict(list)
    sample = defaultdict(list)
    heap_config = defaultdict(list)
    heap_algo = defaultdict(list)
    for row in timing:
        key = tuple(row[k] for k in KEY)
        by_algo[(*key, row["algorithm"])].append(row)
        if row["algorithm"] in PRIMITIVES:
            assert row["valid"]
            cases[key].append(row)
            b = row["block"] if row["n"] > 128 else 0
            config[(*key, b)].append(row["ns"])
            sample[(*key, b, row["pair"], row["order"])].append(row["ns"])
    assert len(cases) == 1045
    for row in memory:
        key = tuple(row[k] for k in KEY)
        heap_algo[(*key, row["algorithm"])].append(row)
        if row["algorithm"] in PRIMITIVES:
            b = row["block"] if row["n"] > 128 else 0
            heap_config[(*key, b)].append(row["peak_bytes"])
    results = []
    comparisons = []
    baseline = "block_fixed_bytes_4096"
    for key, observations in sorted(cases.items()):
        s = observations[0]["bytes_per_record"]
        blocks = {r["algorithm"]: r["block"] for r in observations}
        effective = dict(blocks)
        for c in [4, 8]:
            for floor, algorithm in [("bytes_1024", "block_fixed_bytes_1024"), ("bytes_4096", "block_fixed_bytes_4096"), ("128", "block_fixed_128")]:
                effective[f"block_balanced_{c}__floor_{floor}"] = max(blocks[f"block_balanced_{c}"], blocks[algorithm])
        block_set = set(blocks.values())
        assert all(b in block_set for b in effective.values())
        fastest = min(statistics.median(config[(*key, b if key[2] > 128 else 0)]) for b in block_set)
        for policy in POLICIES:
            b = effective[policy]
            effective_b = b if key[2] > 128 else 0
            elapsed = config[(*key, effective_b)]
            allocated = heap_config[(*key, effective_b)]
            row = dict(kind=key[0], dist=key[1], n=key[2], record_bytes=s, policy=policy, block=b,
                       block_bytes=b*s, comparison_leaf=key[2] <= 128,
                       source_algorithms="|".join(a for a in PRIMITIVES if key[2] <= 128 or blocks[a] == b),
                       observations=len(elapsed), median_ns=statistics.median(elapsed), min_ns=min(elapsed), max_ns=max(elapsed),
                       median_peak_bytes=statistics.median(allocated), min_peak_bytes=min(allocated), max_peak_bytes=max(allocated),
                       regret=statistics.median(elapsed)/fastest,
                       heap_vs_input=statistics.median(allocated)/(key[2]*s))
            for comparator in [baseline, "lsd", "std", "timsort", "lsd_core"]:
                ck = (*key, comparator)
                if ck not in by_algo:
                    continue
                other_rows = by_algo[ck]
                other = {(r["pair"], r["order"]): r for r in other_rows}
                ratios = []
                for pair in range(3):
                    for order in range(2):
                        numerator = statistics.median(sample[(*key, effective_b, pair, order)])
                        if comparator in PRIMITIVES:
                            comp_b = blocks[comparator] if key[2] > 128 else 0
                            denominator = statistics.median(sample[(*key, comp_b, pair, order)])
                        else:
                            denominator = other[pair, order]["ns"]
                        ratios.append(numerator/denominator)
                valid = all(r["valid"] for r in other_rows + heap_algo[ck])
                row[f"ratio_vs_{comparator}"] = statistics.median(ratios)
                row[f"valid_vs_{comparator}"] = valid
                if policy == CANDIDATE and comparator in ["lsd", "std", "timsort", "lsd_core"]:
                    peak = statistics.median(r["peak_bytes"] for r in heap_algo[ck])
                    comparisons.append(dict(kind=key[0], dist=key[1], n=key[2], record_bytes=s, comparator=comparator,
                                            stable_semantics_match=valid, median_paired_time_ratio=statistics.median(ratios),
                                            min_paired_time_ratio=min(ratios), max_paired_time_ratio=max(ratios),
                                            candidate_peak_bytes=row["median_peak_bytes"], comparator_peak_bytes=peak,
                                            heap_difference_bytes=row["median_peak_bytes"]-peak,
                                            heap_relation="less" if row["median_peak_bytes"]<peak else "equal" if row["median_peak_bytes"]==peak else "more"))
            results.append(row)
    write("validated-policy-conditions.csv", results)
    write("candidate-comparisons.csv", comparisons)
    ranked = []
    for scope, subset in [("all", results), ("large_n_ge_262144", [r for r in results if r["n"] >= 262144])]:
        for policy in POLICIES:
            rows = [r for r in subset if r["policy"] == policy]
            regret = [r["regret"] for r in rows]
            positive = [r for r in rows if r["median_peak_bytes"] > 0]
            ranked.append(dict(scope=scope, policy=policy, conditions=len(rows), gm_regret=geometric(regret),
                               p90_regret=float(np.quantile(regret, .9)), max_regret=max(regret),
                               fraction_within_25pct_fastest=statistics.mean(r <= 1.25 for r in regret),
                               gm_time_vs_fixed_4k=geometric(r["ratio_vs_"+baseline] for r in rows),
                               gm_heap_vs_input_nonzero=geometric(r["heap_vs_input"] for r in positive),
                               positive_heap_conditions=len(positive), max_heap_bytes=max(r["median_peak_bytes"] for r in rows)))
    ranked.sort(key=lambda r: (r["scope"], r["p90_regret"], r["gm_regret"]))
    write("validated-policy-ranking.csv", ranked)
    # Ratios are computed per matched condition before any distribution/type aggregation.
    strata = [(f"n={n}", [r for r in results if r["n"] == n]) for n in [128,1024,16384,262144,1048576]]
    strata += [(d+" @1M", [r for r in results if r["n"] == 1048576 and r["dist"] == d])
               for d in ["skew95", "common_prefix", "nearly_sorted", "normal", "organ_pipe", "push_front"]]
    strata += [("u64 extra scales", [r for r in results if r["kind"] == "u64" and r["n"] not in [128,1024,16384,262144,1048576]])]
    matrix = []
    for label, group in strata:
        for policy in POLICIES:
            rows = [r for r in group if r["policy"] == policy]
            matrix.append(dict(stratum=label, policy=policy, conditions=len(rows), gm_regret=geometric(r["regret"] for r in rows),
                               max_regret=max(r["regret"] for r in rows),
                               gm_time_vs_fixed_4k=geometric(r["ratio_vs_"+baseline] for r in rows)))
    write("policy-strata-matrix.csv", matrix)
    forests = []
    memory_counts = []
    overall = []
    for comparator in ["lsd", "std", "timsort"]:
        rows = [r for r in comparisons if r["n"] == 1048576 and r["comparator"] == comparator and r["stable_semantics_match"]]
        assert rows
        memory_counts.append(dict(comparator=comparator, conditions=len(rows),
                                  **{relation:sum(r["heap_relation"]==relation for r in rows) for relation in ["less","equal","more"]}))
        overall.append(dict(comparator=comparator, conditions=len(rows),
                            gm_paired_time_ratio=geometric(r["median_paired_time_ratio"] for r in rows),
                            faster_5pct=sum(r["median_paired_time_ratio"]<.95 for r in rows),
                            slower_5pct=sum(r["median_paired_time_ratio"]>1.05 for r in rows),
                            **{relation:sum(r["heap_relation"]==relation for r in rows) for relation in ["less","equal","more"]}))
        for dist in DISTS:
            subset = [r for r in rows if r["dist"] == dist]
            values = [r["median_paired_time_ratio"] for r in subset]
            forests.append(dict(comparator=comparator, dist=dist, types=len(values),
                                 gm_time_ratio=geometric(values), min_type_ratio=min(values), max_type_ratio=max(values)))
    write("comparison-forest.csv", forests)
    write("comparison-memory-counts.csv", memory_counts)
    write("comparison-overall.csv", overall)
    largest = []
    key = ("u64", "uniform", 16777216)
    for algorithm in [CANDIDATE, "lsd", "std", "timsort"]:
        if algorithm == CANDIDATE:
            row = next(r for r in results if (r["kind"],r["dist"],r["n"]) == key and r["policy"] == algorithm)
            largest.append(dict(algorithm=algorithm, block=row["block"], **{k:row[k] for k in ["median_ns","min_ns","max_ns","median_peak_bytes","min_peak_bytes","max_peak_bytes"]}))
        else:
            tr, mr = by_algo[(*key, algorithm)], heap_algo[(*key, algorithm)]
            largest.append(dict(algorithm=algorithm, block=tr[0]["block"],
                                median_ns=statistics.median(r["ns"] for r in tr), min_ns=min(r["ns"] for r in tr), max_ns=max(r["ns"] for r in tr),
                                median_peak_bytes=statistics.median(r["peak_bytes"] for r in mr), min_peak_bytes=min(r["peak_bytes"] for r in mr), max_peak_bytes=max(r["peak_bytes"] for r in mr)))
    write("comparison-largest-example.csv", largest)
    # Full-semantics filtering is explicit; raw legacy failures remain in validation/data.
    excluded = [r for r in comparisons if not r["stable_semantics_match"]]
    write("comparison-excluded.csv", excluded)
    paths = [VALIDATION / "data/audit.json", VALIDATION / "data/time.jsonl", VALIDATION / "data/memory.jsonl",
             ROOT / "data/policy-screen-floor-decision.json", Path(__file__)]
    (ROOT / "data/evaluation-provenance.json").write_text(json.dumps(dict(
        candidate=CANDIDATE, policy_conditions=len(results), input_conditions=1045, policies=len(POLICIES),
        methods="Pool identical effective block arguments within the new validation campaign; derive floors only by selecting the same measured argument. Pair time ratios by seed/order before taking a condition median; aggregate conditions equally.",
        heatmap="Normalize each matched workload to the fastest finalist configuration, then take geometric means within a labelled stratum. No global min-max or per-algorithm rescaling.",
        source_sha256={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}), indent=2)+"\n")
    print(json.dumps(dict(input_conditions=1045, policies=len(POLICIES), policy_conditions=len(results),
                          excluded_comparison_cases=len(excluded), overall=overall), indent=2))


if __name__ == "__main__":
    main()
