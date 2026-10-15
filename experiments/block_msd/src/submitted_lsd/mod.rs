//! Exact submitted serial Block LSD at commit d6f6b70497ae25f3600b5f458b316a4cedfcb470.
//! The shared frozen utils file is byte-identical to that commit's utils.rs.
#[path = "../frozen_lsd/utils.rs"]
pub mod utils;
pub mod sort;
pub use sort::block_lsd_stable_radixsort;
