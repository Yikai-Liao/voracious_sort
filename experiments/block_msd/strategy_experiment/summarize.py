#!/usr/bin/env python3
import csv,collections,math,sys
rows=list(csv.DictReader(open(sys.argv[1] if len(sys.argv)>1 else 'strategy_experiment/comparison.csv')))
by={(r['type'],r['load'],r['n'],r['block'],r['algorithm']):r for r in rows}
controls={'local_free':'full_scan','local_prefix':'local_free','carried':'full_scan','leaf_batch':'full_scan','joint0':'full_scan','joint512':'joint0','gate_R4':'local_free','gate_potential4':'local_free','minority_single':'full_scan','deferred_chain':'minority_single','ordinary':'full_scan','stable_fixed':'full_scan'}
out=csv.writer(sys.stdout,lineterminator="\n");out.writerow(['scope','algorithm','control','cases','geomean_ratio','faster_5pct','within_5pct','slower_5pct','max_ratio'])
for scope in ['all140','nonordered100','large_nonordered75','million_nonordered25']:
 for method,control in controls.items():
  ratios=[]
  for r in rows:
   if r['algorithm']!=method:continue
   if scope!='all140' and r['load'] in ('sorted','descending'):continue
   if scope=='large_nonordered75' and int(r['n'])<16384:continue
   if scope=='million_nonordered25' and int(r['n'])!=1048576:continue
   key=(r['type'],r['load'],r['n'],r['block'],control)
   ratios.append(float(r['median_ns'])/float(by[key]['median_ns']))
  out.writerow([scope,method,control,len(ratios),math.exp(sum(map(math.log,ratios))/len(ratios)),sum(v<.95 for v in ratios),sum(.95<=v<=1.05 for v in ratios),sum(v>1.05 for v in ratios),max(ratios)])
