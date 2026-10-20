#!/usr/bin/env python3
"""Summarize independent pinned runs, retaining scaling and serial references."""
import argparse, csv, statistics
from collections import defaultdict
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory',type=Path);p.add_argument('--csv',type=Path,required=True);a=p.parse_args()
groups=defaultdict(list)
for file in sorted(a.directory.glob('*-p*.csv')):
    for row in csv.DictReader(file.open()):
        assert row['status']=='ok', (file,row)
        groups[(row['layout'],int(row['n']),row['distribution'],row['algorithm'],int(row['threads']))].append(int(row['ns']))
medians={key:statistics.median(values) for key,values in groups.items()}
fields=['layout','n','distribution','algorithm','threads','samples','median_ms','min_ms','max_ms','t1_ms','speedup_t1','efficiency_percent','speedup_serial_block','speedup_serial_lsd','speedup_c_permuted']
with a.csv.open('w') as f:
    out=csv.DictWriter(f,fieldnames=fields);out.writeheader()
    for key in sorted(groups):
        layout,n,load,method,threads=key;ns=medians[key];values=groups[key]
        t1=medians.get((layout,n,load,method,1))
        row=dict(layout=layout,n=n,distribution=load,algorithm=method,threads=threads,samples=len(values),median_ms=ns/1e6,min_ms=min(values)/1e6,max_ms=max(values)/1e6,t1_ms='' if t1 is None else t1/1e6,speedup_t1='' if t1 is None else t1/ns,efficiency_percent='' if t1 is None else t1/ns/threads*100)
        for serial,column in [('serial_block','speedup_serial_block'),('serial_lsd','speedup_serial_lsd'),('c_permuted','speedup_c_permuted')]:
            ref=medians.get((layout,n,load,serial,1));row[column]='' if ref is None else ref/ns
        out.writerow(row)
print('| Layout | n | Load | Algorithm | Threads | Median ms | T1/Tp | Efficiency |')
print('|---|---:|---|---|---:|---:|---:|---:|')
for key in sorted(groups):
    layout,n,load,method,threads=key
    if method not in ('rayon_block','c_parallel') or load!='uniform':continue
    t1=medians[(layout,n,load,method,1)];ns=medians[key]
    print(f'| {layout} | {n:,} | {load} | {method} | {threads} | {ns/1e6:.3f} | {t1/ns:.2f} | {t1/ns/threads*100:.1f}% |')
print('\n16 threads use SMT on this 8-core machine; thread efficiency divides by 16.')
