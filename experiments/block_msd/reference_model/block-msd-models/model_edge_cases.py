"""Degenerate-domain and transient instrumentation checks for all global models."""
import json,random
from global_dfs_model import run as base
from retained_dfs_model import run as retained
from normalized_dfs_model import run as normalized

def main():
    results={}
    for name,run in [('base',base),('retained',retained),('normalized',normalized)]:
        count=0
        for b in (1,2,3,8):
            for D in (0,1,2,9,32):
                for n in sorted({0,1,max(0,b-1),b,b+1,2*b,2*b+1}):
                    run([(0,)*D]*n,b,1,D);count+=1
        # Shallow random cases with more records and large fanout.
        rng=random.Random(173205)
        for _ in range(200):
            b=rng.choice([1,2,3,8,17]);R=rng.choice([1,2,3,16]);D=rng.choice([0,1,2,3,10]);n=rng.randrange(80)
            keys=[tuple(rng.randrange(R) for _ in range(D)) for _ in range(n)]
            run(keys,b,R,D);count+=1
        results[name]={'cases_passed':count,'checks':'R=1,D=0,n=0,n=1,b=1,block boundary lengths, random fanout/skew; transient sample after every read/allocate/write'}
    print(json.dumps(results,indent=2))
if __name__=='__main__':main()
