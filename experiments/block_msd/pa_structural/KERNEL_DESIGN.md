# Classification execution contract

The candidate is `Pa_kernel` / `UnifiedPackedContext`. It combines the bounded
bit projection already described in DESIGN.md with a corrected execution
boundary. `Pa_packed` is retained as the scalar execution control. All changes
are in the research experiment; the frozen LSD implementation is unchanged.

## Why a checked instruction token was insufficient

On the ordinary x86-64 target, the previous code entered `Isa::run` around
`partition_packed`, then called the deliberately out-of-line block scatter.
The caller's CPU features did not carry into that callee. Extraction therefore
called a small hardware helper once per record. Native compilation already
inlined the instruction; its timings cannot be explained by removing those
same calls. The previous source's ordinary-target regression and disassembly
are archived separately in VALIDATION_SINGLE_PATH.md.

The new private `Labeler<T,U>` couples `classify(&T)` with
`in_context(kernel)`. Ordinary labels and existing closure callers execute the
kernel directly. `Classified` adapts the PA classifier and converted record key;
`Masked` normalizes digits while forwarding the execution context. The packed
context classifier enters its already-checked HakMem ISA context once for the
whole kernel. It adds no per-record ISA check.

The actual bodies of block scatter, grouped scatter, dense histogram/scatter,
variation and exact histograms, and run-boundary scans are inside that context.
The block entry stays out of line to bound code expansion. Child recursion
stays outside each boundary-search kernel. A future label adapter must forward
the context; wrapping it in a bare closure would preserve correctness while
potentially restoring per-record extraction calls.

HakMem remains pinned at 0.2.0. The compatibility module accepts the library's
checked X86V3 token on eligible x86-64 builds. Without that token, or with
`projection_portable`, PA keeps its original classifier. That feature disables
hardware admission; it does not enable a production software-compression path.
There are no newly introduced unsafe blocks in this execution change.

## Sorting and ownership invariants

The context change preserves label values, original-coordinate remainder caps,
terminal decisions, histogram counts, pass order, bucket writes, recycling,
compaction, child order and leaf geometry. The complete Work equality test
compares context and scalar execution across q=8/16/24/64/128 and B=3/64/512,
with full key, incoming identity and payload equality against a stable oracle.
A guarded labeler checks that block/grouped and dense kernels retain their
context through the normalized-label adapter.

No labels are buffered per record. Context objects hold references and bounded
closure state. Distribution scratch still drops before PA child recursion;
the existing O(n/B + BR) auxiliary bound and dense workspace budget remain.
Projection admission itself retains the conservative rule: a complete tag
adds no pass over the old first node; a partial tag selects exactly the old
prefix's varying coordinates, so it changes representation without increasing
fanout. The rejected aggressive rule survives only as an explicit diagnostic.

## Evidence boundaries

The first screen, its exact ELF hashes, generic direct-PEXT disassembly and
positive/negative controls are in EXECUTION_SCREEN.md. The direct
`slice-group-by` iterator experiment failed its uniform controls and was
removed, including the dependency. A different captured-label search primitive
is unmeasured and has not been folded into this candidate.

Final-source performance must use separately frozen ordinary and native
executables and retain the original PA A/A controls. The complete matrix,
information boundaries, fresh seed, old-executable ABBA control and operation
memory/work runs are independent evidence scopes. Compilation, correctness
tests and work-counter runs must not overlap timed sorting. Full-matrix results
from previous source hashes cannot establish this candidate's acceptance.
