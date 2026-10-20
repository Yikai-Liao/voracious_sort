#!/usr/bin/env python3
"""Audit the exact final PDFs, including a fresh collision check after rendering."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT=Path(__file__).resolve().parent


def main():
    parser=argparse.ArgumentParser();parser.add_argument("--fits-only",action="store_true")
    args=parser.parse_args()
    stems=["curve-and-tier-fitting"] if args.fits_only else ["01-algorithm-comparison","01b-efficiency-overview","02-policy-selection","curve-and-tier-fitting"]
    failures=[]
    for source in (["plot_fits.py"] if args.fits_only else ["plot_story.py","plot_fits.py"]):
        run=subprocess.run([sys.executable,str(ROOT/"qa-tools/validate_figure.py"),str(ROOT/source),"--json"],capture_output=True,text=True)
        (ROOT/"qa"/(source+".source-audit.json")).write_text(run.stdout)
        report=json.loads(run.stdout)
        if run.returncode or report["summary"]["counts"]["FAIL"]:
            failures.append(source+":source")
    metadata=[]
    for stem in stems:
        pdf=ROOT/"figures"/(stem+".pdf")
        assert pdf.is_file(),pdf
        glyph=subprocess.run([sys.executable,str(ROOT/"qa-tools/audit_pdf_text.py"),str(pdf),"--min-pt","5","--json"],capture_output=True,text=True)
        (ROOT/"qa"/(stem+".glyph-audit.json")).write_text(glyph.stdout)
        collision=subprocess.run([sys.executable,str(ROOT/"qa-tools/audit_figure_collisions.py"),str(pdf),
                                  "--json-out",str(ROOT/"qa"/(stem+".collision-audit.json")),
                                  "--overlay-pdf",str(ROOT/"qa"/(stem+".collision-audit.pdf"))],capture_output=True,text=True)
        (ROOT/"qa"/(stem+".collision-audit.log")).write_text(collision.stdout+collision.stderr)
        if glyph.returncode:failures.append(stem+":glyph")
        if collision.returncode:failures.append(stem+":collision")
        import fitz
        with fitz.open(pdf) as document:
            metadata.append(dict(file=str(pdf.relative_to(ROOT)),sha256=hashlib.sha256(pdf.read_bytes()).hexdigest(),
                                 pages=[dict(width_mm=page.rect.width*25.4/72,height_mm=page.rect.height*25.4/72,
                                             fonts=page.get_fonts(full=True)) for page in document]))
        print(stem,"glyph",glyph.returncode,"collision",collision.returncode,flush=True)
    (ROOT/"qa"/("fits-export-metadata.json" if args.fits_only else "export-metadata.json")).write_text(json.dumps(metadata,indent=2)+"\n")
    if failures:
        print("FIX BEFORE DELIVERY",", ".join(failures));raise SystemExit(1)
    print("Automated blocking gates passed; inspect every panel and review warnings.")


if __name__=="__main__":main()
