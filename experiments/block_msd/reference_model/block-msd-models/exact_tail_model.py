"""Abstract local stable distribution; not production code or a benchmark."""
from itertools import product
from collections import deque
import json


def check(keys, b, radix, offset=0):
    n=len(keys); F,r=divmod(n,b)
    tags=[(k,i) for i,k in enumerate(keys)]
    mem={}; nextid=0
    def block(cells=None):
        nonlocal nextid
        z=nextid;nextid+=1
        mem[z]=list(cells) if cells is not None else [None]*b
        return z
    src=[]; exclusive=[]
    for a in range(F):
        z=block(tags[a*b:(a+1)*b]);exclusive.append(z)
        src.extend((z,j) for j in range(b))
    siblings={}
    if r:
        shared=[]
        for zindex in range((offset+r+b-1)//b):
            z=block([('SIBLING',zindex,j) for j in range(b)])
            shared.append(z)
            for j in range(b):siblings[z,j]=mem[z][j]
        for j,t in enumerate(tags[F*b:]):
            z=shared[(offset+j)//b]; s=(offset+j)%b
            mem[z][s]=t; siblings.pop((z,s));src.append((z,s))
    counts=[keys.count(i) for i in range(radix)]
    full=[c//b for c in counts]; residues=[c%b for c in counts]
    R=sum(residues);q=(R+b-1)//b
    arena=[block() for _ in range(q)]
    pool=deque(block() for _ in range(radix))
    starts=[];v=0
    for t in residues:starts.append(v);v+=t
    chains=[[] for _ in range(radix)]; seen=[0]*radix
    unread=set(src); released=set(); minpool=len(pool)
    def acquire():
        nonlocal minpool
        assert pool, ('allocator exhaustion',keys,b,radix,offset)
        z=pool.popleft()
        assert not any(z==u for u,_ in unread), ('reuse before read',z)
        for j in range(b):assert (z,j) not in siblings
        mem[z]=[None]*b
        minpool=min(minpool,len(pool));return z
    for index,(z,s) in enumerate(src):
        x=mem[z][s]
        assert x==tags[index], ('read after overwrite',index,x,tags[index])
        unread.remove((z,s))
        # Loaded record is now safe in a register. Release only exclusive blocks.
        if z in exclusive and s==b-1:
            assert not any(z==u for u,_ in unread)
            assert z not in released;released.add(z);pool.append(z)
        key=x[0];rank=seen[key];seen[key]+=1
        if rank<full[key]*b:
            if rank%b==0:chains[key].append(acquire())
            dest=chains[key][-1];j=rank%b
        else:
            a=starts[key]+rank-full[key]*b
            dest=arena[a//b];j=a%b
        assert (dest,j) not in unread
        assert (dest,j) not in siblings
        assert mem[dest][j] is None
        mem[dest][j]=x
    assert not unread
    result=[]
    for k in range(radix):
        child=[]
        for z in chains[k]:child.extend(mem[z])
        for a in range(starts[k],starts[k]+residues[k]):
            child.append(mem[arena[a//b]][a%b])
        assert child==[x for x in tags if x[0]==k]
        result.extend(child)
    assert result==sorted(tags,key=lambda x:x[0])
    assert all(mem[z][j]==value for (z,j),value in siblings.items())
    assert sum(map(len,chains))+q==(n+b-1)//b
    allocated=[z for chain in chains for z in chain]+arena
    assert len(set(allocated))==len(allocated)
    assert not set(allocated).intersection(pool)
    assert q<=radix
    return minpool


def main():
    cases=0;minimum=10**9;coverage=[]
    for radix,maxn in ((2,10),(3,8),(4,6)):
        subtotal=0
        for b in (2,3,4):
            for n in range(maxn+1):
                for keys in product(range(radix),repeat=n):
                    for offset in range(b):
                        minimum=min(minimum,check(keys,b,radix,offset));cases+=1;subtotal+=1
        coverage.append({'radix':radix,'max_length':maxn,'cases':subtotal})
    # Long boundary and sparse-bucket probes, including exact/full±1 and skew.
    probes=0
    for b in (2,3,4,8,16):
        for radix in (2,3,5):
            for counts in ([b-1,b,b+1]+[0]*(radix-3) if radix>=3 else [b-1,b+1],
                           [0]*(radix-1)+[7*b+1],
                           [b-1]*radix,[b]*radix,[b+1]*radix):
                # First arrangement groups keys; second interleaves.
                grouped=tuple(k for k,c in enumerate(counts) for _ in range(c))
                interleaved=tuple(k for j in range(max(counts)) for k,c in enumerate(counts) if j<c)
                for keys in (grouped,interleaved,tuple(reversed(grouped))):
                    for offset in range(b):check(keys,b,radix,offset);probes+=1
    out={'exhaustive_cases':cases,'coverage':coverage,'boundary_cases':probes,
         'minimum_observed_free_pool_blocks':minimum,
         'checks':['stable tagged child order','no write to unread location',
                   'no acquisition of block with unread records',
                   'shared sibling sentinels unchanged','unique live block ownership',
                   'output block count equals ceil(n/b)','arena blocks at most radix'],
         'scope':'Single local node only; no runtime or complete-recursion claim.'}
    print(json.dumps(out,indent=2))

if __name__=='__main__':main()
