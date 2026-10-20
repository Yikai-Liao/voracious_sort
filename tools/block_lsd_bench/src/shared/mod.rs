// Use the repository's unchanged histogram kernel for the dynamic-shift
// ablation. This module stays in the standalone benchmark crate.
pub mod core;
pub mod prefetch;
pub mod cursor;
#[path = "../../../../src/sorts/utils.rs"]
pub mod utils;
