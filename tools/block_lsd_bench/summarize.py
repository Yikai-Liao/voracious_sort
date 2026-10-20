#!/usr/bin/env python3
"""Summarize timings and requested heap bytes without third-party modules."""
import csv
import statistics
import sys
from collections import defaultdict

groups = defaultdict(list)
failures = []
with open(sys.argv[1], newline="") as source:
    for row in csv.DictReader(source):
        if row["status"] != "ok":
            failures.append(row)
        else:
            groups[row["workload"], row["distribution"], int(row["n"]), row["algorithm"]].append(row)
print("| Workload | Distribution | n | Algorithm | Median ms | Min–max ms | Extra heap MiB |")
print("| --- | --- | ---: | --- | ---: | ---: | ---: |")
for (workload, distribution, n, algorithm), rows in groups.items():
    ns = [int(row["ns"]) for row in rows]
    peak = max(int(row["peak_extra_bytes"]) for row in rows)
    print(f"| {workload} | {distribution} | {n} | {algorithm} | {statistics.median(ns)/1e6:.4f} | "
          f"{min(ns)/1e6:.4f}–{max(ns)/1e6:.4f} | {peak/2**20:.4f} |")
if failures:
    print("\nFailed baselines (no performance claim):\n")
    for row in failures:
        print(f"- {row['workload']}, {row['distribution']}, n={row['n']}, {row['algorithm']}: {row['status']}")
