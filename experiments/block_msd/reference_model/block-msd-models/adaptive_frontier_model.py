"""Bounded retained-cut model with exact persistent split credits."""
from global_dfs_model import Pool,Arena,Node
from retained_dfs_model import Completed,materialize
from fixed_fork_model import child_sort
from collections import deque
from itertools import product
import random,json

def view(G,domain,free,n,K,R,D):
    P=object.__new__(Pool);P.b=G.b;P.n=n;P.q=n//G.b;P.K=K
    P.mem={z:G.mem[z] for z in domain};P.freeset=set(free);P.free=deque(sorted(free))
    P.minimum=len(free);P.max_nonfull=0;P.moves=0;P.allocations=0;P.nonfull_limit=R+2*D+4
    return P

def node(P,full,tail,length):
    A=Arena(P)
    if tail is not None:A.parts.append([tail,length]);A.count=length
    return Node(full,A,length)

def split(P,N,depth,R):
    full=[[] for _ in range(R)];tail=[None]*R;lens=[0]*R;counts=[0]*R
    for x in N.consume(P):
        c=x[0][depth];counts[c]+=1
        if tail[c] is None:tail[c]=P.get()
        P.write(tail[c],lens[c],x);lens[c]+=1
        if lens[c]==P.b:full[c].append(tail[c]);tail[c]=None;lens[c]=0
    return [(c,counts[c],full[c],tail[c],lens[c]) for c in range(R) if counts[c]]

def join(G,finished):
    C=Completed(G)
    for child in finished:
        if child.C:
            C.C.extend(child.C);C.before.extend([C.trailing+child.before[0]]+child.before[1:]);C.trailing=child.trailing
        else:C.trailing+=child.trailing
        C.E.parts.extend(child.E.parts);C.E.count+=child.E.count
    return C

def run(keys,b,R,D,p,Q,seed):
    tags=[(tuple(k),i) for i,k in enumerate(keys)];n=len(tags);ceil=lambda m:(m+b-1)//b
    K=R+2*D+8;target=ceil(n)+(Q-1)+p*K
    G=Pool(tags,b,R,D)
    for z in range(len(G.mem),target):G.mem[z]=[None]*b;G.free.append(z);G.freeset.add(z)
    assert len(G.mem)==target
    A=Arena(G)
    for x in tags[G.q*b:]:A.append(x)
    th=A.parts[0][0] if A.parts else None
    handles=set(range(G.q))|({th} if th is not None else set())
    jobs={():{'m':n,'full':list(range(G.q)),'tail':th,'r':n%b,'handles':handles,'done':None}}
    banks={w:set(G.free.popleft() for _ in range(K)) for w in range(p)}
    slack=set(G.free);assert len(slack)==Q-1
    rng=random.Random(seed);splits=0;deltatotal=0;maxq=1;denied=0
    def verify():
        assert len(jobs)<=Q
        F=sum(ceil(j['m']) for j in jobs.values())-ceil(n)
        assert len(slack)==Q-1-F and 0<=F<=len(jobs)-1
        groups=[j['handles'] for j in jobs.values()]+list(banks.values())+[slack]
        ids=[h for group in groups for h in group]
        assert len(ids)==len(set(ids)) and set(ids)==set(G.mem)
        assert all(len(bank)==K for bank in banks.values())
    while any(j['done'] is None for j in jobs.values()):
        candidates=[k for k,j in jobs.items() if j['done'] is None]
        prefix=max(candidates,key=lambda k:jobs[k]['m']) if rng.randrange(2) else rng.choice(candidates)
        job=jobs[prefix];depth=len(prefix);w=rng.randrange(p)
        records=[x for z in job['full'] for x in G.mem[z]]+([] if job['tail'] is None else G.mem[job['tail']][:job['r']])
        do_split=depth<D and job['m']>1 and rng.random()<0.8
        if do_split:
            counts=[sum(x[0][depth]==c for x in records) for c in range(R)];k=sum(c>0 for c in counts)
            delta=sum(ceil(c) for c in counts)-ceil(job['m'])
            assert 0<=delta<=max(0,k-1)
            if len(jobs)+k-1>Q or delta>len(slack):do_split=False;denied+=1
        if do_split:
            credit=set(sorted(slack)[:delta]);slack-=credit
            domain=job['handles']|banks[w]|credit
            P=view(G,domain,banks[w]|credit,job['m'],K,R,D)
            children=split(P,node(P,job['full'],job['tail'],job['r']),depth,R)
            assert len(P.free)==K
            banks[w]=set(P.freeset);del jobs[prefix]
            for c,m,full,tail,r in children:
                hs=set(full)|({tail} if tail is not None else set())
                assert len(hs)==ceil(m)
                jobs[prefix+(c,) ]={'m':m,'full':full,'tail':tail,'r':r,'handles':hs,'done':None}
            splits+=1;deltatotal+=delta;maxq=max(maxq,len(jobs))
        else:
            domain=job['handles']|banks[w]
            P=view(G,domain,banks[w],job['m'],K,R,D)
            C=child_sort(P,node(P,job['full'],job['tail'],job['r']),depth,job['m'],R,D)
            assert len(P.free)==K
            live=set(C.C+[z for z,_ in C.E.parts]);assert len(live)==ceil(job['m'])
            job['handles']=live;job['done']=C;banks[w]=set(P.freeset)
        verify()
    C=join(G,[jobs[k]['done'] for k in sorted(jobs)])
    assert C.records()==sorted(tags,key=lambda x:x[0])
    live=set(C.C+[z for z,_ in C.E.parts]);G.freeset=set(G.mem)-live;G.free=deque(sorted(G.freeset));G.nonfull_limit=Q+4
    output,_=materialize(G,C);assert output==sorted(tags,key=lambda x:x[0])
    assert len(G.mem)==target
    return {'splits':splits,'persistent_delta':deltatotal,'max_frontier_including_completed':maxq,'refused_splits':denied}

def unsafe_split():
    tags=[((0,),0),((1,),1)];P=Pool(tags,2,2,1);K=P.K
    children=split(P,Node([0],Arena(P),0),0,2)
    assert len(children)==2 and len(P.free)==K-1
    return {'b':2,'parent_records':2,'child_sizes':[1,1],'bank_before':K,'bank_after':len(P.free),'persistent_delta':1}

def main():
    cases=0;stats={'splits':0,'persistent_delta':0,'max_frontier_including_completed':0,'refused_splits':0}
    def add(r):
        for k,v in r.items():stats[k]=max(stats[k],v) if k.startswith('max_') else stats[k]+v
    alphabet=list(product(range(2),repeat=2))
    for n in range(5):
        for keys in product(alphabet,repeat=n):
            for b in (2,3):
                for Q in (1,2,4):add(run(keys,b,2,2,2,Q,cases));cases+=1
    rng=random.Random(244949);randomcases=0
    for _ in range(300):
        R=rng.choice([1,2,3,5]);D=rng.choice([0,1,2,5,12]);b=rng.choice([1,2,3,8]);n=rng.randrange(70)
        keys=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(n)]
        add(run(keys,b,R,D,rng.choice([1,2,4]),rng.choice([1,2,4,8,16]),rng.randrange(99999)));randomcases+=1
    print(json.dumps({'exhaustive_cases':cases,'randomized_cases':randomcases,**stats,'unsafe_full_bank_return_counterexample':unsafe_split(),
      'scope':'Sequential adaptive split/solve operations with multiple reusable bank identities; bounded retained cut includes completed streams; no concurrent operation interleaving.'},indent=2))
if __name__=='__main__':main()
