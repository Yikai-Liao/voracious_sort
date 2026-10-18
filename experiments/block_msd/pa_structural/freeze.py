#!/usr/bin/env python3
import json
from pathlib import Path
import shutil
import subprocess
import sys
from run import REPO, source_hash, digest
name, features = sys.argv[1:]
source = REPO / 'experiments/block_msd/target/release/frontier_experiment'
target = source.parents[1] / 'pa-structural' / name
target.parent.mkdir(exist_ok=True)
assert not target.exists(), target
shutil.copy2(source, target)
meta = dict(sha256=digest(target), source_sha256=source_hash(), base='745cea6ab21030710cb036f88fa757505ef1990b', rustflags='-C target-cpu=native', features=features, rustc=subprocess.check_output(['/root/.cargo/bin/rustc','-Vv'], text=True))
Path(str(target)+'.json').write_text(json.dumps(meta,indent=2)+'\n')
print(target)
