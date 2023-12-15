global class EncuestasRecordatorioDiario implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;
    global LogATC__c log = new LogATC__c();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'EncuestasRecordatorio';
        //N_DAYS_AGO:3
        return Database.getQueryLocator(
            
            'Select Id, Email__c, SurveyId, Cuenta__r.CorreoElectronico__c, Proceso_ATC__c, ResponseStatus, Last_Email__c from SurveyInvitation where Last_Email__c = N_DAYS_AGO:3 AND ResponseStatus != \'Completed\' AND InviteExpiryDateTime > Today'
        );
    }
    
    global void execute(Database.BatchableContext bc, List<SurveyInvitation> scope){
        for (SurveyInvitation Invitation : scope) {
            try{
                Contact con = new Contact();
                con.FirstName = 'Test';
                con.LastName = 'Contact';
                con.Email = Invitation.Email__c;
                insert con;
                
                Inventario__c PATC = [Select Id from Inventario__c where Id =: Invitation.Proceso_ATC__c];
                EmailTemplate et = new EmailTemplate();
                
                Survey S1 = [Select Id from Survey where Name =: 'Entrega vivienda'];
                Survey S2 = [Select Id from Survey where Name =: 'Entrega 3 meses vivienda'];
                Survey S3 = [Select Id from Survey where Name =: 'Entrega 1 año'];
                
                if(Invitation.SurveyId == S1.Id){
                    system.debug('Invitation.SurveyId='+Invitation.SurveyId);
                    et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =: 'Recordatorio1'];
                }else if(Invitation.SurveyId == S2.Id){
                    et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =: 'Recordatorio2'];
                }else if(Invitation.SurveyId == S3.Id){
                    et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =: 'Recordatorio3'];
                }
                list<OrgWideEmailAddress> owea = [select Id from OrgWideEmailAddress where Address = 'atencionaclientes@javer.com.mx' Limit 1];
                system.debug('owea='+owea);
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setOrgWideEmailAddressId(owea[0].Id);
                mail.setTemplateId(et.Id);
                mail.setToAddresses(new list<string>{Invitation.Email__c});
                mail.setTreatTargetObjectAsRecipient(False);
                mail.setTargetObjectId(con.Id);
                mail.setSaveAsActivity(false);
                mail.setWhatId(PATC.Id);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
                Invitation.Last_Email__c = System.today();
                delete con;
                
            }catch(Exception e){
                system.debug(e);
                log.Mensaje__c = 'Error: before sending' + e + e.getLineNumber();
            }
            recordsProcessed = recordsProcessed + 1;
            upsert Invitation;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        log.Mensaje__c += '\r\n';
        log.Mensaje__c += recordsProcessed + ' records processed.';
        System.debug(log.Mensaje__c);
        insert log;
        System.debug(recordsProcessed + ' records processed. Shazam!');
        /*if(Test.isRunningTest()){
            Integer i = 1;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
        }*/
    }    
    
}