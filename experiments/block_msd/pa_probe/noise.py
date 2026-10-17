#!/usr/bin/env python3
"""Report A/A by fixed method-list slot, plus wall/thread-CPU ratios."""
import argparse
import collections
import csv
from pathlib import Path
import statistics

from analyze import quantile


def main():
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument("files", nargs="+")
    args = parser.parse_args()
    fields = ["file", "layout", "case", "pairs", "aa_median", "aa_p10", "aa_p90",
              "aa_min", "aa_max", "wall_cpu_median", "wall_cpu_p90"]
    import sys
    writer = csv.DictWriter(sys.stdout, fieldnames=fields)
    writer.writeheader()
    for filename in args.files:
        rows = list(csv.DictReader(Path(filename).open()))
        assert all(r["kind"] == "time" for r in rows)
        grouped = collections.defaultdict(list)
        for row in rows:
            grouped[row["layout"], row["case"]].append(row)
        grouped["ALL", "ALL"] = rows
        for (layout, case), group in sorted(grouped.items()):
            pairs = collections.defaultdict(list)
            for row in group:
                if row["method"] == "Pa":
                    pairs[row["layout"], row["case"], row["seed"], row["rep"]].append(row)
            ratios = []
            for pair in pairs.values():
                assert len(pair) == 2
                first, second = sorted(pair, key=lambda r: int(r["slot"]))
                ratios.append(int(second["wall_ns"]) / int(first["wall_ns"]))
            cpu = [int(r["wall_ns"]) / int(r["cpu_ns"]) for r in group]
            writer.writerow(dict(file=Path(filename).stem, layout=layout, case=case,
                pairs=len(ratios), aa_median=statistics.median(ratios),
                aa_p10=quantile(ratios, .1), aa_p90=quantile(ratios, .9),
                aa_min=min(ratios), aa_max=max(ratios),
                wall_cpu_median=statistics.median(cpu), wall_cpu_p90=quantile(cpu, .9)))


if __name__ == "__main__":
    main()
