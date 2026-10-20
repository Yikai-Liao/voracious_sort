use block_msd_research::PhaseStats;
use std::cell::RefCell;
thread_local! { static STATS: RefCell<PhaseStats> = RefCell::new(PhaseStats::default()); }
pub fn reset() {
    STATS.with(|stats| {
        let mut stats = stats.borrow_mut();
        *stats = PhaseStats::default();
        stats.leaf_lengths.resize(129, 0);
    });
}
pub fn with(update: impl FnOnce(&mut PhaseStats)) {
    STATS.with(|stats| update(&mut stats.borrow_mut()));
}
pub fn take() -> PhaseStats {
    STATS.with(|stats| std::mem::take(&mut *stats.borrow_mut()))
}
