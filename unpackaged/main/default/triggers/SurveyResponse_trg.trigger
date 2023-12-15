trigger SurveyResponse_trg on SurveyResponse (before insert, before update, after insert, after update, after delete) {
    if(trigger.isAfter && trigger.isUpdate){
    }
    if(trigger.isAfter && trigger.isInsert){
        for(SurveyResponse response : trigger.new){
            System.debug('----------SurveyResponse_trg - After Insert------------');
            try{
                SurveyInvitation SI = [Select Id, No_Migrada__c, ResponseStatus from SurveyInvitation Where Id=: response.InvitationId];
                SI.No_Migrada__c = TRUE;
                update SI;
            }catch(Exception e){
                System.debug(e);
            }
        }
    }
    if(trigger.isBefore && trigger.isUpdate){
        for(SurveyResponse response : trigger.new){
            System.debug('----------SurveyResponse_trg - Before Update------------');
            SurveyInvitation SI = [Select Id, No_Migrada__c, SR_Update_Flag__c, ResponseStatus from SurveyInvitation Where Id=: response.InvitationId];
            SI.No_Migrada__c = TRUE;
            SI.SR_Update_Flag__c = TRUE;
            update SI;
        }
    }
    if(trigger.isAfter && trigger.isDelete){
    }
}