import collections,csv,json,math,statistics,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent
S=statistics.median

def write(p,rows):
 if not rows:return
 with p.open('w') as f:
  w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
def load(stage):
 g=collections.defaultdict(dict)
 for l in (stage/'time.jsonl').read_text().splitlines():
  r=json.loads(l);g[r['kind'],r['dist'],r['n']][r['algorithm'],r['pair'],r['order']]=r
 return g

def baseline():
 stage=ROOT/(sys.argv[1] if len(sys.argv)>1 else 'auto-baseline');g=load(stage)
 old=Path('/root/code/voracious_sort-workspaces/benchmarks/block-lsd-pr-20261018')
 refs=json.loads((old.parent/'block-lsd-pr-20261018-story/validation/data/reference-input-digests.json').read_text())
 summary={}
 for r in csv.DictReader((old/'data/summary.csv').open()):
  if r['algorithm'] in ['lsd','std','timsort']:
   summary[r['kind'],r['dist'],int(r['n']),r['algorithm']]=r
 for r in csv.DictReader((old.parent/'block-lsd-pr-20261018-story/data/validated-policy-conditions.csv').open()):summary[r['kind'],r['dist'],int(r['n']),'block_auto']=r
 results=[];strict=[]
 for c,rows in g.items():
  for r in rows.values():
   key='|'.join(map(str,(*c,r['pair'])))
   assert r['input_digest']==int(refs[key]),key
  times={a:[r['ns'] for (aa,p,o),r in rows.items() if aa==a] for a in ['pa','pa_aa','pa_strict']}
  if any(len(t)!=6 for t in times.values()):continue
  aa=[rows['pa_aa',p,o]['ns']/rows['pa',p,o]['ns'] for p in range(3) for o in range(2)]
  ratios=[rows['pa_strict',p,o]['ns']/rows['pa',p,o]['ns'] for p in range(3) for o in range(2)]
  strict.append(dict(kind=c[0],dist=c[1],n=c[2],ratio=S(ratios),min=min(ratios),max=max(ratios),aa_min=min(aa),aa_max=max(aa)))
  for a in ['block_auto','lsd','std','timsort']:
   ref=summary.get((*c,a))
   if ref:
    med=S(times['pa']);r=dict(kind=c[0],dist=c[1],n=c[2],comparator=a,pa_ns=med,reference_ns=float(ref['median_ns']),cross_campaign_ratio=med/float(ref['median_ns']),reference_stable=ref.get('full_stable_output_matches','True'),pa_aa_min=min(aa),pa_aa_max=max(aa))
    results.append(r)
 write(stage/'reuse-comparison.csv',results);write(stage/'strict-paired.csv',strict)
 print('complete PA cells:',len(g))
 for a in ['block_auto','lsd','std','timsort']:
  sel=[r for r in results if r['n']==1048576 and r['comparator']==a and r['reference_stable']=='True']
  print(a,'1M cells',len(sel),'median faster',sum(r['cross_campaign_ratio']<1 for r in sel),'1.5x slower',sum(r['cross_campaign_ratio']>1.5 for r in sel))
  for r in sorted(sel,key=lambda r:r['cross_campaign_ratio'],reverse=True)[:8]:print(r['kind'],r['dist'],round(r['pa_ns']/1e6,3),round(r['reference_ns']/1e6,3),round(r['cross_campaign_ratio'],3))
 print('strict worst',sorted(strict,key=lambda r:r['ratio'],reverse=True)[:8])
if __name__=='__main__':baseline()
