#!/usr/bin/env python3
"""Force software gather while retaining the native compiler target."""
import subprocess
import sys
from run import ROOT, BASE
methods=','.join(['Pa_packed',BASE,'Rollercoaster','L_frozen',BASE,'Pa_packed'])
for block in [64,512]:
    subprocess.run([sys.executable,str(ROOT/'run.py'),f'portable-final-b{block}',
                    '--binary','portable_final','--methods',methods,
                    '--reps','12','--block',str(block),
                    '--layouts','u32,u64,u128,wide32','--cases','uniform,sparse'],check=True)
subprocess.run([sys.executable,str(ROOT/'run.py'),'portable-final-information',
                '--binary','portable_final','--methods',methods,'--n','262144',
                '--reps','12','--layouts','u128,wide32',
                '--cases','project7_spaced,project8_spaced,project9_spaced,project16_spaced,project24_spaced,project32_spaced'],check=True)
subprocess.run([sys.executable,str(ROOT/'analyze.py'),'portable-final-'],check=True)
