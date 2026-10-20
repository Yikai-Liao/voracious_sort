#!/usr/bin/env python3
"""Collect source, tabular results, figures and reports; omit built artifacts."""
from pathlib import Path
import gzip
import hashlib
import json
import os
import shutil

ROOT = Path(__file__).resolve().parents[1]
WORKSPACES = Path('/root/code/voracious_sort-workspaces')
DEST = ROOT / 'archive' / 'workspaces'
CACHE_NAMES = {'target', '.venv', '__pycache__', '.git', '.pytest_cache'}
SUFFIXES = {'.rs', '.py', '.c', '.h', '.cpp', '.hpp', '.toml', '.lock', '.md', '.csv', '.json', '.jsonl', '.sh', '.pdf', '.svg', '.png', '.txt', '.log', '.diff', '.patch'}
NORMALIZED = {
    'benchmarks/block-lsd-pr-20261018/data/primary.jsonl': 'benchmarks/block-lsd-pr-20261018/data/timing.csv',
    'benchmarks/block-lsd-pr-20261018/data/memory.jsonl': 'benchmarks/block-lsd-pr-20261018/data/memory.csv',
    'benchmarks/block-lsd-pr-20261018/data/supplemental-sqrt-time.jsonl': 'benchmarks/block-lsd-pr-20261018/data/supplemental-sqrt-timing.csv',
    'benchmarks/block-lsd-pr-20261018/data/supplemental-sqrt-memory.jsonl': 'benchmarks/block-lsd-pr-20261018/data/supplemental-sqrt-memory.csv',
}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    entries = []
    canonical = {}
    excluded = []
    sources = ['benchmarks', 'pr-draft-20261018', 'validation/std-reuse-20261018']
    for source in sources:
        for directory, dirs, files in os.walk(WORKSPACES / source):
            parent = Path(directory)
            for name in list(dirs):
                if name in CACHE_NAMES or name.endswith('-target') or name == 'research':
                    dirs.remove(name)
            for name in sorted(files):
                src = parent / name
                relative = src.relative_to(WORKSPACES).as_posix()
                if name in {'SHA256SUMS', 'SEAL.json', 'verification.json'} or src.suffix not in SUFFIXES:
                    continue
                if relative in NORMALIZED:
                    excluded.append({'path': relative, 'represented_by': NORMALIZED[relative]})
                    continue
                if src.suffix == '.log' and not any(token in name.lower() for token in ('test', 'validation', 'audit', 'format')):
                    continue
                if src.suffix == '.txt' and any(token in name.lower() for token in ('perf', 'symbol', 'disassembl')):
                    continue
                if src.is_symlink():
                    raise RuntimeError(f'Unexpected symlink: {src}')
                before = src.stat()
                data = src.read_bytes()
                after = src.stat()
                assert (before.st_size, before.st_mtime_ns) == (after.st_size, after.st_mtime_ns), src
                assert not data.startswith(b'\x7fELF'), src
                digest = sha(data)
                entry = {'path': relative, 'bytes': len(data), 'sha256': digest}
                if src.suffix in {'.csv', '.jsonl'}:
                    entry['data_lines'] = data.count(b'\n')
                if digest in canonical:
                    entry['alias_of'] = canonical[digest]
                else:
                    compressed = src.suffix in {'.csv', '.jsonl'} and len(data) > 128 * 1024
                    stored = relative + ('.gz' if compressed else '')
                    output = DEST / stored
                    output.parent.mkdir(parents=True, exist_ok=True)
                    output.write_bytes(gzip.compress(data, compresslevel=9, mtime=0) if compressed else data)
                    canonical[digest] = relative
                    entry.update({'stored': stored, 'gzip': compressed, 'stored_bytes': output.stat().st_size})
                entries.append(entry)
    result = {
        'source_roots': sources,
        'files': sorted(entries, key=lambda e: e['path']),
        'normalized_duplicates_omitted': excluded,
        'excluded': ['Compiled executables, Cargo targets, Python environments/caches, assembly/perf dumps, duplicate JSONL already represented by complete observation CSV, obsolete binary-dependent seal files, routine build/process logs.'],
        'stored_files': sum('stored' in e for e in entries),
        'stored_bytes': sum(e.get('stored_bytes', 0) for e in entries),
        'logical_files': len(entries),
        'logical_bytes': sum(e['bytes'] for e in entries),
    }
    (ROOT / 'archive' / 'DATA-INDEX.json').write_text(json.dumps(result, indent=2) + '\n')
    for key in ['stored_files', 'stored_bytes', 'logical_files', 'logical_bytes']:
        print(f'{key}: {result[key]}', flush=True)
    print('largest:', sorted([(e.get('stored_bytes',0),e['path']) for e in entries], reverse=True)[:5], flush=True)


if __name__ == '__main__':
    main()
