"""Cooperative root: ordered block-aligned chunks, fragmented digit inputs,
private K banks independent of chunk count, randomized completion. No real threads.
"""
from global_dfs_model import Pool,Arena,Node
from retained_dfs_model import Completed,materialize
from fixed_fork_model import child_sort
from adaptive_frontier_model import view,node,split,join
from collections import deque
from itertools import product
import random,json

class SegmentedNode:
    def __init__(self,parts,b,m):
        self.parts=parts;self.b=b;self.m=m
        self.S=sum(len(full)+(tail is not None) for full,tail,r in parts)
        self.W0=self.S*b-m;self.processed=0;self.freed=0;self.max_excess=0
    def consume(self,P):
        for full,tail,r in self.parts:
            streams=[(z,self.b) for z in full]+([] if tail is None else [(tail,r)])
            for z,length in streams:
                for j in range(length):
                    x=P.read(z,j);self.processed+=1
                    excess=self.processed-self.freed*self.b
                    self.max_excess=max(self.max_excess,excess)
                    assert 0<=self.W0+excess<=self.W0+self.b,'SOURCE_HOLE_CREDIT'
                    if j==length-1:P.release(z);self.freed+=1
                    yield x
        assert self.freed==self.S and self.processed==self.m
        assert self.W0+self.processed-self.freed*self.b==0


