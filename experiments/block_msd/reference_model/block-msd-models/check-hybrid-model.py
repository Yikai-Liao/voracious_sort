"""Abstract sequence model only: not Radsort or a native sorting benchmark."""
from itertools import product

R, D = 2, 3

def digit(key, d):
    return (key >> (D - 1 - d)) & 1

def hybrid(records, d, threshold, early, reverse):
    n = len(records)
    if d == D or (early and n <= 1):
        return records, 0, 0, 0
    if n <= threshold:
        out = list(records)
        for k in range(D - 1, d - 1, -1):
            buckets = [[], []]
            for x in out:
                buckets[digit(x[0], k)].append(x)
            out = buckets[0] + buckets[1]
        return out, 0, n * (D - d), 0
    buckets = [[], []]
    for x in records:
        buckets[digit(x[0], d)].append(x)
    results = [None, None]
    A, B, nodes = n, 0, 1
    for c in ([1, 0] if reverse else [0, 1]):
        if not buckets[c]:
            results[c] = []
            continue
        results[c], a, b, j = hybrid(buckets[c], d + 1, threshold, early, reverse)
        A, B, nodes = A + a, B + b, nodes + j
    return results[0] + results[1], A, B, nodes

checks = 0
for n in range(6):
    for keys in product(range(2 ** D), repeat=n):
        records = list(zip(keys, range(n)))
        expected = sorted(records, key=lambda x: x[0])
        for threshold in (0, 1, 2, 4):
            for early in (False, True):
                for reverse in (False, True):
                    actual, A, B, nodes = hybrid(records, 0, threshold, early, reverse)
                    assert actual == expected
                    assert A + B <= n * D
                    if not early:
                        assert A + B == n * D
                    # Every partitioned node exceeds threshold; depth at most D.
                    assert nodes <= D * (n // (threshold + 1))
                    checks += 1
print(f'{checks} exhaustive abstract checks passed; R=2, D=3, n=0..5, four thresholds, both singleton policies and both child schedules.')
print('Verified stable sequence output, exact/full or upper/early digit-visit accounting, and the internal-node count bound. No block allocator, materializer, parallel implementation, or timing was tested.')
