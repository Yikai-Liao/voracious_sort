#!/usr/bin/env python3
"""Case medians with within-binary standard-library and submitted LSD controls."""
import csv,sys,statistics,collections
rows=collections.defaultdict(list)
for path in sys.argv[1:]:
 with open(path,newline='') as f:
  for r in csv.DictReader(f):
   key=(r['type'],r['load'],int(r['n']),int(r['block']))
   rows[(key,r['algorithm'])].append(r)
med={k:statistics.median(int(r['ns']) for r in v) for k,v in rows.items()}
out=csv.writer(sys.stdout,lineterminator='\n')
controls=['local_free','stable_fixed','std_stable','block_lsd','block_lsd512']
out.writerow(['type','load','n','block','algorithm','samples','median_ns','p25_ns','p75_ns']+['ratio_'+c for c in controls]+['peak_heap','method_block']+['work'+str(i) for i in range(1,12)])
for (case,method),values in sorted(rows.items()):
 times=sorted(int(r['ns']) for r in values)
 q=statistics.quantiles(times,n=4,method='inclusive') if len(times)>1 else [times[0]]*3
 m=med[case,method]
 for field in ['peak_heap','method_block']+['work'+str(i) for i in range(1,12)]:
  assert len({r[field] for r in values})==1,((case,method),field)
 if method=='gate_R4':assert int(values[0]['work1'])<=4*int(values[0]['work2'])<=4*case[2]
 if method in ('gate_potential4','gate_carried','mono_gate_carried','hybrid','hybrid_mono'):
  n=case[2];chunks=(n-1)//128+1
  psi=0 if n<=128 else n*(1+(chunks-1).bit_length())
  assert int(values[0]['work1'])<=4*int(values[0]['work6'])<=4*psi
 if method in ('minority_single','deferred_chain'):assert int(values[0]['work5'])<=262144
 if method=='joint512':assert int(values[0]['work4'])<=524288
 if method=='reverse_unique':raise AssertionError('load used as method')
 out.writerow(list(case)+[method,len(times),m,q[0],q[2]]+[m/med[case,c] for c in controls]+[values[0]['peak_heap'],values[0]['method_block']]+[values[0]['work'+str(i)] for i in range(1,12)])
