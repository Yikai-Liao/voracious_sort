"""Exhaustive abstract cycle/segmented-cycle check; not a performance test."""
from itertools import permutations

def cycles(pi):
    seen = set()
    for start in range(len(pi)):
        if start in seen:
            continue
        cycle = []
        v = start
        while v not in seen:
            seen.add(v)
            cycle.append(v)
            v = pi[v]
        assert v == start
        yield cycle

def apply(pi, p, reverse):
    a = list(range(len(pi)))
    copies = 0
    for cycle in cycles(pi):
        l = len(cycle)
        if l == 1:
            continue
        q = min(l, p)
        cuts = [j*l//q for j in range(q+1)]
        scratch = [a[cycle[cuts[j]]] for j in range(q)]
        copies += q
        # Each team's saves complete before any writer proceeds.
        pending = []
        for j in range(q):
            pending.append(list(range(cuts[j], cuts[j+1]-1)))
        order = list(range(q))
        if reverse:
            order.reverse()
        # Arbitrary interleaving of segment-internal ordered shifts.
        while any(pending):
            for j in order:
                if pending[j]:
                    i = pending[j].pop(0)
                    a[cycle[i]] = a[cycle[i+1]]
                    copies += 1
        for j in order:
            a[cycle[cuts[j+1]-1]] = scratch[(j+1)%q]
            copies += 1
        # Scratch is retained until all boundary readers complete.
    assert a == list(pi)
    assert copies <= 2*len(pi)

checks = 0
for n in range(8):
    for pi in permutations(range(n)):
        for p in (1,2,3,4):
            for reverse in (False,True):
                apply(pi,p,reverse)
                checks += 1
print(f'{checks} exhaustive abstract checks passed for all permutations of 0..7 slots, four worker counts, and two segment interleavings.')
print('Checked token permutation and at most 2N logical block copies; no physical memory, concurrent implementation, or timing claim.')
