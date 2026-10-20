import json, subprocess, statistics, sys
from pathlib import Path
p = Path(__file__).parent
candidate = sys.argv[1]
cases = sys.argv[2:] or ["equal", "late-difference", "descending", "scatter", "random", "small"]
rows = []
for case in cases:
    for pair in range(6):
        order = ["baseline", candidate] if pair % 2 == 0 else [candidate, "baseline"]
        for binary in order:
            result = json.loads(subprocess.check_output(["taskset", "-c", "2", str(p / binary), case]))
            result.update(binary=binary, pair=pair)
            rows.append(result)
            with (p / (candidate + "-results.jsonl")).open("a") as f:
                f.write(json.dumps(result) + "\n")
    a = [r["ns_per_sort"] for r in rows if r["case"] == case and r["binary"] == "baseline"]
    b = [r["ns_per_sort"] for r in rows if r["case"] == case and r["binary"] == candidate]
    ratios = [y/x-1 for x,y in zip(a,b)]
    print(json.dumps(dict(case=case, baseline_ns=statistics.median(a), candidate_ns=statistics.median(b), median_pair_change_pct=100*statistics.median(ratios), baseline_spread_pct=100*(max(a)/min(a)-1))), flush=True)
