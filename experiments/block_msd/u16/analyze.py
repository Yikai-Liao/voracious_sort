#!/usr/bin/env python3
"""Summarize paired rows; retain raw timings and per-case regressions."""
import argparse
import collections
import csv
import math
from pathlib import Path
import statistics as stat

ROOT = Path(__file__).resolve().parent


def quantile(values, q):
    x = sorted(values)
    pos = (len(x)-1)*q
    i = int(pos)
    return x[i] + (x[min(i+1,len(x)-1)]-x[i])*(pos-i)


def main():
    p = argparse.ArgumentParser(__doc__)
    p.add_argument("files", nargs="+")
    p.add_argument("--out", default="summary.csv")
    args = p.parse_args()
    rows = []
    for name in args.files:
        with Path(name).open() as f:
            data = list(csv.DictReader(f))
        assert all(r["kind"] == "time" and r["instrumented"] == "false" for r in data)
        rows.extend(data)
    groups = collections.defaultdict(list)
    paired = collections.defaultdict(list)
    for r in rows:
        key = (r["layout"],r["case"],int(r["n"]),int(r["block"]))
        groups[key+(r["method"],)].append(r)
        paired[key+(r["seed"],r["rep"],r["method"])].append(int(r["wall_ns"]))
    result = []
    for key, group in groups.items():
        case, method = key[:-1],key[-1]
        ratios = []
        for r in group:
            baseline = paired.get(case+(r["seed"],r["rep"],"L"))
            if baseline:
                ratios.append(int(r["wall_ns"])/stat.mean(baseline))
        wall = [int(r["wall_ns"]) for r in group]
        cpu = [int(r["cpu_ns"]) for r in group]
        entry = dict(zip(["layout","case","n","block","method"],key),
            samples=len(group),wall_ms=stat.median(wall)/1e6,cpu_ms=stat.median(cpu)/1e6,
            paired_L=stat.median(ratios) if ratios else "",
            ratio_p10=quantile(ratios,.1) if ratios else "",
            ratio_p90=quantile(ratios,.9) if ratios else "",
            wall_p10_ms=quantile(wall,.1)/1e6,wall_p90_ms=quantile(wall,.9)/1e6)
        for reference in ["L_frozen","stable_msd"]:
            reference_ratios=[]
            for r in group:
                baseline=paired.get(case+(r["seed"],r["rep"],reference))
                if baseline:
                    reference_ratios.append(int(r["wall_ns"])/stat.mean(baseline))
            entry["paired_"+reference]=stat.median(reference_ratios) if reference_ratios else ""
        result.append(entry)
    result.sort(key=lambda r:(r["n"],r["block"],r["layout"],r["case"],r["method"]))
    out = ROOT / args.out
    with out.open("w") as f:
        writer=csv.DictWriter(f,fieldnames=result[0].keys());writer.writeheader();writer.writerows(result)
    for method in sorted({r["method"] for r in result}):
        ratios=[r["paired_L"] for r in result if r["method"]==method and r["paired_L"]!=""]
        if ratios:
            print(method,"cases",len(ratios),"geomean",round(math.exp(stat.mean(math.log(x) for x in ratios)),4),
                  "fast>5%",sum(x<.95 for x in ratios),"slow>5%",sum(x>1.05 for x in ratios))


if __name__ == "__main__":
    main()
