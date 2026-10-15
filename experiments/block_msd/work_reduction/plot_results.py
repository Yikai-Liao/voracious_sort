#!/usr/bin/env python3
import csv
import math
import statistics
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.colors import TwoSlopeNorm
import numpy as np

ROOT=Path(__file__).resolve().parent
rows=list(csv.DictReader((ROOT/'phase2-ratios.csv').open()))
loads=['uniform','deep_skew','skew95','shared_prefix','almost_sorted','digit_grouped','digit_tail_inversion']
layouts=['u32','u64','u128','wide32','large128']
scales=[1024,16384,262144,1048576]
methods=[('cached_two_arrays','A: two arrays'),('cycle_placement','B1: paths/cycles'),('two_arrays_scratch_paths','A+B2: two arrays / scratch paths'),('hybrid_prepared_fused','C+D: prepared / fused')]
fig,ax=plt.subplots(figsize=(9.5,5.2),layout='constrained')
for name,label in methods:
 values=[]
 for n in scales:
  xs=[float(r['ratio']) for r in rows if r['algorithm']==name and r['control']=='local_free' and int(r['n'])==n and r['load'] in loads]
  assert len(xs)==35
  values.append(math.exp(statistics.mean(math.log(x) for x in xs)))
 ax.plot(scales,values,marker='o',label=label,linewidth=2 if name.startswith(('two_arrays','hybrid')) else 1.3)
ax.axhline(1,color='#333333',linewidth=1,label='local_free')
ax.set_xscale('log',base=2);ax.set_xticks(scales,[f'{n:,}' for n in scales])
ax.set_ylim(.72,1.08);ax.set_ylabel('Runtime / local_free (geometric mean)');ax.set_xlabel('Records')
ax.set_title('Paired native runtime by input scale\n35 cases per scale: five layouts, seven unordered fixtures',fontsize=12)
ax.grid(axis='y',alpha=.25);ax.legend(fontsize=9,loc='lower right')
fig.savefig(ROOT/'runtime-by-scale.png',dpi=170);fig.savefig(ROOT/'runtime-by-scale.svg');plt.close(fig)
fig,axes=plt.subplots(1,2,figsize=(13.5,4.3),layout='constrained',sharey=True)
for ax,(name,title) in zip(axes,[('two_arrays_scratch_paths','A+B2: two arrays / scratch paths'),('hybrid_prepared_fused','C+D: prepared / fused')]):
 data=np.array([[float(next(r['ratio'] for r in rows if r['algorithm']==name and r['control']=='local_free' and r['n']=='1048576' and r['type']==kind and r['load']==load)) for load in loads] for kind in layouts])
 im=ax.imshow(data,cmap='RdYlGn_r',norm=TwoSlopeNorm(vmin=.65,vcenter=1,vmax=1.35),aspect='auto')
 for i in range(5):
  for j in range(7):ax.text(j,i,f'{(data[i,j]-1)*100:+.1f}%',ha='center',va='center',fontsize=8)
 ax.set_xticks(range(7),['uniform','deep skew','skew95','shared prefix','almost sorted','digit grouped','tail inversion'],rotation=32,ha='right',fontsize=8)
 ax.set_yticks(range(5),layouts);ax.set_title(title,fontsize=11)
fig.suptitle('1,048,576 records: per-case change vs local_free (negative is faster)',fontsize=12)
fig.colorbar(im,ax=axes,shrink=.85,label='Runtime ratio')
fig.savefig(ROOT/'million-case-changes.png',dpi=170);fig.savefig(ROOT/'million-case-changes.svg');plt.close(fig)
for name in ['runtime-by-scale.svg','million-case-changes.svg']:
 path=ROOT/name
 path.write_text('\n'.join(line.rstrip() for line in path.read_text().splitlines()).rstrip()+'\n')
print('Plots generated from phase2 paired medians; matplotlib',matplotlib.__version__)
