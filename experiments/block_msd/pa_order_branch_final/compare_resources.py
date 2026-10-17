#!/usr/bin/env python3
"""Require all work/allocation fields to match frozen pre-outline resources."""
from pathlib import Path
import csv
ROOT=Path(__file__).resolve().parent
OLD=ROOT.parent/'pa_groups_final'
EXCLUDE={'wall_ns','cpu_ns','input_address','order_records'}
KEY=('layout','case','n','record_bytes','seed','block','method','slot','rep','kind','instrumented')
total=0
for path in sorted((ROOT/'measurements').glob('*.csv')):
    if not path.name.startswith(('work-','heap-')):
        continue
    old=list(csv.DictReader((OLD/'measurements'/path.name).open()))
    new=list(csv.DictReader(path.open()))
    assert old and len(old)==len(new),(path,len(old),len(new))
    before={tuple(row[k] for k in KEY):row for row in old}
    after={tuple(row[k] for k in KEY):row for row in new}
    assert len(before)==len(old) and len(after)==len(new)
    assert before.keys()==after.keys(),path
    for key,row in after.items():
        assert row.keys()==before[key].keys(),(path,key)
        for field in row.keys()-EXCLUDE:
            assert row[field]==before[key][field],(path,key,field,row[field],before[key][field])
        previous=int(before[key]['order_records']); actual=int(row['order_records'])
        if actual != previous:
            assert row['kind']=='work' and row['layout'] in ('u128','wide32'),(path,key)
            assert row['method'] in ('Pa_unified_prepared_t16777216','Pa_unified_groups_t16777216'),(path,key)
            assert 0 <= previous-actual <= 2*127*int(row['nodes']),(path,key,previous,actual)
    total+=len(new)
assert total==572,total
print(total,'resource rows: all work/label/compact/heap fields match frozen pre-outline except bounded decrease of wide ordered-proof key reads')
