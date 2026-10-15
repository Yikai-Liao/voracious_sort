"""Abstract endpoint-folding arena only; not recursive sorter or machine benchmark."""
from collections import deque,Counter
from itertools import product
import json,random

class Arena:
    def __init__(self,T,b):
        self.b=b;self.parts=deque();self.mem={};self.moves=Counter();self.alias=0
        for i in range((T+b-1)//b):
            lo=i*b;hi=min(T,lo+b)
            self.mem[i]=list(range(lo,hi))+[None]*(b-(hi-lo));self.parts.append([i,0,hi-lo])
        self.remaining=T;self.next=0
    def records(self):return [x for z,a,c in self.parts for x in self.mem[z][a:c]]
    def verify(self,normalized):
        assert self.records()==list(range(self.next,self.next+self.remaining))
        assert len([x for data in self.mem.values() for x in data if x is not None])==self.remaining
        handles={z for z,_,_ in self.parts}
        assert handles==set(self.mem)
        assert all(count<=1 for count in self.moves.values())
        if normalized:assert len(handles)==(self.remaining+self.b-1)//self.b
        else:assert len(handles)*self.b-self.remaining<2*self.b
    def consume(self,k):
        assert 0<=k<self.b and k<=self.remaining
        for _ in range(k):
            z,a,c=self.parts[0]
            assert self.mem[z][a]==self.next
            self.mem[z][a]=None;self.next+=1;self.remaining-=1;a+=1
            if a==c:self.parts.popleft()
            else:self.parts[0][1]=a
            if all(x is None for x in self.mem[z]):
                assert all(q!=z for q,_,_ in self.parts)
                del self.mem[z]
        self.verify(False)
    def normalize(self):
        if len(self.parts)<2:self.verify(True);return
        h,hs,he=self.parts[0];t,ts,te=self.parts[-1]
        if h==t:self.alias+=1;self.verify(True);return
        a=he-hs;size=te-ts
        # Original last full block means single-head fragmentation already fits.
        if ts!=0 or te==self.b:self.verify(True);return
        if a+size<=self.b:
            for j in range(a):
                x=self.mem[h][hs+j];assert x is not None
                assert self.mem[t][te+j] is None
                self.mem[t][te+j]=x;self.mem[h][hs+j]=None;self.moves[x]+=1
            assert all(x is None for x in self.mem[h]);del self.mem[h]
            self.parts[0]=[t,te,te+a];self.alias+=1
        self.verify(True)

def compositions(n,maxpart):
    if n==0:yield ();return
    for k in range(1,min(n,maxpart)+1):
        for suffix in compositions(n-k,maxpart):yield(k,)+suffix

def main():
    cases=0;aliases=0;moves=0
    for b,maxT in ((2,30),(3,18),(4,14),(5,12)):
        for T in range(maxT+1):
            for chunks in compositions(T,b-1):
                A=Arena(T,b);A.verify(True)
                for k in chunks:A.consume(k);A.normalize()
                assert not A.mem and not A.parts
                assert sum(A.moves.values())<=T
                aliases+=A.alias;moves+=sum(A.moves.values());cases+=1
    rng=random.Random(161803);randomcases=0
    for _ in range(2000):
        b=rng.randrange(2,65);T=rng.randrange(1000);A=Arena(T,b)
        while A.remaining:
            A.consume(rng.randrange(1,min(A.remaining,b-1)+1));A.normalize()
        aliases+=A.alias;moves+=sum(A.moves.values());randomcases+=1
    print(json.dumps({'exhaustive_compositions':cases,'randomized_cases':randomcases,
        'alias_events':aliases,'record_moves':moves,
        'checks':['exact remaining tagged order','physical occupancy equals ceil(live/b) after normalization',
                  'transient slack below 2b','no record copied more than once','release only after all alias roles empty'],
        'scope':'Endpoint arena only. Does not combine with recursive sorter or prove parallel safety.'},indent=2))
if __name__=='__main__':main()
