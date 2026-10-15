"""Phase-ordered batch finalization unit. No actual threads or speed claim.
The descriptor-per-record list is verification instrumentation, not a proposed
production metadata representation. Unit initialization adds pre-reserved 2p
pool blocks; p b-record gather buffers are outside the pool.
"""
from global_dfs_model import Pool
from retained_dfs_model import Completed
import retained_dfs_model as serial
import fixed_fork_model as fork
from collections import deque,defaultdict
from itertools import product
import random,json,sys
ADD_EXTRA_POOL = "--no-extra-pool" not in sys.argv


def descriptors(C,b):
    tail=iter((h,j) for h,length in C.E.parts for j in range(length))
    out=[]
    for h,count in zip(C.C,C.before):
        out.extend(next(tail) for _ in range(count));out.extend((h,j) for j in range(b))
    out.extend(next(tail) for _ in range(C.trailing));assert next(tail,None) is None
    return out


def finalize(P,C,p,seed):
    rng=random.Random(seed);b=P.b;q=P.q
    desc=descriptors(C,b);expected=C.records();assert len(desc)==P.n
    assert len(set(desc))==len(desc)
    handles={h for h,j in desc};loc={h:h for h in handles};inverse={h:h for h in handles};fixed=set()
    cset=set(C.C)
    # Reserved capacity is installed once before this finalization unit begins.
    initial_blocks=len(P.mem);start=max(P.mem,default=-1)+1
    extra_blocks=2*p if ADD_EXTRA_POOL else 0
    for z in range(start,start+extra_blocks):P.mem[z]=[None]*b;P.free.append(z);P.freeset.add(z)
    fixed_capacity=len(P.mem);P.nonfull_limit=fixed_capacity
    initial_free=len(P.free);assert initial_free>=3
    stats={'batches':0,'shared_source_gather_batches':0,'source_in_target_records':0,'evacuated_C':0,'evacuated_E':0,'target_already_free':0,'relocated_handles_more_than_once':0}
    relocation=defaultdict(int)
    for first in range(0,q,p):
        k=min(p,q-first);targets=set(range(first,first+k));task_order=list(range(k));rng.shuffle(task_order)
        buffers=[[None]*b for _ in range(k)];source_tasks=defaultdict(set)
        before={z:tuple(data) for z,data in P.mem.items()}
        # Read-only gather; every descriptor survives prior batch relocations.
        for task in task_order:
            for j in range(b):
                index=(first+task)*b+j;h,offset=desc[index];source=loc[h]
                assert source not in fixed and P.mem[source][offset] is not None
                buffers[task][j]=P.mem[source][offset]
                assert buffers[task][j]==expected[index]
                source_tasks[source].add(task)
                stats['source_in_target_records']+=int(source in targets)
        assert all(tuple(P.mem[z])==old for z,old in before.items()),'GATHER_MUTATED_SOURCE'
        stats['shared_source_gather_batches']+=int(any(len(s)>1 for s in source_tasks.values()))
        # Barrier: commit the entire logical prefix before releasing any source.
        selected=desc[first*b:(first+k)*b];commit=list(selected);rng.shuffle(commit)
        touched=set()
        for h,offset in commit:
            source=loc[h];assert P.mem[source][offset] is not None
            P.mem[source][offset]=None;touched.add(h)
        for h in touched:
            source=loc[h]
            if all(x is None for x in P.mem[source]):
                del loc[h];del inverse[source];P.release(source)
        # Reserve ALL final target addresses before allocating evacuation blocks.
        for target in targets:
            assert target not in fixed
            if target in P.freeset:
                P.freeset.remove(target);P.free.remove(target);stats['target_already_free']+=1
            else:assert target in inverse,'TARGET_NEITHER_FREE_NOR_LIVE'
        victims=[]
        for target in sorted(targets):
            if target in inverse:
                h=inverse[target];destination=P.get()
                assert destination not in targets and destination not in fixed and destination not in inverse
                victims.append((target,destination,h))
        assert len({dest for _,dest,_ in victims})==len(victims)
        # Parallel-copy phase: all sources/maps remain unchanged until copies finish.
        copy_order=list(victims);rng.shuffle(copy_order)
        for source,dest,h in copy_order:
            assert loc[h]==source and all(x is None for x in P.mem[dest])
            P.mem[dest]=list(P.mem[source])
        # Barrier, then relocation-map updates and target invalidation.
        for source,dest,h in victims:
            assert inverse[source]==h and loc[h]==source
            del inverse[source];inverse[dest]=h;loc[h]=dest;P.mem[source]=[None]*b
            stats['evacuated_C' if h in cset else 'evacuated_E']+=1;relocation[h]+=1
        write_order=list(range(k));rng.shuffle(write_order)
        for task in write_order:
            target=first+task
            for j,x in enumerate(buffers[task]):P.write(target,j,x)
        fixed|=targets;stats['batches']+=1
        P.snapshot();assert len(P.mem)==fixed_capacity
        assert len(P.free)>=initial_free-2,'FREE_BLOCK_PREFIX_BOUND'
        assert [x for z in range(first+k) for x in P.mem[z]]==expected[:(first+k)*b]
    # Final partial A suffix is outside the block pool and has no unread source.
    remainder=[]
    for h,offset in desc[q*b:]:
        source=loc[h];x=P.mem[source][offset];assert x is not None
        remainder.append(x);P.mem[source][offset]=None
    for h,source in list(loc.items()):
        assert all(x is None for x in P.mem[source]);P.release(source);del loc[h];del inverse[source]
    output=[x for z in range(q) for x in P.mem[z]]+remainder
    assert output==expected and not inverse and not loc
    assert all(z in fixed or z in P.freeset for z in P.mem)
    assert len(P.mem)==initial_blocks+extra_blocks
    stats['relocated_handles_more_than_once']=sum(c>1 for c in relocation.values())
    return output,stats


