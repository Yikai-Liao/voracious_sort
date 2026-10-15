"""Abstract fixed-block stable MSD model. Uses no repository implementation.
Python host structures are proof instrumentation, not a space-efficient implementation.
Only the explicit record pool is subjected to the claimed capacity bound.
"""
from collections import deque
from itertools import product
import random,json

class Pool:
    def __init__(self, tags,b,R,D):
        self.b=b; self.n=len(tags);self.q=self.n//b
        self.K=R+2*D+8;self.nonfull_limit=R+2*D+4;self.mem={}
        for z in range(self.q):self.mem[z]=list(tags[z*b:(z+1)*b])
        for z in range(self.q,self.q+self.K):self.mem[z]=[None]*b
        self.free=deque(range(self.q,self.q+self.K));self.freeset=set(self.free)
        self.minimum=len(self.free);self.max_nonfull=0;self.moves=0;self.allocations=0
    def sample(self):
        current=sum(1 for z,a in self.mem.items() if z not in self.freeset and any(x is None for x in a))
        assert current<=self.nonfull_limit,('NONFULL_BOUND',current,self.nonfull_limit)
        self.max_nonfull=max(self.max_nonfull,current)
    def get(self):
        assert self.free,'EXHAUSTED'
        z=self.free.popleft();self.freeset.remove(z)
        assert all(x is None for x in self.mem[z]),'ALLOCATE_LIVE'
        self.minimum=min(self.minimum,len(self.free));self.allocations+=1;self.sample();return z
    def release(self,z):
        assert z not in self.freeset,'DOUBLE_RELEASE'
        assert all(x is None for x in self.mem[z]),'RELEASE_LIVE'
        self.free.append(z);self.freeset.add(z)
    def read(self,z,j):
        assert z not in self.freeset,'READ_FREE'
        x=self.mem[z][j];assert x is not None,'READ_DEAD'
        self.mem[z][j]=None;self.sample();return x
    def write(self,z,j,x):
        assert z not in self.freeset,'WRITE_FREE'
        assert self.mem[z][j] is None,'OVERWRITE_LIVE'
        self.mem[z][j]=x;self.moves+=1;self.sample()
    def snapshot(self):
        live=[x for z,a in self.mem.items() for x in a if x is not None]
        assert len(live)==len(set(live)),'DUPLICATE_TAG'
        assert len(live)==self.n,'LOST_TAG'
        assert len(self.free)==len(self.freeset)
        assert all(all(x is None for x in self.mem[z]) for z in self.free)
        self.sample()

class Arena:
    def __init__(self,P):self.P=P;self.parts=deque();self.count=0;self.head=0
    def append(self,x):
        if not self.parts or self.parts[-1][1]==self.P.b:
            self.parts.append([self.P.get(),0])
        z,length=self.parts[-1];self.P.write(z,length,x)
        self.parts[-1][1]+=1;self.count+=1
    def consume(self,count):
        assert 0<=count<=self.count
        for _ in range(count):
            z,length=self.parts[0]
            x=self.P.read(z,self.head);self.head+=1;self.count-=1
            if self.head==length:
                self.parts.popleft();self.head=0;self.P.release(z)
            yield x
    def records(self):
        return [x for q,(z,l) in enumerate(self.parts) for x in self.P.mem[z][self.head if q==0 else 0:l]]
    def verify(self):
        assert len(self.records())==self.count
        assert all(x is not None for x in self.records())
        assert sum(1 for q,(z,l) in enumerate(self.parts) if (self.head if q==0 else 0)>0 or l<self.P.b)<=2

class Node:
    def __init__(self,full,arena,tail):self.full=full;self.arena=arena;self.tail=tail
    def consume(self,P):
        for z in self.full:
            for j in range(P.b):
                x=P.read(z,j)
                if j==P.b-1:P.release(z)
                yield x
        self.full=[]
        yield from self.arena.consume(self.tail)
        self.tail=0


def materialize(P,completed):
    assert completed.head==0
    loc=[z for z,_ in completed.parts]; lengths=[l for _,l in completed.parts]
    inverse={z:j for j,z in enumerate(loc)}
    assert len(inverse)==len(loc)
    assert len(loc)==(P.n+P.b-1)//P.b
    # A block swap through one conceptual b-record temporary.
    for j in range(P.q):
        src=loc[j];dst=j
        assert src>=j,'SOURCE_IS_PREVIOUSLY_FIXED'
        if src==dst:continue
        displaced=inverse.get(dst)
        P.mem[src],P.mem[dst]=P.mem[dst],P.mem[src]
        if displaced is not None:
            loc[displaced]=src;inverse[src]=displaced
        else:
            del inverse[src]
            assert dst in P.freeset
            P.freeset.remove(dst);P.freeset.add(src)
        loc[j]=dst;inverse[dst]=j
    result=[x for z in range(P.q) for x in P.mem[z]]
    if P.n%P.b:
        assert loc[-1]>=P.q
        result+=P.mem[loc[-1]][:P.n%P.b]
    assert len(result)==P.n and all(x is not None for x in result)
    P.free=deque(sorted(P.freeset));P.snapshot()
    return result


