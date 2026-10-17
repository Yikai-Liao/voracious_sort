# Direct-loop scalar scatter: screen passes, simplification required

The frozen eaf0c09 candidate completed all 1,296 oracle-checked rows in the
predeclared 18-cell screen, without source/binary changes. n=1,048,576,
seed42, CPU2, twelve paired reverse repetitions, Pa/Groups/Direct/L_frozen/
Stable/Pa. Input restore uses the same allocation within each cell. Raw files
remain separate; no pooled timing result is used for a decision.

All 32 frontier debug tests, two runner registry/generator tests and the
all-target/all-feature check passed before timing. The release seven-layout
screen build took 2m31s with native CPU, CGU16, line-table debug, incremental
cache and six Cargo jobs. This source has not had full-layout release work,
heap or ASan validation. The held-out seed20261018 remains unseen.

| B | layout | case | Direct ms | Direct/Groups | Direct/Stable | slower than Stable /12 |
|---:|---|---|---:|---:|---:|---:|
| 512 | small8 | sparse | 5.373 | 0.982 | 0.334 | 0 |
| 512 | small8 | uniform | 17.935 | 0.952 | 0.600 | 0 |
| 512 | u64 | sparse | 13.102 | 1.001 | 0.377 | 0 |
| 512 | u64 | uniform | 18.335 | 0.971 | 0.705 | 0 |
| 64 | small8 | sparse | 7.155 | 1.012 | 0.437 | 0 |
| 64 | small8 | uniform | 18.753 | 1.046 | 0.621 | 0 |
| 64 | u16 | sparse | 2.841 | 1.013 | 0.910 | 2 |
| 64 | u16 | uniform | 5.366 | 1.000 | 0.875 | 0 |
| 64 | u16_id8 | sparse | 4.112 | 1.008 | 0.716 | 0 |
| 64 | u16_id8 | uniform | 8.187 | 0.959 | 0.641 | 0 |
| 64 | u32 | sparse | 5.159 | 0.998 | 0.453 | 0 |
| 64 | u32 | uniform | 14.468 | 0.984 | 0.582 | 0 |
| 64 | u64 | sparse | 15.246 | 1.001 | 0.439 | 0 |
| 64 | u64 | uniform | 18.285 | 1.035 | 0.691 | 0 |
| 64 | u8 | sparse | 2.744 | 0.974 | 0.850 | 1 |
| 64 | u8 | uniform | 3.003 | 0.962 | 0.680 | 0 |
| 64 | u8_id8 | sparse | 4.478 | 1.004 | 0.733 | 0 |
| 64 | u8_id8 | uniform | 4.404 | 0.985 | 0.453 | 0 |

Small8/uniform is now below Stable at both B64 and B512, and the primitive
sparse guard is below Stable too. However Direct/Groups is 1.046 on the former
and .952 on the latter. The macro adds no consistent incremental benefit.
Both original and macro scalar loops have inlined their per-record writes in
this ELF, unlike the older frozen full Group binary. The whole cross-build
change cannot be attributed to macro expansion. See profile/README.md and
selected full-type nm/objdump records for this compiler-shape finding.

Decision: archive this screen and remove the redundant direct-loop copy and
policy. Evaluate one explicit outline boundary on the existing original
scalar function; keep the grouped schedule, fixed 16 MiB threshold, stability,
record order, reservations, recursion and low-space representation. It still
requires a fresh frozen screen and full validation. No overall goal completion
is claimed from these eighteen cells. No larger matrix, ASan, work/heap,
mechanism sweep or held-out seed was run for this superseded macro candidate.

Validation checks 156 frozen source files plus the frozen ELF, every metadata/
CSV completion, slot/rep, allocation address and zero stderr. The strict review
requires twelve complete six-slot rotations per cell. An independent parser
reproduced every one of the 18*32=576 numeric summary fields. Per-file A/A,
CPU timing, quantiles and raw rows remain available; quantiles are sample
descriptions, not confidence intervals. Host scheduling/frequency is not
exclusive. Narrow seven-layout code generation can differ from the final
full-layout binary; it is a screen, not final evidence.
