#!/usr/bin/env python3
"""Independent leaf/layout ablations and explicit combined candidate."""
import argparse
import subprocess
import sys
from run import ROOT, BASE
p = argparse.ArgumentParser(__doc__)
p.add_argument('--binary', required=True)
p.add_argument('--prefix', required=True)
p.add_argument('--scope', choices=['float-first', 'float-rest', 'integer'], required=True)
a = p.parse_args()
methods = ','.join(['Pa_odd_cached', BASE, 'Pa_leaf_cached', 'Pa_odd_blocks',
                    'Pa_kernel', 'Rollercoaster', 'L_frozen', 'Pa_kernel',
                    BASE, 'Pa_odd_cached'])
def run(name, **kw):
    script = 'run.py' if a.scope == 'integer' else 'float-run.py'
    command = [sys.executable, str(ROOT/script), a.prefix+'-'+name,
               '--binary', a.binary, '--methods', methods, '--reps', '20']
    for key, value in kw.items(): command += ['--'+key, str(value)]
    subprocess.run(command, check=True)
if a.scope == 'float-first':
    run('b512', layouts='f32,f64,f32_id16,f64_id32', cases='uniform,sparse16', block=512)
elif a.scope == 'float-rest':
    run('b64', layouts='f32,f64,f32_id16,f64_id32', cases='uniform,sparse16', block=64)
    for block in [64, 512]:
        run('shape-b'+str(block), layouts='f32,f64', cases='normal12,subnormal', block=block)
else:
    for block in [64, 512]:
        run('main-b'+str(block), layouts='u32,u64,u128,wide32,large128', cases='uniform,sparse', block=block)
        run('deep-b'+str(block), layouts='large128', cases='deep_unique90', block=block)
        run('q64-b'+str(block), layouts='u128,wide32', cases='project64_spaced', n=262144, block=block)
