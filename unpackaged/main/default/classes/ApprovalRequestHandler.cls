public class ApprovalRequestHandler {
    public Static void doInit(){
        String recordId = ApexPages.currentPage().getParameters().get('id');
        String action = ApexPages.currentPage().getParameters().get('action');
        system.debug('recordId'+recordId);  system.debug('action'+action);
        Approval_Event__e ae = new Approval_Event__e();
        ae.Record_Id__c = recordId;
        ae.Action__c = action;
        List<Database.SaveResult> svList = Eventbus.publish(new List<Approval_Event__e> {ae});
        for(Database.SaveResult sr : svList){
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully ' + sr.getId());
                System.debug('errors'+ sr.getErrors());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
}