from fixed_fork_model import run
import json

def main():
    out=[]
    families=[]
    for b,R in ((2,5),(4,9),(16,9)):
        families += [(f'singletons_n_less_b_{b}_{R}',[(c,0,0) for c in range(min(R,b-1))],b,R),
                     (f'one_heavy_child_{b}_{R}',[(c,0,0) for c in range(R-1)]+[(R-1,j%R,j%2) for j in range(5*b+1)],b,R),
                     (f'bank_reuse_{b}_{R}',[(c,d,0) for c in range(R) for d in range(R) for _ in range(b+1)],b,R)]
    for name,keys,b,R in families:
        for p in (1,2,4):
            for schedule in ('reverse','heavy_last'):
                r=run(keys,b,R,3,p,0,schedule)
                out.append({'family':name,'b':b,'R':R,'n':len(keys),'p':p,'schedule':schedule,**r})
    print(json.dumps({'cases':out},indent=2))
if __name__=='__main__':main()
