#!/usr/bin/env python3
"""Reuse equal measured arguments; fill only frozen candidate coverage gaps."""
from collections import Counter, defaultdict
import csv
import hashlib
import json
import math
from pathlib import Path
import re
import statistics

import numpy as np

ROOT = Path(__file__).resolve().parent
CANDIDATE = "block_balanced_4__floor_bytes_1024"
DISTS = ["uniform", "uniform_numeric", "uniform_narrow", "skew95", "few_unique", "sqrt_keys", "common_prefix", "low_bits_constant", "high_only", "sorted", "reversed", "nearly_sorted", "almost_sorted", "reverse_nearly_sorted", "all_equal", "late_difference", "alternating", "organ_pipe", "sawtooth", "zipf", "normal", "push_front", "push_middle"]
KEY = ("kind", "dist", "n")


def write(name, rows):
    fields = list(dict.fromkeys(key for row in rows for key in row))
    with (ROOT / "data" / name).open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def geometric(values):
    values = list(values)
    assert values and all(value > 0 for value in values)
    return math.exp(statistics.mean(math.log(value) for value in values))


def read(path):
    with path.open() as stream:
        rows = [json.loads(line) for line in stream] if path.suffix == ".jsonl" else list(csv.DictReader(stream))
    for row in rows:
        for key in ["n", "block", "pair", "order", "bytes_per_record", "input_digest"]:
            if key in row: row[key] = int(row[key])
        for key in ["ns", "peak_bytes"]:
            if key in row: row[key] = float(row[key])
        for key in ["valid", "ordered", "preserved"]:
            if key in row: row[key] = row[key] is True or row[key] == "True"
    return rows


