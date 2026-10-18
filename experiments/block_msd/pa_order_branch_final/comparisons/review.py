#!/usr/bin/env python3
"""Validate paired comparison rows and summarize each scenario independently."""
import collections
import csv
import json
from pathlib import Path
import statistics

ROOT = Path(__file__).resolve().parent
METHODS = (
    "Pa_unified_groups_t16777216",
    "Fa",
    "Rollercoaster",
    "L_frozen",
    "stable_msd",
    "Pa_unified_groups_t16777216",
)
BASELINES = ("Fa", "Rollercoaster", "L_frozen", "stable_msd")
REPS = range(12)


def quantile(values, q):
    ordered = sorted(values)
    position = (len(ordered) - 1) * q
    lower = int(position)
    return ordered[lower] + (ordered[min(lower + 1, len(ordered) - 1)] - ordered[lower]) * (position - lower)


def main():
    rows_by_cell = collections.defaultdict(dict)
    files = sorted((ROOT / "measurements").glob("final-*.csv"))
    if len(files) != 11:
        raise SystemExit(f"expected 11 comparison CSVs, found {len(files)}")

    seen = set()
    metadata_hashes = set()
    source_commits = set()
    for path in files:
        metadata = json.loads(path.with_suffix(".json").read_text())
        if metadata["returncode"] != 0:
            raise SystemExit(f"failed command recorded in {path.name}")
        metadata_hashes.add(metadata["binary_sha256"])
        source_commits.add(metadata["source_commit"])
        with path.open(newline="") as stream:
            for row in csv.DictReader(stream):
                if row["kind"] != "time" or row["instrumented"] != "false":
                    raise SystemExit(f"not a clean time row: {path.name}")
                cell = (int(row["n"]), int(row["block"]), int(row["seed"]), row["layout"], row["case"])
                rep, slot = int(row["rep"]), int(row["slot"])
                if rep not in REPS or not 0 <= slot < len(METHODS):
                    raise SystemExit(f"unexpected rep/slot {rep}/{slot} in {path.name}")
                if row["method"] != METHODS[slot]:
                    raise SystemExit(f"slot mismatch {path.name}: {rep}/{slot}/{row['method']}")
                key = (cell, rep, slot)
                if key in seen:
                    raise SystemExit(f"duplicate row {path.name}: {key}")
                seen.add(key)
                rows_by_cell[cell].setdefault(rep, {})[slot] = row

    if len(metadata_hashes) != 1 or len(source_commits) != 1:
        raise SystemExit("the comparison files do not share one source and one binary")
    if len(rows_by_cell) != 103:
        raise SystemExit(f"expected 103 complete cells, found {len(rows_by_cell)}")

    results = []
    for cell, reps in sorted(rows_by_cell.items()):
        if set(reps) != set(REPS) or any(set(slots) != set(range(6)) for slots in reps.values()):
            raise SystemExit(f"incomplete paired cell {cell}")
        aa = [int(reps[r][5]["wall_ns"]) / int(reps[r][0]["wall_ns"]) for r in REPS]
        candidate_wall = [statistics.mean(int(reps[r][slot]["wall_ns"]) for slot in (0, 5)) for r in REPS]
        candidate_cpu = [statistics.mean(int(reps[r][slot]["cpu_ns"]) for slot in (0, 5)) for r in REPS]
        result = {
            "n": cell[0], "block": cell[1], "seed": cell[2], "layout": cell[3], "case": cell[4],
            "reps": 12, "candidate_wall_ms": statistics.median(candidate_wall) / 1e6,
            "candidate_cpu_ms": statistics.median(candidate_cpu) / 1e6,
            "candidate_aa_median": statistics.median(aa),
            "candidate_aa_p10": quantile(aa, .1), "candidate_aa_p90": quantile(aa, .9),
            "source_commit": next(iter(source_commits)), "binary_sha256": next(iter(metadata_hashes)),
        }
        for baseline in BASELINES:
            slot = METHODS.index(baseline)
            wall_ratios = [candidate_wall[r] / int(reps[r][slot]["wall_ns"]) for r in REPS]
            cpu_ratios = [candidate_cpu[r] / int(reps[r][slot]["cpu_ns"]) for r in REPS]
            median = statistics.median(wall_ratios)
            result[f"{baseline}_wall_ms"] = statistics.median(int(reps[r][slot]["wall_ns"]) for r in REPS) / 1e6
            result[f"candidate_over_{baseline}_wall_median"] = median
            result[f"candidate_over_{baseline}_wall_p10"] = quantile(wall_ratios, .1)
            result[f"candidate_over_{baseline}_wall_p90"] = quantile(wall_ratios, .9)
            result[f"candidate_over_{baseline}_cpu_median"] = statistics.median(cpu_ratios)
            result[f"candidate_slower_than_{baseline}_reps"] = sum(ratio > 1 for ratio in wall_ratios)
        results.append(result)

    output = ROOT / "review-comparison.csv"
    with output.open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=results[0].keys())
        writer.writeheader()
        writer.writerows(results)

    summary = {}
    for baseline in BASELINES:
        ratios = [row[f"candidate_over_{baseline}_wall_median"] for row in results]
        summary[baseline] = {
            "faster_cells": sum(ratio < 1 for ratio in ratios),
            "tied_cells": sum(ratio == 1 for ratio in ratios),
            "slower_cells": sum(ratio > 1 for ratio in ratios),
            "ratio_median_across_cells_descriptive_only": statistics.median(ratios),
            "worst_cells": [
                {key: row[key] for key in ("n", "block", "seed", "layout", "case", f"candidate_over_{baseline}_wall_median", f"candidate_over_{baseline}_wall_p10", f"candidate_over_{baseline}_wall_p90", f"candidate_slower_than_{baseline}_reps")}
                for row in sorted(results, key=lambda row: row[f"candidate_over_{baseline}_wall_median"], reverse=True)[:5]
            ],
        }
    (ROOT / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(f"{len(files)} files, {len(seen)} paired rows, {len(results)} cells; source and ELF consistent")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
