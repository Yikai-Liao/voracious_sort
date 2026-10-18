#!/usr/bin/env bash
set -euo pipefail
uname -a
lscpu
free -b
cat /proc/self/status | rg 'Cpus_allowed_list'
/root/.cargo/bin/rustc -Vv
