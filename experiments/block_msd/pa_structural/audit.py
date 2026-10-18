#!/usr/bin/env python3
"""Recheck raw row order, allocations, metadata and independently derive ratios."""
import argparse,collections,csv,json,statistics as stats
from pathlib import Path
ROOT=Path(__file__).resolve().parent
BASE='Pa_unified_groups_t16777216'
def percentile(xs,p):
    xs=sorted(xs);x=(len(xs)-1)*p;i=int(x)
    return xs[i]+(x-i)*(xs[min(i+1,len(xs)-1)]-xs[i])
def audit(prefix,candidate,expected):
    cells={}; hashes=set();total=0
    for path in sorted((ROOT/'measurements').glob(prefix+'*.csv')):
        meta=json.loads(path.with_suffix('.json').read_text())
        assert meta['returncode']==0 and meta['args']['kind']=='time'
        assert path.with_suffix('.stderr').stat().st_size==0
        hashes.add(meta['frozen']['sha256'])
        methods=meta['args']['methods'].split(',');reps=meta['args']['reps'];m=len(methods)
        groups=collections.defaultdict(list)
        for r in csv.DictReader(path.open()):
            key=tuple(r[k] for k in ('layout','case','n','block','seed'));groups[key].append(r)
            assert r['kind']=='time' and r['instrumented']=='false'
            assert int(r['wall_ns'])>0 and int(r['cpu_ns'])>0
        for key,rows in groups.items():
            assert key not in cells and len(rows)==reps*m
            assert len(set(r['input_address'] for r in rows))==1
            samples=collections.defaultdict(lambda:collections.defaultdict(list));slots=collections.defaultdict(list)
            for index,r in enumerate(rows):
                rep,j=divmod(index,m)
                slot=(j+rep//2)%m if rep%2==0 else (m-1-j+rep//2)%m
                assert int(r['rep'])==rep and int(r['slot'])==slot and r['method']==methods[slot]
                samples[r['method']][rep].append(int(r['wall_ns']))
                slots[r['method']].append((rep,slot,int(r['wall_ns'])))
            times={name:[stats.mean(rounds[r]) for r in range(reps)] for name,rounds in samples.items()}
            result={'source':path.name,'candidate_ms':stats.median(times[candidate])/1e6}
            for name,ts in times.items():
                ratios=[a/b for a,b in zip(times[candidate],ts)]
                result[name]={'median':stats.median(ratios),'p10':percentile(ratios,.1),'p90':percentile(ratios,.9),'slower':sum(x>1 for x in ratios),'ms':stats.median(ts)/1e6}
                positions=[i for i,v in enumerate(methods) if v==name]
                if len(positions)==2:
                    aa=[]
                    for rep in range(reps):
                        byslot={s:t for r,s,t in slots[name] if r==rep}
                        aa.append(byslot[positions[1]]/byslot[positions[0]])
                    result[name]['aa']={'median':stats.median(aa),'p10':percentile(aa,.1),'p90':percentile(aa,.9)}
            cells[key]=result;total+=len(rows)
    assert len(hashes)==1
    if expected is not None:assert len(cells)==expected,(len(cells),expected)
    if expected==103:
        historical=set()
        previous=ROOT.parent/'pa_order_branch_final/comparisons/measurements'
        for path in previous.glob('final-*.csv'):
            for row in csv.DictReader(path.open()):historical.add(tuple(row[k] for k in ('layout','case','n','block','seed')))
        assert set(cells)==historical,'input matrix differs from original 103 cells'
    names=sorted(set(name for r in cells.values() for name in r if isinstance(r[name],dict)))
    comparisons={name:{'median_wins':sum(r[name]['median']<1 for r in cells.values() if name in r),'p90_wins':sum(r[name]['p90']<1 for r in cells.values() if name in r),'p10_losses':sum(r[name]['p10']>1 for r in cells.values() if name in r)} for name in names if name!=candidate}
    regressions=[dict(cell=key,**r[BASE]) for key,r in cells.items() if BASE in r and r[BASE]['median']>1.05 and r[BASE]['p10']>1]
    report={'candidate':candidate,'elf_sha256':next(iter(hashes)),'cells':len(cells),'rows':total,'comparisons':comparisons,'regression_signals':regressions,'results':[dict(cell=key,**r) for key,r in cells.items()]}
    (ROOT/(prefix+'audit.json')).write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k!='results'},indent=2))
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('prefix');p.add_argument('--candidate',default='Pa_packed');p.add_argument('--cells',type=int);a=p.parse_args();audit(a.prefix,a.candidate,a.cells)
