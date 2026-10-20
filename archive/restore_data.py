#!/usr/bin/env python3
"""Restore compressed tables and deduplicated aliases for original plot scripts."""
from pathlib import Path
import argparse
import gzip
import hashlib
import json
import shutil

ROOT = Path(__file__).resolve().parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True, help='Empty destination for restored workspace files')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    if any(args.output.iterdir()):
        parser.error('Output directory must be empty')
    index = json.loads((ROOT / 'DATA-INDEX.json').read_text())
    for entry in index['files']:
        if 'stored' not in entry:
            continue
        data = (ROOT / 'workspaces' / entry['stored']).read_bytes()
        if entry['gzip']:
            data = gzip.decompress(data)
        assert len(data) == entry['bytes'] and hashlib.sha256(data).hexdigest() == entry['sha256'], entry['path']
        dest = args.output / entry['path']
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
    for entry in index['files']:
        if 'alias_of' not in entry:
            continue
        dest = args.output / entry['path']
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(args.output / entry['alias_of'], dest)
        assert hashlib.sha256(dest.read_bytes()).hexdigest() == entry['sha256'], entry['path']
    print(f"Restored and verified {index['logical_files']} files to {args.output}")


if __name__ == '__main__':
    main()
