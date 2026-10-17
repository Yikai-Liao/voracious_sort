#!/usr/bin/env python3
"""Compare logical work and requested heap; do not analyze instrumented timing."""
import collections
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PREPARED = "Pa_unified_prepared_t16777216"
CANDIDATE = "Pa_unified_groups_t16777216"
LOGICAL_FIELDS = (
    "nodes", "node_records", "prepare_records", "order_records",
    "candidate_records", "scatter_records", "dense_nodes", "block_nodes",
    "passes", "tail_records", "runs_records", "unresolved_records", "leaves",
    "leaf_records", "max_depth", "max_path_passes", "frontier_nodes",
    "equal_nodes", "band_nodes", "band_records", "terminal_band_nodes",
    "probe_records", "leaf_lengths",
)


def cells(path):
    groups = collections.defaultdict(dict)
    with path.open(newline="") as stream:
        for row in csv.DictReader(stream):
            key = tuple(row[field] for field in ("n", "block", "seed", "layout", "case"))
            assert row["method"] not in groups[key], (path, key, row["method"])
            assert row["rep"] == "0", (path, row["rep"])
            groups[key][row["method"]] = row
    return groups


def write_table(name, rows):
    assert rows, name
    with (ROOT / name).open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)


def main():
    work, heap = [], []
    for path in sorted((ROOT / "measurements").glob("work-*.csv")):
        for key, group in sorted(cells(path).items()):
            candidate, prepared = group[CANDIDATE], group[PREPARED]
            assert all(row["kind"] == "work" and row["instrumented"] == "true"
                       for row in group.values()), path
            for field in LOGICAL_FIELDS:
                assert candidate[field] == prepared[field], (path, key, field)
            extra = int(candidate["label_evals"]) - int(prepared["label_evals"])
            assert 0 <= extra <= int(candidate["passes"]), (path, key, extra)
            if key[-1] == "sparse":
                # make_keys places independent bits at 0,18,...,126, then
                # truncates to each key width. Every active digit has at most
                # one varying bit; u8/u16 have only keys 0/1, while wider
                # layouts need multiple passes. The eligible B64 native-sized
                # records in this fixed matrix use only block passes.
                if int(candidate["record_bytes"]) <= 8:
                    assert candidate["dense_nodes"] == "0", (path, key)
                    expected = int(candidate["passes"])
                else:
                    expected = 0
                assert extra == expected, (path, key, extra, expected)
            work.append(dict(file=path.name, n=key[0], block=key[1], seed=key[2],
                layout=key[3], case=key[4], logical_fields_equal=True,
                extra_label_evals=extra,
                prepared_compact_records=prepared["compact_records"],
                candidate_compact_records=candidate["compact_records"],
                compact_delta=int(candidate["compact_records"]) - int(prepared["compact_records"])))
    for path in sorted((ROOT / "measurements").glob("heap-*.csv")):
        for key, group in sorted(cells(path).items()):
            assert all(row["kind"] == "memory" and row["instrumented"] == "false"
                       for row in group.values()), path
            candidate, prepared = group[CANDIDATE], group[PREPARED]
            result = dict(file=path.name, n=key[0], block=key[1], seed=key[2],
                layout=key[3], case=key[4], record_bytes=candidate["record_bytes"])
            for label, method in (("candidate", CANDIDATE), ("prepared", PREPARED),
                                  ("Pa", "Pa"), ("Band", "Pa_band"),
                                  ("L_frozen", "L_frozen"), ("Stable", "stable_msd")):
                result[label + "_peak"] = int(group[method]["heap_peak"])
                result[label + "_allocs"] = int(group[method]["allocs"])
            result["same_peak_as_prepared"] = candidate["heap_peak"] == prepared["heap_peak"]
            result["same_allocs_as_prepared"] = candidate["allocs"] == prepared["allocs"]
            heap.append(result)
    assert len(work) == 50 and len(heap) == 62, (len(work), len(heap))
    write_table("review-work.csv", work)
    write_table("review-heap.csv", heap)
    print(f"{len(work)} work cells: logical work equal, probe deltas valid")
    print(f"{len(heap)} heap cells: {sum(r['same_peak_as_prepared'] for r in heap)} identical peaks, "
          f"{sum(r['same_allocs_as_prepared'] for r in heap)} identical allocation counts vs Prepared")


if __name__ == "__main__":
    main()
