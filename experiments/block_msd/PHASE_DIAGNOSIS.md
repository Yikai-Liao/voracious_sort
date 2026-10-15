# Completed focused Block MSD diagnosis

This is a bounded diagnosis of the validated endpoint count-first algorithm using `cf_std_leaf`, not an all-scenario acceptance claim. These records describe the final diagnosis in the research archive.

## Normal timing evidence

CPU0, uniform u32, radix8, block64, 100 repetitions per method, generated fixture/clone/oracle outside timers. Each timed result was verified. The driver uses a distinct deterministic fixture from the full matrix. Ordinary MSD is the existing unstable method; stable identity qualification comes from the separate tagged tests/matrices.

| n | Count-first std leaf | Ordinary MSD | Ratio |
|---:|---:|---:|---:|
| 16,384 | 175.460 µs | 86.963 µs | 2.02 |
| 262,144 | 5.841654 ms | 2.411740 ms | 2.42 |
| 1,048,576 | 18.372042 ms | 11.325745 ms | 1.62 |

Raw files are `focused-normal-{endpoint,ordinary}-u32-{16384,262144,1048576}.csv`. `profile-normal-hashes.txt` records source and frozen binary hashes; `profile_normal_v1/profile_count_first.rs` preserves the driver. The full-matrix std-only results remain in `comparison-endpoint-std.csv` and `bench-endpoint-std-N.csv`. Do not merge measurements from different fixtures/binaries into a single median.

## What the instrumented probe shows

The six `phases-{endpoint,ordinary}-u32-N.csv` files contain verified20-repeat runs. Counters at n1m show both methods scatter/histogram2n records and initialize65,792 bucket entries. Count-first also OR/AND-scans2n records; ordinary scans n once. Count-first gathers n and writes n terminal records, then relocates almost all blocks. Ordinary instead clones2n buffer records. Thus gather/write are not simply two wholly additional array copies: they replace ordinary buffer clones; the final permutation and differing access/ownership cost must be accounted separately.

At n1m the saved final-iteration observations, in milliseconds, are:

| Stage | Count-first | Ordinary MSD |
|---|---:|---:|
| OR/AND scan | 1.522 | 0.140 |
| Histogram | 1.775 | 0.820 |
| Bucket/directory setup | 1.438 | 0.139 |
| Scatter | 2.784 | 1.506 |
| Leaf sort | 7.797 | 7.385 |
| Gather + terminal writer | 3.300 | 0 |
| Buffer clone/workspace | 0.015 | 0.272 |
| Chain assembly | 0.147 | 0 |
| Final permutation | 1.138 | 0 |

These values identify several costs worth understanding, rather than a single missing optimization. After the already validated standard-leaf change, leaf-sort observations are close, while scan/setup/scatter and stream/finalization remain costly. Avoiding final copies via C+E is a separate route with ownership/finalizer work, not an existing result. Neither a cheap remaining tweak nor whole-scene parity is demonstrated.

The phase numbers are diagnostic observations. An empty timer costs approximately20ns; the larger trees have65,536 small leaves, so instrumentation overhead is material. Headline sort time is a median across20 repeats, but emitted stage lines are from the final repeat. Missing timer overhead, destructor/recursion costs and variation prevent summing this table into a claimed median partition. The normal100-repeat table above is the qualified focused comparison.

`profile-{endpoint,ordinary}-u32-1048576-report.txt` records cycle sampling restricted by perf control descriptors to sort intervals, with generation/verification excluded. Reports contain roughly7K/4K samples and zero lost samples. The endpoint report exposes both standard small-sort and recursive bookkeeping hot spots. This sampling alone does not isolate cache misses, fragmentation, instruction count, or branch misprediction; no such hardware-counter claims are made.

## Source and verification limits

`endpoint_v1/` preserves the native algorithm that passed base/span/std/span+std debug/release/AddressSanitizer, each1 library plus11 integration tests. Current optional `cf_phases` instrumentation compiled and verified the six focused scalar runs; it did not receive another full sanitizer matrix. Normal sorting semantics remain the endpoint backend and optional leaf feature; diagnostic code is gated behind `cf_phases`. The compact remaining-count draft is retained as uncompiled history and has no timing claim. No running background benchmark remains.

Complete workspace accounting and the global directory/ownership construction are in [COUNT_FIRST.md](COUNT_FIRST.md). Native identity/ASan tests and finite uploaded-model reruns do not replace a complete raw-pointer proof, Miri, or a verified parallel protocol. Production integration, C+E/batch evacuation and the all-scenario speed objective remain unfinished.
