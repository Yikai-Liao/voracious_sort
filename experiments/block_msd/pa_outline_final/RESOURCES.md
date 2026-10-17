# Logical work and requested auxiliary heap

All 200 Work and 372 heap rows completed with the full stable oracle. Work uses
the separate frontier_work ELF; heap uses the immutable timing ELF with its
allocator tracker activated only around the sort. These non-timing runs overlap
an isolated ASan build. No wall/CPU field from either kind is used for a speed
claim. Exact commands and process snapshots remain in measurements/*.json;
validation/resource-scope.json records this boundary.

Across 50 cells, Group equals Prepared in all 23 logical fields: node/order/
preparation/scatter work, passes, leaf lengths, terminal/band work and depths.
Each eligible grouped block pass adds one first-live-label probe; the measured
label-evaluation delta is between zero and the number of passes. Compact copies
are reported separately because grouping can change physical reservation order.

Across 62 heap cells, Group and Prepared have exactly the same requested peak
and allocation count. Group never exceeds frozen Block LSD's peak in this
matrix. Its largest peak ratio to Stable MSD is 0.253963. Examples at n1048576:

| layout / case | B | Group peak bytes | Block LSD peak bytes | Stable MSD peak bytes |
|---|---:|---:|---:|---:|
| 128-byte record, uniform | 512 | 33,589,760 | 33,589,760 | 134,784,664 |
| 128-byte record, majority prefix | 512 | 33,589,760 | 33,589,760 | 376,387,624 |
| 32-byte record, 98% shared prefix, distinct keys | 64 | 1,212,928 | 1,212,928 | 414,966,888 |

The compiler-only outline change preserves every work/allocation field relative
to the earlier frozen Group 2513fa5: compare_resources.py matched all 572 rows
for every method, excluding only addresses and unclaimed timing fields. This
includes label evaluations, compact/tail copies, heap peaks and allocations.

Requested heap is not RSS or stack. Input/oracle/restore allocations are outside
tracking; sort scratch allocation and release are inside it, and the runner
asserts zero live scratch after return. No per-record label buffer or input
staging was introduced. The grouped mask is one native word per chunk, with
constant local cursors; all record widths retain the same Block representation.
The 16 MiB local-workspace policy is fixed across layouts and seeds.
