#!/usr/bin/env python3
"""Whole-sort work/space invariants for combinations and lifetime admission."""
import csv
import os
from pathlib import Path

ROOT=Path(os.environ.get("MSD_REDUCTION_OUT",str(Path(__file__).resolve().parent)))
KEY=('type','load','n','block')
WIDTH={'u32':4,'u64':8,'u128':16,'wide32':32,'large128':128}


def load(pattern):
    data={}
    for path in ROOT.glob(pattern):
        for r in csv.DictReader(path.open()):
            if 'sample' in r and r['sample']!='0':continue
            key=tuple(r[k] for k in KEY)+(r['algorithm'],)
            assert key not in data,key
            data[key]=r
    return data


def main():
    native=load('combined-*.csv');diag=load('phase2-diagnostics-*.csv')
    cases=sorted({k[:-1] for k in native});assert len(cases)==200
    effects=[]
    for key in cases:
        get=lambda data,name:data[key+(name,)]
        a=get(native,'cached_two_arrays');b=get(native,'cycle_placement');b2=get(native,'scratch_path_cycles');ab=get(native,'two_arrays_scratch_paths')
        for field in [f'work{i}' for i in range(1,12)]+['allocations','requested_heap','peak_heap']:
            assert b[field]==b2[field],(key,field)
        for field in [f'work{i}' for i in range(1,9)]+['allocations','requested_heap','peak_heap']:
            assert a[field]==get(native,'admission_control')[field],(key,field)
        for field in ['ordered_records','ordered_writes','variation_records','histogram_records','histogram_slots','metadata_allocations','metadata_bytes','scatter_records','tail_save_records','placement_writes','copyback_records','leaf_records','leaf_lengths','cached_depth_records']:
            assert get(diag,'cycle_placement')[field]==get(diag,'scratch_path_cycles')[field],(key,field)
        db=get(diag,'scratch_path_cycles');dab=get(diag,'two_arrays_scratch_paths')
        for field in ['ordered_records','ordered_writes','variation_records','histogram_records','scatter_records','tail_save_records','placement_writes','copyback_records','leaf_records','leaf_lengths','cached_depth_records']:
            assert db[field]==dab[field],(key,field)
        assert int(b2['allocations'])-int(ab['allocations'])==int(db['metadata_allocations'])-int(dab['metadata_allocations']),key
        assert int(b2['requested_heap'])-int(ab['requested_heap'])==int(db['metadata_bytes'])-int(dab['metadata_bytes']),key
        assert int(ab['peak_heap'])<=int(get(native,'local_free')['peak_heap']),key
        old=get(native,'admission_control');new=get(native,'live_admission')
        assert int(new['work10'])<=262144,key
        if new['work11']=='1':
            assert int(new['n'])*WIDTH[new['type']]+int(new['peak_heap'])<=262144,(key,'root working set')
        changes={field:int(new[field])-int(old[field]) for field in ['peak_heap','allocations','requested_heap','work1','work2','work3','work4','work5']}
        row=dict(zip(KEY,key));row.update(changes)
        row.update(old_root_cached=int(old['work11']),new_root_cached=int(new['work11']),max_cache_working_set=int(new['work10']))
        effects.append(row)
    with (ROOT/'admission-effects.csv').open('w',newline='') as out:
        writer=csv.DictWriter(out,fieldnames=list(effects[0]),lineterminator='\n');writer.writeheader();writer.writerows(effects)
    changed=sum(any(r[f'work{i}']!=0 for i in range(1,6)) for r in effects)
    print(f'PASS: {len(cases)} cases; B1/B2 exact moves and heap; two-array deltas; admission control exact work; all admitted estimates and empirical root working sets within 256 KiB')
    print(f'Admission changes whole-tree work in {changed} cases; largest peak-heap increase {max(r["peak_heap"] for r in effects)} bytes; largest decrease {-min(r["peak_heap"] for r in effects)} bytes')
    bounds=load('phase2-cache-*.csv')
    for key,row in bounds.items():
        if key[-1]=='live_admission' and row['work11']=='1':
            assert int(row['n'])*WIDTH[row['type']]+int(row['peak_heap'])<=262144,key
    print(f'PASS: {len(bounds)} boundary case/method measurements; empirical root working-set checks')


if __name__=='__main__':main()
