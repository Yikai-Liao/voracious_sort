The question is where Block LSD changes the speed–space tradeoff against the
existing LSD implementation and Rust's stable comparison sort. No speedup is
assumed before measurement. This is a PR report, not a journal submission.

Three predeclared policies share the identical sorting implementation:
fixed-count b in {128,512,1024}; fixed-bytes q in {1024,4096,8192},
b=max(1,floor(q/record_bytes)); balanced square root with coefficient c in
{0.5,1,2}, b=max(1,ceil(c*sqrt(9*n/(2*2^radix*record_bytes)))). The last policy balances
the two leading allocation terms, not runtime. Fixed byte size fixes scratch
space, not total space. Radix=8 for all primary comparisons. Policy selection
is performed before the timed sorting call, so these are parameterized-function
measurements rather than a benchmark of a new automatic dispatcher.

The quantitative-grid overview uses (a) u64 uniform-input time scaling to expose
crossovers, (b) measured additional requested heap on the same inputs to establish
the space tradeoff and square-root growth, and (c) at 1,048,576 records the effect
of record width on space for all three policies, plus (d) selected distribution
effects. The retained raw data cover every primary type/distribution/size; the
comparison PDF displays all types and distributions at one selectable size.
Parameter sweeps are supplementary sensitivity checks and do not select a
favourable configuration after seeing the primary results.

Use Python/matplotlib only. Export at 183 mm width with editable SVG/PDF text,
at least 5 pt glyphs and a high-resolution PNG preview. Time summaries use the
median of six observations (three fixed seeds, forward/reverse order for each
seed); ranges show all six observations, not a confidence interval. Paired
ratios compare observations from the same seed/order block. A/A observations
call the identical existing LSD function. Memory is an independently compiled,
allocator-instrumented run; it is not included in timing measurements. It
measures peak live requested allocation bytes during the sort, excluding the
input and harness, rather than RSS or allocator metadata.

All timed outputs must match the complete converted-key stable oracle,
including payload and equal-key order. Any comparator failure remains in raw
data and is visibly marked; it must not support a same-semantics speedup claim.
Retain the full primary matrix; describe any detail-panel subsets explicitly.
Freeze source, dependency lock, compiler, binaries, seed generator and order.
Record affinity, process swap, global swap traffic and KVM limitations. Require
rendered alignment, PDF text, PDF collision and final-size visual audits.

Display amendment after the 415-case interim check: retain the original eight
detail distributions and add organ_pipe and push_front to panel d because
structured-input regressions emerged. This is an exploratory presentation
addition, not a new favourable subset or a parameter selection. The complete
23-distribution matrix, all observations, and all predeclared policies remain.

Supplemental contract following the user's coefficient-range and normalization
corrections (declared before supplemental measurement): retain the original
campaign intact. Expand the space-balanced coefficient c to 1,2,4,8,16,32,64.
Add a distinct byte-normalized sqrt family b=max(1,floor(k*sqrt(n)/s)), with
k in 1,2,4,8,16,32,64,128 bytes. For every measured type, both families must
include block lengths below and above 512 at n=1048576. This does not assert
that every smaller input length straddles 512; the current implementation's
small-input and bounded full-scatter paths also remain part of the measurement.

The supplemental parameter sweep uses all nine types and five primary sizes on
uniform inputs, the same ten additional u64 uniform sizes, and six predeclared
stress distributions at n=1048576: skew95, common_prefix, nearly_sorted, normal,
organ_pipe, push_front. Total 109 input cases, 25 methods, six time and three
memory observations per method. It is a focused parameter/normalization study,
not a rerun of the initial full 23-distribution matrix for every new coefficient.
Rerun fixed-count, fixed-byte, original LSD, Rust stable, TimSort and LSD A/A
controls inside the supplemental campaign. Never pool cross-campaign timings.
The only harness adapter accepts explicit per-method block lengths before the
timed call; preserve its diff and separate binaries/manifests.

Revise the sensitivity figure to show all four parameter families on the same
uniform n=1048576 inputs. Following the user's unit clarification, point shape
indicates block bytes below/equal/above 4 KiB. At this length the normalized
family already covers 1–128 KiB for every type; this clarification adds no
measurements and keeps fixed 512 elements as a separate control. Audit both
the byte range and the original element range. A separate four-panel scaling figure
shows time and measured heap for predeclared representative coefficients:
space-balanced c=1,8,16,64; byte-normalized k=1,4,16,128. These span the expanded
range rather than selecting the fastest measured coefficients. At n=1048576,
normalized k=1,4,8 duplicates fixed 1,4,8 KiB; label that equivalence. The complete
sweep and stress observations remain available as CSV/JSONL. Large coefficients
may admit the existing full-scatter path and spend linear-sized storage over
part of the measured range; report actual heap rather than treating every
finite-n point as the asymptotic square-root regime.
