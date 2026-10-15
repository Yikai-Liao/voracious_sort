from fixed_fork_model import run
import json

def main():
    rows=[]
    for b,R in ((2,3),(3,5),(4,9),(8,9)):
        families={
          'one_partial_per_root':[(c,0) for c in range(R) for _ in range(b-1)],
          'full_and_tail_per_root':[(c,0) for c in range(R) for _ in range(2*b+1)],
          'interleaved_C_and_E_per_root':[(c,d) for c in range(R) for d in range(R) for _ in range(b+1)]}
        for name,keys in families.items():
            for p in (1,2,4):
                for seed in (0,1,2):
                    result=run(keys,b,R,2,p,seed)
                    rows.append({'family':name,'b':b,'R':R,'p':p,'seed':seed,'n':len(keys),**result})
    print(json.dumps({'cases':rows,'finalizer_nonfull_limit':'R+4 including allocation/write transitions'},indent=2))
if __name__=='__main__':main()
