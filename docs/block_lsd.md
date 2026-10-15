# Stable block LSD radix sort

`block_lsd_stable_radixsort(arr, radix, block_size)` sorts by the converted
`Radixable` key. Equal converted keys retain their original record order.
`radix` accepts 1..=8 bits per digit; `block_size` is a positive element count.

The implementation adapts Robert Clausecker's
[block LSD algorithm](https://arxiv.org/abs/2607.05302) and
[C implementation](https://github.com/clausecker/radsort/blob/f69e816c3cd79d312cd67aea5b9cf1c338c1b371/radixsort_permuted.c).
It is single-threaded and does not change the existing sort dispatchers.

## Algorithm

Each pass processes one digit, from least to most significant:

1. Traverse records in logical input order and append them to bucket blocks.
   Consumed input blocks are recycled as output storage.
2. Group block descriptors by digit while preserving each bucket's record order.
   The next pass follows this logical order without rearranging all physical blocks.
3. After the last pass, compact the logical result into the original slice.

For n records, block size b and sigma = 2^radix buckets, scratch holds
2*sigma*b records. Block directories use O(n/b + sigma) entries. With fixed
radix and record size, auxiliary space is O(b + n/b), becoming O(sqrt(n))
when b is proportional to sqrt(n). A fixed b leaves linear metadata growth.

## Additions

- **Generic keys and records.** Reuses `Radixable` and `RadixKey`, including the
  existing signed and floating-point key conversions. Radix and block size are
  caller parameters.
- **Constant-digit skipping.** The union and intersection of converted keys
  identify varying digits. Constant digits need no scatter pass; constant high
  digits are removed before sizing the fused histogram. The key scan can stop
  after a prefix establishes that every bit varies.
- **Small and ordered inputs.** At most 128 records use stable comparison sorting
  by converted key. Constant or ascending input returns directly. Descending input
  is reversed, then equal-key groups are reversed again to preserve stability.
- **Scatter acceleration within the space bound.** A conventional stable scatter
  path avoids block bookkeeping when its array buffer, histograms and cursors
  fit within the block scratch budget. The admission rule uses allocation sizes.