def run(keys,b,R,D,cutoff=1):
    assert cutoff==1, 'Only singleton and terminal-depth base cases have modeled storage'
    tags=[(tuple(k),i) for i,k in enumerate(keys)]
    assert all(len(k)==D for k in keys)
    P=Pool(tags,b,R,D);root_tail=Arena(P)
    for x in tags[P.q*b:]:root_tail.append(x)
    root=Node(list(range(P.q)),root_tail,len(tags)%b)
    complete=Arena(P);frames=[];nodecount=0
    def verify_frames():
        for arena in frames:arena.verify()
        complete.verify();P.snapshot()
    def visit(node,depth,m):
        nonlocal nodecount
        if depth==D or m<=cutoff:
            # cutoff=1 in proof/test; larger cutoff explicitly uses stable sorting.
            if m<=cutoff and cutoff>1:
                records=list(node.consume(P));records.sort(key=lambda x:x[0])
                for x in records:complete.append(x)
            else:
                for x in node.consume(P):complete.append(x)
            verify_frames();return
        nodecount+=1
        full=[[] for _ in range(R)];tail=[None]*R;lens=[0]*R;counts=[0]*R
        for x in node.consume(P):
            c=x[0][depth];counts[c]+=1
            if tail[c] is None:tail[c]=P.get()
            P.write(tail[c],lens[c],x);lens[c]+=1
            if lens[c]==b:
                full[c].append(tail[c]);tail[c]=None;lens[c]=0
        # Pack only residual tails; never duplicate live tags.
        packed=Arena(P)
        for c in range(R):
            if tail[c] is not None:
                z=tail[c]
                for j in range(lens[c]):
                    x=P.read(z,j)
                    if j==lens[c]-1:P.release(z)
                    packed.append(x)
        frames.append(packed);verify_frames()
        for c in range(R):
            if counts[c]:visit(Node(full[c],packed,lens[c]),depth+1,counts[c])
        assert packed.count==0 and not packed.parts
        frames.pop();verify_frames()
    visit(root,0,len(tags))
    assert complete.records()==sorted(tags,key=lambda x:x[0])
    result=materialize(P,complete)
    assert result==sorted(tags,key=lambda x:x[0])
    return {'minimum_free':P.minimum,'max_nonfull':P.max_nonfull,'nodes':nodecount,
            'capacity_blocks':len(P.mem),'scratch_blocks':P.K}


def deliberate_failures():
    findings=[]
    # First child's end does not free a shared arena block containing a sibling.
    P=Pool([],4,2,1);A=Arena(P)
    A.append(((0,),0));A.append(((1,),1));z=A.parts[0][0]
    list(A.consume(1))
    try:P.release(z)
    except AssertionError as e:findings.append({'bug':'free shared block after first child','detected':str(e)})
    else:raise AssertionError('BROKEN_SHARED_RELEASE_NOT_CAUGHT')
    # A final offset is not a free location merely because the leaf is complete.
    P=Pool([((1,),0),((1,),1)],2,2,1)
    try:P.write(0,0,((0,),2))
    except AssertionError as e:findings.append({'bug':'write final A offset while sibling live','detected':str(e)})
    else:raise AssertionError('BROKEN_FINAL_WRITE_NOT_CAUGHT')
    return findings


def main():
    cases=0;minimum=10**9;maxnonfull=0;coverage=[]
    for R,D,maxn in ((2,2,6),(2,3,4),(3,2,4)):
        alphabet=list(product(range(R),repeat=D));sub=0
        for b in (1,2,3,4):
            for n in range(maxn+1):
                for keys in product(alphabet,repeat=n):
                    result=run(keys,b,R,D);cases+=1;sub+=1
                    minimum=min(minimum,result['minimum_free']);maxnonfull=max(maxnonfull,result['max_nonfull'])
        coverage.append({'radix':R,'depth':D,'max_length':maxn,'cases':sub})
    rng=random.Random(271828);randomcases=0
    for _ in range(500):
        R=rng.choice([2,3,4,8]);D=rng.choice([1,2,3,5,10,24]);b=rng.choice([1,2,3,4,8,16]);n=rng.randrange(0,160)
        mode=rng.randrange(4)
        if mode==0:keys=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(n)]
        elif mode==1:keys=[(0,)*(D-1)+(rng.randrange(R),) for _ in range(n)]
        elif mode==2:keys=[(0,)*D for _ in range(n)]
        else:
            options=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(3)]
            keys=[rng.choice(options) for _ in range(n)]
        result=run(keys,b,R,D);randomcases+=1
        minimum=min(minimum,result['minimum_free']);maxnonfull=max(maxnonfull,result['max_nonfull'])
    print(json.dumps({'exhaustive_cases':cases,'coverage':coverage,'randomized_cases':randomcases,
      'minimum_observed_free_blocks':minimum,'maximum_observed_nonfull_blocks':maxnonfull,
      'deliberate_bug_checks':deliberate_failures(),
      'scope':'Global one-pass partition plus tailpacking, serial ordered DFS, pooled physical blocks, shared-arena suffix reclamation, global completed stream, physical finalization. No production/runtime claim.'},indent=2))

if __name__=='__main__':main()
