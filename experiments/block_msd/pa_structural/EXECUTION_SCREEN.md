# Classifier execution and library boundary screen

Source: `d2669f1`; frozen `execution_generic` and `execution_native`.
Status: the kernel-context candidate passed the initial four u32 cells on each
target. This is a local screen, not final acceptance. The direct library
grouping replacement failed and is rejected.

Both targets ran u32 sparse/uniform at n=1,048,576, B64/B512, seed 42, 16
repetitions and eight rotating slots. Every complete key/identity/payload oracle
passed. Each executable has separate raw files and analysis; timings are not
pooled across hashes. CPU 2 was used with no concurrent task compilation or
sorting. Same-executable original PA is `Pa_unified_groups_t16777216`.

| Target | Cell | Kernel/original PA paired median |
|---|---|---:|
| Ordinary target | sparse B64 | 0.709 |
| Ordinary target | sparse B512 | 0.692 |
| Native | sparse B64 | 0.712 |
| Native | sparse B512 | 0.688 |

Neither target's uniform controls exposed a material regression signal under
the established median >1.05 and p10 >1 rule. Exact p10/p90 and A/A values
are in `execution-{generic,native}-first-summary.csv`. The ordinary target's
scatter and dense context bodies contain direct PEXT and no outlined extraction
calls, while its scalar controls still call the extraction helper. See
`validation/execution-generic-codegen.json` and the four assembly excerpts.
This inspection explains the changed execution boundary; it is not a timing
attribution by instruction count.

The public `slice-group-by = 0.3.1` mutable exponential group iterator kept child
geometry intact and reduced labels on the long-run work test. However, its
ordinary-target uniform u32 controls took 1.93/1.98 times original PA at
B64/B512, with p10 above 1.84/1.90. Native controls also regressed substantially.
Do not retain this direct replacement. Its key callback re-evaluates the first
element and its search revisits known bracket positions; fewer long-run labels
do not establish a whole-sort gain. A captured-label search primitive would be
a separate experiment, not a measured fix here.

An independent ABBA executable control compared this source with `5f6d211`
on the same four cells per target. The new kernel's sparse medians relative to
the previous frozen executable's original PA were 0.793/0.724 (ordinary) and
0.715/0.670 (native). The shared original PA path exposed no >1.05 median plus
p10 >1 signal in these controls. Ordinary B64 had a 1.134 median but p10 0.982,
so broad common-path validation remains necessary. Absolute timings changed
from older sessions and are not used as cross-session speedups. See the two
`execution-*-control.json` files and their raw ABBA CSVs.

Native full library tests passed 60/60. Forced hardware-disabled full library
tests passed 60/60 and runner tests 4/4. AArch64 and RISC-V cross-checks passed.
The new context-only work test matched every work counter and the full stable
oracle. Parent workspace release, child order and O(n/B + BR) auxiliary bounds
are unchanged; no record label buffer was added.

Next: remove the rejected library path, freeze the final source, then complete
the original matrix and boundary/holdout/resource controls for that source.
No result here substitutes for those pending checks or for another machine.
