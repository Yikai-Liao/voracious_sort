"""Fixed-fork disjoint-pool simulation. Jobs complete in randomized order.
This is an ownership/admission model, not concurrent execution or speed evidence.
"""
from global_dfs_model import Pool,Arena,Node
from retained_dfs_model import Completed,materialize
from collections import deque
from itertools import product
import json,random


def child_sort(P,node,depth,m,R,D):
    completed=Completed(P);frames=[]
    def verify():
        for a in frames:a.verify()
        completed.verify();P.snapshot()
    def visit(node,depth,m):
        if depth==D or m<=1:completed.append_node(node);verify();return
        full=[[] for _ in range(R)];tail=[None]*R;lens=[0]*R;counts=[0]*R
        for x in node.consume(P):
            c=x[0][depth];counts[c]+=1
            if tail[c] is None:tail[c]=P.get()
            P.write(tail[c],lens[c],x);lens[c]+=1
            if lens[c]==P.b:full[c].append(tail[c]);tail[c]=None;lens[c]=0
        arena=Arena(P)
        for c in range(R):
            if tail[c] is not None:
                z=tail[c]
                for j in range(lens[c]):
                    x=P.read(z,j)
                    if j==lens[c]-1:P.release(z)
                    arena.append(x)
        frames.append(arena);verify()
        for c in range(R):
            if counts[c]:visit(Node(full[c],arena,lens[c]),depth+1,counts[c])
        assert not arena.parts;frames.pop();verify()
    visit(node,depth,m)
    return completed