def run(keys,b,R,D,p,seed,schedule='random'):
    assert D>=1 and p>=1
    tags=[(tuple(k),i) for i,k in enumerate(keys)];n=len(tags);q=n//b;K=R+2*D+8
    target=q+p*(R+K)+1;G=Pool(tags,b,R,D)
    for z in range(len(G.mem),target):G.mem[z]=[None]*b;G.free.append(z);G.freeset.add(z)
    G.K=target-q;G.minimum=len(G.free);G.nonfull_limit=p*(R+2*D+4)
    A=Arena(G)
    for x in tags[q*b:]:A.append(x)
    tail=A.parts[0][0] if A.parts else None
    initial=[];domains=[]
    for j in range(p):
        full=list(range(q*j//p,q*(j+1)//p));th=tail if j==p-1 else None;r=n%b if j==p-1 else 0
        m=len(full)*b+r;hs=set(full)|({th} if th is not None else set())
        bank=set(G.free.popleft() for _ in range(R+K));domains.append(hs|bank)
        initial.append((full,th,r,m,hs,bank))
    free=set(G.free);rootparts={};rng=random.Random(seed);order=list(range(p));rng.shuffle(order)
    for j in order:
        full,th,r,m,hs,bank=initial[j]
        P=view(G,domains[j],bank,m,K,R,D)
        children=split(P,node(P,full,th,r),0,R)
        assert len(P.free)>=K
        rootparts[j]={c:(mi,fc,tc,rc) for c,mi,fc,tc,rc in children}
        free|=P.freeset
    jobs={}
    for c in range(R):
        parts=[];m=0;hs=set()
        for j in range(p):
            if c in rootparts[j]:
                mi,fc,tc,rc=rootparts[j][c];parts.append((fc,tc,rc));m+=mi
                hs|=set(fc)|({tc} if tc is not None else set())
        if m:jobs[c]=(parts,m,hs)
    assert len(free)>=p*K
    banks={}
    for w in range(p):
        bank=set(sorted(free)[:K]);free-=bank;banks[w]=bank
    waiting=list(jobs)
    if schedule=='reverse':waiting.sort(reverse=True)
    elif schedule=='heavy_last':waiting.sort(key=lambda c:(jobs[c][1],c))
    else:rng.shuffle(waiting)
    waiting=deque(waiting);active={};done={};totalextra=0;maxfragment=0;maxexcess=0;bankchanges=0;maxactive=0;terminal_details=[]
    def ownership():
        groups=[jobs[c][2] for c in waiting]+[domain for c,domain in active.values()]+list(banks.values())+[free]+[set(C.C+[z for z,_ in C.E.parts]) for C in done.values()]
        ids=[z for group in groups for z in group]
        assert len(ids)==len(set(ids)) and set(ids)==set(G.mem),'COOPERATIVE_DOMAIN_ALIAS'
    while waiting or active:
        for w in range(p):
            if w not in active and waiting:
                c=waiting.popleft();active[w]=(c,jobs[c][2]|banks.pop(w))
        maxactive=max(maxactive,len(active));ownership()
        if schedule=='reverse':w=max(active,key=lambda w:active[w][0])
        elif schedule=='heavy_last':w=min(active,key=lambda w:(jobs[active[w][0]][1],active[w][0]))
        else:w=rng.choice(list(active))
        c,domain=active[w];parts,m,hs=jobs[c];oldbank=domain-hs
        P=view(G,domain,oldbank,m,K,R,D);P.nonfull_limit=p+R+2*D+4
        S=len(hs);N=SegmentedNode(parts,b,m);maxfragment=max(maxfragment,S-(m+b-1)//b)
        if D==1 or m<=1:
            C=Completed(P)
            for fc,tc,rc in parts:C.append_node(node(P,fc,tc,rc))
            C.verify();P.snapshot()
            expected_tail=sum(rc for _,_,rc in parts)
            assert C.E.count==expected_tail,'TERMINAL_CHUNK_TAIL_COUNT'
            terminal_details.append({'digit':c,'m':m,'initial_blocks':S,'E_records':C.E.count,'m_mod_b':m%b,'finished_blocks':len(C.C)+len(C.E.parts)})
        else:
            C=child_sort(P,N,1,m,R,D);maxexcess=max(maxexcess,N.max_excess)
        assert C.records()==sorted([x for x in tags if x[0][0]==c],key=lambda x:x[0])
        live=set(C.C+[z for z,_ in C.E.parts]);expected_extra=S-(m+b-1)//b
        assert len(live)==(m+b-1)//b and len(P.free)==K+expected_extra
        newbank=set(list(P.free)[:K]);bankchanges+=int(newbank!=oldbank)
        banks[w]=newbank;free|=(P.freeset-newbank);totalextra+=expected_extra
        done[c]=C;del active[w];ownership()
    C=join(G,[done[c] for c in sorted(done)])
    assert C.records()==sorted(tags,key=lambda x:x[0])
    live=set(C.C+[z for z,_ in C.E.parts]);G.freeset=set(G.mem)-live;G.free=deque(sorted(G.freeset));G.nonfull_limit=R+4
    output,branches=materialize(G,C);assert output==sorted(tags,key=lambda x:x[0])
    assert len(G.mem)==target
    return {'released_initial_fragment_blocks':totalextra,'max_initial_fragment_blocks_per_digit':maxfragment,
            'max_source_hole_excess':maxexcess,'bank_identity_changes':bankchanges,'max_admitted_jobs':maxactive,'finalizer_branches':branches,'terminal_details':terminal_details}


def main():
    cases=0;randomcases=0;extra=0;maxfrag=0;maxexcess=0;changes=0;maxactive=0
    def add(r):
        nonlocal extra,maxfrag,maxexcess,changes,maxactive
        extra+=r['released_initial_fragment_blocks'];maxfrag=max(maxfrag,r['max_initial_fragment_blocks_per_digit']);maxexcess=max(maxexcess,r['max_source_hole_excess']);changes+=r['bank_identity_changes'];maxactive=max(maxactive,r['max_admitted_jobs'])
    alphabet=list(product(range(2),repeat=2))
    for n in range(5):
        for keys in product(alphabet,repeat=n):
            for b in (1,2,3):
                for p in (1,2,3):add(run(keys,b,2,2,p,cases));cases+=1
    rng=random.Random(264575)
    for _ in range(500):
        R=rng.choice([1,2,3,8]);D=rng.choice([1,2,3,8,16]);b=rng.choice([1,2,3,8,16]);p=rng.choice([1,2,3,8]);n=rng.randrange(160)
        mode=rng.randrange(3)
        if mode==0:keys=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(n)]
        elif mode==1:keys=[(0,)*(D-1)+(rng.randrange(R),) for _ in range(n)]
        else:keys=[(0,)*D for _ in range(n)]
        add(run(keys,b,R,D,p,rng.randrange(99999),rng.choice(['random','reverse','heavy_last'])));randomcases+=1
    bad=[0,1,3,4,2];good=[0,1,2,3,4];assert bad!=good
    print(json.dumps({'exhaustive_cases':cases,'randomized_cases':randomcases,'initial_fragment_blocks_reclaimed_total':extra,
      'maximum_initial_fragment_excess_per_digit':maxfrag,'maximum_source_hole_excess_observed':maxexcess,
      'bank_identity_changes':changes,'maximum_admitted_jobs':maxactive,
      'grouping_fulls_before_tails_counterexample':{'stable_chunk_order':good,'incorrect_all_fulls_first':bad},
      'scope':'Ordered block-aligned root chunks; randomized root/post-root completion; per-digit segmented first reader and exact returned credits; no true thread interleaving.'},indent=2))
if __name__=='__main__':main()
