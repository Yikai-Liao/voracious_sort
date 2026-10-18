#!/usr/bin/env python3
"""ABBA executable control: detect common-path drift hidden by same-ELF ratios."""
import argparse
import csv
import json
import resource
import statistics as st
import subprocess
import time
from collections import defaultdict
from pathlib import Path
from run import ROOT, REPO, BASE, digest, source_hash
from analyze import quantile

p=argparse.ArgumentParser()
p.add_argument('--binary', required=True)
p.add_argument('--candidate', default='Pa_packed')
a=p.parse_args()
old=REPO.parent/'voracious_sort-pa-unified/experiments/block_msd/target/pa-comparator/time'
old_sha='ef8dd60c19eedf6246fa62595bba3814b71c7e24a509988a6896bbc0b3c68c43'
assert digest(old)==old_sha
new=REPO/'experiments/block_msd/target/pa-structural'/a.binary
frozen=json.loads(new.with_suffix(new.suffix+'.json').read_text())
assert digest(new)==frozen['sha256']
assert source_hash()==frozen['source_sha256']
raw=ROOT/'measurements'
metadata=dict(old_sha256=old_sha,old_source_commit='06331aa5f1e6fb20dac535bd405d8a68ab5a5ab3',new=frozen,order=['old','new','new','old'],commands=[],vmstat_before=Path('/proc/vmstat').read_text())
groups=[('guards','uniform,sparse','u32,u64,u128,wide32,large128'),
        ('leaf','deep_unique90','large128'),
        ('order','equal,sorted,reverse','u128,wide32')]
samples=defaultdict(lambda:defaultdict(list))
for group,cases,layouts in groups:
    for outer,which in enumerate(metadata['order']):
        methods=','.join([BASE,BASE]) if which=='old' else ','.join([a.candidate,BASE,BASE,a.candidate])
        command=['taskset','-c','2',str(old if which=='old' else new),'1048576','8',methods,cases,layouts,'time','512','42']
        path=raw/f'frozen-control-{group}-{outer}-{which}.csv'
        assert not path.exists(),path
        started=time.time_ns()
        with path.open('w') as out:
            subprocess.run(command,check=True,cwd=REPO,stdout=out)
        metadata['commands'].append(dict(command=command,file=path.name,started_ns=started,ended_ns=time.time_ns()))
        grouped=defaultdict(list)
        for row in csv.DictReader(path.open()):
            assert row['kind']=='time' and row['instrumented']=='false'
            cell=tuple(row[k] for k in ('layout','case','n','block','seed'))
            grouped[cell,row['method'],int(row['rep'])].append(int(row['wall_ns']))
        for (cell,method,rep),times in grouped.items():
            samples[cell][which+':'+method].append(st.mean(times))
    print(group,flush=True)
results=[]
for cell,methods in samples.items():
    reference=methods['old:'+BASE]
    row={'cell':cell}
    for method in ['new:'+BASE,'new:'+a.candidate]:
        # Pair symmetric process runs, preserving each executable's inner rep.
        ratios=[x/y for x,y in zip(methods[method],reference)]
        row[method]={'median':st.median(ratios),'p10':quantile(ratios,.1),'p90':quantile(ratios,.9)}
    results.append(row)
metadata['results']=results
usage=resource.getrusage(resource.RUSAGE_CHILDREN)
metadata['usage']={k:getattr(usage,k) for k in ['ru_utime','ru_stime','ru_maxrss','ru_minflt','ru_majflt','ru_nivcsw']}
metadata['vmstat_after']=Path('/proc/vmstat').read_text()
(ROOT/'frozen-control.json').write_text(json.dumps(metadata,indent=2)+'\n')
print(json.dumps(results,indent=2))
