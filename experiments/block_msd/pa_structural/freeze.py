#!/usr/bin/env python3
import argparse
import json
from pathlib import Path
import shutil
import subprocess
from run import REPO, source_hash, digest
p=argparse.ArgumentParser()
p.add_argument('name');p.add_argument('features')
p.add_argument('--source',default='experiments/block_msd/target/release/frontier_experiment')
p.add_argument('--rustflags',default='-C target-cpu=native')
p.add_argument('--profile',default='release')
a=p.parse_args()
source=REPO/a.source
target=REPO/'experiments/block_msd/target/pa-structural'/a.name
target.parent.mkdir(exist_ok=True)
assert not target.exists(),target
shutil.copy2(source,target)
meta=dict(source_hash_version=2,source_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=REPO,text=True).strip(),sha256=digest(target),source_sha256=source_hash(),base='745cea6ab21030710cb036f88fa757505ef1990b',rustflags=a.rustflags,features=a.features,profile=a.profile,rustc=subprocess.check_output(['/root/.cargo/bin/rustc','-Vv'],text=True))
Path(str(target)+'.json').write_text(json.dumps(meta,indent=2)+'\n')
print(target)