def capture_serial(keys,b,R,D):
    state=[];old=serial.materialize
    def capture(P,C):state.append((P,C));return C.records(),{}
    serial.materialize=capture
    try:serial.run(keys,b,R,D)
    finally:serial.materialize=old
    return state[0]

def capture_fork(keys,b,R,D,p,seed):
    state=[];old=fork.materialize
    def capture(P,C):state.append((P,C));return C.records(),{}
    fork.materialize=capture
    try:fork.run(keys,b,R,D,p,seed)
    finally:fork.materialize=old
    return state[0]

def repeated_tail(q,b):
    tags=[((0,),i) for i in range(q*b+1)];P=Pool(tags,b,2,2)
    assert P.K>=q+1
    for z in P.mem:P.mem[z]=[None]*b
    for j in range(q):P.mem[q+j]=list(tags[j*b:(j+1)*b])
    P.mem[0][0]=tags[-1]
    free=list(range(1,q))+list(range(2*q,q+P.K));P.free=deque(free);P.freeset=set(free)
    C=Completed(P);C.C=list(range(q,2*q));C.before=[0]*q;C.E.parts.append([0,1]);C.E.count=1;C.trailing=1
    return P,C

def reserve_bug():
    # In the repeated-tail fixture, A[1] is free but is a final target in batch0.
    P,C=repeated_tail(4,2)
    picked=P.get();assert picked==1
    assert picked in {0,1}
    return {'without_reserving_all_targets':'First evacuation would choose A block1, which batch0 must subsequently overwrite.','colliding_target':picked}

def main():
    cases=0;randomcases=0;forkcases=0;forced=0;totals=defaultdict(int)
    def add(P,C,p,seed):
        _,stats=finalize(P,C,p,seed)
        for k,v in stats.items():totals[k]+=v
    alphabet=list(product(range(2),repeat=2))
    for n in range(5):
        for keys in product(alphabet,repeat=n):
            for b in (1,2,3):
                for p in (1,2,3):add(*capture_serial(keys,b,2,2),p,cases);cases+=1
    rng=random.Random(282842)
    for _ in range(500):
        R=rng.choice([1,2,3,8]);D=rng.choice([0,1,2,5,8]);b=rng.choice([1,2,3,8]);n=rng.randrange(100)
        keys=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(n)]
        add(*capture_serial(keys,b,R,D),rng.choice([1,2,3,8,16]),rng.randrange(999999));randomcases+=1
    for b,R in ((2,3),(3,5),(4,5)):
        keys=[(c,d) for c in range(R) for d in range(R) for _ in range(b+1)]
        for p in (1,2,4,16):
            for seed in range(4):add(*capture_fork(keys,b,R,2,3,seed),p,seed);forkcases+=1
    for q in (1,2,4,8,12):
        for b in (2,3,8):
            for p in (1,2,3,16):
                P,C=repeated_tail(q,b);_,stats=finalize(P,C,p,q+b+p)
                assert stats['evacuated_E']==(q+p-1)//p
                for k,v in stats.items():totals[k]+=v
                forced+=1
    print(json.dumps({'exhaustive_serial_states':cases,'random_serial_states':randomcases,'fragmented_root_states':forkcases,
      'forced_relocation_states':forced,'phase_coverage_totals':dict(totals),'missing_target_reservation_counterexample':reserve_bug(),
      'extra_pool_blocks':'2p' if ADD_EXTRA_POOL else 'zero; existing input pool only','gather_buffers':'p external b-record buffers','scope':'Batch finalization unit, shuffled phase orders and read-only gather; per-record descriptors are instrumentation; no actual threading.'},indent=2))
if __name__=='__main__':main()
