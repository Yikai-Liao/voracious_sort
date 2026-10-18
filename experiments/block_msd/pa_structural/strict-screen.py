#!/usr/bin/env python3
"""Fresh-source screens for the independent conservative PA packing policy."""
import argparse
import subprocess
import sys
from run import ROOT, BASE

p = argparse.ArgumentParser(__doc__)
p.add_argument('--binary', required=True)
p.add_argument('--prefix', required=True)
p.add_argument('--scope', choices=['boundary', 'float-first', 'integer'], required=True)
a = p.parse_args()
methods = ','.join(['Pa_strict', BASE, 'Pa_kernel', 'Rollercoaster',
                    'L_frozen', 'Pa_kernel', BASE, 'Pa_strict'])


def run(name, **kw):
    script = 'run.py' if a.scope == 'integer' else 'float-run.py'
    command = [sys.executable, str(ROOT / script), a.prefix + '-' + name,
               '--binary', a.binary, '--methods', methods, '--reps', '16',
               '--seed', '42' if a.scope == 'boundary' else '20261027']
    for key, value in kw.items():
        command += ['--' + key, str(value)]
    subprocess.run(command, check=True)


if a.scope == 'boundary':
    run('b512', layouts='f32_id16', cases='sparse16', block=512)
elif a.scope == 'float-first':
    run('b512', layouts='f32,f64,f32_id16,f64_id32',
        cases='uniform,sparse16', block=512)
else:
    for block in [64, 512]:
        run('main-b' + str(block), layouts='u32,u64,u128,wide32,large128',
            cases='uniform,sparse', block=block)
        run('deep-b' + str(block), layouts='large128',
            cases='deep_unique90', block=block)
        run('q64-b' + str(block), layouts='u128,wide32',
            cases='project64_spaced', n=262144, block=block)
