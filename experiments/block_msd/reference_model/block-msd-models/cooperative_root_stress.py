from cooperative_root_model import run
import json

def main():
    explicit=run([(0,),(1,),(0,),(1,)],2,2,1,2,0)
    assert all(d['E_records']==2 and d['m_mod_b']==0 and d['finished_blocks']==1 for d in explicit['terminal_details'])
    rows=[]
    for p in (2,4,8,16,32):
        for b in (2,4,16):
            for D in (1,2,3):
                keys=[]
                for j in range(p):keys += [(0,)+(j%2,)*(D-1)]+[(1,)+(0,)*(D-1)]*(b-1)
                for schedule in ('random','reverse','heavy_last'):
                    r=run(keys,b,2,D,p,0,schedule)
                    rows.append({'p':p,'b':b,'D':D,'n':len(keys),'schedule':schedule,**r})
    p=64;b=16;D=2
    keys=[key for j in range(p) for key in ([(0,j%2)]+[(1,0)]*(b-1))]
    large=run(keys,b,2,D,p,1,'reverse')
    print(json.dumps({'terminal_residue_counterexample':explicit,'cases':rows,'p64_case':large},indent=2))
if __name__=='__main__':main()
