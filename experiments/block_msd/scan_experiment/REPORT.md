# Early termination of the variation scan

This follow-up isolates one change to the archived endpoint count-first backend:
stop scanning OR/AND when the current highest digit is known to vary. Boundary
allocation, histogram/scatter, recursion, leaves, Writer and final permutation
are unchanged. Feature `cf_early_scan` selects `../src/count_first.rs`; the
default continues to use the archived full scan.
`full_scan.rs` is an exact copy of that file from archive commit
`2a64a6d16c00349abc739627f12f1b2e378f14b6` and is compiled into the same driver.

## Why the split remains the same

The old scan skips a digit only when all records agree in that digit. If any
prefix already disagrees, scanning more records cannot make it constant. The
new scan checks this condition after each valid contiguous span and stops as
soon as it is established. If the current digit remains constant, it completes
the full node scan and uses the original complete OR/AND result to skip common
high digits. It neither guesses that an unread suffix is constant nor consumes
or releases the scanned input blocks.

Tests compare stable identities, node counts, scattered-record totals, scratch
size and peak live blocks between both versions. Diagnostic builds additionally
compare histogram/scatter totals and leaf-size histograms, and count the actual
variation-scan records. Cases cover early and late high-digit changes, shared
prefixes, non-byte radices and partial spans.

## Correct stable MSD comparison

`../src/stable_baseline/` contains an experimental copy of upstream stable MSD
and its Verge preprocessing/merge dependencies from base commit `3dbdd7f`.
The three descending-run reversals now restore equal-key groups after reversing
the run. Its original histogram, four-record scatter and 128-record stable
fallback are retained. The copied private Params type requires spelling out the
same default trait mask/shift formula in `sort.rs`; utilities are reused from
`src/frozen_lsd/utils.rs`. Production source is unchanged.

This baseline is measured on integer keys and records whose comparison agrees
with their radix key. It is not a claim to fix upstream NaN ordering, arbitrary
trait overrides or changing extractors. Dedicated tagged tests include the
129-record regression, descending ties, mixed ascending/descending runs, skew,
and 2,187 ternary run patterns above the small-array fallback. Every timed
stable result is checked against the full key/ordinal/payload oracle; ordinary
MSD is checked for key order and identity permutation under its unstable
contract. The old broken stable baseline's archived failures remain unchanged.

## Measurement method

`../src/bin/scan_experiment.rs` runs four methods in rotating order: frozen
full scan, early scan, ordinary MSD and corrected stable MSD. All methods use
one input allocation per case, reset outside the timer. Generation, warm-up,
reference sorting and identity verification are outside the timer. Workspace
allocation and all sorting work remain inside. Requested-heap peaks are measured
separately, excluding input/reference storage, stack, allocator overhead and RSS.

Normal timing enables `cf_std_leaf` and disables `cf_phases`; the phase build is
used only for structural counters. Both use release mode and
`-C target-cpu=native`, pinned to CPU0, after all task compilation/tests finish.
`environment.txt` records the host and compiler. Separate CSVs preserve each
sample. Instrumented times are not combined with normal timing medians.

## Reproduction

From the repository root:

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --release \
  --features cf_std_leaf,cf_phases,cf_early_scan --lib --test correctness --test scan_experiment
