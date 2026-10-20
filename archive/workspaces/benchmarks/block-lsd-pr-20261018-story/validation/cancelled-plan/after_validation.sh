#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
story_python=/root/code/voracious_sort-workspaces/benchmarks/block-lsd-pr-20261018/.venv/bin/python
# Rendering is kept off the timing stage; requested-heap measurements are local
# to the separate memory binary, while figure work is pinned to another CPU.
while [ ! -e validation/memory.log ]; do sleep 5; done
taskset -c 0 "$story_python" plot_fits.py > fit-plot.log 2>&1
taskset -c 0 "$story_python" audit_story.py --fits-only > fit-figure-audit.log 2>&1
taskset -c 0 "$story_python" create_fit_report.py
while [ ! -s validation/data/audit.json ]; do sleep 5; done
taskset -c 0 "$story_python" evaluate.py > evaluation.log 2>&1
taskset -c 0 "$story_python" plot_story.py > story-plot.log 2>&1
taskset -c 0 "$story_python" audit_story.py > story-figure-audit.log 2>&1
taskset -c 0 "$story_python" create_story_report.py
