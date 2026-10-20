#!/usr/bin/env python3
"""Measure expanded sqrt coefficients in a separately frozen campaign."""
import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import random
import re
import subprocess
import time

ROOT=Path(__file__).resolve().parent
BUNDLE=ROOT.parent
DATA=BUNDLE/"data"
spec=importlib.util.spec_from_file_location("initial_campaign",BUNDLE/"run.py")
initial=importlib.util.module_from_spec(spec)
spec.loader.exec_module(initial)
WIDTHS={"u32":4,"u64":8,"u128":16,"i32":4,"i64":8,"f32":4,"f64":8,"record32":32,"record128":128}
STRESS=["skew95","common_prefix","nearly_sorted","normal","organ_pipe","push_front"]
BALANCED=[1,2,4,8,16,32,64]
NORMALIZED=[1,2,4,8,16,32,64,128]


def methods(case):
    n,s=case["n"],WIDTHS[case["kind"]]
    result=[]
    def add(name,family,parameter,block):
        result.append(dict(algorithm=name,policy_family=family,policy_parameter=parameter,block=max(1,block)))
    for b in [128,512,1024]:add(f"block_fixed_{b}","fixed_items",b,b)
    for size in [1024,4096,8192]:add(f"block_fixed_bytes_{size}","fixed_bytes",size,size//s)
    for c in BALANCED:
        add(f"block_balanced_{c}","space_balanced_sqrt",c,math.ceil(c*math.sqrt(9*n/(512*s))))
    for c in NORMALIZED:
        add(f"block_normalized_{c}","byte_normalized_sqrt",c,math.floor(c*math.sqrt(n)/s))
    for a in ["lsd","std","timsort","lsd_aa"]:add(a,"comparison",0,512)
    assert len(result)==25
    return result


def cases():
    result=[dict(kind=k,dist="uniform",n=n,group="uniform_matrix") for k in initial.KINDS for n in initial.SIZES]
    result += [dict(c,group="u64_scaling") for c in initial.primary_cases() if c["group"]=="scaling"]
    result += [dict(kind=k,dist=d,n=1048576,group="stress") for k in initial.KINDS for d in STRESS]
    assert len(result)==109
    random.Random(20261019).shuffle(result)
    return result


def freeze():
    assert (BUNDLE/"data/audit.json").is_file(),"Complete the initial campaign first"
    files=[ROOT/"run.py",ROOT/"ADAPTER.diff",ROOT/"benchmark-time",ROOT/"benchmark-memory"]
    files += [p for p in (ROOT/"harness").rglob("*") if p.is_file() and "target" not in p.relative_to(ROOT).parts]
    before=json.loads((BUNDLE/"manifest.json").read_text())
    for name,digest in before["source_files"].items():
        assert initial.sha(ROOT/"harness/source/pr"/name)==digest,name
    manifest={
        "created_utc":time.strftime("%Y-%m-%dT%H:%M:%SZ",time.gmtime()),
        "candidate_commit":before["candidate_commit"],
        "initial_manifest_sha256":initial.sha(BUNDLE/"manifest.json"),
        "files":{str(p.relative_to(ROOT)):initial.sha(p) for p in files},
        "compiler":before["compiler"],"rustflags":before["rustflags"],"profile":before["profile"],
        "cpp_compiler":before["cpp_compiler"],"cpp_flags":before["cpp_flags"],
        "cpu_affinity":[2],"threads":1,"seed":initial.SEED,
        "space_balanced_formula":"max(1, ceil(c * sqrt(9*n/(512*s))))",
        "space_balanced_coefficients":BALANCED,
        "byte_normalized_formula":"max(1, floor(k * sqrt(n) / s))",
        "byte_normalized_coefficients_bytes":NORMALIZED,
        "coverage":"All nine types and five primary sizes on uniform inputs, ten additional u64 uniform sizes, plus six predeclared stress distributions at 1048576 elements for all nine types",
        "stress_distributions":STRESS,"input_cases":109,"algorithms_per_case":25,
        "time_replicates":6,"memory_replicates":3,
        "protocol":"Same seeds, warmup, batches, oracle and exact forward/reverse method order as the initial campaign; controls rerun within this campaign; supplemental ratios never mix timing campaigns",
        "why":"User requested coefficients spanning block length 512 and a distinct sqrt policy normalized by record byte size",
        "harness_adapter":"Accept a comma-separated list of algorithm:block tokens; parse explicit block lengths outside timing; all sorting implementation files match the initial frozen candidate",
        "initial_meminfo":Path("/proc/meminfo").read_text(),"vmstat_start":initial.vmstat(),
    }
    (ROOT/"manifest.json").write_text(json.dumps(manifest,indent=2)+"\n")
    print("Frozen expanded sqrt campaign: 109 cases x 25 methods")


def execute(case,mode,stem,replicates):
    policies=methods(case)
    algorithm_arg=",".join(f"{p['algorithm']}:{p['block']}" for p in policies)
    lookup={p["algorithm"]:p for p in policies}
    args=["taskset","-c","2","/usr/bin/time","-f","RESOURCE %M %F %W %x",
        str(ROOT/("benchmark-time" if mode=="time" else "benchmark-memory")),mode,case["kind"],case["dist"],
        str(case["n"]),str(initial.SEED),"8","512",str(replicates),algorithm_arg]
    start=time.time();before=initial.vmstat()
    proc=subprocess.run(args,capture_output=True,text=True,cwd=ROOT,env={**os.environ,"RAYON_NUM_THREADS":"1"})
    after=initial.vmstat()
    meta=dict(case=case,mode=mode,command=args,start_unix=start,wall_seconds=time.time()-start,
        returncode=proc.returncode,stderr=proc.stderr,vmstat_delta={k:after[k]-before[k] for k in before})
    with (DATA/(stem+"-processes.jsonl")).open("a") as f:f.write(json.dumps(meta)+"\n")
    if proc.returncode:
        (DATA/(stem+"-failed-stdout.txt")).write_text(proc.stdout)
        raise RuntimeError(f"{case}: {proc.stderr[-2000:]}")
    rows=[json.loads(line) for line in proc.stdout.splitlines()]
    assert len(rows)==len(policies)*replicates*(2 if mode=="time" else 1)
    assert int(re.search(r"VmSwap:\s+(\d+)",proc.stderr).group(1))==0
    for row in rows:
        policy=lookup[row["algorithm"]]
        assert row["block"]==policy["block"],row
        row.update(group=case["group"],campaign="expanded_sqrt",policy_family=policy["policy_family"],policy_parameter=policy["policy_parameter"])
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
    for name,digest in manifest["files"].items():assert initial.sha(ROOT/name)==digest,name
    stem="supplemental-sqrt-"+stage
    if (DATA/(stem+".jsonl")).exists():raise RuntimeError("Refusing duplicate supplemental campaign")
    matrix=cases() if stage!="preflight" else [dict(kind=k,dist="uniform",n=16384,group="preflight") for k in initial.KINDS]
    (DATA/(stem+"-schedule.json")).write_text(json.dumps(matrix,indent=2)+"\n")
    start=time.time()
    for i,case in enumerate(matrix,1):
        execute(case,"memory" if stage=="memory" else "time",stem,1 if stage=="preflight" else 3)
        print(f"{stage} {i}/{len(matrix)} {case['kind']} {case['dist']} n={case['n']} elapsed={time.time()-start:.1f}s",flush=True)
    manifest[stage+"_wall_seconds"]=time.time()-start
    manifest[stage+"_vmstat_end"]=initial.vmstat()
    (ROOT/"manifest.json").write_text(json.dumps(manifest,indent=2)+"\n")


if __name__=="__main__":main()
