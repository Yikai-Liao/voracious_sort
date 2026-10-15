"""Force repeated relocation of one tail handle through future destinations."""
from global_dfs_model import Pool
from retained_dfs_model import Completed,materialize
from collections import deque
import json

def main():
    rows=[]
    for b in (2,3,8):
        for q in (1,2,4,8,12):
            tags=[((0,),i) for i in range(q*b+1)];P=Pool(tags,b,2,2)
            assert P.K>=q+1
            for z in P.mem:P.mem[z]=[None]*b
            for j in range(q):P.mem[q+j]=list(tags[j*b:(j+1)*b])
            P.mem[0][0]=tags[-1]
            live=set(range(q,2*q))|{0}
            free=list(range(1,q))+list(range(2*q,q+P.K))
            assert set(free)==set(P.mem)-live
            P.free=deque(free);P.freeset=set(free)
            C=Completed(P);C.C=list(range(q,2*q));C.before=[0]*q
            C.E.parts.append([0,1]);C.E.count=1;C.trailing=1
            P.snapshot();assert C.records()==tags
            output,hits=materialize(P,C)
            assert output==tags and hits['evacuated_E']==q
            assert P.mem[0][0]!=tags[-1], 'STALE_PHYSICAL_POINTER_COUNTEREXAMPLE_MISSING'
            rows.append({'b':b,'full_output_blocks':q,'same_tail_evacuations':hits['evacuated_E'],
                         'stale_original_tail_address_now_contains_record_id':P.mem[0][0][1],
                         'correct_tail_record_id':tags[-1][1]})
    print(json.dumps({'cases':rows,'scope':'Finalizer only; repeatedly updated stable handle preserves final tail while raw original physical address becomes wrong.'},indent=2))
if __name__=='__main__':main()
