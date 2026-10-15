"""Independent abstract endpoint-normalization invariant check; not a benchmark."""
from itertools import product
from collections import deque
import random,json

def check(b, lengths):
    n=sum(lengths);blocks={j:list(range(j*b,min((j+1)*b,n)))+[None]*(b-len(range(j*b,min((j+1)*b,n)))) for j in range((n+b-1)//b)}
    seg=deque((j,0,min(b,n-j*b)) for j in blocks)
    moves=[0]*n;consumed=0;merges=0
    def verify(normalized):
        logical=[blocks[h][k] for h,lo,hi in seg for k in range(lo,hi)]
        assert logical==list(range(consumed,n))
        occupied=[x for a in blocks.values() for x in a if x is not None]
        assert sorted(occupied)==logical
        used=sum(any(x is not None for x in a) for a in blocks.values())
        if normalized:assert used==(n-consumed+b-1)//b
        assert max(moves,default=0)<=1
    verify(True)
    for length in lengths:
        assert 0<=length<b
        for _ in range(length):
            h,lo,hi=seg.popleft();assert blocks[h][lo]==consumed
            blocks[h][lo]=None;consumed+=1
            if lo+1<hi:seg.appendleft((h,lo+1,hi))
        if len(seg)>1:
            h,lo,hi=seg[0];t,tlo,thi=seg[-1]
            if h!=t and (hi-lo)+(thi-tlo)<=b:
                # In the prescribed representation the untouched original tail is a prefix.
                assert tlo==0 and thi<b
                a=hi-lo
                assert all(blocks[t][k] is None for k in range(thi,thi+a))
                for j in range(a):
                    x=blocks[h][lo+j];blocks[t][thi+j]=x;blocks[h][lo+j]=None;moves[x]+=1
                seg[0]=(t,thi,thi+a);merges+=1
        verify(True)
    assert consumed==n
    return merges,sum(moves)

cases=0;merges=0;moves=0
for b,maxchildren in [(1,8),(2,10),(3,8),(4,7),(5,6),(6,5),(8,4)]:
    for r in range(maxchildren+1):
        for lengths in product(range(b),repeat=r):
            a,c=check(b,lengths);cases+=1;merges+=a;moves+=c
rng=random.Random(92813)
for _ in range(5000):
    b=rng.randrange(1,65);lengths=[rng.randrange(b) for _ in range(rng.randrange(100))]
    a,c=check(b,lengths);cases+=1;merges+=a;moves+=c
print(json.dumps({'cases':cases,'endpoint_merges':merges,'records_relocated':moves,'checks':['exact logical suffix after every child','no missing or duplicated records','exact ceiling block count after normalization','each record relocated at most once'],'scope':'Independent standalone sequential arena model only; no production or performance validation'},indent=2))
