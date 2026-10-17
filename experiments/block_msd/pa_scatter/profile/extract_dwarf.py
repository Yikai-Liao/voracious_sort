#!/usr/bin/env python3
"""Print the u16 Identity scatter subprogram DIEs without dumping all DWARF."""
import re
import subprocess
import sys

proc = subprocess.Popen(['readelf', '--debug-dump=info', sys.argv[1]], stdout=subprocess.PIPE, text=True)
block = []
pattern = re.compile(r'^\s*<\d+><[a-f0-9]+>: Abbrev Number:')

def output(lines):
    text = ''.join(lines)
    if ('(DW_TAG_subprogram)' in text and
        re.search(r'DW_AT_name\s*:.*(?:step_impl|scatter)<u16, u16,.*frontier::Identity', text)):
        print(text, end='')

for line in proc.stdout:
    if pattern.match(line):
        output(block)
        block = []
    block.append(line)
output(block)
raise SystemExit(proc.wait())
