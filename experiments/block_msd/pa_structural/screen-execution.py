#!/usr/bin/env python3
"""Independent classifier-context and library-boundary screens, one frozen ELF."""
import argparse
import subprocess
import sys
from run import BASE, ROOT

p = argparse.ArgumentParser()
p.add_argument('--binary', required=True)
p.add_argument('--prefix', required=True)
p.add_argument('--stage', choices=['u32', 'mixed'], required=True)
a = p.parse_args()
methods = ','.join([BASE, 'Pa_packed', 'Pa_kernel', 'Pa_gallop',
                    'Pa_packed_gallop', 'Rollercoaster', 'L_frozen', BASE])

def run(name, **kw):
    command = [sys.executable, str(ROOT / 'run.py'), a.prefix + '-' + name,
               '--binary', a.binary, '--methods', methods, '--reps', '16']
    for key, value in kw.items():
        command += ['--' + key, str(value)]
    subprocess.run(command, check=True)

if a.stage == 'u32':
    for block in [64, 512]:
        run(f'u32-b{block}', layouts='u32', cases='sparse,uniform', block=block)
else:
    for block in [512, 64]:
        run(f'mixed-b{block}', layouts='u64,u128,wide32,large128',
            cases='uniform,sparse', block=block)
    run('prefix', layouts='u64,u128,wide32',
        cases='few,deep_skew,majority_prefix,deep_unique90,deep_unique98')
    run('large-leaves', layouts='large128', block=512,
        cases='deep_unique90,deep_skew')

subprocess.run([sys.executable, str(ROOT / 'analyze.py'), a.prefix + '-'], check=True)
