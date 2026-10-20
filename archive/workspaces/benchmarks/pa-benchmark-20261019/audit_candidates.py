"""Audit frozen candidate timings and references without measuring algorithms."""
import hashlib
import json
import re
import sys
from pathlib import Path

root = Path(__file__).resolve().parent
final = root / sys.argv[1]
allowed = {'pa_interval', 'pa_runs', 'pa_adaptive', 'pa_radix'}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


saved = {}
for line in (root / 'auto-baseline/time.jsonl').read_text().splitlines():
    row = json.loads(line)
    if row['algorithm'] == 'pa':
        saved[row['kind'], row['dist'], row['n'], row['seed'], row['order']] = row

stages = []
for manifest_path in sorted(root.glob('*/manifest.json')):
    stage = manifest_path.parent
    if not (stage / 'time-completion.json').exists():
        continue
    manifest = json.loads(manifest_path.read_text())
    if not set(manifest['methods']) <= allowed:
        continue
    for name, digest in manifest['files'].items():
        assert sha(root / name) == digest, (stage.name, name)
    rows = [json.loads(line) for line in (stage / 'time.jsonl').read_text().splitlines()]
    completion = json.loads((stage / 'time-completion.json').read_text())
    assert len(rows) == completion['rows']
    assert len(rows) == len(manifest['schedule']) * len(manifest['methods']) * 6
    for row in rows:
        assert row['algorithm'] in allowed
        assert row['valid'] and row['ordered'] and row['preserved']
        old = saved[row['kind'], row['dist'], row['n'], row['seed'], row['order']]
        for field in ['input_digest', 'block', 'radix', 'bytes_per_record']:
            assert row[field] == old[field], (stage.name, field)
        if row['batch'] % 2 == old['batch'] % 2:
            assert row['digest'] == old['digest']
    processes = [json.loads(line) for line in (stage / 'time-processes.jsonl').read_text().splitlines()]
    assert len(processes) == len(manifest['schedule'])
    for process in processes:
        assert process['returncode'] == 0
        assert int(re.search(r'VmSwap:\s+(\d+)', process['stderr'])[1]) == 0
    stages.append(dict(stage=stage.name, cells=len(manifest['schedule']), rows=len(rows),
                       seconds=completion['seconds'], files=len(manifest['files'])))

manifest = json.loads((final / 'manifest.json').read_text())
baseline = json.loads((root / 'auto-baseline/manifest.json').read_text())
full_schedule = manifest['schedule'] == baseline['schedule']
if '--require-full' in sys.argv:
    assert full_schedule
else:
    canonical = {(c['kind'], c['dist'], c['n'], c['block']) for c in baseline['schedule']}
    assert all((c['kind'], c['dist'], c['n'], c['block']) in canonical for c in manifest['schedule'])
assert manifest['methods'] == ['pa_radix', 'pa_radix']
source = final / 'harness/source/pa/src/frontier'
worktree = Path('/root/code/voracious_sort-workspaces/block-pa-benchmark-20261019/experiments/block_msd/src/frontier')
for path in source.rglob('*.rs'):
    assert sha(path) == sha(worktree / path.relative_to(source))
for name, digest in json.loads((root / 'reuse-sources.json').read_text()).items():
    assert sha(Path(name)) == digest

result = dict(status='PASS', final_stage=final.name, stages=stages,
              candidate_only_rows=sum(s['rows'] for s in stages),
              final_schedule_matches_saved_1045=full_schedule,
              final_methods=['pa_radix', 'pa_radix'],
              current_frontier_source_matches_frozen=True,
              note='Hash, input/output oracle and resource audit. No algorithms executed.')
(root / 'validation-followup.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({k: v for k, v in result.items() if k != 'stages'}, indent=2))
