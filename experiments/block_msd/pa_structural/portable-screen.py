#!/usr/bin/env python3
"""Force software gather while retaining the native compiler target."""
import subprocess
import sys
import argparse
from run import ROOT, BASE
p=argparse.ArgumentParser()
p.add_argument('--binary',default='validated_portable')
p.add_argument('--prefix',default='software-validated')
a=p.parse_args()
methods=','.join(['Pa_packed',BASE,'Rollercoaster','L_frozen',BASE,'Pa_packed'])
for block in [64,512]:
    subprocess.run([sys.executable,str(ROOT/'run.py'),f'{a.prefix}-b{block}',
                    '--binary',a.binary,'--methods',methods,
                    '--reps','12','--block',str(block),
                    '--layouts','u32,u64,u128,wide32','--cases','uniform,sparse'],check=True)
subprocess.run([sys.executable,str(ROOT/'run.py'),a.prefix+'-information',
                '--binary',a.binary,'--methods',methods,'--n','262144',
                '--reps','12','--layouts','u64,u128,wide32',
                '--cases','project7_spaced,project8_spaced,project9_spaced,project16_spaced,project24_spaced,project32_spaced,project33_spaced,project64_spaced,project8_cross,project16_cross'],check=True)
subprocess.run([sys.executable,str(ROOT/'analyze.py'),a.prefix+'-'],check=True)
