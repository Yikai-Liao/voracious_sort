#!/usr/bin/env python3
"""Predeclared finite float/double cells, with a separate nonfinite cohort."""
import argparse
import subprocess
import sys
from run import ROOT, BASE

p = argparse.ArgumentParser(__doc__)
p.add_argument('--binary', required=True)
p.add_argument('--prefix', required=True)
p.add_argument('--candidate', default='Pa_kernel')
p.add_argument('--scope', choices=['native', 'generic', 'holdout', 'work'], required=True)
a = p.parse_args()
layouts = 'f32,f64,f32_id16,f64_id32'
finite = 'uniform,normal12,log_scale,few_unique,skew90,sparse8,sparse16,signed_sparse8,subnormal,sorted,reverse'
methods = ','.join([a.candidate, BASE, 'Rollercoaster', 'L_frozen', 'stable_msd', BASE, a.candidate])

def run(name, **kw):
    command = [sys.executable, str(ROOT/'float-run.py'), a.prefix+'-'+name,
               '--binary', a.binary, '--layouts', layouts]
    for key, value in kw.items():
        command += ['--'+key, str(value)]
    subprocess.run(command, check=True)

if a.scope == 'work':
    run('sparse', methods=','.join([BASE, 'Pa_packed', 'Pa_kernel']),
        kind='work', n=65537, reps=1, cases='sparse8,sparse16,signed_sparse8')
else:
    if a.scope == 'generic':
        finite = 'uniform,skew90,sparse8,sparse16'
    if a.scope == 'holdout':
        finite = 'sparse8,sparse16'
        methods = ','.join([a.candidate, BASE, 'Rollercoaster', 'L_frozen', BASE, a.candidate])
    for block in ([512, 64] if a.scope == 'holdout' else [64, 512]):
        run('finite-b'+str(block), block=block, cases=finite, methods=methods,
            n=262144 if a.scope == 'holdout' else 1048576,
            reps=12 if a.scope == 'holdout' else 14,
            seed=20261022 if a.scope == 'holdout' else 42)
    if a.scope != 'holdout':
        methods = ','.join([a.candidate, BASE, 'L_frozen', BASE, a.candidate])
        for block in [64, 512]:
            run('special-b'+str(block), block=block, cases='special_mix,all_bits',
                methods=methods, n=1048576, reps=10, seed=42)
