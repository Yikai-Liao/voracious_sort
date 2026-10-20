import argparse, hashlib, json, os, random, re, subprocess, time, math
from pathlib import Path
ROOT=Path(__file__).resolve().parent
KINDS=['u32','u64','u128','i32','i64','f32','f64','record32','record128']
DISTS=['uniform','uniform_numeric','uniform_narrow','skew95','few_unique','sqrt_keys','common_prefix','low_bits_constant','high_only','sorted','reversed','nearly_sorted','almost_sorted','reverse_nearly_sorted','all_equal','late_difference','alternating','organ_pipe','sawtooth','zipf','normal','push_front','push_middle']
SIZES=[128,1024,16384,262144,1048576]
SEED=0x6A09E667F3BCC909
WIDTHS=dict(u32=4,u64=8,u128=16,i32=4,i64=8,f32=4,f64=8,record32=32,record128=128)

def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def vmstat():
 d=dict(x.split() for x in Path('/proc/vmstat').read_text().splitlines());return {k:int(d[k]) for k in ['pswpin','pswpout','pgmajfault','oom_kill']}
def freeze(stage):
 stage.mkdir(exist_ok=True)
 assert not (stage/'manifest.json').exists()
 if (stage/'cases.json').exists(): cases=json.loads((stage/'cases.json').read_text())
 else:
  cases=[dict(kind=k,dist=d,n=n) for k in KINDS for d in DISTS for n in SIZES]
  cases += [dict(kind='u64',dist='uniform',n=n) for n in [256,4096,65536,131072,250000,524288,2097152,4194304,8388608,16777216]]
 for c in cases:
  size=WIDTHS[c['kind']];c['block']=max(1,1024//size,math.ceil(4*math.sqrt(9*c['n']/(512*size))))
 random.Random(20261019).shuffle(cases)
 cases.sort(key=lambda c: c['n']!=1048576)
 methods=(stage/'methods.txt').read_text().strip().split(',')
 harness=stage/'harness' if (stage/'harness').exists() else ROOT
 files=[p for folder in [harness/'src',harness/'source'] for p in folder.rglob('*') if p.is_file() and p.suffix in ['.rs','.toml','.cpp','.hpp']]
 files += [harness/f for f in ['Cargo.toml','Cargo.lock','build.rs','timsort_bridge.cpp']]
 files += [ROOT/'run_auto.py',ROOT/'PLAN.md']
 files += [stage/'benchmark-time']
 if (stage/'benchmark-memory').exists(): files += [stage/'benchmark-memory']
 manifest=dict(schedule=cases,methods=methods,files={os.path.relpath(p,ROOT):sha(p) for p in files},seed=SEED,cpu=2,pa_block="max(1,1024//s,ceil(4*sqrt(9*n/(512*s))))",workspace_threshold=16777216,rustflags='-C target-cpu=native',profile='opt3 codegen1 thinLTO',compiler=subprocess.check_output(['/root/.cargo/bin/rustc','-Vv'],text=True),cpuinfo=subprocess.check_output(['lscpu'],text=True),vmstat=vmstat(),meminfo=Path('/proc/meminfo').read_text())
 (stage/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
def run(stage,mode,seeds):
 m=json.loads((stage/'manifest.json').read_text())
 for p,s in m['files'].items(): assert sha(ROOT/p)==s,p
 out=stage/(mode+'.jsonl');assert not out.exists()
 started=time.time()
 for i,c in enumerate(m['schedule'],1):
  args=['taskset','-c','2','/usr/bin/time','-f','RESOURCE %M %F %W %x',str(stage/('benchmark-'+mode)),mode,c['kind'],c['dist'],str(c['n']),str(m['seed']),'8',str(c['block']),str(seeds),','.join(m['methods'])]
  before=vmstat();start=time.time()
  p=subprocess.run(args,text=True,capture_output=True,env={**os.environ,'RAYON_NUM_THREADS':'1'})
  after=vmstat()
  meta=dict(case=c,command=args,returncode=p.returncode,wall_seconds=time.time()-start,stderr=p.stderr,vmstat_delta={k:after[k]-before[k] for k in before})
  with (stage/(mode+'-processes.jsonl')).open('a') as f:f.write(json.dumps(meta)+'\n')
  assert p.returncode==0,(c,p.stderr)
  assert int(re.search(r'VmSwap:\s+(\d+)',p.stderr)[1])==0
  rows=[json.loads(l) for l in p.stdout.splitlines()]
  assert len(rows)==len(m['methods'])*seeds*(2 if mode=='time' else 1)
  assert all(r['ordered'] and r['preserved'] and (r['valid'] or r['algorithm']=='roller') for r in rows)
  with out.open('a') as f:
   for r in rows:f.write(json.dumps(r)+'\n')
  print(f'{mode} {i}/{len(m["schedule"])} {c} elapsed={time.time()-started:.1f}s',flush=True)
 (stage/(mode+'-completion.json')).write_text(json.dumps(dict(seconds=time.time()-started,rows=len(m['schedule'])*len(m['methods'])*seeds*(2 if mode=='time' else 1),vmstat=vmstat()),indent=2)+'\n')
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('stage');p.add_argument('mode',choices=['freeze','time','memory']);p.add_argument('--seeds',type=int,default=3);a=p.parse_args();s=ROOT/a.stage
 freeze(s) if a.mode=='freeze' else run(s,a.mode,a.seeds)
