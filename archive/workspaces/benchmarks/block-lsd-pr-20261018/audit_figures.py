#!/usr/bin/env python3
"""Run source, glyph-size and rendered-collision gates on final exports."""
import argparse
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--output-dir",type=Path,default=ROOT)
    output=parser.parse_args().output_dir.resolve()
    pdfs=sorted((output/"figures").glob("*.pdf"))
    if len(pdfs) != 4:
        raise SystemExit(f"Expected 4 final PDFs, found {len(pdfs)} in {output/'figures'}")
    failures=[]
    source=subprocess.run([sys.executable,str(ROOT/"qa-tools/validate_figure.py"),str(ROOT/"plot.py"),"--json"],capture_output=True,text=True)
    (output/"qa/source-audit.json").write_text(source.stdout)
    if source.returncode:failures.append("source")
    for pdf in pdfs:
        stem=pdf.stem
        glyph=subprocess.run([sys.executable,str(ROOT/"qa-tools/audit_pdf_text.py"),str(pdf),"--min-pt","5","--json"],capture_output=True,text=True)
        (output/"qa"/(stem+".glyph-audit.json")).write_text(glyph.stdout)
        collision=subprocess.run([sys.executable,str(ROOT/"qa-tools/audit_figure_collisions.py"),str(pdf),
            "--json-out",str(output/"qa"/(stem+".collision-audit.json")),
            "--overlay-pdf",str(output/"qa"/(stem+".collision-audit.pdf"))],capture_output=True,text=True)
        (output/"qa"/(stem+".collision-audit.log")).write_text(collision.stdout+collision.stderr)
        print(stem,"glyph",glyph.returncode,"collision",collision.returncode,flush=True)
        if glyph.returncode:failures.append(stem+":glyph")
        if collision.returncode:failures.append(stem+":collision")
    if failures:
        print("FIX BEFORE DELIVERY",", ".join(failures))
        raise SystemExit(1)
    print("All automated blocking gates passed; review warnings and final-size panels.")


if __name__=="__main__":main()
