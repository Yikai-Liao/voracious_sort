#!/usr/bin/env python3
"""Exhaustive injective dense-block mappings; None represents uninitialized padding."""
from itertools import permutations

B = 4


def run(full, scratch, tail, mapping, rotate):
    blocks = list(mapping)
    memory = [[None] * B for _ in range(full + scratch)]
    owner = [None] * len(memory)
    for logical, source in enumerate(blocks):
        assert owner[source] is None
        owner[source] = logical
        count = tail if logical == full else B
        memory[source][:count] = range(logical * B, logical * B + count)
    writes = 0
    final_tail = []
    if rotate:
        if tail:
            source = blocks[full]
            final_tail = memory[source][:tail]
            assert None not in final_tail
            writes += tail
            owner[source] = None
        for target in range(full):
            hole = scratch + target
            if owner[hole] is not None:
                continue
            while True:
                logical = hole - scratch
                source = blocks[logical]
                if source == hole:
                    break
                assert None not in memory[source]
                memory[hole] = memory[source].copy()
                writes += B
                blocks[logical], owner[hole], owner[source] = hole, logical, None
                if source < scratch:
                    break
                hole = source
        assert all(x is None for x in owner[:scratch])
        for target in range(full):
            destination, source = scratch + target, blocks[target]
            if source == destination:
                continue
            other = owner[destination]
            assert other is not None and other < full
            if source == scratch + other:
                memory[source], memory[destination] = memory[destination], memory[source]
                writes += 2 * B
                blocks[other], owner[source] = source, other
                blocks[target], owner[destination] = destination, target
                continue
            assert None not in memory[destination]
            memory[0] = memory[destination].copy()
            writes += B
            hole = destination
            while True:
                logical = hole - scratch
                source = blocks[logical]
                origin = 0 if source == destination else source
                assert None not in memory[origin]
                memory[hole] = memory[origin].copy()
                writes += B
                blocks[logical], owner[hole] = hole, logical
                if source == destination:
                    break
                hole = source
        assert blocks[:full] == list(range(scratch, scratch + full))
        assert all(owner[scratch + i] == i for i in range(full))
    else:
        for target in range(full):
            source, destination = blocks[target], scratch + target
            if source == destination:
                continue
            other = owner[destination]
            if other is not None and other > target:
                # The old Rust implementation swaps MaybeUninit<T>, including
                # padding in a partial owner; this does not read padding as T.
                memory[source], memory[destination] = memory[destination], memory[source]
                writes += 2 * B
                blocks[other], owner[source] = source, other
            else:
                assert None not in memory[source]
                memory[destination] = memory[source].copy()
                writes += B
                owner[source] = None
            blocks[target], owner[destination] = destination, target
        if tail:
            final_tail = memory[blocks[full]][:tail]
            assert None not in final_tail
            writes += tail
    result = [v for block in memory[scratch:] for v in block] + final_tail
    assert result == list(range(full * B + tail))
    return writes


def main():
    cases = improved = saved = 0
    for full in range(6):
        for scratch in (1, 2):
            for tail in (0, 1, 3):
                for mapping in permutations(range(full + scratch), full + bool(tail)):
                    old = run(full, scratch, tail, mapping, False)
                    new = run(full, scratch, tail, mapping, True)
                    assert new <= old, (full, scratch, tail, mapping, old, new)
                    cases += 1
                    improved += new < old
                    saved += old - new
    assert cases == 17399
    print(f"PASS cases={cases} strictly_fewer_writes={improved} total_saved_records={saved}")


if __name__ == "__main__":
    main()
