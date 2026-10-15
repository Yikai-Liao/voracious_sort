#!/usr/bin/env python3
"""Cross-check work ledgers against paired native allocation measurements."""
import csv
import os
from pathlib import Path

ROOT=Path(os.environ.get("MSD_REDUCTION_OUT",str(Path(__file__).resolve().parent)))
KEY=('type','load','n','block')


def load(pattern):
    result={}
    for path in ROOT.glob(pattern):
        for row in csv.DictReader(path.open()):
            key=tuple(row[k] for k in KEY)+(row['algorithm'],)
            if 'sample' in row and row['sample']!='0':continue
            assert key not in result,key
            result[key]=row
    return result


def main():
    native=load('normal-*.csv');diag=load('diagnostics-*.csv')
    cases=sorted({key[:-1] for key in native})
    assert len(cases)==200
    for key in cases:
        get=lambda data,name:data[key+(name,)]
        control=get(native,'reduction_control');arrays=get(native,'cached_two_arrays');cycle=get(native,'cycle_placement')
        dc=get(diag,'reduction_control');da=get(diag,'cached_two_arrays');db=get(diag,'cycle_placement')
        for field in ['ordered_records','ordered_writes','variation_records','histogram_records','histogram_slots','scatter_records','tail_save_records','placement_writes','copyback_records','leaf_records','leaf_lengths','cached_depth_records']:
            assert dc[field]==da[field],(key,field)
            if field!='placement_writes':assert dc[field]==db[field],(key,field)
        saved_alloc=int(dc['metadata_allocations'])-int(da['metadata_allocations'])
        saved_bytes=int(dc['metadata_bytes'])-int(da['metadata_bytes'])
        assert int(control['allocations'])-int(arrays['allocations'])==saved_alloc,key
        assert int(control['requested_heap'])-int(arrays['requested_heap'])==saved_bytes,key
        assert int(arrays['peak_heap'])<=int(control['peak_heap']),key
        for field in ['allocations','requested_heap','peak_heap']:
            assert control[field]==cycle[field],(key,field)
        assert int(db['placement_writes'])<=int(dc['placement_writes']),key
        for method,old in [('reduction_control','local_free'),('hybrid_control','hybrid'),('hybrid_independent_mono','hybrid_mono')]:
            for field in [f'work{i}' for i in range(1,12)]:
                assert get(native,method)[field]==get(native,old)[field],(key,method,field)
        hc=get(diag,'hybrid_control');hp=get(diag,'hybrid_prepared')
        diff=int(hc['histogram_records'])-int(hp['histogram_records'])
        assert diff==int(hc['variation_records'])-int(hp['variation_records']),key
        assert 0<=diff<=int(hp['fallback_records']),key
        for field in ['scatter_records','placement_writes','tail_save_records','gather_records','writer_records','leaf_lengths','cached_depth_records']:
            assert hc[field]==hp[field],(key,field)
        hi=get(diag,'hybrid_independent_mono');hf=get(diag,'hybrid_fused_mono')
        assert int(hf['extra_monotone_records'])==0,key
        assert hi['extra_monotone_records']==hi['monotone_records'],key
        for field in ['histogram_records','variation_records','scatter_records','placement_writes','leaf_lengths','cached_depth_records','monotone_records']:
            assert hi[field]==hf[field],(key,field)
    print('PASS: 200 cases; exact control work, array allocation deltas, cycle heap invariance, fallback scan savings and fused traversal ledgers')


if __name__=='__main__':main()
