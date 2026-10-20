#!/usr/bin/env python3
"""Evaluate deterministic floors by selecting already measured equal arguments."""
from collections import defaultdict
import csv
import hashlib
import json
from pathlib import Path
import statistics
import numpy as np

from screen import geometric, write

ROOT=Path(__file__).resolve().parent


def main():
    with (ROOT/"data/policy-screen-conditions.csv").open() as f:
        rows=list(csv.DictReader(f))
    index={(r["kind"],r["dist"],int(r["n"]),r["algorithm"]):r for r in rows}
    cases=sorted({key[:3] for key in index})
    roots=[f"block_balanced_{c}" for c in [1,2,4,8,16,32,64]]
    roots += [f"block_normalized_{k}" for k in [1,2,4,8,16,32,64,128]]
    floors=[f"block_fixed_{b}" for b in [128,512,1024]]
    floors += [f"block_fixed_bytes_{b}" for b in [1024,4096,8192]]
    policies=[(a,None) for a in sorted({key[3] for key in index})]
    policies += [(a,floor) for a in roots for floor in floors]
    output=[];detailed=[]
    for base,floor in policies:
        observations=[]
        changed=0
        name=base if floor is None else base+"__floor_"+floor.removeprefix("block_fixed_")
        for case in cases:
            source=index[(*case,base)]
            if floor and int(index[(*case,floor)]["block"])>int(source["block"]):
                source=index[(*case,floor)]
                changed+=1
            row=dict(kind=case[0],dist=case[1],n=case[2],policy=name,root=base,floor=floor or "none",
                source_algorithm=source["algorithm"],block=int(source["block"]),
                record_bytes=int(source["record_bytes"]),
                pooled_median_ns=float(source["pooled_median_ns"]),
                median_peak_bytes=float(source["median_peak_bytes"]),regret=float(source["regret"]),
                time_vs_fixed_4k=float(source["time_vs_fixed_4k"]))
            observations.append(row);detailed.append(row)
        values=[r["regret"] for r in observations]
        output.append(dict(policy=name,root=base,floor=floor or "none",conditions=len(observations),
            changed_conditions=changed,p90_regret=float(np.quantile(values,.9)),max_regret=max(values),
            gm_regret=geometric(values),fraction_within_25pct_fastest=statistics.mean(x<=1.25 for x in values),
            gm_time_vs_fixed_4k=geometric(r["time_vs_fixed_4k"] for r in observations),
            max_heap_bytes=max(r["median_peak_bytes"] for r in observations)))
    output.sort(key=lambda r:(r["p90_regret"],r["max_regret"]))
    assert len(output)==111 and len(detailed)==111*109
    assert output[0]["policy"]=="block_balanced_4__floor_bytes_1024"
    write("policy-floor-screen-conditions.csv",detailed)
    write("policy-floor-screen-ranking.csv",output)
    decision=dict(candidate=output[0]["policy"],candidate_formula="max(ceil(4*sqrt(9*n/(512*s))),floor(1024/s),1)",
        status="Screened candidate, not a universal optimum; validate against plain c=4, plain c=8, floor alternatives and fixed-policy finalists.",
        policies=111,conditions=109,measured_primitive_policies=21,
        minimum_element_floors=[128,512,1024],minimum_byte_floors=[1024,4096,8192],
        balanced_coefficients=[1,2,4,8,16,32,64],normalized_coefficients=[1,2,4,8,16,32,64,128],
        methodology="max(root block, floor block) always equals an existing measured block argument for that exact input. Select by n and record size only, never by observed speed. Equal block arguments pool retained observations. No extra timing observations created.",
        caveat="Policy calculation is outside the measured boundary, as in the original campaign. Ranking is exploratory over a finite grid. Equal-weight conditions are not a business workload distribution.",
        rule="Smallest P90 latency regret, then inspect worst regret and heap separately. All 111 formulas and all rows retained.",
        validation_primitive_calls=["block_balanced_4","block_balanced_8","block_fixed_128","block_fixed_bytes_1024","block_normalized_2","block_fixed_bytes_4096"],
        validation_derived_floors="For both c=4 and c=8, derive min 128 items, min 1 KiB and min 4 KiB by selecting the measured call with exactly the effective block argument for each input.",
        source_sha256=hashlib.sha256((ROOT/"data/policy-screen-conditions.csv").read_bytes()).hexdigest(),ranked=output)
    (ROOT/"data/policy-screen-floor-decision.json").write_text(json.dumps(decision,indent=2)+"\n")
    print(json.dumps({k:v for k,v in decision.items() if k!="ranked"},indent=2))
    print("Top five:")
    print(json.dumps(output[:5],indent=2))


if __name__=="__main__":main()
