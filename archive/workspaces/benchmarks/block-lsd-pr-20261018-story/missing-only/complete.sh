#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
missing_python=/root/code/voracious_sort-workspaces/benchmarks/block-lsd-pr-20261018/.venv/bin/python
taskset -c 0 "$missing_python" run.py time > time.log 2>&1
taskset -c 0 "$missing_python" run.py memory > memory.log 2>&1
