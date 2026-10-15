//! Experimental copy of upstream stable MSD with stable descending-run reversal.
//! See scan_experiment/REPORT.md for provenance and comparator restrictions.
use voracious_radix_sort::{RadixKey, Radixable};
mod algo {
    pub mod verge_sort_heuristic {
        include!("verge.rs");
    }
    pub mod k_way_merge {
        include!("merge.rs");
    }
}
mod sorts {
    pub mod utils {
        include!("../frozen_lsd/utils.rs");
    }
    pub mod msd_sort {
        include!("scatter.rs");
    }
    pub mod msd_stable_sort {
        include!("sort.rs");
    }
}
pub use sorts::msd_stable_sort::msd_stable_radixsort;
