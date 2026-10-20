//! Stable completion of a bounded natural-run frontier, within PA's scratch budget.
use super::*;

const MAX_RUNS: usize = 128;

#[derive(Clone, Copy, Default)]
struct Run {
    start: usize,
    end: usize,
    descending: bool,
}

#[inline(never)]
pub(super) fn complete<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    block: usize,
) -> bool {
    let mut runs = [Run::default(); MAX_RUNS];
    // Amortize one frontier entry over the existing 128-record PA leaf size.
    // Small inputs reject disorder quickly; the fixed stack frontier also
    // bounds discovery and scheduling state for arbitrarily large inputs.
    let run_limit = (arr.len() / 128).clamp(2, MAX_RUNS);
    let mut count = 0;
    let mut start = 0;
    // Prove the whole frontier before changing any record. Rejection leaves
    // the input untouched, including equal-key identities and payloads.
    while start < arr.len() {
        if count == run_limit {
            return false;
        }
        let mut end = (start + 2).min(arr.len());
        let descending = start + 1 < arr.len()
            && arr[start].into_key_type() > arr[start + 1].into_key_type();
        while end < arr.len()
            && if descending {
                arr[end - 1].into_key_type() > arr[end].into_key_type()
            } else {
                arr[end - 1].into_key_type() <= arr[end].into_key_type()
            }
        {
            end += 1;
        }
        runs[count] = Run { start, end, descending };
        count += 1;
        start = end;
    }
    for run in &runs[..count] {
        // Descending runs are strict, so reversing cannot reorder equal keys.
        if run.descending {
            arr[run.start..run.end].reverse();
        }
    }
    let budget = 512usize.checked_mul(block).expect("scratch size overflow");
    let mut scratch = Vec::new();
    while count > 1 {
        let mut next = 0;
        for i in (0..count).step_by(2) {
            let left = runs[i];
            if i + 1 == count {
                runs[next] = left;
            } else {
                let right = runs[i + 1];
                merge::<T, K>(
                    &mut arr[left.start..right.end],
                    left.end - left.start,
                    budget,
                    &mut scratch,
                );
                runs[next] = Run {
                    start: left.start,
                    end: right.end,
                    descending: false,
                };
            }
            next += 1;
        }
        count = next;
    }
    true
}

// Trim already-final prefixes/suffixes before reserving scratch. If neither
// side fits, stable binary cuts and rotation reduce the same merge until it
// does. At most one bounded scratch allocation survives between merges.
fn merge<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    middle: usize,
    budget: usize,
    scratch: &mut Vec<T>,
) {
    if middle == 0
        || middle == arr.len()
        || arr[middle - 1].into_key_type() <= arr[middle].into_key_type()
    {
        return;
    }
    let first_right = arr[middle].into_key_type();
    let last_left = arr[middle - 1].into_key_type();
    let start =
        arr[..middle].partition_point(|v| v.into_key_type() <= first_right);
    let end = middle
        + arr[middle..].partition_point(|v| v.into_key_type() < last_left);
    let middle = middle - start;
    let arr = &mut arr[start..end];
    let right = arr.len() - middle;
    if middle.min(right) <= budget {
        scratch.clear();
        let needed = middle.min(right);
        if scratch.capacity() < needed {
            scratch.reserve_exact(needed);
        }
        if middle <= right {
            scratch.extend_from_slice(&arr[..middle]);
            let (mut i, mut j, mut out) = (0, middle, 0);
            while i < middle && j < arr.len() {
                if scratch[i].into_key_type() <= arr[j].into_key_type() {
                    arr[out] = scratch[i];
                    i += 1;
                } else {
                    arr[out] = arr[j];
                    j += 1;
                }
                out += 1;
            }
            arr[out..out + middle - i].copy_from_slice(&scratch[i..]);
        } else {
            scratch.extend_from_slice(&arr[middle..]);
            let (mut i, mut j, mut out) = (middle, right, arr.len());
            while i > 0 && j > 0 {
                out -= 1;
                if scratch[j - 1].into_key_type() >= arr[i - 1].into_key_type()
                {
                    j -= 1;
                    arr[out] = scratch[j];
                } else {
                    i -= 1;
                    arr[out] = arr[i];
                }
            }
            arr[..j].copy_from_slice(&scratch[..j]);
        }
        return;
    }
    let (left_cut, right_cut) = if middle >= right {
        let left_cut = middle / 2;
        let key = arr[left_cut].into_key_type();
        (left_cut, arr[middle..].partition_point(|v| v.into_key_type() < key))
    } else {
        let right_cut = right / 2;
        let key = arr[middle + right_cut].into_key_type();
        (arr[..middle].partition_point(|v| v.into_key_type() <= key), right_cut)
    };
    arr[left_cut..middle + right_cut].rotate_left(middle - left_cut);
    let new_middle = left_cut + right_cut;
    let (left, right) = arr.split_at_mut(new_middle);
    merge::<T, K>(left, left_cut, budget, scratch);
    merge::<T, K>(right, middle - left_cut, budget, scratch);
}

#[cfg(test)]
mod tests {
    use super::*;
    #[derive(Clone, Copy, Debug, PartialEq, PartialOrd)]
    struct Record {
        key: u64,
        id: usize,
        payload: [u64; 3],
    }
    impl Radixable<u64> for Record {
        type Key = u64;
        fn key(&self) -> u64 {
            self.key
        }
    }
    fn record(key: u64, id: usize) -> Record {
        Record { key, id, payload: [id as u64, !(id as u64), key ^ 0xdeadbeef] }
    }
    fn random(state: &mut u64) -> u64 {
        *state ^= *state << 13;
        *state ^= *state >> 7;
        *state ^= *state << 17;
        *state
    }

    #[test]
    fn bounded_merge_preserves_ties_payloads_and_scratch_limit() {
        let mut seed = 678901;
        for n in [2, 3, 7, 31, 128, 257, 1024] {
            for middle in [1, n / 2, n - 1] {
                for budget in [1, 2, 7, 64, 512] {
                    let mut values: Vec<_> = (0..n)
                        .map(|i| record(random(&mut seed) % 37, i))
                        .collect();
                    values[..middle].sort_by_key(|v| v.key);
                    values[middle..].sort_by_key(|v| v.key);
                    let mut expected = values.clone();
                    expected.sort_by_key(|v| v.key);
                    let mut scratch = Vec::new();
                    merge::<Record, u64>(
                        &mut values,
                        middle,
                        budget,
                        &mut scratch,
                    );
                    assert_eq!(values, expected);
                    assert!(scratch.capacity() <= budget);
                }
            }
        }
    }

    #[test]
    fn natural_frontiers_and_rejection_preserve_full_records() {
        let mut seed = 1234567;
        for parts in [1, 2, 3, 7, 16, 32, 63, 64, 65, 128] {
            for trial in 0..8 {
                let mut values = Vec::new();
                for part in 0..parts {
                    let length = 1 + (random(&mut seed) % 67) as usize;
                    let start = values.len();
                    for i in 0..length {
                        values.push(record(random(&mut seed) % 113, start + i));
                    }
                    values[start..].sort_by_key(|v| v.key);
                    if (part + trial) % 2 == 0 {
                        values[start..].reverse();
                    }
                }
                let before = values.clone();
                let mut expected = before.clone();
                expected.sort_by_key(|v| v.key);
                if complete::<Record, u64>(&mut values, 1) {
                    assert_eq!(values, expected);
                } else {
                    assert_eq!(values, before);
                }
            }
        }
    }
}
