#!/usr/bin/env python3
import argparse
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parent
SKIP={'.git','.venv','target','__pycache__'}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def files():
    return sorted(p for p in ROOT.rglob('*') if p.is_file()
                  and not SKIP.intersection(p.relative_to(ROOT).parts)
                  and p.name!='SHA256SUMS')


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--verify',action='store_true');args=parser.parse_args()
    if args.verify:
        expected=dict(line.split('  ',1)[::-1] for line in (ROOT/'SHA256SUMS').read_text().splitlines())
        assert set(expected)=={str(p.relative_to(ROOT)) for p in files()}
        assert all(sha(ROOT/name)==digest for name,digest in expected.items())
        print(f'PASS: {len(expected)} sealed files, exact member set and SHA-256')
        return
    assert not (ROOT/'SHA256SUMS').exists(), 'Already sealed'
    assert json.loads((ROOT/'FINAL-DECISION.json').read_text())['status']=='rejected_all'
    assert '10 passed; 0 failed' in (ROOT/'final-tests.log').read_text()
    for manifest in ROOT.glob('*/manifest.json'):
        record=json.loads(manifest.read_text())
        for name,digest in record['files'].items():
            assert sha(manifest.parent/name)==digest, (manifest,name)
    counts={}
    for stage in ['prefix-reuse','single-displaced','prefix-confirmation','prefix-exit-index']:
        counts[stage]={}
        for mode in ['time','memory']:
            rows=[json.loads(x) for x in (ROOT/stage/f'{mode}.jsonl').read_text().splitlines()]
            assert all(r['valid'] and r['ordered'] and r['preserved'] for r in rows)
            if mode=='memory':
                assert all(r['peak_bytes']<=512*r['block']*r['bytes_per_record']+9*(r['n']//r['block'])+66*256 for r in rows)
            counts[stage][mode]=len(rows)
    (ROOT/'SEAL.json').write_text(json.dumps(dict(decision='All candidates rejected; original code restored',
        observations=counts,all_retained_full_outputs_valid=True,
        all_retained_memory_bounds_pass=True,
        partial_campaigns_explicitly_rejected=['single-displaced','prefix-confirmation'],
        exclusions=sorted(SKIP)),indent=2)+'\n')
    (ROOT/'SHA256SUMS').write_text(''.join(f'{sha(p)}  {p.relative_to(ROOT)}\n' for p in files()))
    print(f'Sealed {len(files())} files')


if __name__=='__main__':main()
