#!/usr/bin/env python3
"""Describe independent scatter ablations per complete four-rep screen cell."""
import collections
import csv
from pathlib import Path
import statistics as stat
from analyze import quantile

ROOT = Path(__file__).resolve().parent
P = 'Pa_unified_prepared_t16777216'
F = 'Pa_unified_fixed_t16777216'
L = 'Pa_unified_preload_t16777216'
C = 'Pa_unified_backend_t16777216'
NAMES = ('Pa', P, F, L, C, 'L_frozen', 'stable_msd', 'Pa')
RATIOS = ((F,P),(L,P),(C,P),(C,F),(C,L),(F,'stable_msd'),(L,'stable_msd'),(C,'stable_msd'))
LABEL = {P:'prepared',F:'fixed',L:'preload',C:'combined','stable_msd':'Stable','Pa':'Pa','L_frozen':'L_frozen'}
results=[]
for path in sorted((ROOT/'measurements').glob('screen-*.csv')):
    cells=collections.defaultdict(dict)
    for row in csv.DictReader(path.open(newline='')):
        key=tuple(row[k] for k in ('n','block','seed','layout','case'))
        pos=int(row['rep']),int(row['slot'])
        assert row['kind']=='time' and row['instrumented']=='false', path
        assert row['method']==NAMES[pos[1]] and pos not in cells[key], (path,key,pos)
        cells[key][pos]=row
    for key,rows in sorted(cells.items()):
        assert set(rows)=={(r,s) for r in range(4) for s in range(8)}, (path,key)
        out={'file':path.name,**dict(zip(('n','block','seed','layout','case'),key))}
        times={name:[int(rows[r,s]['wall_ns']) for r in range(4)] for s,name in enumerate(NAMES) if name!='Pa'}
        cpus={name:[int(rows[r,s]['cpu_ns']) for r in range(4)] for s,name in enumerate(NAMES) if name!='Pa'}
        times['Pa']=[stat.mean(int(rows[r,s]['wall_ns']) for s in (0,7)) for r in range(4)]
        for name,values in times.items(): out[LABEL[name]+'_ms']=stat.median(values)/1e6
        for numerator,denominator in RATIOS:
            prefix=LABEL[numerator]+'_over_'+LABEL[denominator]
            ratios=[a/b for a,b in zip(times[numerator],times[denominator])]
            out[prefix]=stat.median(ratios)
            out[prefix+'_p10']=quantile(ratios,.1)
            out[prefix+'_p90']=quantile(ratios,.9)
            out[prefix+'_slower']=sum(x>1 for x in ratios)
            out[prefix+'_cpu']=stat.median(a/b for a,b in zip(cpus[numerator],cpus[denominator]))
        aa=[int(rows[r,7]['wall_ns'])/int(rows[r,0]['wall_ns']) for r in range(4)]
        out['Pa_aa_p10']=quantile(aa,.1)
        out['Pa_aa_p90']=quantile(aa,.9)
        results.append(out)
if results:
    with (ROOT/'review-screen.csv').open('w',newline='') as stream:
        writer=csv.DictWriter(stream,fieldnames=results[0].keys())
        writer.writeheader()
        writer.writerows(results)
print(len(results),'complete screen cells')
