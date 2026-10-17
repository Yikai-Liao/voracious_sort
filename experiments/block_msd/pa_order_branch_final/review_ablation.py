#!/usr/bin/env python3
"""Review complete final cells without pass thresholds or cross-cell averages.

Each row covers one file/n/block/seed/layout/case with twelve reps and six fixed
method slots. Pa wall/CPU medians and paired denominators use each rep's mean
of slots 0 and 5; Pa A/A uses slot 5 / slot 0. Other methods have one sample
per rep. Ratio quantiles describe samples, not confidence intervals.
"""
import collections
import csv
from pathlib import Path
import statistics as stat
import sys

from analyze import quantile

ROOT = Path(__file__).resolve().parent
CANDIDATE = "Pa_unified_groups_t16777216"
SLOT_METHODS = ("Pa", "Pa_unified_prepared_t16777216", CANDIDATE, "L_frozen", "stable_msd", "Pa")
REFERENCES = ("Pa", "Pa_unified_prepared_t16777216", "L_frozen", "stable_msd")
METHOD_SLOTS = {
    method: tuple(slot for slot, name in enumerate(SLOT_METHODS) if name == method)
    for method in dict.fromkeys(SLOT_METHODS)
}
CELL_FIELDS = ("n", "block", "seed", "layout", "case")
REPS = 12


def load_cells(path):
    cells = collections.defaultdict(list)
    with path.open(newline="") as stream:
        reader = csv.DictReader(stream)
        required = set(CELL_FIELDS) | {
            "method", "slot", "rep", "kind", "instrumented", "wall_ns", "cpu_ns"
        }
        missing = required - set(reader.fieldnames or [])
        if missing:
            raise ValueError("missing columns: " + ", ".join(sorted(missing)))
        for row in reader:
            cell = (int(row["n"]), int(row["block"]), int(row["seed"]),
                    row["layout"], row["case"])
            cells[cell].append(row)
    if not cells:
        raise ValueError("no data rows")
    return cells


def complete_samples(rows):
    expected_rows = REPS * len(SLOT_METHODS)
    if len(rows) != expected_rows:
        raise ValueError(f"expected {expected_rows} rows, found {len(rows)}")
    by_rep = {rep: {} for rep in range(REPS)}
    for row in rows:
        rep, slot = int(row["rep"]), int(row["slot"])
        if rep not in by_rep or not 0 <= slot < len(SLOT_METHODS):
            raise ValueError(f"unexpected rep/slot {rep}/{slot}")
        if row["method"] != SLOT_METHODS[slot]:
            raise ValueError(f"rep {rep} slot {slot}: expected {SLOT_METHODS[slot]}")
        if slot in by_rep[rep]:
            raise ValueError(f"duplicate rep/slot {rep}/{slot}")
        if row["kind"] != "time" or row["instrumented"] != "false":
            raise ValueError(f"rep {rep} slot {slot}: requires uninstrumented time")
        wall, cpu = int(row["wall_ns"]), int(row["cpu_ns"])
        if wall <= 0 or cpu <= 0:
            raise ValueError(f"rep {rep} slot {slot}: nonpositive wall/CPU time")
        by_rep[rep][slot] = (wall, cpu)

    samples = {method: [] for method in METHOD_SLOTS}
    aa = []
    for slots in by_rep.values():
        # The exact row count, valid ranges and unique positions prove completeness.
        aa.append(slots[5][0] / slots[0][0])
        for method, method_slots in METHOD_SLOTS.items():
            samples[method].append((
                stat.mean(slots[slot][0] for slot in method_slots),
                stat.mean(slots[slot][1] for slot in method_slots),
            ))
    return samples, aa


def summarize_cell(path, cell, samples, aa):
    result = {"file": path.name, **dict(zip(CELL_FIELDS, cell)),
              "reps": REPS, "candidate": CANDIDATE}
    candidate = samples[CANDIDATE]
    result["candidate_wall_ms"] = stat.median(wall for wall, _ in candidate) / 1e6
    result["candidate_cpu_ms"] = stat.median(cpu for _, cpu in candidate) / 1e6
    result["Pa_aa_p10"] = quantile(aa, .1)
    result["Pa_aa_p90"] = quantile(aa, .9)
    for reference in REFERENCES:
        baseline = samples[reference]
        result[f"{reference}_wall_ms"] = stat.median(wall for wall, _ in baseline) / 1e6
        result[f"{reference}_cpu_ms"] = stat.median(cpu for _, cpu in baseline) / 1e6
        wall_ratios = [c[0] / b[0] for c, b in zip(candidate, baseline)]
        cpu_ratios = [c[1] / b[1] for c, b in zip(candidate, baseline)]
        prefix = f"candidate_over_{reference}"
        result[prefix + "_wall_median"] = stat.median(wall_ratios)
        result[prefix + "_wall_p10"] = quantile(wall_ratios, .1)
        result[prefix + "_wall_p90"] = quantile(wall_ratios, .9)
        result[f"candidate_slower_than_{reference}_reps"] = sum(r > 1 for r in wall_ratios)
        result[prefix + "_threadcpu_median"] = stat.median(cpu_ratios)
    return result


def main():
    result = []
    incomplete = 0
    for path in sorted((ROOT / "measurements").glob("ablation-narrow-*.csv")):
        try:
            cells = load_cells(path)
        except (OSError, TypeError, ValueError) as error:
            print(f"INCOMPLETE {path.name}: {error}; file excluded", file=sys.stderr)
            incomplete += 1
            continue
        for cell, rows in sorted(cells.items()):
            try:
                samples, aa = complete_samples(rows)
            except (TypeError, ValueError) as error:
                label = ", ".join(f"{key}={value}" for key, value in zip(CELL_FIELDS, cell))
                print(f"INCOMPLETE {path.name}: {label}: {error}; cell excluded", file=sys.stderr)
                incomplete += 1
                continue
            result.append(summarize_cell(path, cell, samples, aa))
    if result:
        output = ROOT / "review-ablation.csv"
        with output.open("w", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=result[0].keys())
            writer.writeheader()
            writer.writerows(result)
        destination = str(output)
    else:
        destination = "no CSV written"
    print(f"{len(result)} complete cells; {incomplete} incomplete entries; {destination}")
    return 1 if incomplete else 0


if __name__ == "__main__":
    raise SystemExit(main())
