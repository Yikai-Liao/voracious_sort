#!/usr/bin/env python3
"""Verify all stored files and losslessly compressed measurement tables."""
from pathlib import Path
import gzip
import hashlib
import json

ROOT = Path(__file__).resolve().parent


def main():
    count = 0
    for line in (ROOT / 'SHA256SUMS').read_text().splitlines():
        expected, name = line.split('  ', 1)
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
        count += 1
    entries = json.loads((ROOT / 'DATA-INDEX.json').read_text())['files']
    by_name = {e['path']: e for e in entries}
    for entry in entries:
        canonical = by_name[entry['alias_of']] if 'alias_of' in entry else entry
        data = (ROOT / 'workspaces' / canonical['stored']).read_bytes()
        if canonical['gzip']:
            data = gzip.decompress(data)
        assert len(data) == entry['bytes'], entry['path']
        assert hashlib.sha256(data).hexdigest() == entry['sha256'], entry['path']
    snapshot = json.loads((ROOT / 'SNAPSHOT.json').read_text())
    for name, expected in snapshot['validated_source_sha256'].items():
        assert hashlib.sha256((ROOT.parent / name).read_bytes()).hexdigest() == expected, name
    print(f'PASS: {count} stored archive files; {len(entries)} logical files; validated adaptive API source hashes match.')


if __name__ == '__main__':
    main()
