global class Survey_Migration_IRC33 implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;
    global LogATC__c log = new LogATC__c();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'SurveyMigrationIRC';
        if(Test.isRunningTest()){
            return Database.getQueryLocator([
                Select Id, Survey_Invitation__c, IRC1__c, IRC14__c
                FROM SurveyResponse__c]);
        }else{
            return Database.getQueryLocator([
                SELECT Id, Survey_Invitation__c, IRC1__c, IRC14__c
                FROM SurveyResponse__c 
                WHERE Fecha_de_Envio_de_Inivitaci_n__c = THIS_MONTH
                AND IRC1__c >= 4
                AND IRC14__c = NULL
                ORDER BY CreatedDate ASC]);}
    }
    
    global void execute(Database.BatchableContext bc, List<SurveyResponse__c> scope){
        for(SurveyResponse__c SR : scope){
            try{
                List<SurveyResponse> SRL_Completed = [SELECT Id, InvitationId, CompletionDateTime, CreatedDate, Status
                                                      FROM SurveyResponse
                                                      WHERE InvitationId=: SR.Survey_Invitation__c
                                                      AND Status =: 'Completed'
                                                      ORDER BY CompletionDateTime ASC];
                
                //Se asignan valores al nuevo SR y se crean las SQR correspondientes
                List<SurveyQuestionResponse__c> newSQRList = new List<SurveyQuestionResponse__c>();
                List<SurveyQuestionResponse> SQRList = [Select Id, ResponseValue,QuestionId, Datatype, 
                                                        NumberValue, SurveyVersionId, ResponseId, QuestionChoiceId
                                                        from SurveyQuestionResponse
                                                        where ResponseId =: SRL_Completed[0].Id];
                
                for(SurveyQuestionResponse SQR: SQRList){
                    
                    SurveyQuestion SQ = [Select QuestionName, 
                                         SurveyPageId, SurveyVersionId
                                         from SurveyQuestion 
                                         where Id =: SQR.QuestionId];
                    
                    SurveyPage SP = [Select Id, Name from SurveyPage where id =: SQ.SurveyPageId];
                    system.debug(SQ.QuestionName + ' - ' + SP.Name + ' - ' + SP.Id);
                    if(SP.Name == 'IRC-BIEN'){
                        if(!SQ.QuestionName.containsIgnoreCase('Comentarios')){
                            SR.IRC14__c = SQR.ResponseValue;
                        }else{
                            
                        }
                    }
                }
                update SR;
            }catch(exception e){
                System.debug(e);
            }
            
        }
    }
    
    
    global void finish(Database.BatchableContext bc){
        log.Mensaje__c += '\r\n';
        log.Mensaje__c += ' Respuestas actualizadas: ' + recordsProcessed;
        System.debug(log.Mensaje__c);
        System.debug(recordsProcessed + ' records processed. Shazam!');
        
    }    
    
}