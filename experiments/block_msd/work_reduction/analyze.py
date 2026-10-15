#!/usr/bin/env python3
"""Case medians, descriptive dispersion and paired geometric ratios."""
import argparse
import csv
import math
from pathlib import Path
import statistics
from collections import defaultdict

KEY = ('type','load','n','block')
ORIGINAL = {'uniform','deep_skew','skew95','shared_prefix','almost_sorted'}
PRIMARY = ORIGINAL | {'digit_grouped','digit_tail_inversion'}
PAIRS = [('reduction_control','local_free'),('hybrid_control','hybrid'),
         ('hybrid_independent_mono','hybrid_mono'),
         ('cached_two_arrays','reduction_control'),('cycle_placement','reduction_control'),
         ('hybrid_prepared','hybrid_control'),('hybrid_independent_mono','hybrid_control'),
         ('hybrid_fused_mono','hybrid_control'),('hybrid_fused_mono','hybrid_independent_mono'),
         ('two_arrays_cycles','cycle_placement'),('two_arrays_cycles','cached_two_arrays'),
         ('hybrid_prepared_fused','hybrid_prepared'),('hybrid_prepared_fused','hybrid_fused_mono'),
         ('scratch_path_cycles','cycle_placement'),('two_arrays_scratch_paths','cached_two_arrays'),
         ('two_arrays_scratch_paths','scratch_path_cycles'),('two_arrays_scratch_paths','two_arrays_cycles'),
         ('live_admission','admission_control'),('admission_control','cached_two_arrays')]


def write(path, rows):
    with path.open('w',newline='') as out:
        writer=csv.DictWriter(out,fieldnames=list(rows[0]),lineterminator="\n")
        writer.writeheader();writer.writerows(rows)


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('files',nargs='+',type=Path)
    args=parser.parse_args()
    groups=defaultdict(list)
    for path in args.files:
        with path.open(newline='') as inp:
            for row in csv.DictReader(inp):
                key=tuple(row[k] for k in KEY)+(row['algorithm'],)
                groups[key].append(row)
    cases={}
    medians=[]
    for key, samples in sorted(groups.items()):
        assert len({r['sample'] for r in samples})==len(samples),key
        for field in ('peak_heap','allocations','requested_heap','method_block',*[f'work{i}' for i in range(1,12)]):
            assert len({r[field] for r in samples})==1,(key,field)
        ns=[int(r['ns']) for r in samples];median=statistics.median(ns)
        row=dict(zip((*KEY,'algorithm'),key))
        row.update(samples=len(ns),median_ns=median,mad_ns=statistics.median(abs(x-median) for x in ns),min_ns=min(ns),max_ns=max(ns))
        row.update({field:int(samples[0][field]) for field in ('peak_heap','allocations','requested_heap','method_block',*[f'work{i}' for i in range(1,12)])})
        cases[key]=row;medians.append(row)
    methods=sorted({key[-1] for key in cases})
    pairs=list(dict.fromkeys([(m,'local_free') for m in methods if m!='local_free']+PAIRS))
    ratios=[]
    for method, control in pairs:
        for key,row in cases.items():
            if key[-1]!=method or key[:-1]+(control,) not in cases:continue
            base=cases[key[:-1]+(control,)]
            result={k:row[k] for k in KEY};result.update(algorithm=method,control=control,
                ratio=row['median_ns']/base['median_ns'],median_ns=row['median_ns'],control_ns=base['median_ns'],
                peak_heap=row['peak_heap'],control_heap=base['peak_heap'])
            ratios.append(result)
    summaries=[]
    for method,control in pairs:
        paired=[r for r in ratios if r['algorithm']==method and r['control']==control]
        for scope,allowed in [('all',None),('primary105',PRIMARY),('original75',ORIGINAL)]:
            selected=[r for r in paired if allowed is None or (r['load'] in allowed and int(r['n'])>=16384)]
            if not selected:continue
            splits=[('all','all',selected)]
            for dim in ('type','load','n'):
                for value in sorted({r[dim] for r in selected}):
                    splits.append((dim,value,[r for r in selected if r[dim]==value]))
            for dim,value,rows in splits:
                values=[r['ratio'] for r in rows]
                summaries.append(dict(algorithm=method,control=control,scope=scope,dimension=dim,value=value,
                    cases=len(values),geomean=math.exp(statistics.mean(math.log(x) for x in values)),
                    win_gt5=sum(x<.95 for x in values),within5=sum(.95<=x<=1.05 for x in values),lose_gt5=sum(x>1.05 for x in values),
                    worst_ratio=max(values),best_ratio=min(values)))
    write(Path(str(args.output)+'-medians.csv'),medians)
    write(Path(str(args.output)+'-ratios.csv'),ratios)
    write(Path(str(args.output)+'-summary.csv'),summaries)
    print(f'{args.output}: {len(medians)} case/method medians; {len(ratios)} paired ratios')
    for row in summaries:
        if row['scope']=='primary105' and row['dimension']=='all':
            print(f"{row['algorithm']}/{row['control']}: {row['geomean']:.4f}; {row['win_gt5']}/{row['within5']}/{row['lose_gt5']}")


if __name__=='__main__':main()