def main():
    for mode in ["time", "memory"]:
        assert (ROOT / "missing-only" / (mode + "-complete.json")).exists()
    paths = {
        "original": {"time":"data/original-timing.csv", "memory":"data/original-memory.csv"},
        "expanded": {"time":"data/supplemental-sqrt-timing.csv", "memory":"data/supplemental-sqrt-memory.csv"},
        "prefix": {"time":"validation/data/time.jsonl"},
        "missing": {"time":"missing-only/data/time.jsonl", "memory":"missing-only/data/memory.jsonl"},
    }
    data = {source:{mode:read(ROOT/path) for mode,path in modes.items()} for source,modes in paths.items()}
    assert len(data["missing"]["time"]) == 32 * 4 * 6
    assert len(data["missing"]["memory"]) == 210 * 3
    reference = json.loads((ROOT/"validation/data/reference-input-digests.json").read_text())
    configs = defaultdict(list)
    algorithms = defaultdict(list)
    aa = {}
    for source, modes in data.items():
        for mode, rows in modes.items():
            for row in rows:
                case = tuple(row[key] for key in KEY)
                digest_key = "|".join(map(str, (*case, row["pair"])))
                assert row["input_digest"] == int(reference[digest_key]), (source, digest_key)
                assert row["ordered"] and row["preserved"], (source, row)
                algorithms[source,mode,*case,row["algorithm"]].append(row)
                if row["algorithm"].startswith("block"):
                    assert row["valid"]
                    effective = row["block"] if row["n"] > 128 else 0
                    configs[source,mode,*case,effective].append(row)
        if "time" in modes and source != "missing":
            index = {(r["kind"],r["dist"],r["n"],r["algorithm"],r["pair"],r["order"]):r for r in modes["time"]}
            values = [r["ns"]/index[r["kind"],r["dist"],r["n"],"lsd",r["pair"],r["order"]]["ns"]
                      for r in modes["time"] if r["algorithm"] == "lsd_aa"]
            aa[source] = dict(samples=len(values),median_ratio=statistics.median(values),
                              absolute_change_percent_median=float(np.median(np.abs(np.array(values)-1))*100),
                              absolute_change_percent_p95=float(np.quantile(np.abs(np.array(values)-1),.95)*100))
    coverage = read(ROOT/"missing-only/coverage-before.csv")
    results=[]; comparisons=[]; largest=[]; selected_aa=[]
    time_sources=Counter(); memory_sources=Counter()
    for covered in coverage:
        case=tuple(covered[key] for key in KEY)
        n,s,block=case[2],covered["bytes_per_record"],covered["block"]
        assert block == max(1,1024//s,math.ceil(4*math.sqrt(9*n/(512*s))))
        effective=block if n>128 else 0
        ts,ms=covered["time_source"],covered["memory_source"]
        tr=configs[ts,"time",*case,effective]; mr=configs[ms,"memory",*case,effective]
        assert tr and mr, covered
        assert {(r["pair"],r["order"]) for r in tr} == {(p,o) for p in range(3) for o in range(2)}
        assert {r["pair"] for r in mr} == set(range(3))
        assert all(r["peak_bytes"] <= 512*block*s+9*(n//block)+66*256 for r in mr)
        time_sources[ts]+=1; memory_sources[ms]+=1
        elapsed=[r["ns"] for r in tr]; allocated=[r["peak_bytes"] for r in mr]
        condition=dict(kind=case[0],dist=case[1],n=n,record_bytes=s,policy=CANDIDATE,block=block,
                       block_bytes=block*s,time_source=ts,memory_source=ms,
                       observations=len(elapsed),median_ns=statistics.median(elapsed),min_ns=min(elapsed),max_ns=max(elapsed),
                       median_peak_bytes=statistics.median(allocated),min_peak_bytes=min(allocated),max_peak_bytes=max(allocated))
        samples=defaultdict(list)
        for row in tr: samples[row["pair"],row["order"]].append(row["ns"])
        for comparator in ["lsd","std","timsort"]:
            other=algorithms[ts,"time",*case,comparator]
            assert len(other)==6, (case,ts,comparator)
            cms=ts if algorithms[ts,"memory",*case,comparator] else "original"
            other_memory=algorithms[cms,"memory",*case,comparator]
            assert len(other_memory)==3
            paired=[statistics.median(samples[r["pair"],r["order"]])/r["ns"] for r in other]
            peak=statistics.median(r["peak_bytes"] for r in other_memory)
            valid=all(r["valid"] for r in other+other_memory)
            condition["ratio_vs_"+comparator]=statistics.median(paired)
            comparison=dict(kind=case[0],dist=case[1],n=n,record_bytes=s,comparator=comparator,
                                    time_source=ts,candidate_memory_source=ms,comparator_memory_source=cms,
                                    stable_semantics_match=valid,median_paired_time_ratio=statistics.median(paired),
                                    min_paired_time_ratio=min(paired),max_paired_time_ratio=max(paired),
                                    candidate_peak_bytes=condition["median_peak_bytes"],comparator_peak_bytes=peak,
                                    heap_difference_bytes=condition["median_peak_bytes"]-peak,
                                    heap_relation="less" if condition["median_peak_bytes"]<peak else "equal" if condition["median_peak_bytes"]==peak else "more",
                                    all_six_pairs_faster=max(paired)<1,all_six_pairs_slower=min(paired)>1,
                                    same_case_aa_available=False,large_gain_beyond_aa_envelope=False,large_loss_beyond_aa_envelope=False)
            control=algorithms[ts,"time",*case,"lsd_aa"] if comparator=="lsd" else []
            if control:
                baseline={(r["pair"],r["order"]):r["ns"] for r in other}
                ratios=[r["ns"]/baseline[r["pair"],r["order"]] for r in control]
                factor=max(max(value,1/value) for value in ratios)
                comparison.update(same_case_aa_available=True,aa_min_ratio=min(ratios),aa_max_ratio=max(ratios),aa_max_symmetric_factor=factor,
                    large_gain_beyond_aa_envelope=statistics.median(paired)<=1/1.5 and max(paired)<1/factor,
                    large_loss_beyond_aa_envelope=statistics.median(paired)>=1.5 and min(paired)>factor)
                if n==1048576 and valid:selected_aa.extend(ratios)
            comparisons.append(comparison)
            if case==("u64","uniform",16777216):
                times=[r["ns"] for r in other]; heaps=[r["peak_bytes"] for r in other_memory]
                largest.append(dict(algorithm=comparator,time_source=ts,memory_source=cms,
                                    median_ns=statistics.median(times),min_ns=min(times),max_ns=max(times),
                                    median_peak_bytes=statistics.median(heaps),min_peak_bytes=min(heaps),max_peak_bytes=max(heaps)))
        if case==("u64","uniform",16777216):
            largest.insert(0,dict(algorithm=CANDIDATE,**{key:condition[key] for key in ["time_source","memory_source","median_ns","min_ns","max_ns","median_peak_bytes","min_peak_bytes","max_peak_bytes"]}))
        results.append(condition)
    assert len(results)==1045
    write("validated-policy-conditions.csv",results); write("candidate-comparisons.csv",comparisons)
    write("comparison-largest-example.csv",largest)
    forest=[]; counts=[]; overall=[]
    for comparator in ["lsd","std","timsort"]:
        rows=[r for r in comparisons if r["n"]==1048576 and r["comparator"]==comparator and r["stable_semantics_match"]]
        summary=dict(comparator=comparator,conditions=len(rows),**{relation:sum(r["heap_relation"]==relation for r in rows) for relation in ["less","equal","more"]})
        counts.append(summary)
        overall.append(dict(**summary,gm_paired_time_ratio=geometric(r["median_paired_time_ratio"] for r in rows),
                            faster_1_5x=sum(r["median_paired_time_ratio"]<=1/1.5 for r in rows),slower_1_5x=sum(r["median_paired_time_ratio"]>=1.5 for r in rows),
                            faster_2x=sum(r["median_paired_time_ratio"]<=.5 for r in rows),slower_2x=sum(r["median_paired_time_ratio"]>=2 for r in rows),
                            all_six_pairs_faster=sum(r["all_six_pairs_faster"] for r in rows),all_six_pairs_slower=sum(r["all_six_pairs_slower"] for r in rows)))
        for dist in DISTS:
            values=[r["median_paired_time_ratio"] for r in rows if r["dist"]==dist]
            forest.append(dict(comparator=comparator,dist=dist,types=len(values),gm_time_ratio=geometric(values),min_type_ratio=min(values),max_type_ratio=max(values)))
    write("comparison-overall.csv",overall); write("comparison-memory-counts.csv",counts); write("comparison-forest.csv",forest)
    write("comparison-excluded.csv",[r for r in comparisons if not r["stable_semantics_match"]])
    # The complete 109-condition scan supplies internal selection; no new policy matrix.
    screened=read(ROOT/"data/policy-floor-screen-conditions.csv")
    strata=[(f"n={n}",[r for r in screened if r["n"]==n]) for n in [128,1024,16384,262144,1048576]]
    strata += [(dist+" @1M",[r for r in screened if r["n"]==1048576 and r["dist"]==dist]) for dist in ["skew95","common_prefix","nearly_sorted","normal","organ_pipe","push_front"]]
    strata += [("u64 extra scales",[r for r in screened if r["kind"]=="u64" and r["n"] not in [128,1024,16384,262144,1048576]])]
    matrix=[]
    for label,group in strata:
        for policy in sorted({r["policy"] for r in group}):
            subset=[r for r in group if r["policy"]==policy]
            matrix.append(dict(stratum=label,policy=policy,conditions=len(subset),gm_regret=geometric(float(r["regret"]) for r in subset),max_regret=max(float(r["regret"]) for r in subset),gm_time_vs_fixed_4k=geometric(float(r["time_vs_fixed_4k"]) for r in subset)))
    write("policy-strata-matrix.csv",matrix)
    audit=dict(input_conditions=1045,all_candidate_outputs_match=True,all_inputs_match_original=True,
               all_candidate_heap_measurements_within_bound=True,time_source_conditions=dict(time_sources),memory_source_conditions=dict(memory_sources),
               missing_only_time_conditions=32,missing_only_memory_conditions=210,missing_only_time_observations=768,missing_only_memory_observations=630,
               interrupted_prefix_conditions=884,interrupted_prefix_time_observations=len(data["prefix"]["time"]),
               no_cross_campaign_time_pairs=True,aa_by_campaign=aa,internal_selection_conditions=109,internal_selection_formulas=111,overall_1m=overall)
    lsd_rows=[r for r in comparisons if r["n"]==1048576 and r["comparator"]=="lsd" and r["stable_semantics_match"]]
    audit["large_effect_aa_screen_1m_lsd"]=dict(conditions=len(lsd_rows),assessable=sum(r["same_case_aa_available"] for r in lsd_rows),
        not_assessable=sum(not r["same_case_aa_available"] for r in lsd_rows),
        large_gain_beyond_observed_envelope=sum(r["large_gain_beyond_aa_envelope"] for r in lsd_rows),
        large_loss_beyond_observed_envelope=sum(r["large_loss_beyond_aa_envelope"] for r in lsd_rows),
        rule="Median factor at least 1.5, and every candidate/control pair lies beyond the full symmetric A/A envelope for the same condition and campaign. Descriptive screening only; not a significance test.")
    audit["aa_for_1m_lsd_compared_conditions"]=dict(observations=len(selected_aa),
        absolute_change_percent_median=float(np.median(np.abs(np.array(selected_aa)-1))*100),
        absolute_change_percent_p95=float(np.quantile(np.abs(np.array(selected_aa)-1),.95)*100),
        symmetric_factor_p95=float(np.quantile([max(value,1/value) for value in selected_aa],.95)))
    process_paths=[ROOT/"validation/data/time-processes.jsonl",ROOT/"missing-only/data/time-processes.jsonl",ROOT/"missing-only/data/memory-processes.jsonl"]
    processes=[row for path in process_paths for row in read(path)]
    assert len(processes)==884+32+210 and all(row["returncode"]==0 for row in processes)
    swaps=[int(re.search(r"VmSwap:\s+(\d+)",row["stderr"]).group(1)) for row in processes]
    resources=[list(map(int,re.search(r"RESOURCE (\d+) (\d+) (\d+) (\d+)",row["stderr"]).groups())) for row in processes]
    assert max(swaps)==0 and all(row[3]==0 for row in resources)
    audit["retained_and_missing_processes"]=dict(count=len(processes),failures=0,max_final_process_swap_kib=max(swaps),
        max_rss_kib=max(row[0] for row in resources),total_major_faults=sum(row[1] for row in resources),total_process_swaps=sum(row[2] for row in resources),
        global_swap_traffic_pages={key:sum(row["vmstat_delta"][key] for row in processes) for key in ["pswpin","pswpout"]})
    (ROOT/"data/reuse-audit.json").write_text(json.dumps(audit,indent=2)+"\n")
    source_paths=[ROOT/path for modes in paths.values() for path in modes.values()]
    source_paths += [ROOT/"missing-only/coverage-before.csv",ROOT/"data/policy-floor-screen-conditions.csv",Path(__file__)] + process_paths
    (ROOT/"data/evaluation-provenance.json").write_text(json.dumps(dict(candidate=CANDIDATE,
        methods="Use original, expanded, retained prefix, then missing-only, in that fixed priority. Pool equal arguments within a campaign only. Each time ratio uses same-campaign controls. Memory source and matching input identity are explicit.",
        heatmap="Completed 109-condition screen; normalize each workload to fastest tested Block argument before group GM. No global min-max.",
        source_sha256={str(path.relative_to(ROOT)):hashlib.sha256(path.read_bytes()).hexdigest() for path in source_paths}),indent=2)+"\n")
    print(json.dumps(audit,indent=2))


if __name__=="__main__":
    main()
