"""Summarize the complete candidate matrix without rerunning references."""
import csv
import json
import math
import statistics
import sys
from collections import defaultdict
from pathlib import Path

root = Path(__file__).resolve().parent
stage = root / sys.argv[1]
cells = list(csv.DictReader((stage / 'acceptance-cells.csv').open()))
for row in cells:
    for key in ['n', 'observations']:
        row[key] = int(row[key])
    for key in ['ratio', 'minimum', 'maximum', 'candidate_ns', 'saved_pa_ns',
                'delta_ns', 'candidate_aa_median', 'candidate_aa_min',
                'candidate_aa_max']:
        row[key] = float(row[key]) if row[key] != '' else None


def summarize(rows):
    return dict(
        cases=len(rows),
        median_ratio=statistics.median(r['ratio'] for r in rows),
        geometric_mean_ratio=math.exp(statistics.mean(math.log(r['ratio']) for r in rows)),
        wins_10=sum(r['ratio'] < .9 for r in rows),
        losses_10=sum(r['ratio'] > 1.1 for r in rows),
        losses_20=sum(r['ratio'] > 1.2 for r in rows),
        all_observations_loss_10=sum(r['minimum'] > 1.1 for r in rows),
        all_observations_loss_20=sum(r['minimum'] > 1.2 for r in rows),
        aa_cell_median=statistics.median(r['candidate_aa_median'] for r in rows
                                       if r['candidate_aa_median'] is not None),
    )


groups = defaultdict(list)
for row in cells:
    groups['all'].append(row)
    groups['n=' + str(row['n'])].append(row)
    groups['kind=' + row['kind']].append(row)
summary = {key: summarize(rows) for key, rows in groups.items()}
summary['large_losses'] = [r for r in cells if r['n'] >= 262144 and r['ratio'] > 1.1]
summary['worst'] = sorted(cells, key=lambda r: r['ratio'], reverse=True)[:25]
summary['best'] = sorted(cells, key=lambda r: r['ratio'])[:25]
summary['note'] = ('Equal weight per scheduled cell. Historical PA ratios are not '
                   'same-process causal estimates. Duplicate candidate slots share '
                   'the same six seed/order reference conditions.')
(stage / 'campaign-summary.json').write_text(json.dumps(summary, indent=2) + '\n')

references = defaultdict(dict)
for row in csv.DictReader((root / 'auto-baseline/reuse-comparison.csv').open()):
    if row['reference_stable'].lower() == 'true':
        key = row['kind'], row['dist'], int(row['n'])
        references[key][row['comparator']] = float(row['reference_ns'])
comparisons = []
for row in cells:
    key = row['kind'], row['dist'], row['n']
    for method, ns in references[key].items():
        comparisons.append(dict(kind=key[0], dist=key[1], n=key[2], comparator=method,
                                candidate_ns=row['candidate_ns'], reference_ns=ns,
                                historical_ratio=row['candidate_ns'] / ns))
with (stage / 'reference-comparison.csv').open('w') as output:
    writer = csv.DictWriter(output, fieldnames=list(comparisons[0]))
    writer.writeheader()
    writer.writerows(comparisons)
for method in sorted({r['comparator'] for r in comparisons}):
    values = [r for r in comparisons if r['comparator'] == method and r['n'] == 1048576]
    print(method, 'million-record cases', len(values), 'candidate faster',
          sum(r['historical_ratio'] < 1 for r in values), 'over 1.5x slower',
          sum(r['historical_ratio'] > 1.5 for r in values))
for key in ['all', 'n=1048576', 'n=1024']:
    print(key, json.dumps(summary[key]))
