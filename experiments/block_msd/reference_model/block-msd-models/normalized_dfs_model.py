"""Integrated endpoint-normalized DFS model; reduced conservative reserve R+D+8.
All host dictionaries are instrumentation, not an implementation-space measurement.
"""
from global_dfs_model import Pool as BasePool,Arena,Node
from retained_dfs_model import Completed,materialize
from collections import deque,Counter
from itertools import product
import random,json

class Pool(BasePool):
    def __init__(self,tags,b,R,D):
        super().__init__(tags,b,R,D)
        self.K=R+D+8
        for z in list(self.mem):
            if z>=self.q+self.K:
                del self.mem[z];self.freeset.remove(z);self.free.remove(z)
        self.minimum=len(self.free)

class NormalizedArena:
    def __init__(self,P):self.P=P;self.parts=deque();self.count=0;self.moves=Counter();self.aliases=0
    def append(self,x):
        if not self.parts or self.parts[-1][2]==self.P.b:self.parts.append([self.P.get(),0,0])
        z,a,c=self.parts[-1];self.P.write(z,c,x);self.parts[-1][2]+=1;self.count+=1
    def records(self):return [x for z,a,c in self.parts for x in self.P.mem[z][a:c]]
    def normalize(self):
        if len(self.parts)<2:self.verify();return
        h,hs,he=self.parts[0];t,ts,te=self.parts[-1]
        if h==t:self.aliases+=1;self.verify();return
        a=he-hs
        if ts==0 and te<self.P.b and a+te<=self.P.b:
            for j in range(a):
                x=self.P.read(h,hs+j);self.P.write(t,te+j,x);self.moves[x]+=1
                assert self.moves[x]<=1,'RECOPIED_ARENA_RECORD'
            self.P.release(h);self.parts[0]=[t,te,te+a];self.aliases+=1
        self.verify()
    def consume(self,count):
        assert 0<=count<self.P.b and count<=self.count
        for _ in range(count):
            z,a,c=self.parts[0];x=self.P.read(z,a);a+=1;self.count-=1
            if a==c:self.parts.popleft()
            else:self.parts[0][1]=a
            if all(x is None for x in self.P.mem[z]):
                assert not any(h==z for h,_,_ in self.parts)
                self.P.release(z)
            yield x
        # Normalize after the entire child tail was consumed, not mid-child.
        self.normalize()
    def verify(self):
        records=self.records();handles={z for z,_,_ in self.parts}
        assert len(records)==self.count and all(x is not None for x in records)
        assert len(handles)==(self.count+self.P.b-1)//self.P.b,'NORMALIZED_BLOCK_COUNT'
        assert all(c<=1 for c in self.moves.values())

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
        arena=NormalizedArena(P)
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
      'scope':'Integrated endpoint-normalized parent arenas, R+D+8 reserve, retained terminal full blocks, global dense tails, evacuating finalizer. No production/performance claim.'},indent=2))

if __name__=='__main__':main()