def run(keys,b,R,D,p,seed,schedule="random"):
    assert D>=1 and p>=1
    tags=[(tuple(k),i) for i,k in enumerate(keys)];n=len(tags);K=R+2*D+8
    G=Pool(tags,b,R,D);target=len(tags)//b+R+p*K
    for z in range(len(G.mem),target):G.mem[z]=[None]*b;G.free.append(z);G.freeset.add(z)
    G.K=R+p*K;G.minimum=len(G.free);G.nonfull_limit=R+p*(R+2*D+4)
    tailarena=Arena(G)
    for x in tags[G.q*b:]:tailarena.append(x)
    root=Node(list(range(G.q)),tailarena,n%b)
    full=[[] for _ in range(R)];tail=[None]*R;lens=[0]*R;counts=[0]*R
    for x in root.consume(G):
        c=x[0][0];counts[c]+=1
        if tail[c] is None:tail[c]=G.get()
        G.write(tail[c],lens[c],x);lens[c]+=1
        if lens[c]==b:full[c].append(tail[c]);tail[c]=None;lens[c]=0
    childhandles={c:set(full[c]+([tail[c]] if tail[c] is not None else [])) for c in range(R) if counts[c]}
    assert sum(map(len,childhandles.values()))==sum((m+b-1)//b for m in counts)
    assert len(G.free)>=p*K
    banks={w:set(G.free.popleft() for _ in range(K)) for w in range(p)}
    for bank in banks.values():G.freeset-=bank
    leftover=set(G.free);G.free=deque(leftover);G.freeset=set(leftover)
    queue=list(childhandles);rng=random.Random(seed)
    if schedule=="reverse":queue.sort(reverse=True)
    elif schedule=="heavy_last":queue.sort(key=lambda c:(counts[c],c))
    else:rng.shuffle(queue)
    queue=deque(queue)
    active={};completed={};maxactive=0;returned=0;bank_identity_changes=0;array_bank_handles=0;scratch_completed_handles=0
    def ownership():
        groups=list(banks.values())+[domain for _,domain in active.values()]+[childhandles[c] for c in queue]+[set(C.C+[z for z,_ in C.E.parts]) for C in completed.values()]+[leftover]
        allids=[z for group in groups for z in group]
        assert len(allids)==len(set(allids)),'DOMAIN_ALIAS'
        assert set(allids)==set(G.mem),'UNOWNED_HANDLE'
        assert all(all(x is None for x in G.mem[z]) for bank in banks.values() for z in bank)
        assert all(all(x is None for x in G.mem[z]) for z in leftover)
    while queue or active:
        for w in range(p):
            if w not in active and queue:
                c=queue.popleft();domain=childhandles[c]|banks.pop(w)
                assert len(domain)==(counts[c]+b-1)//b+K
                active[w]=(c,domain)
        maxactive=max(maxactive,len(active));ownership()
        if schedule=="reverse":w=max(active,key=lambda w:active[w][0])
        elif schedule=="heavy_last":w=min(active,key=lambda w:(counts[active[w][0]],active[w][0]))
        else:w=rng.choice(list(active))
        c,domain=active[w]
        # A private pool view shares physical cell arrays but has a private allocator.
        P=object.__new__(Pool);P.b=b;P.n=counts[c];P.q=P.n//b;P.K=K
        P.mem={z:G.mem[z] for z in domain};P.freeset=domain-childhandles[c];oldbank=set(P.freeset);P.free=deque(sorted(P.freeset))
        P.minimum=K;P.max_nonfull=0;P.moves=0;P.allocations=0;P.nonfull_limit=R+2*D+4
        A=Arena(P)
        if tail[c] is not None:A.parts.append([tail[c],lens[c]]);A.count=lens[c]
        C=child_sort(P,Node(full[c],A,lens[c]),1,counts[c],R,D)
        assert C.records()==sorted([x for x in tags if x[0][0]==c],key=lambda x:x[0])
        live=set(C.C+[z for z,_ in C.E.parts])
        assert len(live)==(counts[c]+b-1)//b
        assert len(P.free)==K and live|P.freeset==domain and not live&P.freeset
        bank_identity_changes+=int(oldbank!=P.freeset)
        array_bank_handles+=sum(z<G.q for z in P.freeset)
        scratch_completed_handles+=sum(z>=G.q for z in live)
        banks[w]=set(P.freeset);returned+=1;completed[c]=C;del active[w];ownership()
    # Join descriptors only; E may now contain a partial block at each root boundary.
    C=Completed(G)
    for c in sorted(completed):
        child=completed[c]
        if child.C:
            C.C.extend(child.C)
            C.before.extend([C.trailing+child.before[0]]+child.before[1:])
            C.trailing=child.trailing
        else:C.trailing+=child.trailing
        C.E.parts.extend(child.E.parts);C.E.count+=child.E.count
    assert C.records()==sorted(tags,key=lambda x:x[0])
    live=set(C.C+[z for z,_ in C.E.parts]);G.freeset=set(G.mem)-live;G.free=deque(sorted(G.freeset));G.snapshot()
    G.nonfull_limit=R+4
    result,branches=materialize(G,C);assert result==sorted(tags,key=lambda x:x[0])
    assert len(G.mem)==target,'BACKING_POOL_GREW'
    return {'max_active':maxactive,'jobs_returned_exact_K':returned,'banks_changed_physical_identity':bank_identity_changes,'original_array_handles_returned':array_bank_handles,'scratch_handles_completed':scratch_completed_handles,'finalizer_branches':branches}


def main():
    total=0;randomcases=0;maxactive=0;returned=0;changes=0;array_banks=0;scratch_completed=0;branches={}
    def account(r):
        nonlocal maxactive,returned,changes,array_banks,scratch_completed
        maxactive=max(maxactive,r['max_active']);returned+=r['jobs_returned_exact_K'];changes+=r['banks_changed_physical_identity']
        array_banks+=r['original_array_handles_returned'];scratch_completed+=r['scratch_handles_completed']
        for k,v in r['finalizer_branches'].items():branches[k]=branches.get(k,0)+v
    for R,D,maxn in ((2,2,5),(3,2,3)):
        alphabet=list(product(range(R),repeat=D))
        for b in (1,2,3,4):
            for n in range(maxn+1):
                for keys in product(alphabet,repeat=n):
                    for p in (1,2,3):account(run(keys,b,R,D,p,total));total+=1
    rng=random.Random(223606)
    for _ in range(500):
        R=rng.choice([1,2,3,8,16]);D=rng.choice([1,2,3,8,16]);b=rng.choice([1,2,3,8,16]);p=rng.choice([1,2,3,8]);n=rng.randrange(160)
        mode=rng.randrange(3)
        if mode==0:keys=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(n)]
        elif mode==1:keys=[(0,)*(D-1)+(rng.randrange(R),) for _ in range(n)]
        else:keys=[(0,)*D for _ in range(n)]
        account(run(keys,b,R,D,p,rng.randrange(100000)));randomcases+=1
    print(json.dumps({'exhaustive_cases':total,'randomized_cases':randomcases,'maximum_simultaneously_admitted_jobs':maxactive,
      'jobs_returning_exact_K_handles':returned,'bank_physical_identity_changed':changes,'original_array_handles_returned':array_banks,'scratch_handles_retained_in_completed_streams':scratch_completed,'finalizer_branches':branches,
      'scope':'Fixed root fork, isolated domains, randomized admission/completion, no concurrent instruction interleaving; verifies ownership, returned bank cardinality, and global stable materialization.'},indent=2))
if __name__=='__main__':main()