experiments/block_msd/scan_experiment/run.sh
```

The runner defaults to sizes 1024/16384/262144/1048576, nine samples, radix8,
block64 and all five layouts/six distributions. It writes to a separate `rerun/`
directory. Override `MSD_CPU`, `MSD_REPEATS`, `MSD_BLOCK` or `MSD_SCAN_OUT` as
needed. The binary also accepts a load filter as argument four and a type filter
as argument five, e.g. `1048576 25 64 uniform u32`.

For diagnostic counters, build with `cf_std_leaf,cf_phases,cf_early_scan` into a separate target
directory and run the same driver. Regenerate a normal summary with
`python3 experiments/block_msd/scan_experiment/analyze.py <normal CSV paths>`.

## Results

The normal matrix contains 120 cases: four sizes, five layouts and six loads,
with nine rotating samples per method (4,320 timed sorts). All result checks
passed. Across all cases, the geometric mean early/full time ratio is 0.9826;
27 cases improve by more than 5%, 86 are within ±5%, and seven regress by more
than 5%. Across the 80 cases excluding sorted/descending preflight paths, the
geometric mean ratio is 0.9556. Requested heap is identical between the two
count-first implementations in all 120 cases.

The separate 25-sample u32 uniform comparison is:

| Records | Full scan | Early scan | Ordinary MSD | Corrected stable MSD | Time reduction |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 16,384 | 0.121569 ms | 0.121298 ms | 0.076203 ms | 0.095540 ms | 0.2% |
| 262,144 | 4.150898 ms | 4.089433 ms | 1.936758 ms | 1.931790 ms | 1.5% |
| 1,048,576 | 13.519167 ms | 13.056018 ms | 8.358973 ms | 8.497434 ms | 3.4% |

These fixtures/builds differ from the historical report; these numbers do not
replace or combine with its medians. Small differences remain subject to host
variation. At one million records the candidate is still 1.54 times the corrected
stable MSD time. Removing most variation-scan accesses does not close the gap.

The diagnostic build confirms that u32 uniform at 1,048,576 records reduces
variation visits from 2,097,152 to 9,236 (99.56% fewer), while both versions still
have 257 nodes, 2,097,152 histogram visits and 2,097,152 scatter visits. For the
shared-prefix fixture the visits fall only to 1,056,936: proving the common root
prefix still requires its complete scan. At 16,384 records that shared-prefix
fixture saves no variation visits. See `counter-summary.csv`. Diagnostic timing
is intrusive and is not used in the normal timing table.

Large records remain favorable in this round. In the nine-sample million-record
uniform matrix, large128 changes from 80.236 to 74.186 ms; corrected stable MSD
uses 110.294 ms. Requested extra heap is 4,748,176 bytes for either count-first
version versus 134,787,224 bytes for corrected stable MSD. These observations do
not prove a hardware-cache explanation.

### Preflight regression and decision

The first matrix showed roughly twice the time on sorted u32 at every size.
The separate 25-sample million-record rerun reproduces 0.213090 ms full scan
versus 0.426561 ms early scan. Both report zero nodes, zero variation/histogram/
scatter visits and zero extra requested heap: neither reaches the changed scan.
The ascending preflight loops in `assembly/*-u32.asm` have the same instruction
sequence but different addresses/alignment. This is evidence of a binary-level
confound, not proof that alignment alone causes the difference. There are no
hardware-counter results for that preflight loop.

The candidate is therefore retained as an opt-in research ablation, without
promoting it to the default or adding unrelated inlining/alignment changes.
Timing/counter collection preceded the final opt-in selection; that selection
changes default module routing, not either measured implementation body.
`source-hashes.txt` identifies the measured source files and binaries. Final
selection checks are recorded in `validation/selection-*.txt`. Enable
`cf_early_scan` when reproducing the candidate from this branch.

This experiment measures an achievable gain for this early-termination policy,
not a rigorous upper bound on all scan-elimination strategies. A fused scan or
inherited metadata would be different experiments. C+E, terminal-block retention,
Writer removal and parallel work remain unimplemented and have no new speed
claim here.


## Final validation

With default selection restored, debug passes one library test, eleven original
correctness tests and the corrected stable-baseline test. With
`cf_std_leaf,cf_phases,cf_early_scan`, release passes one library plus thirteen
integration tests. AddressSanitizer with `cf_std_leaf,cf_early_scan` passes the
same fourteen tests. `cargo check --all-targets --all-features` passes. Existing
dead-code warnings from copied research modules remain. Full data, summaries,
source/binary hashes and validation logs accompany this report.
