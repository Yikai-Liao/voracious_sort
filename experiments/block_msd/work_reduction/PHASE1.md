# Independent reductions at 749ca4d

The frozen source and binaries are recorded in stage1-source-sha256.txt and stage1-binary-sha256.txt. The full native matrix contains 200 cases, 15 methods and 15 rotating samples: 45,000 timed sorts, plus untimed warmups and allocator probes. Source, reset, reference and identity validation are outside the clock. The four sizes, five layouts and ten loads match the uploaded plan. The original measurements at 749ca4d are untouched.

On primary105, relative to each direct control, the median-time geometric ratios are: two arrays 0.9743; cycle placement 0.9517; prepared fallback 0.9639; fused histogram versus independent monotone scan 0.9897. These are descriptive aggregates, not significance tests. The cycle candidate has eight regressions greater than 5% against its direct control, so reduced writes do not justify unconditional promotion.

The three source-copy calibration ratios versus their frozen counterparts are 1.0001, 0.9970 and 1.0009 on primary105. The work counters match exactly on all 200 cases. validate.py also checks exact native allocation/request deltas for two arrays, identical heap for cycle placement, unchanged fallback scatter/placement, precise saved root scans, and zero extra record traversals for fused checks.

Metadata setup accounts for a median 1.66% of the selected diagnostic phase times (maximum 8.14%). Those instrumented times are not interchangeable with native timings and include setup work beyond allocation. They do not support adding a globally retained metadata workspace now. Only two of 105 primary cases have a nonzero cached ping-pong write opportunity; uniform cached subtrees all have one actual scatter level. That branch is not implemented in this round.

The next controlled tests are the two compatible combinations, a graph-based reduction of the cycle candidate's directory traversal, and a separate lifetime-aware admission rule based on SPACE.md. They do not introduce distribution classifiers or type/length choice tables.

The initial five-sample interface calibration is retained separately under calibration_initial and excluded from these ratios. It motivated restricting prepared counts to the Stream root and sharing the frozen node-local kernel in native hybrid builds. Its changed source files match the original captured hashes byte-for-byte.
