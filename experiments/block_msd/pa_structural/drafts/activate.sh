#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_structural
while [ ! -f "$p/confirm-summary.csv" ]; do sleep 2; done
taskset -c 0 python3 "$p/audit.py" final- --cells 103
taskset -c 0 python3 "$p/audit.py" confirm- --cells 48
python3 - <<'PY'
from pathlib import Path
import json
p=Path('experiments/block_msd/pa_structural')
r=json.loads((p/'final-audit.json').read_text())
text='\n投影阶段原矩阵已完成：103 cells / '+str(r['rows'])+' timed rows，同一 ELF / 全部 oracle 通过。对照胜出数：'+str(r['comparisons'])+'。实质回退待复测信号：'+str(r['regression_signals'])+'。这些数值仅对应投影阶段；后续集合分类仍须独立筛选。\n'
with (p/'REPORT.md').open('a') as out:out.write(text)
PY
git add "$p"
git commit -m 'Archive full packed PA matrix and reversed paired confirmations'
git tag -a pa-packed-matrix-20261018 -m 'Packed projection: inherited 103-cell matrix plus independent paired confirmations and heap evidence. Generalization candidates remain separate.'
python3 "$p/drafts/apply_keyset.py"
python3 "$p/drafts/clean_failed.py"
/root/.cargo/bin/cargo fmt --manifest-path experiments/block_msd/Cargo.toml > "$p/validation/format-keyset.log" 2>&1
/root/.cargo/bin/cargo check --manifest-path experiments/block_msd/Cargo.toml --locked --offline --jobs 2 --features frontier_work --bin frontier_experiment > "$p/validation/check-keyset.log" 2>&1
