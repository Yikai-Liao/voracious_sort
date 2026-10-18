#!/usr/bin/env python3
"""Fresh seed for target reversal and information-budget boundary controls."""
import subprocess
import sys
import argparse
from run import ROOT, BASE
p=argparse.ArgumentParser()
p.add_argument('--binary',default='library_native')
p.add_argument('--prefix',default='heldout-library')
a=p.parse_args()
methods=','.join(['Pa_packed',BASE,'Rollercoaster','L_frozen',BASE,'Pa_packed'])
def run(name, **kw):
    command=[sys.executable,str(ROOT/'run.py'),a.prefix+'-'+name,
             '--binary',a.binary,'--methods',methods,'--reps','12','--seed','20261020']
    for key,value in kw.items():command+=['--'+key,str(value)]
    subprocess.run(command,check=True)
for block in [512,64]:
    run(f'target-b{block}',block=block,layouts='wide32,u128,u32',cases='sparse')
run('information',n=262144,layouts='u128,wide32',
    cases='project7_spaced,project8_spaced,project9_spaced,project16_spaced,project24_spaced,project32_spaced,project33_spaced,project64_spaced,project8_cross,project16_cross,project8_spaced_skew,project16_spaced_skew')
subprocess.run([sys.executable,str(ROOT/'analyze.py'),a.prefix+'-'],check=True)
