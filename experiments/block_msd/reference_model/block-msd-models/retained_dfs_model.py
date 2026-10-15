"""Stronger abstract terminal representation and evacuation finalizer.
Imports the independently checked local pool/arena model. Host metadata is instrumentation.
"""
from global_dfs_model import Pool,Arena,Node
from itertools import product
from collections import deque
import random,json

class Completed:
    def __init__(self,P):self.P=P;self.C=[];self.before=[];self.trailing=0;self.E=Arena(P)
    def append_node(self,node):
        if node.full:
            self.C.extend(node.full)
            self.before.extend([self.trailing]+[0]*(len(node.full)-1))
            self.trailing=0;node.full=[]
        for x in node.arena.consume(node.tail):self.E.append(x)
        self.trailing+=node.tail;node.tail=0
    def records(self):
        tails=iter(self.E.records());out=[]
        for z,count in zip(self.C,self.before):
            out.extend(next(tails) for _ in range(count));out.extend(self.P.mem[z])
        out.extend(next(tails) for _ in range(self.trailing))
        assert next(tails,None) is None
        return out
    def verify(self):
        self.E.verify()
        assert len(self.C)==len(self.before)
        assert self.E.count==sum(self.before)+self.trailing
        assert all(all(x is not None for x in self.P.mem[z]) for z in self.C)


def materialize(P,C):
    # Stable handles identify original live source blocks. Physical locations may change.
    allhandles=C.C+[z for z,_ in C.E.parts]
    assert len(set(allhandles))==len(allhandles)
    loc={h:h for h in allhandles};inverse={h:h for h in allhandles};fixed=set()
    ep=deque([list(x) for x in C.E.parts]);eh=0
    counts={'evacuated_C':0,'evacuated_E':0,'target_already_free':0,'source_eq_target_gather':0}
    cset=set(C.C);eset={z for z,_ in C.E.parts}
    nexttarget=0
    def read_handle(h,j,last):
        z=loc[h];assert z not in fixed
        if z==nexttarget:counts['source_eq_target_gather']+=1
        x=P.read(z,j)
        if last:
            P.release(z);del loc[h];del inverse[z]
        return x
    def takeE(amount):
        nonlocal eh
        for _ in range(amount):
            h,length=ep[0]
            last=(eh+1==length)
            x=read_handle(h,eh,last);eh+=1
            if last:ep.popleft();eh=0
            yield x
    def logical_records():
        for h,count in zip(C.C,C.before):
            yield from takeE(count)
            for j in range(P.b):yield read_handle(h,j,j==P.b-1)
        yield from takeE(C.trailing)
    reader=iter(logical_records());output=[]
    for target in range(P.q):
        nexttarget=target
        temporary=[next(reader) for _ in range(P.b)]
        assert target not in fixed
        if target in inverse:
            # Evacuate unread contents, including holes, to a genuine free physical block.
            h=inverse.pop(target);destination=P.get()
            assert destination not in inverse and destination not in fixed
            P.mem[destination]=list(P.mem[target]);P.mem[target]=[None]*P.b
            loc[h]=destination;inverse[destination]=h
            counts['evacuated_C' if h in cset else 'evacuated_E']+=1
        else:
            assert target in P.freeset,('EMPTY_TARGET_NOT_FREE',target)
            counts['target_already_free']+=1
            P.freeset.remove(target);P.free.remove(target)
        for j,x in enumerate(temporary):P.write(target,j,x)
        fixed.add(target);output.extend(temporary)
        P.snapshot()
    nexttarget=-1
    remainder=[next(reader) for _ in range(P.n%P.b)]
    assert next(reader,None) is None
    assert not loc and not inverse and not ep
    output.extend(remainder)
    assert [x for z in range(P.q) for x in P.mem[z]]+remainder==output
    remaining=[x for a in P.mem.values() for x in a if x is not None]+remainder
    assert len(remaining)==P.n and len(set(remaining))==P.n
    assert all(z in fixed or z in P.freeset for z in P.mem)
    return output,counts


def run(keys,b,R,D):
    tags=[(tuple(k),i) for i,k in enumerate(keys)]
    P=Pool(tags,b,R,D);root_tail=Arena(P)
    for x in tags[P.q*b:]:root_tail.append(x)
    root=Node(list(range(P.q)),root_tail,len(tags)%b)
    completed=Completed(P);frames=[]
    def verify():
        for a in frames:a.verify()
        completed.verify();P.snapshot()
    def visit(node,depth,m):
        if depth==D or m<=1:
            completed.append_node(node);verify();return
        full=[[] for _ in range(R)];tail=[None]*R;lens=[0]*R;counts=[0]*R
        for x in node.consume(P):
            c=x[0][depth];counts[c]+=1
            if tail[c] is None:tail[c]=P.get()
            P.write(tail[c],lens[c],x);lens[c]+=1
            if lens[c]==b:full[c].append(tail[c]);tail[c]=None;lens[c]=0
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
        assert not arena.parts and arena.count==0
        frames.pop();verify()
    visit(root,0,len(tags))
    expected=sorted(tags,key=lambda x:x[0]);assert completed.records()==expected
    retained=len(completed.C);tailrecords=completed.E.count
    result,coverage=materialize(P,completed);assert result==expected
    return P.minimum,P.max_nonfull,coverage,retained,tailrecords


def main():
    cases=0;coverage=[];minimum=10**9;maxnonfull=0;evac={};retained=0;tails=0
    def account(result):
        nonlocal minimum,maxnonfull,retained,tails
        low,high,hits,c,t=result;minimum=min(minimum,low);maxnonfull=max(maxnonfull,high)
        retained+=c;tails+=t
        for k,v in hits.items():evac[k]=evac.get(k,0)+v
    for R,D,maxn in ((2,2,6),(2,3,4),(3,2,4)):
        alphabet=list(product(range(R),repeat=D));sub=0
        for b in (1,2,3,4):
            for n in range(maxn+1):
                for keys in product(alphabet,repeat=n):
                    account(run(keys,b,R,D));cases+=1;sub+=1
        coverage.append({'radix':R,'depth':D,'max_length':maxn,'cases':sub})
    rng=random.Random(314159);randomcases=0
    for _ in range(500):
        R=rng.choice([2,3,4,8]);D=rng.choice([1,2,3,5,10,24]);b=rng.choice([1,2,3,4,8,16]);n=rng.randrange(160)
        mode=rng.randrange(4)
        if mode==0:keys=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(n)]
        elif mode==1:keys=[(0,)*(D-1)+(rng.randrange(R),) for _ in range(n)]
        elif mode==2:keys=[(0,)*D for _ in range(n)]
        else:
            options=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(3)]
            keys=[rng.choice(options) for _ in range(n)]
        account(run(keys,b,R,D));randomcases+=1
    print(json.dumps({'exhaustive_cases':cases,'coverage':coverage,'randomized_cases':randomcases,
      'minimum_free_blocks':minimum,'maximum_nonfull_blocks':maxnonfull,
      'finalizer_branch_hits':evac,'terminal_full_blocks_retained_total':retained,'terminal_tail_records_packed_total':tails,
      'scope':'Serial ordered DFS retains terminal full blocks, packs only terminal tails, then materializes with live-target evacuation and stable handle relocation; no production/performance claim.'},indent=2))

if __name__=='__main__':main()
