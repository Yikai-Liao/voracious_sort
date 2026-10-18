#!/usr/bin/env python3
"""Whole-sort ABBA comparison of identical admission with two library backends."""
import csv
import json
import statistics as st
import subprocess
import sys
from collections import defaultdict
from run import ROOT, BASE
from analyze import quantile

prefix='library-backends'
methods=','.join(['Pa_packed',BASE,BASE,'Pa_packed'])
groups=[
    ('b64',dict(block=64,layouts='u32,u64,u128,wide32',cases='uniform,sparse')),
    ('b512',dict(block=512,layouts='u32,u64,u128,wide32',cases='uniform,sparse')),
    ('information',dict(n=262144,layouts='u128,wide32',cases='project7_spaced,project8_spaced,project9_spaced,project16_spaced,project24_spaced,project32_spaced,project64_spaced,project8_cross')),
]
samples=defaultdict(lambda:defaultdict(list))
for group,kw in groups:
    for outer,backend in enumerate(['native','portable','portable','native']):
        name=f'{prefix}-{group}-{outer}-{backend}'
        command=[sys.executable,str(ROOT/'run.py'),name,'--binary','library_'+backend,
                 '--methods',methods,'--reps','8']
        for k,v in kw.items():command+=['--'+k,str(v)]
        subprocess.run(command,check=True)
        grouped=defaultdict(list)
        for r in csv.DictReader((ROOT/'measurements'/(name+'.csv')).open()):
            key=tuple(r[k] for k in ('layout','case','n','block','seed'))
            grouped[key,r['method'],int(r['rep'])].append(int(r['wall_ns']))
        for (key,method,rep),times in grouped.items():
            samples[key][backend+':'+method].append(st.mean(times))
results=[]
for key,methods in samples.items():
    hardware=methods['native:Pa_packed']
    software=methods['portable:Pa_packed']
    base_native=methods['native:'+BASE]
    base_software=methods['portable:'+BASE]
    result=dict(zip(('layout','case','n','block','seed'),key))
    for name,values in [('hardware_ms',hardware),('software_ms',software),
                        ('base_hardware_ms',base_native),('base_software_ms',base_software)]:
        result[name]=st.median(values)/1e6
    for name,left,right in [('software_over_hardware',software,hardware),
                            ('hardware_over_base',hardware,base_native),
                            ('software_over_base',software,base_software),
                            ('base_software_over_hardware',base_software,base_native)]:
        ratios=[x/y for x,y in zip(left,right)]
        result[name]=dict(median=st.median(ratios),p10=quantile(ratios,.1),p90=quantile(ratios,.9))
    results.append(result)
(ROOT/(prefix+'.json')).write_text(json.dumps(results,indent=2)+'\n')
for r in results:
    print(r['layout'],r['case'],'B'+r['block'],
          'base/hw/sw_ms',*[round(r[k],3) for k in ['base_hardware_ms','hardware_ms','software_ms']],
          'sw/hw',round(r['software_over_hardware']['median'],3),flush=True)
