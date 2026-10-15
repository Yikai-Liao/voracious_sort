"""Executable failures of two intentionally broken batch protocols."""
import json

def main():
    memory=['A','B']
    buffer0=memory[1]
    memory[0]=buffer0  # Wrong: another task has not gathered its source yet.
    buffer1=memory[0]
    memory[1]=buffer1
    assert memory==['B','B'] and memory!=['B','A']
    early={'protocol':'early target write before all gathers','initial':['A','B'],'expected':['B','A'],'observed':memory.copy(),'failure':'A is lost and B duplicated'}
    memory={0:'FUTURE',1:None};location={'future':0}
    # Wrong: target1 is currently free but belongs to this batch.
    victim_destination=1
    memory[victim_destination]=memory[0];location['future']=victim_destination
    memory[0]='OUTPUT0';memory[1]='OUTPUT1'
    later_read=memory[location['future']]
    assert later_read=='OUTPUT1' and later_read!='FUTURE'
    target={'protocol':'evacuation destination chosen among batch targets','targets':[0,1],'evacuation_destination':victim_destination,'expected_later_source':'FUTURE','observed_later_source':later_read,'failure':'final target write destroys evacuated future source'}
    print(json.dumps({'negative_tests':[early,target],'result':'Both intentionally broken protocols reproduce the predicted corruption.'},indent=2))
if __name__=='__main__':main()
