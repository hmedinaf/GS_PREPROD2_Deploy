public without sharing class ApproveEventHandler {
    public class InputVariables {
        @InvocableVariable
        public List<ProcessInstanceWorkitem> workItems;
        @InvocableVariable
        public String Action;
    }
    @InvocableMethod(label='Approval Event' description='For Approve the record')
    Public static void ApproveEvent(List<InputVariables> InputVariables) {
        List<ProcessInstanceWorkitem> items = InputVariables[0].workItems;
        String action = InputVariables[0].Action;
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        if(items.size()>0){
            for(ProcessInstanceWorkitem workItem : items){
                Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
                req.setWorkitemId(workItem.Id);
                if(action == 'approve'){
                    req.setAction('Approve');
                }
                else if(action == 'reject'){
                    req.setAction('Reject');
                }
                requests.add(req);
            }
            Approval.ProcessResult[] processResults = Approval.process(requests);  
        } 
    }
}