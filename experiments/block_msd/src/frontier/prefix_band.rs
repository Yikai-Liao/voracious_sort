//! A candidate prefix interval, from sampling through exact approval.
//! It can contain distinct keys; only its shared prefix is consumed.
use super::*;

pub(super) struct PrefixBand<U> {
    low: usize,
    prefix: U,
    mask: U,
    side_width: usize,
}

impl<U: NativeKey> PrefixBand<U> {
    #[inline]
    pub(super) fn contains(&self, key: U) -> bool {
        (key & self.mask) >> self.low == self.prefix
    }

    // A sampled interval is only a preparation signal. Exact membership must
    // certify a majority, and its prefix must skip more than an ordinary node.
    pub(super) fn approve(
        mut self,
        width: usize,
        coarse: usize,
        population: usize,
        len: usize,
    ) -> Option<Self> {
        if population <= len / 2 || width.saturating_sub(self.low) <= coarse {
            return None;
        }
        self.side_width = width;
        Some(self)
    }
}

impl<U: NativeKey> Classifier<U> for PrefixBand<U> {
    #[inline]
    fn label(&self, key: U) -> U {
        let prefix = (key & self.mask) >> self.low;
        U::from_u128(match prefix.cmp(&self.prefix) {
            std::cmp::Ordering::Less => 0,
            std::cmp::Ordering::Equal => 1,
            std::cmp::Ordering::Greater => 2,
        })
    }

    fn remaining(&self, key: U) -> usize {
        if self.contains(key) {
            self.low
        } else {
            self.side_width
        }
    }
}

pub(super) fn sample<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    cap: usize,
    coarse: usize,
    stats: &mut Work,
) -> Option<PrefixBand<Converted<T, K>>>
where
    Converted<T, K>: NativeKey,
{
    if cap <= coarse {
        return None;
    }
    let mask = Converted::<T, K>::mask(cap);
    let zero = Converted::<T, K>::from_u128(0);
    let mut keys = [zero; 64];
    let mut union = zero;
    let mut intersection = mask;
    let mut previous = arr[0].into_key_type() & mask;
    let mut ascending = true;
    let mut descending = true;
    let last = arr.len() - 1;
    for (i, slot) in keys.iter_mut().enumerate() {
        // Quotient/remainder form avoids overflow for any valid slice length.
        let index = i * (last / 63) + i * (last % 63) / 63;
        let key = arr[index].into_key_type() & mask;
        union |= key;
        intersection &= key;
        ascending &= previous <= key;
        descending &= previous >= key;
        previous = key;
        *slot = key;
    }
    work! { stats.probe_records += 64; }
    if ascending || descending {
        return None;
    }
    // A numeric median lies in any sampled prefix interval with a majority.
    // The 40th nearest XOR key gives a conservative 40/64 support signal.
    // No probabilistic claim is needed: the full node verifies membership.
    let pivot = *keys.select_nth_unstable(32).1;
    for key in &mut keys {
        *key = *key ^ pivot;
    }
    let distance = *keys.select_nth_unstable(39).1;
    let low = Converted::<T, K>::BITS - distance.leading_zeros() as usize;
    if cap - low <= coarse || (union ^ intersection) >> low == zero {
        return None;
    }
    Some(PrefixBand { low, prefix: pivot >> low, mask, side_width: cap })
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn prefix_intervals_preserve_order_and_suffix() {
        for width in 1..=8 {
            for low in 0..width {
                for prefix in 0u16..1 << (width - low) {
                    let band = PrefixBand {
                        low,
                        prefix,
                        mask: (1 << width) - 1,
                        side_width: width,
                    };
                    let mut previous = 0;
                    for key in 0u16..1 << width {
                        let key = key | 0x8000;
                        let label = band.label(key);
                        assert!(label >= previous);
                        previous = label;
                        assert_eq!(label == 1, band.contains(key));
                        assert_eq!(
                            band.remaining(key),
                            if label == 1 { low } else { width }
                        );
                    }
                }
            }
        }
    }
}
