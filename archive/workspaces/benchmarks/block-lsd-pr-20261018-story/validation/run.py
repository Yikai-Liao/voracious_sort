#!/usr/bin/env python3
"""Validate the screened policies on the complete retained input matrix."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import random
import re
import subprocess
import sys
import time

sys.dont_write_bytecode = True
import protocol

ROOT = Path(__file__).resolve().parent
DATA = ROOT / "data"
WIDTHS = dict(u32=4,u64=8,u128=16,i32=4,i64=8,f32=4,f64=8,record32=32,record128=128)


def methods(case):
    n, s, kind = case["n"], WIDTHS[case["kind"]], case["kind"]
    result = [
        ("block_balanced_4", max(1,math.ceil(4*math.sqrt(9*n/(512*s))))),
        ("block_balanced_8", max(1,math.ceil(8*math.sqrt(9*n/(512*s))))),
        ("block_fixed_128",128),
        ("block_fixed_bytes_1024",max(1,1024//s)),
        ("block_normalized_2",max(1,math.floor(2*math.sqrt(n)/s))),
        ("block_fixed_bytes_4096",max(1,4096//s)),
        ("lsd",512),("std",512),("timsort",512),("lsd_aa",512),
    ]
    if n == 1048576 or case.get("include_variants"):
        result += [(a,512) for a in ["lsd_plain","lsd_core","dlsd"]]
        if not kind.startswith("record"):
            result.append(("lsd_heuristic",512))
        if kind != "u128":
            result.append(("thiel",512))
        if kind in ["u32","f32"]:
            result.append(("dedicated",512))
    return result


def cases():
    result=protocol.primary_cases()
    random.Random(20261021).shuffle(result)
    return result


def freeze():
    decision=ROOT.parent/"data/policy-screen-floor-decision.json"
    assert json.loads(decision.read_text())["candidate"]=="block_balanced_4__floor_bytes_1024"
    original=json.loads((ROOT/"initial-manifest.json").read_text())
    for name,digest in original["source_files"].items():
        assert protocol.sha(ROOT/"harness/source/pr"/name)==digest,name
    files=[ROOT/"run.py",ROOT/"protocol.py",ROOT/"benchmark-time",ROOT/"benchmark-memory",ROOT/"ADAPTER.diff",ROOT/"data/reference-input-digests.json"]
    files += [p for p in (ROOT/"harness").rglob("*") if p.is_file() and not {"target","__pycache__"}.intersection(p.relative_to(ROOT).parts)]
    count=sum(len(methods(c)) for c in cases())
    result=dict(created_utc=time.strftime("%Y-%m-%dT%H:%M:%SZ",time.gmtime()),
        candidate_commit=original["candidate_commit"],compiler=original["compiler"],cpp_compiler=original["cpp_compiler"],
        rustflags=original["rustflags"],profile=original["profile"],cpp_flags=original["cpp_flags"],
        cpu_affinity=[2],threads=1,seed=protocol.SEED,
        decision_sha256=protocol.sha(decision),
        decision="Validate c=4 and c=8, family finalists (128 items, 1 KiB, byte-normalized k=2), and previous 4 KiB reference. Derive screened c=4 + min 1 KiB and competing floors only by choosing the measured call with identical block arguments. No formula is retuned from these observations.",
        formulas={"block_balanced_4":"max(1,ceil(4*sqrt(9*n/(512*s))))","block_balanced_8":"max(1,ceil(8*sqrt(9*n/(512*s))))","block_normalized_2":"max(1,floor(2*sqrt(n)/s))"},
        input_conditions=len(cases()),algorithm_cases=count,time_observations=count*6,memory_observations=count*3,
        pure_lsd_variant_coverage="All applicable repository pure-LSD variants at 1,048,576; Stable LSD/Rust stable/TimSort/A/A and all policy finalists at every size.",
        paired_protocol=original["replicates"],timing_boundary=original["timing_boundary"],cache_protocol=original["cache_protocol"],
        memory_metric=original["memory_metric"],
        files={str(p.relative_to(ROOT)):protocol.sha(p) for p in files},
        vmstat_start=protocol.vmstat(),initial_meminfo=Path("/proc/meminfo").read_text())
    (ROOT/"manifest.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k not in ["files","initial_meminfo"]},indent=2))


def execute(case, mode, stem, replicates):
    policies=methods(case)
    args=["taskset","-c","2","/usr/bin/time","-f","RESOURCE %M %F %W %x",
        str(ROOT/("benchmark-time" if mode=="time" else "benchmark-memory")),mode,case["kind"],case["dist"],
        str(case["n"]),str(protocol.SEED),"8","512",str(replicates),",".join(f"{a}:{b}" for a,b in policies)]
    before=protocol.vmstat();start=time.time()
    proc=subprocess.run(args,capture_output=True,text=True,cwd=ROOT,env={**os.environ,"RAYON_NUM_THREADS":"1"})
    after=protocol.vmstat()
    meta=dict(case=case,mode=mode,command=args,start_unix=start,wall_seconds=time.time()-start,
        returncode=proc.returncode,stderr=proc.stderr,vmstat_delta={k:after[k]-before[k] for k in before})
    with (DATA/(stem+"-processes.jsonl")).open("a") as f:f.write(json.dumps(meta)+"\n")
    if proc.returncode:
        (DATA/(stem+"-failed-stdout.txt")).write_text(proc.stdout)
        raise RuntimeError(f"{case}: {proc.stderr[-2000:]}")
    rows=[json.loads(line) for line in proc.stdout.splitlines()]
    assert len(rows)==len(policies)*replicates*(2 if mode=="time" else 1)
    assert int(re.search(r"VmSwap:\s+(\d+)",proc.stderr).group(1))==0
    lookup=dict(policies)
    for row in rows:
        assert row["block"]==lookup[row["algorithm"]]
        row.update(group=case["group"],campaign="screened_policy_validation")
        if row["algorithm"].startswith("block_") or row["algorithm"] in ["std","timsort"]:
            assert row["valid"] and row["ordered"] and row["preserved"],row
        if mode=="memory" and row["algorithm"].startswith("block_"):
            bound=512*row["block"]*row["bytes_per_record"]+9*(row["n"]//row["block"])+66*256
            assert row["peak_bytes"]<=bound,(row,bound)
    with (DATA/(stem+".jsonl")).open("a") as f:
        for row in rows:f.write(json.dumps(row)+"\n")


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("stage",choices=["freeze","preflight","time","memory"])
    stage=parser.parse_args().stage
    if stage=="freeze":freeze();return
    manifest=json.loads((ROOT/"manifest.json").read_text())
    for name,digest in manifest["files"].items():assert protocol.sha(ROOT/name)==digest,name
    assert protocol.sha(ROOT.parent/"data/policy-screen-floor-decision.json")==manifest["decision_sha256"]
    if (DATA/(stage+".jsonl")).exists():raise RuntimeError("Refusing to append duplicate campaign")
    matrix=cases() if stage!="preflight" else [dict(kind=k,dist="uniform",n=1024,group="preflight",include_variants=True) for k in protocol.KINDS]
    (DATA/(stage+"-schedule.json")).write_text(json.dumps(matrix,indent=2)+"\n")
    start=time.time()
    for i,case in enumerate(matrix,1):
        execute(case,"memory" if stage=="memory" else "time",stage,1 if stage=="preflight" else 3)
        print(f"{stage} {i}/{len(matrix)} {case['kind']} {case['dist']} n={case['n']} elapsed={time.time()-start:.1f}s",flush=True)
    manifest[stage+"_wall_seconds"]=time.time()-start
    manifest[stage+"_vmstat_end"]=protocol.vmstat()
    (ROOT/"manifest.json").write_text(json.dumps(manifest,indent=2)+"\n")


if __name__=="__main__":main()
