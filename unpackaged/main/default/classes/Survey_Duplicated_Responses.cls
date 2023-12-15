global class Survey_Duplicated_Responses implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        if(Test.isRunningTest()){
            return Database.getQueryLocator([
                Select Id, InvitationId, CompletionDateTime
                FROM SurveyResponse]);
        }else{
            return Database.getQueryLocator([ SELECT Id, InvitationId, CompletionDateTime FROM SurveyResponse  WHERE CreatedDate = THIS_MONTH AND Status =: 'Completed']);}
    }
    
    global void execute(Database.BatchableContext bc, List<SurveyResponse> scope){
        for(SurveyResponse SR : scope){
            List<SurveyResponse> SRL_Completed = [SELECT Id, InvitationId, CompletionDateTime, CreatedDate, Status
                                                  FROM SurveyResponse
                                                  WHERE InvitationId=: SR.InvitationId
                                                  AND Status =: 'Completed'
                                                  ORDER BY CompletionDateTime ASC];
            List<SurveyResponse__c> SRL_Completed_ATC = [SELECT Id
                                                         FROM SurveyResponse__c
                                                         WHERE Survey_Invitation__c=: SR.InvitationId
                                                         ORDER BY ResponseDate__c ASC];
            List<SurveyResponse> SRL_Started = [SELECT Id, InvitationId, CompletionDateTime, CreatedDate, Status
                                                FROM SurveyResponse
                                                WHERE InvitationId=: SR.InvitationId
                                                AND Status =: 'Started'
                                                ORDER BY CompletionDateTime ASC];
            if(SRL_Completed.size() > 1 || SRL_Completed_ATC.size() > 1){
                try{
                    SurveyInvitation SI = [Select Id, InviteExpiryDateTime from SurveyInvitation where Id=: SR.InvitationId];
                    SI.InviteExpiryDateTime = System.today();SI.InviteExpiryDateTime = SI.InviteExpiryDateTime.addDays(1);update SI; SRL_Completed.remove(0);SRL_Completed_ATC.remove(0); delete SRL_Completed; delete SRL_Started; delete SRL_Completed_ATC;
                }catch(Exception e){
                    System.debug(e);
                }
            }else if(SRL_Completed.size() == 1 || SRL_Completed_ATC.size() == 1){
                try{
                    delete SRL_Started;
                }catch(Exception e){
                    System.debug(e);
                }
            }
        }
        recordsProcessed = recordsProcessed + 1;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        
    }
}