#!/usr/bin/env python3
"""Independently reconstruct every numeric timing-review field from raw rows."""
import csv
import math
from pathlib import Path
import statistics

ROOT = Path(__file__).resolve().parent
CELL = ("n", "block", "seed", "layout", "case")


def percentile(values, probability):
    ordered = sorted(values)
    position = probability * (len(ordered) - 1)
    lower, upper = math.floor(position), math.ceil(position)
    return ordered[lower] * (upper - position) + ordered[upper] * (position - lower) \
        if lower != upper else ordered[lower]


def audit(path):
    tables = list(csv.DictReader(path.open()))
    raw = {}
    checked = 0
    for summary in tables:
        filename = summary["file"]
        if filename not in raw:
            raw[filename] = list(csv.DictReader((ROOT / "measurements" / filename).open()))
        rows = [r for r in raw[filename] if all(r[k] == summary[k] for k in CELL)]
        assert len(rows) == 72, (filename, summary)
        by_rep = {}
        for row in rows:
            rep = int(row["rep"])
            method = row["method"]
            by_rep.setdefault(rep, {}).setdefault(method, []).append(row)
        assert set(by_rep) == set(range(12))
        methods = set(by_rep[0])
        candidate = summary["candidate"]
        samples = {method: [] for method in methods}
        aa = []
        for rep in range(12):
            group = by_rep[rep]
            assert set(group) == methods
            pa = sorted(group["Pa"], key=lambda r: int(r["slot"]))
            assert [int(r["slot"]) for r in pa] == [0, 5]
            aa.append(int(pa[1]["wall_ns"]) / int(pa[0]["wall_ns"]))
            for method in methods:
                values = group[method]
                assert len(values) == (2 if method == "Pa" else 1)
                samples[method].append(tuple(
                    sum(int(r[field]) for r in values) / len(values)
                    for field in ("wall_ns", "cpu_ns")
                ))
        expected = {
            "candidate_wall_ms": statistics.median(x[0] for x in samples[candidate]) / 1e6,
            "candidate_cpu_ms": statistics.median(x[1] for x in samples[candidate]) / 1e6,
            "Pa_aa_p10": percentile(aa, .1),
            "Pa_aa_p90": percentile(aa, .9),
        }
        for method in methods - {candidate}:
            baseline = samples[method]
            expected[method + "_wall_ms"] = statistics.median(x[0] for x in baseline) / 1e6
            expected[method + "_cpu_ms"] = statistics.median(x[1] for x in baseline) / 1e6
            ratios = [x[0] / y[0] for x, y in zip(samples[candidate], baseline)]
            cpu_ratios = [x[1] / y[1] for x, y in zip(samples[candidate], baseline)]
            prefix = "candidate_over_" + method
            expected[prefix + "_wall_median"] = statistics.median(ratios)
            expected[prefix + "_wall_p10"] = percentile(ratios, .1)
            expected[prefix + "_wall_p90"] = percentile(ratios, .9)
            expected[prefix + "_threadcpu_median"] = statistics.median(cpu_ratios)
            expected["candidate_slower_than_" + method + "_reps"] = sum(x > 1 for x in ratios)
        for field, value in expected.items():
            assert math.isclose(float(summary[field]), value, rel_tol=1e-12, abs_tol=1e-12), \
                (filename, tuple(summary[k] for k in CELL), field, summary[field], value)
            checked += 1
    print(path.name, len(tables), "cells;", checked, "numeric fields independently reproduced")


if __name__ == "__main__":
    for name in ("review-ablation.csv", "review-matrix.csv"):
        path = ROOT / name
        if path.exists():
            audit(path)
