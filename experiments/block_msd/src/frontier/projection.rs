//! A complete order-preserving projection of at most eight varying key bits.
use super::NativeKey;

pub(super) struct ByteProjection {
    shifts: [u8; 8],
    masks: [u8; 8],
    segments: usize,
    bits: usize,
}

impl ByteProjection {
    pub(super) fn new<U: NativeKey>(variation: U) -> Self {
        assert!(variation.count_ones() <= 8);
        let mut plan =
            Self { shifts: [0; 8], masks: [0; 8], segments: 0, bits: 0 };
        let mut source = 0;
        while source < U::BITS {
            if (variation >> source).byte(0) & 1 == 0 {
                source += 1;
                continue;
            }
            let start = source;
            while source < U::BITS && (variation >> source).byte(0) & 1 != 0 {
                source += 1;
            }
            let length = source - start;
            plan.shifts[plan.segments] = (start - plan.bits) as u8;
            plan.masks[plan.segments] =
                (((1u16 << length) - 1) << plan.bits) as u8;
            plan.bits += length;
            plan.segments += 1;
        }
        plan
    }

    #[inline]
    pub(super) fn label<U: NativeKey>(&self, key: U) -> u8 {
        let mut label = 0;
        for segment in 0..self.segments {
            label |= (key >> self.shifts[segment] as usize).byte(0) as u8
                & self.masks[segment];
        }
        label
    }

    pub(super) fn variation(&self) -> u8 {
        ((1u16 << self.bits) - 1) as u8
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn embedded(label: usize, positions: &[usize]) -> u128 {
        positions.iter().enumerate().fold(0, |key, (bit, &position)| {
            key | (((label >> bit) & 1) as u128) << position
        })
    }

    #[test]
    fn full_projection_preserves_order_equality_and_constant_bits() {
        let positions: &[&[usize]] = &[
            &[],
            &[127],
            &[0, 127],
            &[63, 64],
            &[0, 1, 2, 3, 4, 5, 6, 7],
            &[120, 121, 122, 123, 124, 125, 126, 127],
            &[0, 18, 36, 54, 72, 90, 108, 126],
            &[0, 1, 31, 63, 64, 65, 126, 127],
            &[7, 8, 31, 62, 63, 64, 127],
        ];
        for &positions in positions {
            let variation = embedded((1 << positions.len()) - 1, positions);
            let plan = ByteProjection::new(variation);
            assert_eq!(plan.variation() as usize, (1 << positions.len()) - 1);
            for label in 0..1 << positions.len() {
                let key = embedded(label, positions);
                assert_eq!(plan.label(key), label as u8);
                assert_eq!(plan.label(key | !variation), label as u8);
            }
        }
        for mask in 0..=u16::MAX {
            if mask.count_ones() > 8 {
                continue;
            }
            let plan = ByteProjection::new(mask);
            let positions: Vec<_> =
                (0..16).filter(|bit| mask & (1 << bit) != 0).collect();
            for label in 0..1 << positions.len() {
                assert_eq!(
                    plan.label(embedded(label, &positions) as u16),
                    label as u8
                );
            }
        }
    }
}
