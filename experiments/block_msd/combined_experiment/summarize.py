#!/usr/bin/env python3
import csv,math,sys
rows=list(csv.DictReader(open(sys.argv[1] if len(sys.argv)>1 else 'combined_experiment/comparison.csv')))
by={(r['type'],r['load'],r['n'],r['block'],r['algorithm']):r for r in rows}
original={'uniform','deep_skew','skew95','shared_prefix','almost_sorted'}
scopes={
 'all200':lambda r:True,
 'primary105':lambda r:int(r['n'])>=16384 and r['load'] in original|{'digit_grouped','digit_tail_inversion'},
 'original75':lambda r:int(r['n'])>=16384 and r['load'] in original,
 'digit_targets30':lambda r:int(r['n'])>=16384 and r['load'] in {'digit_grouped','digit_tail_inversion'},
 'reverse_unique20':lambda r:r['load']=='reverse_unique',
 'descending20':lambda r:r['load']=='descending',
}
methods=sorted({r['algorithm'] for r in rows})
paired={'stream_carry_leaf':'local_free','hybrid':'local_free','hybrid_mono':'hybrid'}
out=csv.writer(sys.stdout,lineterminator='\n');out.writerow(['scope','algorithm','control','cases','geomean_ratio','faster_5pct','within_5pct','slower_5pct','max_ratio'])
for scope,include in scopes.items():
 for method in methods:
  for control in dict.fromkeys(['local_free','std_stable','block_lsd','block_lsd512']+([paired[method]] if method in paired else [])):
   if method==control:continue
   ratios=[]
   for r in rows:
    if r['algorithm']!=method or not include(r):continue
    base=by[r['type'],r['load'],r['n'],r['block'],control]
    ratios.append(float(r['median_ns'])/float(base['median_ns']))
   if not ratios:continue
   out.writerow([scope,method,control,len(ratios),math.exp(sum(map(math.log,ratios))/len(ratios)),sum(v<.95 for v in ratios),sum(.95<=v<=1.05 for v in ratios),sum(v>1.05 for v in ratios),max(ratios)])
