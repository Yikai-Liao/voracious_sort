"""Deterministic nested-boundary adversary; not a performance benchmark."""
from global_dfs_model import run as base
from retained_dfs_model import run as retained
from normalized_dfs_model import run as normalized
import json

def keys(b,D):
    a=[]
    for level in range(D):
        a.extend([(1,)*level+(0,)+(0,)*(D-level-1)]*(b-2))
        a.extend([(1,)*level+(2,)+(0,)*(D-level-1)]*2)
    a.append((1,)*D)
    assert len(a)==b*D+1
    return a

def main():
    results=[]
    for b in (3,4,8,16):
        for D in (1,2,4,8,16,24,32):
            inputs=keys(b,D)
            for name,run in [('base',base),('retained',retained),('normalized',normalized)]:
                r=run(inputs,b,3,D)
                if name=='base':low=r['minimum_free'];high=r['max_nonfull']
                else:low,high=r[0],r[1]
                results.append({'model':name,'b':b,'depth':D,'n':len(inputs),'minimum_free_blocks':low,'maximum_nonfull_blocks':high})
    print(json.dumps({'construction':'At every middle-child level, earlier tail b-2, central tail1, later tail2 form b+1 arena; later2 straddles two physical blocks.','cases':results},indent=2))
if __name__=='__main__':main()
