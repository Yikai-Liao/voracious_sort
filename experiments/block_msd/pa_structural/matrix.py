#!/usr/bin/env python3
"""Reproduce the original 103 cells with an additional frozen PA reference."""
import argparse
import subprocess
import sys
from pathlib import Path
from run import ROOT, BASE
p=argparse.ArgumentParser()
p.add_argument('--candidate',default='Pa_packed')
p.add_argument('--binary',default='final')
p.add_argument('--prefix',default='final')
p.add_argument('--reps',default='16')
a=p.parse_args()
reference = BASE if a.candidate in ['Pa_packed', 'Pa_kernel'] else 'Pa_packed'
methods=','.join([a.candidate,BASE,reference,'Fa','Rollercoaster','L_frozen','stable_msd',a.candidate])
shared='deep_skew,majority_prefix,deep_unique90,deep_unique98'
cells=[
('guards-b64-s42',dict(cases='uniform,sparse',layouts='u8,u16,u32,u64,u128,u8_id8,u16_id8,small8,wide32,large128')),
('prefix-b64-s42',dict(layouts='u64,u128,wide32',cases=shared)),
('seedflip-b64-s7',dict(seed=7,layouts='u64',cases='deep_unique90')),
('prefix-b512-s42',dict(block=512,layouts='u64,u128,wide32',cases=shared)),
('cache-domain-b512-s42',dict(block=512,layouts='u64,u128,u16_id8,small8,wide32,large128',cases='uniform,sparse')),
('narrow-repeat-b64-s42',dict(layouts='u8,u16,u8_id8,u16_id8',cases='deep_skew')),
('order-small-b64-s42',dict(n=16384,layouts='u8,u16,u128,wide32',cases='equal,sorted,reverse')),
('order-large-b64-s42',dict(layouts='u8,u16,u128,wide32',cases='equal,sorted,reverse')),
('large-b512-s42',dict(block=512,layouts='large128',cases='deep_skew,majority_prefix,deep_unique90')),
('medium-b64-s42',dict(n=262144,layouts='u128',cases='uniform,majority_prefix,deep_unique90')),
('prefix-heldout-b64-s20261018',dict(seed=20261018,layouts='u64,u128,wide32',cases=shared)),
]
for name,kw in cells:
    command=[sys.executable,str(ROOT/'run.py'),a.prefix+'-'+name,'--methods',methods,'--binary',a.binary,'--reps',a.reps]
    for k,v in kw.items(): command += ['--'+k,str(v)]
    subprocess.run(command,check=True)
