#!/usr/bin/env python3
"""Review fixed mechanism comparisons, preserving every cell and reference."""
import collections
import csv
from pathlib import Path
import statistics
from analyze import quantile
ROOT = Path(__file__).resolve().parent
GROUP = 'Pa_unified_groups_t16777216'
CACHED = 'Pa_unified_cache_t16777216'
SAMPLED = 'Pa_unified_sample_t16777216'
REUSED = 'Pa_unified_reuse_t16777216'
PREPARED = 'Pa_unified_prepared_t16777216'
DISTRIBUTION = ('Pa', 'Pa_unified', CACHED, SAMPLED, REUSED, PREPARED, GROUP, 'Pa')
ORDER = ('Pa', 'Pa_ordered', 'Pa_ordered_tiled', 'Pa_unified', GROUP, 'stable_msd', 'Pa')
BAND = ('Pa', 'Pa_band', 'Pa_band_nested', 'Pa_band_sortleaf', 'Pa_unified', GROUP, 'Pa')
CONFIG = {
    'mechanism-distribution-large-b512-s42.csv': (16, DISTRIBUTION, 3),
    'mechanism-distribution-medium-b64-s42.csv': (16, DISTRIBUTION, 3),
    'mechanism-order-small-b64-s42.csv': (14, ORDER, 12),
    'mechanism-band-b64-s42.csv': (14, BAND, 4),
}
FIELDS = ('n', 'block', 'seed', 'layout', 'case')
result, count = [], 0
paths = {p.name: p for p in (ROOT / 'measurements').glob('mechanism-*.csv')}
assert paths.keys() == CONFIG.keys(), (paths.keys(), CONFIG.keys())
for filename, (reps, slots, expected_cells) in CONFIG.items():
    rows = list(csv.DictReader(paths[filename].open()))
    cells = collections.defaultdict(list)
    for row in rows:
        assert row['kind'] == 'time' and row['instrumented'] == 'false'
        cells[tuple(row[k] for k in FIELDS)].append(row)
    assert len(cells) == expected_cells, filename
    for cell, data in sorted(cells.items()):
        assert len(data) == reps * len(slots), (filename, cell)
        by_rep = collections.defaultdict(dict)
        execution = collections.defaultdict(list)
        for row in data:
            rep, slot = int(row['rep']), int(row['slot'])
            assert 0 <= rep < reps and 0 <= slot < len(slots)
            assert row['method'] == slots[slot]
            assert slot not in by_rep[rep]
            by_rep[rep][slot] = (int(row['wall_ns']), int(row['cpu_ns']))
            execution[rep].append(slot)
        assert set(by_rep) == set(range(reps))
        samples = {m: [] for m in dict.fromkeys(slots)}
        aa = []
        for rep in range(reps):
            values = by_rep[rep]
            assert set(values) == set(range(len(slots)))
            expected_order = [((j if rep % 2 == 0 else len(slots) - 1 - j) + rep // 2) % len(slots) for j in range(len(slots))]
            assert execution[rep] == expected_order, (filename, cell, rep)
            aa.append(values[len(slots)-1][0] / values[0][0])
            for method in samples:
                indices = [i for i, m in enumerate(slots) if m == method]
                samples[method].append(tuple(statistics.mean(values[i][axis] for i in indices) for axis in (0, 1)))
        pairs = [(GROUP, other) for other in samples if other != GROUP]
        if slots == DISTRIBUTION:
            pairs += [(SAMPLED, CACHED), (REUSED, CACHED),
                      (PREPARED, SAMPLED), (PREPARED, REUSED)]
        elif slots == ORDER:
            pairs += [('Pa_ordered_tiled', 'Pa_ordered')]
        elif slots == BAND:
            pairs += [('Pa_band_nested', 'Pa_band'), ('Pa_band_sortleaf', 'Pa_band')]
        for numerator, denominator in dict.fromkeys(pairs):
            a, b = samples[numerator], samples[denominator]
            wall = [x[0]/y[0] for x, y in zip(a, b)]
            cpu = [x[1]/y[1] for x, y in zip(a, b)]
            result.append(dict(file=filename, **dict(zip(FIELDS, cell)), reps=reps,
                numerator=numerator, denominator=denominator,
                numerator_wall_ms=statistics.median(x[0] for x in a)/1e6,
                denominator_wall_ms=statistics.median(x[0] for x in b)/1e6,
                wall_ratio_median=statistics.median(wall), ratio_p10=quantile(wall, .1),
                ratio_p90=quantile(wall, .9), slower_reps=sum(x>1 for x in wall),
                threadcpu_ratio_median=statistics.median(cpu), aa_p10=quantile(aa, .1), aa_p90=quantile(aa, .9)))
        count += len(data)
assert count == 2336, count
with (ROOT / 'review-mechanisms.csv').open('w', newline='') as stream:
    writer = csv.DictWriter(stream, fieldnames=list(result[0]))
    writer.writeheader()
    writer.writerows(result)
print('22 mechanism cells, 2336 full-oracle rows; exact reversed rotations and all paired references reviewed')
