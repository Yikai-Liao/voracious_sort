import collections,csv,json,math,statistics,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent
S=statistics.median
stage=ROOT/sys.argv[1]
g=collections.defaultdict(dict)
for line in (stage/'time.jsonl').read_text().splitlines():
 r=json.loads(line);g[r['kind'],r['dist'],r['n']][r['algorithm'],r['pair'],r['order']]=r
methods=json.loads((stage/'manifest.json').read_text())['methods']
results=[]
for c,rows in g.items():
 seeds=1+max(key[1] for key in rows)
 if len(rows)!=len(methods)*seeds*2:continue
 aa=[rows['pa_aa',p,o]['ns']/rows['pa',p,o]['ns'] for p in range(seeds) for o in range(2)]
 envelope=max(max(aa),1/min(aa))
 for a in methods:
  if a in ['pa','pa_aa']:continue
  ratios=[rows[a,p,o]['ns']/rows['pa',p,o]['ns'] for p in range(seeds) for o in range(2)]
  results.append(dict(kind=c[0],dist=c[1],n=c[2],method=a,paired_median=S(ratios),min=min(ratios),max=max(ratios),aa_min=min(aa),aa_max=max(aa),aa_envelope=envelope,regression_over_5pct=S(ratios)>1.05,loss_beyond_observed_aa=S(ratios)>1.05 and min(ratios)>envelope,pa_ns=S([rows['pa',p,o]['ns'] for p in range(seeds) for o in range(2)]),candidate_ns=S([rows[a,p,o]['ns'] for p in range(seeds) for o in range(2)])))
if results:
 with (stage/'comparison.csv').open('w') as f:
  w=csv.DictWriter(f,fieldnames=list(results[0]));w.writeheader();w.writerows(results)
print('cells',len(g),'rows',sum(len(r) for r in g.values()))
for a in methods:
 if a in ['pa','pa_aa']:continue
 rs=[r for r in results if r['method']==a]
 print(a,'wins',sum(r['paired_median']<1 for r in rs),'/',len(rs),'over5pct',sum(r['regression_over_5pct'] for r in rs),'all pairs beyond AA',sum(r['loss_beyond_observed_aa'] for r in rs))
 print('WORST')
 for r in sorted(rs,key=lambda r:r['paired_median'],reverse=True)[:10]:print(r)
 print('BEST')
 for r in sorted(rs,key=lambda r:r['paired_median'])[:6]:print(r)
