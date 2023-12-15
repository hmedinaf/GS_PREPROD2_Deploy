global class Survey_Migration_Entrega_V1 implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;
    //global LogMovilidad__c log = new LogMovilidad__c();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //log.FechaHora__c = Datetime.now();
        //log.Metodo__c = 'SurveyMigration';
        Date myDate = Date.newInstance(2019, 8, 28);
        if(Test.isRunningTest()){
            return Database.getQueryLocator([
            Select Id, InvitationId, CompletionDateTime
            FROM SurveyResponse]);
        }else{
        Survey S1 = [Select Id from Survey where Name =: 'Entrega vivienda'];
        return Database.getQueryLocator([ SELECT Id, InvitationId, CompletionDateTime FROM SurveyResponse  WHERE CreatedDate <: myDate AND SurveyId =: S1.Id AND Status =: 'Completed']);
        }
    }
    
    global void execute(Database.BatchableContext bc, List<SurveyResponse> scope){
        for(SurveyResponse SR : scope){
            
            //Se crea nueva SR en base a la SI
            SurveyInvitation SI = [Select Id, Name, SurveyId, Proceso_ATC__r.Cuenta__c, Proceso_ATC__c from SurveyInvitation where Id =: SR.InvitationId]; 
            SurveyResponse__c newSR = new SurveyResponse__c();
            newSR.Name = SI.Name + ' (ATC)';
            newSR.Account__c = SI.Proceso_ATC__r.Cuenta__c;
            newSR.Encuesta__c = SI.SurveyId;
            newSR.Survey_Invitation__c = SI.Id;
            newSR.Proceso_ATC__c = SI.Proceso_ATC__c;
            newSR.ResponseDate__c = SR.CompletionDateTime;
            insert newSR;
            
            //Se asignan valores al nuevo SR y se crean las SQR correspondientes
            List<SurveyQuestionResponse__c> newSQRList = new List<SurveyQuestionResponse__c>();
            List<SurveyQuestionResponse> SQRList = [Select Id, ResponseValue,QuestionId, Datatype, 
                                                    NumberValue, SurveyVersionId, ResponseId, QuestionChoiceId
                                                    from SurveyQuestionResponse
                                                    where ResponseId =: SR.Id];
            
            for(SurveyQuestionResponse SQR: SQRList){

                SurveyQuestion SQ = [Select QuestionName, 
                                     SurveyPageId, SurveyVersionId
                                     from SurveyQuestion 
                                     where Id =: SQR.QuestionId];
                
                SurveyPage SP = [Select Id, Name from SurveyPage where id =: SQ.SurveyPageId];
                system.debug(SQ.QuestionName + ' - ' + SP.Name + ' - ' + SP.Id);
                SurveyQuestionResponse__c newSQR = new SurveyQuestionResponse__c();
                newSQR.Data_Type__c = SQR.Datatype;
                newSQR.Number_Value__c = SQR.NumberValue;
                newSQR.Survey_Response__c = SQR.ResponseId;
                newSQR.Survey_Response_ATC__c = newSR.Id;
                newSQR.Survey_Question__c = SQR.QuestionId;
                newSQR.Survey_Question_Choice__c = SQR.QuestionChoiceId;
                newSQR.ResponseValue__c = SQR.ResponseValue;
                
                //SP.Name sin espacio en PROD
                if(SP.Name == 'SA'){
                    newSQR.Name = '1 - SA';
                    //newSQR.Name = '1 - ' + SQ.QuestionName;
                    newSR.SA1__c = SQR.NumberValue;
                }else if(SP.Name == 'SA-MAL'){
                    if(!SQ.QuestionName.containsIgnoreCase('Comentarios')){
                        newSQR.Name = '1.1 - SA - MAL';
                        //newSQR.Name = '1.1 - ' + SQ.QuestionName;
                        newSR.SA12__c = SQR.ResponseValue;
                    }else{
                        newSQR.Name = '1.2 - SA - MAL';
                        //newSQR.Name = '1.2 - ' + SQ.QuestionName;
                        newSR.SA13__c = SQR.ResponseValue;
                    }
                }else if(SP.Name == 'SA-BIEN'){
                    if(!SQ.QuestionName.containsIgnoreCase('Comentarios')){
                        newSQR.Name = '1.3 - SA - BIEN';
                        //newSQR.Name = '1.3 - ' + SQ.QuestionName;
                        newSR.SA14__c = SQR.ResponseValue;
                    }else{
                        newSQR.Name = '1.4 - SA - BIEN';
                        //newSQR.Name = '1.4 - ' + SQ.QuestionName;
                        newSR.SA15__c = SQR.ResponseValue;
                    }
                }else if(SP.Name == 'SP'){
                    newSQR.Name = '2 - SP';
                    //newSQR.Name = '3 - ' + SQ.QuestionName;
                    newSR.SP1__c = SQR.NumberValue;
                }else if(SP.Name == 'SP-MAL'){
                    if(!SQ.QuestionName.containsIgnoreCase('Comentarios')){
                        newSQR.Name = '2.1 - SP - MAL';
                        //newSQR.Name = '2.1 - ' + SQ.QuestionName;
                        newSR.SP12__c = SQR.ResponseValue;
                    }else{
                        newSQR.Name = '2.2 - SP - MAL';
                        //newSQR.Name = '2.2 - ' + SQ.QuestionName;
                        newSR.SP13__c = SQR.ResponseValue;
                    }
                }else if(SP.Name == 'SP-BIEN'){
                    if(!SQ.QuestionName.containsIgnoreCase('Comentarios')){
                        newSQR.Name = '2.3 - SP - BIEN';
                        //newSQR.Name = '2.3 - ' + SQ.QuestionName;
                        newSR.SP14__c = SQR.ResponseValue;
                    }else{
                        newSQR.Name = '2.4 - SP - BIEN';
                        //newSQR.Name = '2.4 - ' + SQ.QuestionName;
                        newSR.SP15__c = SQR.ResponseValue;
                    }
                }else if(SP.Name == 'IRC'){
                    newSQR.Name = '3 - IRC';
                    //newSQR.Name = '3 - ' + SQ.QuestionName;
                    newSR.IRC1__c = SQR.NumberValue;
                }else if(SP.Name == 'IRC-MAL'){
                    if(!SQ.QuestionName.containsIgnoreCase('Comentarios')){
                        newSQR.Name = '3.1 - IRC - MAL';
                        //newSQR.Name = '3.1 - ' + SQ.QuestionName;
                        newSR.IRC12__c = SQR.ResponseValue;
                    }else{
                        newSQR.Name = '3.2 - IRC - MAL';
                        //newSQR.Name = '3.2 - ' + SQ.QuestionName;
                        newSR.IRC13__c = SQR.ResponseValue;
                    }
                }else if(SP.Name == 'IRC-BIEN'){
                    if(!SQ.QuestionName.containsIgnoreCase('Comentarios')){
                        newSQR.Name = '3.3 - IRC - BIEN';
                        //newSQR.Name = '3.3 - ' + SQ.QuestionName;
                        newSR.IRC14__c = SQR.ResponseValue;
                    }else{
                        newSQR.Name = '3.4 - IRC - BIEN';
                        //newSQR.Name = '3,5 - ' + SQ.QuestionName;
                        newSR.IRC15__c = SQR.ResponseValue;
                    }
                }else{
                    newSQR.Name = '4 - Comentarios Adicionales';
                    //newSQR.Name = '4 - ' + SQ.QuestionName;
                    newSR.Comentario_Adicional__c = SQR.ResponseValue;
                }
                newSQRList.add(newSQR);
            }
            update newSR;
            insert newSQRList;
        }
        
        recordsProcessed = recordsProcessed + 1;
    }
    
    
    global void finish(Database.BatchableContext bc){
        /*log.Mensaje__c += '\r\n';
        log.Mensaje__c += recordsProcessed + ' records processed.';
        System.debug(log.Mensaje__c);
        insert log;*/
        System.debug(recordsProcessed + ' records processed. Shazam!');
        
    }    
    
}