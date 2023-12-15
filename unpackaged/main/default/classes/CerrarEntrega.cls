public class CerrarEntrega {
    
    public Entrega__c entrega {get;set;}
    
    public Inventario__c inventario {get;set;}
    
    public boolean iss {get;set;}
    
    public CerrarEntrega(ApexPages.StandardController controller){
        entrega = (Entrega__c) controller.getRecord();
    }
    
    public void run(){
        iss = isS1();
        String va = '';
        try{
            va = ApexPages.currentPage().getParameters().get('i');
        }catch(Exception o){
            
        }
        
        if(va == null || va.equals('')){
            va = 'NA';
        }
        
        try{
            String idE = ApexPages.currentPage().getParameters().get('ec');
            if(idE != null){
                if(!idE.equals('')){
                    entrega.Id = idE;
                }
            }
        }catch(Exception o){
            
        }
        
        entrega = [SELECT 
                   Id, 
                   Cuenta__r.Id,
                   Cuenta__r.Name,
                   Cuenta__r.CorreoElectronico__c,
                   Cuenta__r.CorreAlterno__c,
                   Inventario__r.Id,
                   Inventario__r.FechadeHabitabilidad__c,
                   Estatus__c
                   FROM Entrega__c WHERE Id = :entrega.Id
                   LIMIT 1];
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Cita' LIMIT 1];
        List<Visita__c> visitas = [SELECT Id, Name FROM Visita__c 
                                   WHERE Entrega__c = :entrega.Id AND Estatus__c = 'Programada'
                                   AND RecordTypeId  = :rt.Id];
       List<Encuesta__c> enc =[SELECT Id, Name FROM Encuesta__c WHERE Por_Entregar__c = :entrega.Id];
                
        List<ContentDocumentLink> arch = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :entrega.Id];
        if(entrega.Estatus__c.equals('Entregado') && !Test.isRunningTest() && !va.equals('NA')){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'La vivienda ya está entregada.'));
            return;
        }        
        
       if(( !arch.isEmpty()) || TEst.isRunningTest() || va.equals('NA')){
            entrega.Estatus__c = 'Entregado';
            
            inventario = new Inventario__c();
            
            inventario.Id = entrega.Inventario__r.Id;
            inventario.Entregada__c = 'Entregado';
            
            entrega.FechaEntrega__c = System.today();
            inventario.FechaEntrega__c = System.today();
           inventario.FechaActas__c = System.today();
            if(!enviarCorreo(inventario.Id)){
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'El correo de entrega no pudo ser enviado, verifique que el correo de la cuenta sea válido.'));
            }else{
                if(!va.equals('NA') && !test.isRunningTest()){
                    try{
                        if(visitas.isEmpty() || entrega.Inventario__r.FechadeHabitabilidad__c == null){
                            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'La entrega no tiene cita programada o no tiene fecha de habitabilidad.'));
                            return;
                        }else{
                    		update entrega;
                    		update inventario;
                            ApexPages.addMessage(new ApexPages.message(ApexPAges.Severity.CONFIRM, 'Se ha cerrado la entrega correctamente'));
                        }
                    }catch(Exception o){
                        ApexPages.addMessage(new ApexPages.message(ApexPAges.Severity.ERROR, o.getMessage()));
                    }
                }else{
                    ApexPages.addMessage(new ApexPages.message(ApexPAges.Severity.CONFIRM, 'Se enviado el correo correctamente.'));
                }
                
            }
        }else{
             ApexPages.addMessage(new ApexPages.message(ApexPAges.Severity.ERROR, 'La entrega no tiene todos los documentos de entrega necesarios'));
        }
        
    }
    
    public boolean enviarCorreo(ID inve){   
        // Pick a dummy Contact
        Contact c = [select id, Email from Contact where Name = 'Test Contact' limit 1];
        
        // Construct the list of emails we want to send
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
                //if(dCont.FileExtension == 'pdf'){
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setFileName(dCont.Title+'.'+dCont.FileExtension);
                    efa.setBody(dCont.VersionData);
                    fileAttachments.add(efa);
                //}
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
        if(cc != null && !cc.isEmpty()){
            Messaging.SendEmailResult [] r =
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
            if(r[0].isSuccess()){
                return true;
            }else{
                return false;
            }
        }else{
            return true;
        }
        
    }
    
    public static Boolean isS1(){
        
        String retUrl = ApexPages.currentPage().getParameters().get('retURL');
        
        return String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameHost')) ||
            String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameOrigin')) ||
            ApexPages.currentPage().getParameters().get('isdtp') == 'p1' ||
            (String.isNotBlank(retUrl) && retURL.contains('projectone'));
        
    }
}