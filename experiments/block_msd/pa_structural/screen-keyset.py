#!/usr/bin/env python3
"""Independent bounded-alphabet screen; no timings pooled with prior ELFs."""
import subprocess
import sys
from run import ROOT, BASE

methods = ','.join([BASE, 'Pa_packed', 'Pa_packed_keyset_binary',
                    'Pa_packed_keyset8', 'Pa_packed_keyset',
                    'Rollercoaster', 'L_frozen', BASE])
def run(name, **kw):
    command = [sys.executable, str(ROOT/'run.py'), 'keyset-screen-'+name,
               '--binary', 'keyset', '--methods', methods, '--reps', '16']
    for key, value in kw.items():
        command += ['--'+key, str(value)]
    subprocess.run(command, check=True)

run('alphabet', n=262144, layouts='u64,u128,wide32',
    cases='alphabet2,alphabet4,alphabet8,alphabet16,alphabet32,alphabet64,alphabet4_noise,alphabet4_noise50,alphabet4_noise90')
run('guards', n=1048576, layouts='u32,u64,u128,large128',
    cases='uniform,sparse', block=512)
run('leaf', n=1048576, layouts='large128', cases='deep_unique90', block=512)
subprocess.run([sys.executable,str(ROOT/'analyze.py'),'keyset-screen-'],check=True)
