# PA caller-capacity validation

Status: **rejected**. Source `17531ed`, fingerprint `6d39a251e5535fd619c7ba0a66e3b2381b378beda7b0e207e585852f0a21b52e`. This experiment changes PA caller capacity only; the existing Block LSD kernel is unchanged. The candidate is removed before further optimization.

Native Work library59 and float6 tests pass. The float executable SHA-256 is `229bd7b72ef5db8d78766a07608f9c9285ee5e6ed75f90eb08a5dbb5fbae655b`. [PA_CAPACITY_PLAN.md](PA_CAPACITY_PLAN.md) records the fixed policy and gates. The initial independent seed20261024 screen covers eight uniform/sparse16 cells, n1,048,576, B512, CPU2, sixteen repetitions and eight rotated slots (1,024 rows). Complete stable record oracles and row-order audits pass.

| Layout / case | Odd capacity / original PA |
|---|---:|
| f32 / uniform | 1.0025 |
| f32 / sparse16 | 0.7080 |
| f64 / uniform | 1.0097 |
| f64 / sparse16 | 0.2215 |
| f32_id16 / uniform | 1.0027 |
| f32_id16 / sparse16 | 1.0214 |
| f64_id32 / uniform | 1.0112 |
| f64_id32 / sparse16 | 0.5443 |

The original seed42 failing boundary receives a separate reversed sixteen-repetition four-slot repeat (64 rows): f32_id16/sparse16, candidate/original PA median **1.1830**, p10 **1.0989**, p90 **1.4049**, slower15/16. Median times are19.8685ms and16.5511ms. Original PA A/A median is0.9965. CPU-time paired median1.1814 corroborates the wall-time regression. This fails the predeclared gate despite the initial fresh seed not showing that loss. B64, larger float/integer matrices and ordinary-ISA timings stop.

## Bounded causal diagnostics

A separate native Work executable of the same source checks f32 and f32_id16 sparse16 at both seeds (12 rows). Original PA performs three scatter passes and3,145,728 label evaluations; packed PA and odd capacity perform two passes and2,097,152 evaluations. Both seeds have identical node, pass and leaf geometry. Compaction copies differ by about1%; this does not explain the large timing difference. Instrumented wall time and zeroed allocation fields are excluded from performance/memory conclusions.

The native allocation cohort separately checks the same four cells (12 rows). At both seeds f32 peak is1,083,904 bytes for original PA/prior kernel and1,081,892 for odd capacity; f32_id16 peak is4,229,632 and4,221,476 respectively. Allocation counts are14 for original PA and11 for either packed route. A small scratch saving does not establish speed.

Disassembly of the frozen native executable shows a packed Float32Record/u16 byte-zero specialization repeatedly loading the classifier pointer and using a memory mask operand for PEXT inside its record loop. This is a code-generation hypothesis for subsequent PA adapter work; the observed specialization alone does not establish its share of total runtime or explain input-seed dependence. The identity/prefix comparison has no PEXT. Saved assembly is diagnostic evidence, not a throughput result.

## Resources and scope

- `pa-capacity-memory-seed20261024`: 6 memory rows, RSS73580KiB, major faults0, host swap-in0 pages, swap-out0.
- `pa-capacity-memory-seed42`: 6 memory rows, RSS74012KiB, major faults0, host swap-in0 pages, swap-out0.
- `pa-capacity-native-float-first-b512`: 1024 time rows, RSS197904KiB, major faults0, host swap-in25 pages, swap-out0.
- `pa-capacity-original-boundary-f32id16`: 64 time rows, RSS64328KiB, major faults0, host swap-in1 pages, swap-out0.
- `pa-capacity-work-seed20261024`: 6 work rows, RSS94184KiB, major faults0, host swap-in31 pages, swap-out0.
- `pa-capacity-work-seed42`: 6 work rows, RSS94236KiB, major faults0, host swap-in4 pages, swap-out0.

No compiler/test/benchmark overlap was authorized during timing. All six processes return0 with empty stderr and complete-record oracle success. Host swap counters also include unrelated processes. Raw data, frozen metadata, Work/memory diagnostics, test logs and [integrity hashes](pa-capacity-rejected-integrity.json) are preserved. Earlier positive cohorts do not validate this source. Full current-source matrices and other-machine validation are not completed.
