"""Join existing full-parameter candidate results to native radix observations."""
from pathlib import Path
import csv, json, math, statistics, hashlib
from collections import defaultdict
ROOT=Path(__file__).resolve().parent
STORY=ROOT.parent/'benchmarks/block-lsd-pr-20261018-story'
BASE=ROOT.parent/'benchmarks/block-lsd-pr-20261018'
METHODS=['lsd_plain','lsd_core','lsd_heuristic','dlsd','thiel','dedicated']
def read(p):
 with p.open() as f:return list(csv.DictReader(f))
def write(p,rows):
 with p.open('w',newline='') as f:
  w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
conditions=[r for r in read(STORY/'data/validated-policy-conditions.csv') if int(r['n'])==1048576]
assert len(conditions)==207
reference=json.loads((STORY/'validation/data/reference-input-digests.json').read_text())
raw_times=[r for r in read(BASE/'data/timing.csv') if int(r['n'])==1048576 and r['algorithm'] in METHODS]
raw_mem=[r for r in read(BASE/'data/memory.csv') if int(r['n'])==1048576 and r['algorithm'] in METHODS]
groups=defaultdict(list);mem=defaultdict(list)
for r in raw_times+raw_mem:
 k=f"{r['kind']}|{r['dist']}|{r['n']}|{r['pair']}"
 assert int(r['input_digest'])==int(reference[k]), k
 assert r['ordered']=='True' and r['preserved']=='True'
for r in raw_times:groups[r['kind'],r['dist'],r['algorithm']].append(r)
for r in raw_mem:mem[r['kind'],r['dist'],r['algorithm']].append(r)
paths={'original':STORY/'data/original-timing.csv','expanded':STORY/'data/supplemental-sqrt-timing.csv','prefix':STORY/'validation/data/time.jsonl','missing':STORY/'missing-only/data/time.jsonl'}
source_rows={}
for source in {r['time_source'] for r in conditions}:
 p=paths[source]
 if p.suffix=='.jsonl':source_rows[source]=[json.loads(s) for s in p.read_text().splitlines()]
 else:source_rows[source]=read(p)
candidate_inputs=[]
for c in conditions:
 selected=[r for r in source_rows[c['time_source']] if r['kind']==c['kind'] and r['dist']==c['dist'] and int(r['n'])==1048576 and r['algorithm'].startswith('block') and int(r['block'])==int(c['block'])]
 assert selected
 assert {(int(r['pair']),int(r['order'])) for r in selected}=={(p,o) for p in range(3) for o in range(2)}
 for r in selected:
  k=f"{r['kind']}|{r['dist']}|{r['n']}|{r['pair']}"
  assert int(r['input_digest'])==int(reference[k])
  assert r['valid'] in [True,'True']
  candidate_inputs.append({k:r[k] for k in ['kind','dist','n','algorithm','block','pair','order','seed','input_digest','ns']})
 assert math.isclose(statistics.median(float(r['ns']) for r in selected),float(c['median_ns']),rel_tol=1e-12)
rows=[]
for c in conditions:
 for method in METHODS:
  obs=groups[c['kind'],c['dist'],method]
  if not obs:continue
  allocated=mem[c['kind'],c['dist'],method]
  assert len(obs)==6 and len(allocated)==3
  t=statistics.median(float(r['ns']) for r in obs)
  heap=statistics.median(float(r['peak_bytes']) for r in allocated)
  rows.append(dict(kind=c['kind'],dist=c['dist'],n=c['n'],record_bytes=c['record_bytes'],comparator=method,block=c['block'],candidate_median_ns=c['median_ns'],comparator_median_ns=t,speedup=t/float(c['median_ns']),candidate_peak_bytes=c['median_peak_bytes'],comparator_peak_bytes=heap,comparator_matches_stable_oracle=all(r['valid']=='True' for r in obs+allocated),candidate_source=c['time_source']))
assert len(rows)==1012,len(rows)
write(ROOT/'data/native-comparisons.csv',rows)
write(ROOT/'data/native-time-observations.csv',raw_times)
write(ROOT/'data/native-memory-observations.csv',raw_mem)
write(ROOT/'data/candidate-time-observations.csv',candidate_inputs)
write(ROOT/'data/candidate-conditions.csv',conditions)
provenance={str(p.relative_to(ROOT.parent)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [BASE/'data/timing.csv',BASE/'data/memory.csv',STORY/'data/validated-policy-conditions.csv',*paths.values()]}
(ROOT/'qa/native-input-audit.json').write_text(json.dumps(dict(cases=len(rows),input_digests_match=True,all_keys_ordered=True,all_fingerprints_preserved=True,source_sha256=provenance,metric='comparator median ns / candidate median ns; descriptive, no confidence interval',min_speedup=min(r['speedup'] for r in rows),max_speedup=max(r['speedup'] for r in rows)),indent=2)+'\n')
print(len(rows),min(r['speedup'] for r in rows),max(r['speedup'] for r in rows))
for m in METHODS:
 v=[r for r in rows if r['comparator']==m]
 print(m,len(v),'geomean time ratio',math.exp(statistics.mean(math.log(1/r['speedup']) for r in v)))
