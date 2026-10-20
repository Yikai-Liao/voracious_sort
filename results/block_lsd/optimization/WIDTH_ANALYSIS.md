# Why the u32/u64/u128 speedups differ

This is a mechanism investigation, not a type-based parameter rule. The initial
comparison changed both key width and record size: u32 plus payload is 8 bytes,
u64 plus payload 16 bytes, and u128 plus payload 32 bytes. The following factors
must be separated before calling the result an inherent integer-type property.

## Costs implied by the representation

Let d be the number of varying digit passes, s the record bytes, σ the radix
range, and b records per block. For uniform full-width keys at radix 8, d=4/8/16.
A conventional scatter pass reads and writes the full record, so its minimum
payload traffic is approximately 2nsd bytes, excluding write allocation,
histograms, buffer initialization and final copying. In the original three
layouts this is 64/256/1024 bytes per record across all passes. Doubling the key
width also doubled the record bytes in that comparison, quadrupling this term.
Holding s constant is therefore an essential control.

The ordinary implementation builds all d histograms in one scan, using
machine-word counts. On this 64-bit machine its counter matrix is
d×256×8 bytes: 8/16/32 KiB. CPU0's sysfs reports L1D=32 KiB, 8 ways, 64-byte lines,
L2=1 MiB and L3=16 MiB. The u128 matrix occupies the entire nominal L1D capacity,
with input lines and bookkeeping still needed. This predicts a possible
capacity/conflict penalty; matrix size alone does **not** prove its measured
contribution. A counter-width experiment holds the histogram algorithm and
record layout fixed while changing counts from usize to u32 for n<=u32::MAX.

The large block path does not build that fused histogram. It scans converted
keys to find varying bits, scatters each varying digit, reorders block metadata,
and compacts records at the end. Approximate cost decompositions are:

```
ordinary = preprocessing + buffer initialization + fused histogram
           + d * conventional scatter + final merge/copy
block    = preprocessing + varying-bit scan + block setup
           + d * (block scatter + block metadata) + compaction
```

Saved histogram/initialization work and a smaller record workspace compete with
additional metadata and compaction. Their balance depends on n, d, s and b.
The fixed 4 KiB comparison uses b=512/256/128 in the three layouts, so block
metadata n/b also changes with record size. Smaller peak heap is not, by itself,
a proof of faster scatter or fewer cache misses.

## What the measured counters establish

The saved perf results count only 12 sorts of 1M uniform records per cell;
generation, cloning and the oracle are excluded. `const` is the constant-byte-
shift block stage, with 4 KiB blocks. Values are per input record.

| Layout | Algorithm | Instructions | Cycles | Cycles/instruction |
|---|---|---:|---:|---:|
| u32 / 8 B | block | 73.133 | 26.848 | 0.367 |
| u32 / 8 B | ordinary LSD | 89.482 | 34.609 | 0.387 |
| u64 / 16 B | block | 141.057 | 89.578 | 0.635 |
| u64 / 16 B | ordinary LSD | 192.184 | 97.146 | 0.505 |
| u128 / 32 B | block | 315.323 | 336.422 | 1.067 |
| u128 / 32 B | ordinary LSD | 546.547 | 496.967 | 0.909 |

For u64 the block implementation executes 26.6% fewer instructions, but its
average cycles/instruction rises 25.6%, leaving only a 7.8% cycle reduction.
For u128 it executes 42.3% fewer instructions, with a 17.3% CPI increase, and
reduces cycles 32.3%. For u32 it removes 18.3% of instructions without a CPI
penalty and reduces cycles 22.4%. These are different cost balances; there is
no unexplained semantic property of the integer value u64 in the sorting order.

Assembly gives one definite key-width distinction. A native u32/u64 shift is
one machine-word operation. A variable u128 shift uses two words, combining a
cross-word shift, a high-word shift and selection for shifts >=64; the saved
dynamic u128 kernel contains `shrd`, `shrx`, `test` and `cmov` instructions.
Constant byte shifts remove that general selection and specialize which word
is needed. The raw-copy change also replaces the old u128 payload spill and
split record stores with a 32-byte vector copy. The larger u128 instruction
reduction therefore has concrete code-generation causes. It is not solely a
heap-allocation effect.

## Cache claims require specific events

On this CPU, perf's generic cache-references event maps to 0x60/ff (L2 requests),
and cache-misses maps to 0x64/09 (L2 data misses plus instruction misses).
The exact mapping is preserved in `cache-event-mapping.txt`. Calling these
numbers LLC misses would be incorrect.

The existing u64 block result has 18.56 L2 requests and 0.410 generic misses per
record, versus 14.56 and 0.153 for ordinary LSD. This is consistent with an
additional memory-system cost accompanying the CPI increase. It does not
separate source-block traversal, histogram traffic, metadata and compaction,
and does not quantify how many cycles each caused. New phase clocks and
AMD-specific demand-fill/TLB events are needed for that attribution.

## Controls prepared for the investigation

* `--key-width` holds total records at 16, 32 or 64 bytes while changing key
  width; compensating payload fields keep copied bytes fixed. Uniform keys
  vary d, while keys in 0..255 hold the active digit count at one for every
  key width. Alignment and code generation remain observable differences.
* `--phases` adds clocks around whole phases in copies of the current block
  implementation and the ordinary public LSD path. It includes the Verge
  preprocessor and both offset calculations, and subtracts timed callback work
  from its parent timer. Diagnostics validate outputs but do not replace
  uninstrumented acceptance timing. Deallocation/timer residuals are reported.
* `--histogram` compares the unchanged histogram source with a copy whose
  only algorithmic change is counter width. Every histogram row is checked
  against the original. For u128 this reduces the matrix from 32 to 16 KiB
  while retaining the same wide-key extraction and row-counting sequence.

The fixed-record, phase and narrower-counter results must be recorded before
assigning the remaining cost difference to a specific cache level or phase.
