#!/usr/bin/env python3
"""Validate and summarize retained observations; never reruns a benchmark."""
import csv
from collections import defaultdict
import hashlib
import json
from pathlib import Path
import re
import statistics

import numpy as np

ROOT = Path(__file__).resolve().parent
KEY = ("kind", "dist", "n", "algorithm")


def rows(name):
    return [json.loads(line) for line in (ROOT/"data"/name).read_text().splitlines()]


def write_csv(path, data):
    fields = list(dict.fromkeys(k for row in data for k in row))
    with path.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        writer.writerows(data)


def summarize():
    timing = rows("primary.jsonl")
    memory = rows("memory.jsonl")
    assert len(timing) == 112170, len(timing)
    assert len(memory) == 56085, len(memory)
    manifest = json.loads((ROOT/"manifest.json").read_text())
    for name, digest in manifest["files"].items():
        assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest() == digest, name
    for name, digest in manifest["source_files"].items():
        assert hashlib.sha256((ROOT/"source/pr"/name).read_bytes()).hexdigest() == digest, name
    for name, digest in manifest["timsort_reference_files"].items():
        assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest() == digest, name
    by_input = defaultdict(set)
    for row in timing+memory:
        by_input[row["kind"],row["dist"],row["n"],row["pair"]].add(row["input_digest"])
        if row["algorithm"].startswith("block_") or row["algorithm"] in ["std", "timsort"]:
            assert row["valid"] and row["ordered"] and row["preserved"], row
    assert all(len(values) == 1 for values in by_input.values())
    time_groups, memory_groups = defaultdict(list), defaultdict(list)
    indexed = {}
    for row in timing:
        key = tuple(row[x] for x in KEY)
        time_groups[key].append(row)
        sample = key + (row["pair"],row["order"])
        assert sample not in indexed, sample
        indexed[sample] = row
    for row in memory:
        memory_groups[tuple(row[x] for x in KEY)].append(row)
        if row["algorithm"].startswith("block_"):
            radix_range = 1 << row["radix"]
            upper = 2*radix_range*row["block"]*row["bytes_per_record"] + 9*(row["n"]//row["block"]) + 66*radix_range
            assert row["peak_bytes"] <= upper, (row,upper)
    assert time_groups.keys() == memory_groups.keys()
    expected_cases = {(k,d,n) for k in manifest["kinds"] for d in manifest["distributions"] for n in manifest["primary_sizes"]}
    actual_primary = {key[:3] for key, values in time_groups.items() if values[0]["group"] == "primary"}
    assert expected_cases == actual_primary
    result = []
    aa_ratios = []
    aa_by_size = defaultdict(list)
    for key, observations in sorted(time_groups.items()):
        assert len(observations) == 6, key
        allocated = memory_groups[key]
        assert len(allocated) == 3, key
        t = [r["ns"] for r in observations]
        m = [r["peak_bytes"] for r in allocated]
        first = observations[0]
        row = dict(zip(KEY,key))
        row.update(bytes_per_record=first["bytes_per_record"],radix=first["radix"],block=first["block"],
                   block_bytes=first["block"]*first["bytes_per_record"],
                   descriptor_count=first["n"]//first["block"] + 2*(1<<first["radix"]),
                   n_time=len(t),median_ns=statistics.median(t),min_ns=min(t),max_ns=max(t),
                   n_memory=len(m),median_peak_bytes=statistics.median(m),min_peak_bytes=min(m),max_peak_bytes=max(m),
                   median_alloc_calls=statistics.median(r["alloc_calls"] for r in allocated),
                   full_stable_output_matches=all(r["valid"] for r in observations+allocated),
                   key_order_matches=all(r["ordered"] for r in observations+allocated),
                   fingerprint_preserved=all(r["preserved"] for r in observations+allocated),
                   group=first["group"])
        for comparator in ["std","timsort","lsd","lsd_core"]:
            ratios=[]
            paired_valid=[]
            for r in observations:
                other=indexed[(r["kind"],r["dist"],r["n"],comparator,r["pair"],r["order"])]
                ratios.append(r["ns"]/other["ns"])
                paired_valid.append(r["valid"] and other["valid"])
            row[f"ratio_vs_{comparator}"] = statistics.median(ratios)
            row[f"ratio_vs_{comparator}_min"] = min(ratios)
            row[f"ratio_vs_{comparator}_max"] = max(ratios)
            row[f"pair_valid_vs_{comparator}"] = all(paired_valid)
            if key[3] == "lsd_aa" and comparator == "lsd":
                aa_ratios.extend(ratios)
                aa_by_size[key[2]].extend(ratios)
        if key[3].startswith("block_"):
            r=first; R=1<<r["radix"]
            upper=2*R*r["block"]*r["bytes_per_record"] + 9*(r["n"]//r["block"]) + 66*R
            row["block_heap_upper_bytes"]=upper
            row["peak_matches_block_model"]=all(v==upper for v in m)
        result.append(row)
    write_csv(ROOT/"data"/"timing.csv", timing)
    write_csv(ROOT/"data"/"memory.csv", memory)
    write_csv(ROOT/"data"/"summary.csv", result)
    failures=[r for r in result if not r["full_stable_output_matches"]]
    write_csv(ROOT/"data"/"validation-failures.csv", failures)
    processes=rows("primary-processes.jsonl")+rows("memory-processes.jsonl")
    assert len(processes) == 2090
    process_swap = [int(re.search(r"VmSwap:\s+(\d+)",p["stderr"]).group(1)) for p in processes]
    resources = [list(map(int,re.search(r"RESOURCE (\d+) (\d+) (\d+) (\d+)",p["stderr"]).groups())) for p in processes]
    assert max(process_swap) == 0
    assert all(p["returncode"] == 0 for p in processes)
    assert all(row[3] == 0 for row in resources)
    audit={
        "time_observations":len(timing),"memory_observations":len(memory),
        "algorithm_cases":len(result),"input_cases":len(set((r["kind"],r["dist"],r["n"]) for r in result)),
        "primary_input_cases":len(set((r["kind"],r["dist"],r["n"]) for r in result if r["group"]=="primary")),
        "all_block_rust_std_and_timsort_outputs_match":True,
        "all_paired_input_digests_match":True,
        "all_block_policy_allocations_within_implementation_bound":True,
        "comparator_failure_cases":len(failures),
        "comparator_failure_cases_by_algorithm":{a:sum(r["algorithm"]==a for r in failures) for a in sorted(set(r["algorithm"] for r in failures))},
        "aa_samples":len(aa_ratios),"aa_median_ratio":statistics.median(aa_ratios),
        "aa_absolute_change_percent_median":float(np.median(np.abs(np.array(aa_ratios)-1))*100),
        "aa_absolute_change_percent_p90":float(np.quantile(np.abs(np.array(aa_ratios)-1),.9)*100),
        "aa_absolute_change_percent_p95":float(np.quantile(np.abs(np.array(aa_ratios)-1),.95)*100),
        "aa_by_primary_size":{
            str(n):{"samples":len(aa_by_size[n]),
                    "median_ratio":statistics.median(aa_by_size[n]),
                    "absolute_change_percent_median":float(np.median(np.abs(np.array(aa_by_size[n])-1))*100),
                    "absolute_change_percent_p95":float(np.quantile(np.abs(np.array(aa_by_size[n])-1),.95)*100)}
            for n in manifest["primary_sizes"]},
        "process_failures":sum(p["returncode"]!=0 for p in processes),
        "processes":len(processes),
        "max_final_process_swap_kib":max(process_swap),
        "max_process_rss_kib":max(row[0] for row in resources),
        "process_major_faults":sum(row[1] for row in resources),
        "key_order_failure_cases":sum(not r["key_order_matches"] for r in result),
        "fingerprint_failure_cases":sum(not r["fingerprint_preserved"] for r in result),
        "global_swap_traffic_pages":{k:sum(p["vmstat_delta"][k] for p in processes) for k in ["pswpin","pswpout"]},
        "exclusions":"No primary observations removed. All baseline validity failures retained. Documented unsupported comparator/type cells are N/A; warmup/pilot observations are separate from primary data.",
    }
    scaling=[r for r in result if r["kind"]=="u64" and r["dist"]=="uniform" and r["n"]>=1048576 and r["algorithm"]=="block_sqrt"]
    x=np.array([r["n"] for r in scaling]); y=np.array([r["median_peak_bytes"] for r in scaling])
    audit["sqrt_policy_large_u64_log_log_slope"] = float(np.polyfit(np.log(x),np.log(y),1)[0])
    (ROOT/"data"/"audit.json").write_text(json.dumps(audit,indent=2)+"\n")
    print(json.dumps(audit,indent=2))


if __name__ == "__main__":
    summarize()
