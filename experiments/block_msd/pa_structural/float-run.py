#!/usr/bin/env python3
"""Run the extra float harness with the existing immutable-evidence protocol."""
import re
import subprocess
import sys
from run import REPO, ROOT

def schema(path):
    return re.search(r'println!\("(layout,[^"\n]+)"\);', path.read_text()).group(1)

assert schema(REPO/'experiments/block_msd/src/bin/frontier_experiment.rs') == schema(ROOT/'float-bench/src/floats.rs')
subprocess.run([sys.executable, str(ROOT/'run.py'), *sys.argv[1:]], check=True)
