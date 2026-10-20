#!/usr/bin/env python3
"""Reproduce plots: uv run --with matplotlib python plot.py results/block_lsd."""
import csv
import statistics
import sys
from collections import defaultdict
from pathlib import Path
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

root = Path(sys.argv[1])
tuning = defaultdict(list)
with (root / "tuning.csv").open() as f:
    for row in csv.DictReader(f):
        tuning[row["workload"], row["distribution"], int(row["radix"]), int(row["block_bytes"])].append(row)
fig, axes = plt.subplots(2, 2, figsize=(11, 8), constrained_layout=True)
for ax, workload in zip(axes.flat, ["u32_pair8", "u64_pair16", "u128_pair32", "u32_payload128"]):
    for radix in [4, 6, 7, 8]:
        points = sorted((block, statistics.median(int(r["ns"]) for r in rows) / 1e6)
            for (w, d, r, block), rows in tuning.items() if w == workload and d == "uniform" and r == radix)
        ax.plot([p[0]/1024 for p in points], [p[1] for p in points], marker="o", label=f"radix {radix}")
    ax.set_xscale("log", base=2)
    ax.set_xticks([.5,1,2,4,8,16,32,64], labels=[".5","1","2","4","8","16","32","64"])
    ax.set_title(workload)
    ax.set_xlabel("Block KiB")
    ax.set_ylabel("Median sort time (ms)")
    ax.grid(alpha=.25)
    ax.legend(fontsize=8)
fig.suptitle("Block LSD parameter sweep: 1,000,000 uniform records; 5 samples/config")
fig.savefig(root / "tuning.png", dpi=150)
fig.savefig(root / "tuning.svg")
plt.close(fig)

payload = defaultdict(list)
with (root / "payload.csv").open() as f:
    for row in csv.DictReader(f):
        if row["status"] == "ok":
            payload[int(row["record_bytes"]), row["distribution"], row["algorithm"]].append(row)
fig, axes = plt.subplots(1, 2, figsize=(11, 4.8), constrained_layout=True)
labels = {"rust_block_lsd":"Block, 512 elements", "rust_block_lsd_4k":"Block, 4 KiB", "rust_lsd_stable":"Existing LSD", "rust_msd_stable":"Existing MSD", "std_stable":"Standard stable"}
for algorithm, label in labels.items():
    points = []
    for size in [8,16,32,64,128,256]:
        key = (size,"uniform",algorithm)
        if key not in payload and algorithm == "rust_block_lsd_4k" and size == 8:
            key = (size,"uniform","rust_block_lsd")
        rows = payload[key]
        points.append((size, statistics.median(int(r["ns"]) for r in rows)/1e6, int(rows[0]["peak_extra_bytes"])/2**20))
    axes[0].plot([x[0] for x in points],[x[1] for x in points],marker="o",label=label)
    axes[1].plot([x[0] for x in points],[x[2] for x in points],marker="o",label=label)
for ax in axes:
    ax.set_xscale("log",base=2)
    ax.set_xticks([8,16,32,64,128,256],labels=["8","16","32","64","128","256"])
    ax.set_xlabel("Record bytes (fixed u32 key)")
    ax.grid(alpha=.25)
    ax.legend(fontsize=8)
axes[0].set_ylabel("Median sort time (ms)")
axes[1].set_ylabel("Peak extra requested heap (MiB)")
fig.suptitle("Fixed-key control: 1,000,000 uniform u32-key records; 5 samples/config")
fig.savefig(root / "payload.png",dpi=150)
fig.savefig(root / "payload.svg")
