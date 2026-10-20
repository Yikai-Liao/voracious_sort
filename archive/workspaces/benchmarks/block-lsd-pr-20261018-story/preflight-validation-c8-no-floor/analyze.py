#!/usr/bin/env python3
"""Verify every validation observation and emit paired, same-batch summaries."""
from collections import defaultdict
import csv
import hashlib
import json
from pathlib import Path
import re
import statistics
import sys

import numpy as np

sys.dont_write_bytecode=True
import run

ROOT=Path(__file__).resolve().parent
DATA=ROOT/"data"
KEY=("kind","dist","n","algorithm")


def read(name):
    with (DATA/name).open() as f:return [json.loads(line) for line in f]


def write(name,rows):
    fields=list(dict.fromkeys(k for r in rows for k in r))
    with (DATA/name).open("w",newline="") as f:
        writer=csv.DictWriter(f,fieldnames=fields);writer.writeheader();writer.writerows(rows)


def main():
    timing=read("time.jsonl");memory=read("memory.jsonl")
    manifest=json.loads((ROOT/"manifest.json").read_text())
    assert len(timing)==manifest["time_observations"]
    assert len(memory)==manifest["memory_observations"]
    for name,digest in manifest["files"].items():
        assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest()==digest,name
    assert hashlib.sha256((ROOT.parent/"data/policy-screen-decision.json").read_bytes()).hexdigest()==manifest["decision_sha256"]
    reference=json.loads((DATA/"reference-input-digests.json").read_text())
    tg,mg=defaultdict(list),defaultdict(list)
    ti={}
    for rows,groups in [(timing,tg),(memory,mg)]:
        for r in rows:
            assert r["input_digest"]==reference['|'.join(str(r[k]) for k in ["kind","dist","n","pair"])],r
            assert r["ordered"] and r["preserved"],r
            if r["algorithm"].startswith("block_") or r["algorithm"] in ["std","timsort"]:
                assert r["valid"],r
            groups[tuple(r[k] for k in KEY)].append(r)
    for r in timing:
        key=tuple(r[k] for k in KEY)+(r["pair"],r["order"])
        assert key not in ti,key
        ti[key]=r
    expected={(c["kind"],c["dist"],c["n"],a) for c in run.cases() for a,b in run.methods(c)}
    assert tg.keys()==mg.keys()==expected
    assert len(tg)==manifest["algorithm_cases"]
    comparators=["lsd","std","timsort","block_balanced_8","block_fixed_128","block_fixed_bytes_1024","block_normalized_2","block_fixed_bytes_4096","lsd_core"]
    summaries=[];aa=[]
    for key,observations in sorted(tg.items()):
        allocated=mg[key]
        assert len(observations)==6 and len(allocated)==3,key
        assert len({(r["pair"],r["order"]) for r in observations})==6,key
        assert len({r["pair"] for r in allocated})==3,key
        first=observations[0]
        row={k:first[k] for k in KEY+("bytes_per_record","radix","block","group","campaign")}
        row.update(block_bytes=first["block"]*first["bytes_per_record"],n_time=6,n_memory=3,
            full_stable_output_matches=all(r["valid"] for r in observations+allocated),
            key_order_matches=all(r["ordered"] for r in observations+allocated),
            fingerprint_preserved=all(r["preserved"] for r in observations+allocated))
        for values,metric in [(observations,"ns"),(allocated,"peak_bytes")]:
            numbers=[r[metric] for r in values]
            row.update({"median_"+metric:statistics.median(numbers),"min_"+metric:min(numbers),"max_"+metric:max(numbers)})
        for comparator in comparators:
            other_key=key[:3]+(comparator,)
            if other_key not in tg:continue
            pairs=[ti[other_key+(r["pair"],r["order"])] for r in observations]
            assert all(a["input_digest"]==b["input_digest"] for a,b in zip(observations,pairs))
            ratios=[a["ns"]/b["ns"] for a,b in zip(observations,pairs)]
            row["ratio_vs_"+comparator]=statistics.median(ratios)
            row["ratio_vs_"+comparator+"_min"]=min(ratios)
            row["ratio_vs_"+comparator+"_max"]=max(ratios)
            row["pair_valid_vs_"+comparator]=all(a["valid"] and b["valid"] for a,b in zip(observations,pairs))
            if key[3]=="lsd_aa" and comparator=="lsd":aa.extend(ratios)
        if key[3].startswith("block_"):
            bound=512*row["block"]*row["bytes_per_record"]+9*(row["n"]//row["block"])+66*256
            assert all(r["peak_bytes"]<=bound for r in allocated),(key,bound)
            row["block_heap_upper_bytes"]=bound
        summaries.append(row)
    processes=read("time-processes.jsonl")+read("memory-processes.jsonl")
    assert len(processes)==2*manifest["input_conditions"]
    assert all(p["returncode"]==0 for p in processes)
    swaps=[int(re.search(r"VmSwap:\s+(\d+)",p["stderr"]).group(1)) for p in processes]
    resources=[list(map(int,re.search(r"RESOURCE (\d+) (\d+) (\d+) (\d+)",p["stderr"]).groups())) for p in processes]
    assert max(swaps)==0 and all(r[3]==0 for r in resources)
    failures=[r for r in summaries if not r["full_stable_output_matches"]]
    audit=dict(time_observations=len(timing),memory_observations=len(memory),algorithm_cases=len(summaries),
        input_conditions=manifest["input_conditions"],
        all_block_rust_std_and_timsort_outputs_match=True,
        all_inputs_match_original_campaign=True,all_block_allocations_within_bound=True,
        key_order_failure_cases=0,fingerprint_failure_cases=0,
        comparator_stable_oracle_failure_cases=len(failures),
        processes=len(processes),process_failures=0,max_final_process_swap_kib=max(swaps),
        max_process_rss_kib=max(r[0] for r in resources),total_process_major_faults=sum(r[1] for r in resources),
        total_process_swaps=sum(r[2] for r in resources),
        global_swap_traffic_pages={k:sum(p["vmstat_delta"][k] for p in processes) for k in ["pswpin","pswpout"]},
        aa_samples=len(aa),aa_median_ratio=statistics.median(aa),
        aa_absolute_change_percent_median=float(np.median(np.abs(np.array(aa)-1))*100),
        aa_absolute_change_percent_p95=float(np.quantile(np.abs(np.array(aa)-1),.95)*100),
        exclusions="No formal observations removed; preflight separate. Comparisons requiring stable semantics filter only complete-oracle failures.")
    write("timing.csv",timing);write("memory.csv",memory);write("summary.csv",summaries)
    write("validation-failures.csv",failures)
    (DATA/"audit.json").write_text(json.dumps(audit,indent=2)+"\n")
    print(json.dumps(audit,indent=2))


if __name__=="__main__":main()
