global class EnviarCorreoEntrega {
	@future(callout = true)
    public static void run(Id inve, String jsonEntrega){
        Entrega__c entrega = (Entrega__c) JSON.deserialize(jsonEntrega, Entrega__c.class);
        
        Contact c = [select id, Email from Contact where Name = 'Test Contact' limit 1];
        
        List<Messaging.SingleEmailMessage> lstMsgs = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.setTemplateId( [select id from EmailTemplate where DeveloperName='EntregaVivienda'].id );
        msg.setWhatId( [select id from Account where Name = 'CUENTA ASIGNACION GENERICA' limit 1].id );
        msg.setTargetObjectId(c.id);
        msg.setToAddresses(new List<String>{'random_address@opfocus.com'});
        
        lstMsgs.add(msg);
        
        Savepoint sp = Database.setSavepoint();
        Messaging.sendEmail(lstMsgs);
        Database.rollback(sp);
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();    
        
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for(ContentDocumentLink doc : [SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId =: entrega.Id]){
            for(ContentVersion dCont: [SELECT ContentDocumentId,VersionData,FileExtension,FileType,Id,Title FROM ContentVersion where ContentDocumentId =:doc.ContentDocumentId]){
                System.debug(dCont);
                if(dCont.FileExtension == 'pdf'){
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setFileName(dCont.Title+'.'+dCont.FileExtension);
                    efa.setBody(dCont.VersionData);
                    fileAttachments.add(efa);
                }
            }
        }
        email.setSubject(lstMsgs.get(0).getSubject());
        
        List<string> cc = new List<String>();
        
        try{
            cc = entrega.Cuenta__r.CorreoElectronico__c.split(';');
        }catch(Exception o){
            if(entrega.Cuenta__r.CorreoElectronico__c != null){
                cc.add(entrega.Cuenta__r.CorreoElectronico__c);
            }
        }
        
        try{
            cc.addAll(entrega.Cuenta__r.CorreAlterno__c.split(';'));
        }catch(Exception o){
            if(entrega.Cuenta__r.CorreAlterno__c != null){
                cc.add(entrega.Cuenta__r.CorreAlterno__c);
            }
        }
        
        if(Test.isRunningTest()){
            cc.add('yjussental@solcomla.com');
        }
        
        email.setToAddresses( cc  );
        
        email.setHtmlBody(lstMsgs.get(0).getHtmlBody());
        email.setFileAttachments(fileAttachments);
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Soporte Casas JAVER'];
        if(!owea.isEmpty()){
            email.setOrgWideEmailAddressId(owea[0].Id);
        }        
        Messaging.SendEmailResult [] r =
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        
        if(r[0].isSuccess()){
            system.debug('SUCCESS');
        }else{
            system.debug('ERROR');
        }
    }
}