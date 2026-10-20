#!/usr/bin/env python3
"""Verify a portable zstd tar against the SHA256SUMS stored inside it."""
import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import subprocess
import tarfile


def digest_stream(stream):
    digest = hashlib.sha256()
    for chunk in iter(lambda: stream.read(1024 * 1024), b""):
        digest.update(chunk)
    return digest.hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("archive", type=Path)
    parser.add_argument("--json-out", type=Path)
    args = parser.parse_args()
    actual = {}
    manifest = None
    prefix = None
    forbidden = {".git", ".venv", "target", "__pycache__"}
    process = subprocess.Popen(["zstd", "-dc", str(args.archive)], stdout=subprocess.PIPE)
    try:
        with tarfile.open(fileobj=process.stdout, mode="r|") as archive:
            for member in archive:
                path = PurePosixPath(member.name)
                assert not path.is_absolute() and ".." not in path.parts, member.name
                assert not forbidden.intersection(path.parts), member.name
                if member.isdir():
                    continue
                assert member.isfile() and len(path.parts) > 1, member.name
                if prefix is None:
                    prefix = path.parts[0]
                assert path.parts[0] == prefix, member.name
                relative = str(PurePosixPath(*path.parts[1:]))
                assert relative not in actual, relative
                stream = archive.extractfile(member)
                if relative == "SHA256SUMS":
                    content = stream.read()
                    manifest = content.decode("utf-8")
                    actual[relative] = hashlib.sha256(content).hexdigest()
                else:
                    actual[relative] = digest_stream(stream)
        assert process.wait() == 0, "zstd decompression failed"
    finally:
        process.stdout.close()
        if process.poll() is None:
            process.terminate()
            process.wait()
    assert manifest is not None, "No SHA256SUMS in archive"
    expected = {}
    for line in manifest.splitlines():
        digest, name = line.split("  ", 1)
        assert name not in expected, name
        expected[name] = digest
    assert set(actual) == set(expected) | {"SHA256SUMS"}, "Archive member set differs from seal"
    for name, digest in expected.items():
        assert actual[name] == digest, name
    with args.archive.open("rb") as stream:
        archive_digest = digest_stream(stream)
    result = dict(archive=str(args.archive.resolve()), bytes=args.archive.stat().st_size,
                  sha256=archive_digest, bundle_prefix=prefix, sealed_files=len(expected),
                  file_members=len(actual), all_member_hashes_match=True,
                  no_extra_or_missing_members=True, excluded_cache_directories_absent=True)
    serialized = json.dumps(result, indent=2) + "\n"
    if args.json_out:
        args.json_out.write_text(serialized)
    print(serialized, end="")


if __name__ == "__main__":
    main()
