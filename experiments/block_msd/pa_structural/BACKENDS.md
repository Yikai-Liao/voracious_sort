# hakmem whole-sort backend comparison: rejected admission

Source 33377af, source SHA 1759e4bc9091fd1e133dc71a5beb95dcfa71b65aeeb3b3da83aaa89879e7b46d. The two release ELFs differ only in `projection_portable` forwarding to hakmem/portable; all other native compiler settings are fixed. Source, executable SHAs and commands are recorded in library_{native,portable}-binary.json and each run metadata.

32 cells, 4096 timed rows, whole-process hardware/software/software/hardware order. Each process uses 8 repetitions and 4 rotated/reversed slots: candidate, old PA, old PA, candidate. Both methods get A/A. Timing includes workspace lifetime; full key/identity/payload oracles are outside timing. Results are not pooled with earlier local-extraction cohorts.

The JSON library-backends.json reports both candidates against the old PA in their own ELF, direct software/hardware ratios, and the old-PA software/hardware control. The latter detects common binary-layout/build drift.

For n=1048576, sparse, B64, median whole-sort times are about 81/71/17 ms (old/software/hardware) for u128 and 112/71/23 ms for wide32. These are actual whole-sort times, not an instruction benchmark. Hardware is around 3-4 times faster than software here.

The information controls disprove general no-regression claims. At n=262144, u128/project9_spaced software/old PA paired median is 1.480 (p10/p90 1.414/1.563); project24_spaced is 2.239 (2.138/2.303). Hardware helps both, but u128/project8_cross regresses even in hardware: 1.290 (1.243/1.349). The original-byte boundary does not describe the ordinary Prefix label after its right shift: this cross fixture already needs one ordinary label byte. Hardware has one material signal among 32 cells; software has five. Therefore this admission policy is rejected.

An additional software-library-b64 cohort completed 8 cells with no material signal; the following B512 cohort was stopped after the negative screen. Its incomplete rows are only in validation/stopped-* and never enter summaries. Full 103-cell validation has not run on this source.

The allocation run library-memory.csv separately confirms that at B64 the u128/wide32 sparse extra heap peaks are unchanged (672.5/1184.5 KiB), while allocation counts fall from 823 to 8. This measures sort-owned heap allocations, not process RSS or stack.

Tests: forced-software full library 56 pass, automatic-dispatch frontier 42 pass, runner 4 pass, aarch64 and riscv64 library cross-checks pass. Cross compilation does not establish machine performance. The next source uses actual shifted-prefix bytes and requires a strict root-pass reduction before admission; all timings must be repeated for its own frozen executable.
