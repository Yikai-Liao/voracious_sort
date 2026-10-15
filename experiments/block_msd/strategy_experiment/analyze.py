#!/usr/bin/env python3
"""Summarize paired case medians; raw samples remain the source of truth."""
import csv,sys,statistics,collections,math
rows=collections.defaultdict(list)
for path in sys.argv[1:]:
 with open(path,newline='') as f:
  for r in csv.DictReader(f):
   key=(r['type'],r['load'],int(r['n']),int(r['block']))
   rows[(key,r['algorithm'])].append(r)
med={k:statistics.median(int(r['ns']) for r in v) for k,v in rows.items()}
out=csv.writer(sys.stdout,lineterminator="\n")
out.writerow(['type','load','n','block','algorithm','samples','median_ns','p25_ns','p75_ns','ratio_full','ratio_local','ratio_stable','peak_heap']+['work'+str(i) for i in range(1,9)])
for (case,method),values in sorted(rows.items()):
 times=sorted(int(r['ns']) for r in values)
 q=statistics.quantiles(times,n=4,method='inclusive') if len(times)>1 else [times[0]]*3
 m=med[case,method]
 assert len({r['peak_heap'] for r in values})==1
 for i in range(1,9):assert len({r['work'+str(i)] for r in values})==1
 if method=='gate_R4':
  assert int(values[0]['work1'])<=4*int(values[0]['work2'])<=4*case[2]
 if method=='gate_potential4':
  n=case[2];chunks=(n-1)//128+1
  root_potential=0 if n<=128 else n*(1+(chunks-1).bit_length())
  assert int(values[0]['work1'])<=4*int(values[0]['work6'])<=4*root_potential
 if method in ('minority_single','deferred_chain'):assert int(values[0]['work5'])<=262144
 if method=='joint512':assert int(values[0]['work4'])<=524288
 out.writerow(list(case)+[method,len(times),m,q[0],q[2],m/med[case,'full_scan'],m/med[case,'local_free'],m/med[case,'stable_fixed'],values[0]['peak_heap']]+[values[0]['work'+str(i)] for i in range(1,9)])
