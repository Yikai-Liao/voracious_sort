#!/usr/bin/env python3
"""Move a successful isolated sanitizer executable, then reclaim only its cache."""
from pathlib import Path
import hashlib,json,os,shutil,sys
ROOT=Path(__file__).resolve().parent
REPO=ROOT.parents[2]
source,kind=sys.argv[1:]
records=[json.loads(s) for s in Path(source).read_text().splitlines() if s.startswith('{')]
if kind=='asan-tests':
    candidates=[r['executable'] for r in records if r.get('reason')=='compiler-artifact' and r.get('executable') and r.get('profile',{}).get('test') and r.get('target',{}).get('kind')==['lib']]
else:
    assert kind=='asan-time'
    candidates=[r['executable'] for r in records if r.get('reason')=='compiler-artifact' and r.get('executable') and r.get('target',{}).get('name')=='frontier_experiment' and not r.get('profile',{}).get('test')]
assert len(candidates)==1,candidates
src=Path(candidates[0]);dest=REPO/'experiments/block_msd/target/pa-outline-final'/kind
assert not dest.exists(),dest
size=src.stat().st_size;digest=hashlib.sha256(src.read_bytes()).hexdigest()
src.replace(dest)
assert dest.stat().st_size==size and hashlib.sha256(dest.read_bytes()).hexdigest()==digest
with (ROOT/'binary-sha256.txt').open('a') as f:
    f.write(digest+'  '+str(dest.relative_to(REPO))+'\n')
cache=REPO/'experiments/block_msd/target/pa-outline-asan'
assert cache.is_dir() and not cache.is_symlink()
ledgers=list((REPO/'experiments/block_msd').glob('**/*sha256*.txt'))
for ledger in ledgers:
    assert 'target/pa-outline-asan/' not in ledger.read_text(),ledger
logical=sum(x.stat().st_size for x in cache.rglob('*') if x.is_file())
shutil.rmtree(cache)
assert hashlib.sha256(dest.read_bytes()).hexdigest()==digest
v=os.statvfs('/')
record={'artifact':str(dest.relative_to(REPO)),'bytes':size,'sha256':digest,'compiler_artifact':candidates[0],'reclaimed_isolated_cache':str(cache.relative_to(REPO)),'reclaimed_logical_bytes':logical,'hash_ledgers_checked':len(ledgers),'root_free_bytes_after':v.f_bfree*v.f_frsize}
(ROOT/'validation'/('archive-'+kind+'.json')).write_text(json.dumps(record,indent=2)+'\n')
print(kind,size,digest,'rootfree',record['root_free_bytes_after'])
