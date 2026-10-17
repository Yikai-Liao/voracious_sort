# Logical work and requested auxiliary heap

200 Work rows /50 cells and 372 requested-heap rows /62 cells complete with
full stable key/ID/payload oracles. These runs may overlap native regression
compilation; their wall/CPU fields are excluded from speed claims. Native
Time and frontier_work ELFs are separate immutable full ten-layout builds.

All 23 logical sort/leaf/dense/block fields are exactly equal between Prepared
and Groups in all 50 cells. Group's explicit probe adds 0..10 label evaluations
within the pass bound. Physical compact-copy delta is -256..128; grouping can
change free-block assignment order, so this actual quantity is not forced equal.

Across every method and all 572 rows, all sort/scatter/label/compact/heap/alloc
fields equal the frozen pre-outline source `2513fa5`. Only order_records changes:
failed software-wide order proofs exit earlier in Prepared/Groups; every
change is a nonnegative reduction <=254*visited nodes, checked independently.
All exact old/new key-read counts are in review-order-reads.csv.

All 62 Groups heap peaks and allocation counts exactly equal Prepared; zero
peaks exceed frozen Block LSD. Maximum Groups/Stable requested-heap peak is
0.25396293 in this matrix. At large128/B512 the peak is 33,589,760 bytes, same
as frozen LSD, versus 134,784,664 for Stable on uniform and 376,387,624 on majority.
At wide32/deep_unique98/B64 it is 1,212,928 versus 414,966,888 bytes.

These are requested simultaneously-live heap bytes, excluding the restored
input and outside-timer oracle; they are not RSS or a stack measurement. The
new safe equality accumulator is constant-size native-key local state, and
the wide early exit adds no allocated state or record staging.
