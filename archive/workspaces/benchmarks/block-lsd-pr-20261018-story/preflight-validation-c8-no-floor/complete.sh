#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
bench_python=/root/code/voracious_sort-workspaces/benchmarks/block-lsd-pr-20261018/.venv/bin/python
taskset -c 0 "$bench_python" run.py time > time.log 2>&1
taskset -c 0 "$bench_python" run.py memory > memory.log 2>&1
taskset -c 0 "$bench_python" analyze.py > analysis.log 2>&1
