#!/usr/bin/env python3
"""Run pinned, sequential scaling experiments; preserve each run's CSV/log."""
import argparse, os, subprocess
from pathlib import Path
p=argparse.ArgumentParser()
p.add_argument('--types', default='u32,u64,u128,fat128')
p.add_argument('--threads', default='1,2,4,8,16')
p.add_argument('--sizes', default='65536,1048576,4194304')
p.add_argument('--samples', type=int, default=5)
p.add_argument('--loads', default='uniform,duplicates,skew')
p.add_argument('--methods', default='rayon_block,serial_block,serial_lsd,rayon_stable,repo_mt,c_parallel,c_permuted')
p.add_argument('--cpus', default='0,2,4,6,8,10,12,14,1,3,5,7,9,11,13,15')
p.add_argument('--output', type=Path, required=True)
a=p.parse_args()
a.output.mkdir(parents=True,exist_ok=True)
binary=Path(__file__).resolve().parent/'target/release/block_lsd_parallel_bench'
env=dict(os.environ, BENCH_CPUS=a.cpus, OMP_PLACES=','.join('{'+cpu+'}' for cpu in a.cpus.split(',')), OMP_PROC_BIND='true', OMP_DYNAMIC='false', OMP_WAIT_POLICY='PASSIVE', GOMP_SPINCOUNT='0', LOADS=a.loads, METHODS=a.methods)
for kind in a.types.split(','):
    for threads in a.threads.split(','):
        target=a.output/f'{kind}-p{threads}'
        print(f'{kind} p={threads}', flush=True)
        with target.with_suffix('.csv').open('w') as out, target.with_suffix('.log').open('w') as log:
            subprocess.run([str(binary),kind,str(a.samples),threads,*a.sizes.split(',')],env=env,stdout=out,stderr=log,check=True)
