# Unified classification execution: proposal, not measured delivery

The next experiment should fix the execution boundary before changing another
projection admission rule. Keep the current classifier, partition geometry,
record order and workspace lifecycle fixed. Give classification kernels an
execution context, so an ordinary build can execute a whole hot loop under the
same CPU features as a native build. This addresses a confirmed difference in
the generated code. It does not establish a whole-sort speedup yet.

## Observed problem

The frozen `hw_single_generic` executable is slower than its same-executable
original PA on both million-record u32 sparse controls: paired medians are
2.062 at B64 and 2.483 at B512, with every paired repetition slower. A separate
repeat reproduced the direction. Exact raw data and oracle/audit records are
`single-generic-u32-*` and `single-generic-repeat-*`.

`validation/single-path-codegen.json` compares the exact u32/u8 packed scatter
symbols. Native scatter contains inline PEXT instructions. Generic scatter
contains calls to `hakmem::x86::bmi2::pext_u32` in the record loop. Both choose a
checked hardware token. Generic has not selected a software implementation.
Static instruction sites do not quantify the fraction of wall time caused by
these calls.

The source explains this distinction. `partition_packed` puts a large partition
operation inside `Isa::run`, but `block::Sorter::scatter` is deliberately
`inline(never)`. CPU features on the caller do not propagate into an out-of-line
callee. HakMem's `src/isa.rs` documents precisely this requirement: helpers have
to inline into the target-feature closure. Changing a selection threshold cannot
repair that execution boundary.

## First experiment: kernel context, no label buffer

Replace the distribution layer's bare `Fn(&T) -> Label` contract with a small
private labeler contract that owns two related operations:

1. Classify one record, retaining today's converted-key and label types.
2. Execute a supplied kernel in the labeler's instruction context.

Ordinary Prefix, PrefixBand, EqualSplit and Identity labelers execute the kernel
directly. The packed labeler enters its checked hardware context once per
kernel. Keep an out-of-line scatter entry to bound code expansion, but place
the actual scatter body inside that entry's context closure. The short helper
chain from the closure through the record loop and extraction must inline into
the closure. Do not force the entire recursive sorter to inline.

This is an execution contract, not a sorting policy. It adds no input threshold,
admission test, pass, whole-array label cache or new classifier. A normalized
label adapter must forward the underlying context; wrapping it in another bare
closure would silently lose the property again.

The same boundary is required for dense histogram/scatter, grouped scatter and
the recursive run-boundary scan. Fixing only block scatter would leave the same
per-record call in other full scans. A sample-only scalar path is acceptable;
an O(n) classification loop must have a verified context. Never wrap child
recursion in an always-inline loop body merely to obtain target features.

A minimal implementation can retain HakMem. If doing so requires awkward token
plumbing throughout the sorter, replace the small extraction/context adapter
with a checked Rust BMI2 kernel and remove the dependency. Direct intrinsics
still require the same correctly placed target-feature boundary. Removing the
library by itself would not fix an intrinsic helper called once per record.
Keep software compression disabled in either implementation.

## Invariants

- Classification is pure for a fixed prepared node. Labels, original-coordinate
  remaining caps and terminal decisions are unchanged.
- Every initialized record is read and copied in the same order as the current
  scalar scatter. Bucket reservation, permutation, partial blocks and compaction
  use the existing protocol. No recycling proof is weakened.
- Parent distribution workspace is released before child recursion. A context
  wrapper owns no record buffer and adds no n-dependent storage.
- Stable oracle results and work counters match the checkpoint exactly for the
  execution-only experiment, including leaf geometry and label evaluations.
- The original PA comparator still uses its original implementation. Do not
  let a shared refactor change the comparator and hide a common regression;
  retain an executable-to-executable frozen control.

## Alternative: bounded batch classification

If a whole-kernel context causes excessive code size, classify a fixed batch
inside the context and consume its tags in original order. A 64-record batch
needs at most 1 KiB for u128 labels, or 64 bytes for one-byte digits. Only the
initialized block prefix is classified. End the source borrow before writes;
never read block padding. Preserve the old record-copy and recycling order.

This alternative amortizes one context call over a batch and may expose a
regular vectorizable label loop. It also adds tag stores/loads, stack use and
batch boundaries. Those costs apply to cheap ordinary labels too. It is a
separate experiment, not an automatic improvement or a reason to add a runtime
batch-size search. Do not combine it with the first context experiment.

## Falsifiable screen

Use an independent experiment variant and freeze both ordinary-target and
native executables. First inspect their exact packed scatter/dense symbols:
PEXT belongs in the record loop, with no out-of-line extraction call per record.
This is a code-generation check, not performance evidence.

Then compare checkpoint, context-only variant and frozen original PA with
paired rotations and A/A controls. Start with the failed u32 sparse B64/B512
controls, a dense u32 control, u128/wide32 sparse, a dense leaf and the known
large128 deep_unique90 regression. Stop if the first screen is negative. A
passing screen still requires the original 103 cells, information boundaries,
unseen-seed controls, memory and complete stability checks before acceptance.

The checkpoint validation currently running uses immutable executables from
5f6d211. This document changes no Rust/Cargo source and claims no new result.
