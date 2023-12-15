trigger SurveyInvitationTrigger on SurveyInvitation (before insert, after insert, before update, after update) {
    
    if(trigger.isBefore && trigger.isInsert){
        for(SurveyInvitation Invitation : trigger.new){
            try{
                Tiempo_de_Validez__mdt TiempoValidez = [Select Dias__c from Tiempo_de_Validez__mdt Limit 1];
                Invitation.InviteExpiryDateTime = date.today().addDays(Integer.valueOf(TiempoValidez.Dias__c));
                Invitation.Last_Email__c = System.today();
            }catch(Exception e){
                System.debug(e);
                Invitation.InviteExpiryDateTime = date.today().addDays(30);
                Invitation.Last_Email__c = System.today();
            }
        }
    }
    
    if(trigger.isAfter && trigger.isInsert){
        for(SurveyInvitation Invitation : trigger.new){
            Survey S1 = [Select Id from Survey where Name =: 'Entrega vivienda'];
            Survey S2 = [Select Id from Survey where Name =: 'Entrega 3 meses vivienda'];
            Survey S3 = [Select Id from Survey where Name =: 'Entrega 1 año'];
            if(Invitation.SurveyId == S1.Id){
                Inventario__c PATC = [Select Encuesta_1__c, Email__c, Cuenta__r.CorreoElectronico__c
                                      from Inventario__c 
                                      where Id =: Invitation.Proceso_ATC__c];
                PATC.Encuesta_1__c = 'https://javer.force.com/encuestas/survey/runtimeApp.app?invitationId='+
                    //PATC.Encuesta_1__c = 'https://test-encuestas.cs21.force.com/survey/runtimeApp.app?invitationId='+
                    
                    Invitation.Id + '&surveyName=entrega_vivienda&UUID=' + Invitation.UUID;
                PATC.Email__c = PATC.Cuenta__r.CorreoElectronico__c;
                upsert PATC;
                
                Contact con = new Contact();
                con.FirstName = 'Test';
                con.LastName = 'Contact';
                con.Email = Invitation.Email__c;
                insert con;
                
                OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where Address = 'atencionaclientes@javer.com.mx' Limit 1];
                EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =: 'Encuesta1'];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setOrgWideEmailAddressId(owea.Id);
                mail.setTemplateId(et.Id);
                mail.setToAddresses(new list<string>{Invitation.Email__c});
                mail.setTreatTargetObjectAsRecipient(False);
                mail.setTargetObjectId(con.Id);
                mail.setSaveAsActivity(false);
                mail.setWhatId(PATC.Id);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
                delete con;                
            }
            else if(Invitation.SurveyId == S2.Id){
                Inventario__c PATC = [Select Encuesta_2__c, Email__c, Cuenta__r.CorreoElectronico__c
                                      from Inventario__c where Id =: Invitation.Proceso_ATC__c];
                PATC.Encuesta_2__c = 'https://javer.force.com/encuestas/survey/runtimeApp.app?invitationId='+
                    Invitation.Id + '&surveyName=entrega_3_meses_vivienda&UUID=' + Invitation.UUID;
                PATC.Email__c = PATC.Cuenta__r.CorreoElectronico__c;
                upsert PATC;
                
                Contact con = new Contact();
                con.FirstName = 'Test';
                con.LastName = 'Contact';
                con.Email = Invitation.Email__c;
                insert con;
                
                OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where Address = 'atencionaclientes@javer.com.mx' Limit 1];
                EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =: 'Encuesta2'];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setOrgWideEmailAddressId(owea.Id);
                mail.setTemplateId(et.Id);
                mail.setToAddresses(new list<string>{Invitation.Email__c});
                mail.setTreatTargetObjectAsRecipient(False);
                mail.setTargetObjectId(con.Id);
                mail.setSaveAsActivity(false);
                mail.setWhatId(PATC.Id);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
                delete con; 
                
            }
            else if(Invitation.SurveyId == S3.Id){
                Inventario__c PATC = [Select Encuesta_2__c, Email__c, Cuenta__r.CorreoElectronico__c
                                      from Inventario__c where Id =: Invitation.Proceso_ATC__c];
                PATC.Encuesta_3__c = 'https://javer.force.com/encuestas/survey/runtimeApp.app?invitationId='+
                    Invitation.Id + '&surveyName=entrega_1_a_o&UUID=' + Invitation.UUID;
                PATC.Email__c = PATC.Cuenta__r.CorreoElectronico__c;
                upsert PATC;
                
                Contact con = new Contact();
                con.FirstName = 'Test';
                con.LastName = 'Contact';
                con.Email = Invitation.Email__c;
                insert con;
                
                OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where Address = 'atencionaclientes@javer.com.mx' Limit 1];
                EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =: 'Encuesta3'];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setOrgWideEmailAddressId(owea.Id);
                mail.setTemplateId(et.Id);
                mail.setToAddresses(new list<string>{Invitation.Email__c});
                mail.setTreatTargetObjectAsRecipient(False);
                mail.setTargetObjectId(con.Id);
                mail.setSaveAsActivity(false);
                mail.setWhatId(PATC.Id);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
                delete con; 
            }
        }
    }
    
    if(trigger.isBefore && trigger.isUpdate){
        for(SurveyInvitation Invitation : trigger.new){
            System.debug('----------SurveyInvitation_trg - Before Update------------');
            try{
                if (Invitation.No_Migrada__c == TRUE){
                    List<SurveyResponse> SRL_Completed = [SELECT Id, InvitationId, CompletionDateTime, CreatedDate, Status
                                                          FROM SurveyResponse
                                                          WHERE InvitationId=: Invitation.Id
                                                          AND Status =: 'Completed'
                                                          ORDER BY CompletionDateTime ASC];
                    if(Invitation.ResponseStatus != 'Completed' && Invitation.SR_Update_Flag__c != TRUE){
                        System.debug('NM FALSE, Not Completed');
                        Invitation.No_Migrada__c = FALSE;
                    }else if(SRL_Completed.size() > 1 && SRL_Completed[0].CompletionDateTime != System.today()){
                        System.debug('NM FALSE, Completada Previamente');
                        Invitation.No_Migrada__c = FALSE;
                    }
                    Invitation.SR_Update_Flag__c = False;
                }
            }catch(Exception e){
                System.debug(e);
            }
        }
    }
}