public without sharing class Prospects {
    @AuraEnabled
    public static String updateMethod(string pId, String frac){
         String msg = ''; String fId;
        try{
             list<Fraccionamiento__c> f = [Select Id,Name From Fraccionamiento__c where Name =:frac LIMIT 1];
            
            if(f != null && f.size()>0){
                fId = f[0].Id;
            }
            id userId =  UserInfo.getUserId();
            User  u =[Select Id,Name,Phone,SenderEmail,Email,state, Profile.Name,Fraccionamientos__c from User where Id=:userId];
            List<Account>Acc=[Select Id,Asesor__c,Prospectador__c from Account where Id=:pId LIMIT 1];
            if(Acc != null && Acc.size()>0){
                system.debug(Acc);
                if(u.Profile.Name == 'Asesor'){
                    Acc[0].Asesor__c = userId;
                }
                else if(u.Profile.Name == 'Prospectador'){
                    Acc[0].Prospectador__c = userId;
                }
                 Acc[0].Fraccionamiento_cta__c = fId;
                update Acc[0];
                msg = 'Usuario actual asignado';
            }
        }
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            throw new AuraHandledException(msg);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
            return msg;
    }
    @AuraEnabled 
    public static wrapAccount fetchProspectsDetails(String pId){
        wrapAccount wr = new wrapAccount();
        Id userId =  UserInfo.getUserId();
        User  u =[Select Id,Name,Phone,SenderEmail,Email,state, Profile.Name,Fraccionamientos__c from User where Id=:userId];
        List<String> fracList  = new List<String>();
        if(u.Fraccionamientos__c != null && u.Fraccionamientos__c != ''){
            fracList = u.Fraccionamientos__c.split(';');
        }
        fracList.sort();
        Account acc = [Select Id,Zona__c,PersonMobilePhone,Tipo__c,Tipo_de_Direccion__c,Sexo__c,FechaNacimiento__c,Canal_de_Venta__c,Sub_canal_de_venta__c,BillingColony__c,BillingCity,BillingState,BillingCountry,BillingStreet,NumeroExterior__c,NumeroInterior__c,
                       CorreoElectronico__c,TelefonoCelular__c,Otro_Telefono__c,Colonia_cta__c,MANAGEAPPROVALS__Active__c,FirstName,Lastname ,Name,Phone, RecordTypeName__c,Apellidomaterno_cta__c,RecordType.Name,Fraccionamiento_cta__c,Fraccionamiento_cta__r.Name ,
                       Prospectador__c,BillingPostalCode,Prospectador__r.Name,Prospectador__r.FirstName,Prospectador__r.LastName,Estatus_Prospectador__c,Fecha_Prospeccion__c,Fecha_Vencimiento_Prospectador__c,Asesor__c,Asesor__r.Name,Estatus_Asesor__c,FechaAsignacion__c,Ingresos_Mensuales__c,
                       Fecha_Vencimiento_Asesor__c,Colaborador_Javer__c,Estatus_Colaborador_Javer__c, Fecha_Colaborador_Javer__c ,Fecha_Vencimiento_Colaborador_Javer__c,Empresa__c,Puesto__c,TelefonoTrabajo__c,anios__c,Meses__c,
                       NSS__c,QUOTE_Folio_Cotizacion__c,QUOTE_Nombre_Fracc__c,QUOTE_Lote_Tipo__c,QUOTE_Construccion__c,QUOTE_Esquina__c,QUOTE_Terreno_Excedente__c,QUOTE_Ubicacion_Especial__c,QUOTE_Otros__c,QUOTE_Precio_de_Lista__c,QUOTE_Paquete_Descripcion__c,Estado_Civil__c,Hijos__c,
                       QUOTE_Total_Paquete__c,QUOTE_Bonificacion__c,QUOTE_Promocion__c,QUOTE_Gastos__c,QUOTE_Gastos_Credito__c,Tipo_Credito__c,QUOTE_Credito_Bancario__c,QUOTE_Credito_INFONAVIT__c,QUOTE_Subcuenta__c,QUOTE_Mensualidad_Banco__c,DependientesEconomicos__c,
                       QUOTE_Mensualidad_INFONAVIT__c,QUOTE_Ingreso_Solicitado__c,Prototipo_lookup__c, Nombre__c, QUOTE_Total_Atributos__c,QUOTE_m2_Excedentes__c,QUOTE_Total_Terreno_Excedente__c from Account  where Id =: pId  ];
        if(acc != null){
            wr.account = acc;
           
        }
        List<String> tipo = new List<String>();
        List<Prototipo__c> prolist = [Select Id, Name , Fraccionamiento__c from Prototipo__c where Fraccionamiento__c = : acc.Fraccionamiento_cta__c /*AND Cantidad_Viviendas__c >=1 */ Order by LastViewedDate desc];
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Account');
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('Tipo_Credito__c').getDescribe();
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues) {
            tipo.add(plv.getValue());
            tipo.sort();
        }
        wr.postal = acc.BillingPostalCode;
        wr.fracsList = fracList;
        wr.userEmail = u.Email;
        wr.UserId = userId;
        wr.recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        wr.ProfileName = u.Profile.Name;
        wr.proplist = prolist;
        wr.tipoList = tipo;
        return wr; 
    }
    @AuraEnabled
    public static Subjectwrap fetchEveTaskSubject(){
        List<String> statustype = new List<String>();   List<String> subtype = new List<String>();  List<String> Eventsubtype = new List<String>();
        Subjectwrap wr  = new Subjectwrap();
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Task');
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('Status').getDescribe();
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues) {
            statustype.add(plv.getValue());
        }
        Schema.DescribeFieldResult objFieldInfo1 = objDescribe.fields.getMap().get('Subject').getDescribe();
        List<Schema.PicklistEntry> picklistvalues1 = objFieldInfo1.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues1) {
            subtype.add(plv.getValue());
        }
        Schema.SObjectType objType1 = Schema.getGlobalDescribe().get('Event');
        Schema.DescribeSObjectResult objDescribe1 = objType1.getDescribe();
        Schema.DescribeFieldResult objFieldInfo2 = objDescribe1.fields.getMap().get('Subject').getDescribe();
        List<Schema.PicklistEntry> picklistvalues2 = objFieldInfo2.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues2) {
            Eventsubtype.add(plv.getValue());
        }
        wr.statusList = statustype;
        wr.eventsubList = Eventsubtype;
        wr.subList = subtype;
        return wr;
    }
    @AuraEnabled
    public static string saveEvents(String pId,String Subject,DateTime StartTime,DateTime EndTime, String Description){  
        string message = '';
        try {
            Event ev = new Event();
            ev.OwnerId = Userinfo.getUserId();
            ev.EndDateTime = EndTime;
            ev.StartDateTime = StartTime;
            ev.Subject = Subject;
            ev.Description = Description;
            ev.WhatId = pId;
            insert ev;
            message = 'Evento Creado';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =   e.getDmlMessage(0);
            return message;
        }
    }
    @AuraEnabled 
    public static String saveTasks(String pId,String Subject,Date Dates,String Status, String Description){ 
        Id redtId = [Select Id,developername, Name from recordtype where developername = 'Tarea'].Id;
        string message = '';
        try {
            Task t = new Task();
            t.OwnerId = Userinfo.getUserId();
            t.ActivityDate = Dates;
            t.Subject = Subject;
            t.Status =Status;
            t.Description = Description;
            t.Origen__c = 'Portal Web';
            t.WhatId = pId;
            t.RecordTypeId = redtId;
            insert t;
            t.WhatId = pId;
            update t;
            message = 'Tarea Creada';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    } 
    @AuraEnabled
    public static wrap fetchActivities(String pId){
        wrap wr = new wrap();
        Id redtId = [Select Id,developername, Name from recordtype where developername = 'Tarea'].Id;
        Account acc = [SELECT Id, (SELECT Id,Subject,ActivityDate FROM Tasks Where recordtypeId = : redtId ORDER BY CreatedDate DESC), (SELECT Id,Subject,StartDateTime FROM Events ORDER BY CreatedDate DESC) FROM Account where Id =:pId ];
        wr.Taskslist = acc.Tasks;
        wr.eventslist = acc.events;
        return wr;
    }
    @AuraEnabled
    public static String updatePorpFields(String pId,Account prospect, String selectedDiv, String selectedpropotipo, String selectedtipo){
         list<Fraccionamiento__c> f = [Select Id,Name From Fraccionamiento__c where Name =:selectedDiv LIMIT 1];
        string fId;
        
        if(f != null && f.size()>0){
            fId = f[0].id;
        } 
        
            String msg = '';
            try{
                Account acc = new Account();
                acc.Id = Prospect.Id;
                acc.Prototipo_lookup__c = selectedpropotipo;
                acc.Fraccionamiento_cta__c = fId;
                acc.Tipo_Credito__c = selectedtipo;
                //  acc.NSS__c = Prospect.NSS__c;
                acc.QUOTE_Lote_Tipo__c = Prospect.QUOTE_Lote_Tipo__c;
                acc.QUOTE_Construccion__c = Prospect.QUOTE_Construccion__c;
                acc.QUOTE_Esquina__c = Prospect.QUOTE_Esquina__c;
                acc.QUOTE_Terreno_Excedente__c = Prospect.QUOTE_Terreno_Excedente__c;
                acc.QUOTE_Ubicacion_Especial__c = Prospect.QUOTE_Ubicacion_Especial__c;
                acc.QUOTE_Otros__c = Prospect.QUOTE_Otros__c;
                acc.QUOTE_Precio_de_Lista__c = Prospect.QUOTE_Precio_de_Lista__c;
                acc.QUOTE_Paquete_Descripcion__c = Prospect.QUOTE_Paquete_Descripcion__c;
                acc.QUOTE_Total_Paquete__c = Prospect.QUOTE_Total_Paquete__c;
                acc.QUOTE_Bonificacion__c = Prospect.QUOTE_Bonificacion__c;
                acc.QUOTE_m2_Excedentes__c = Prospect.QUOTE_m2_Excedentes__c;
                acc.QUOTE_Gastos__c = Prospect.QUOTE_Gastos__c;
                acc.QUOTE_Gastos_Credito__c = Prospect.QUOTE_Gastos_Credito__c;
                acc.QUOTE_Credito_Bancario__c = Prospect.QUOTE_Credito_Bancario__c;
                acc.QUOTE_Credito_INFONAVIT__c = Prospect.QUOTE_Credito_INFONAVIT__c;
                acc.QUOTE_Subcuenta__c = Prospect.QUOTE_Subcuenta__c;
                acc.QUOTE_Mensualidad_Banco__c = Prospect.QUOTE_Mensualidad_Banco__c;
                acc.QUOTE_Mensualidad_INFONAVIT__c = Prospect.QUOTE_Mensualidad_INFONAVIT__c;
                acc.QUOTE_Ingreso_Solicitado__c = Prospect.QUOTE_Ingreso_Solicitado__c;
                update acc;
                system.debug('acc'+acc);
            }
        
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            throw new AuraHandledException(msg);
        }
        return msg;
    } 
    @AuraEnabled
    public static String pdfGen(String pId, Boolean updateProposal){
        Account acc  = [Select Id, FirstName,QUOTE_Folio_Cotizacion__c,Fraccionamiento_cta__c, Fraccionamiento_cta__r.Name,QUOTE_Nombre_Fracc__c,Nombre__c,CorreoElectronico__c From Account Where Id = : pId];
        PageReference pa = new PageReference('/apex/PropuestaPdf');
        pa.getParameters().put('accId', acc.Id);
        pa.getUrl();
        Blob fileAData;
        if(Test.isRunningTest()) { 
            fileAData = blob.valueOf('Unit.Test');
        } 
        else {
            fileAData = pa.getContentAsPDF();
        }
        String base64Pdf = EncodingUtil.base64Encode(fileAData);
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();  
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
        string file = base64Pdf;
        Blob blobContent = EncodingUtil.base64Decode(file);
        if(updateProposal){
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('Propuesta'+' '+acc.QUOTE_Folio_Cotizacion__c+' '+'-'+' '+acc.QUOTE_Nombre_Fracc__c+' '+'-'+' '+acc.Nombre__c+'.pdf');
            efa.setBody(blobContent);
            efa.setContentType('application/pdf');
            attachments.add(efa);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String sub = 'Cotización '+acc.Fraccionamiento_cta__r.Name;
            mail.setSubject(sub);
            String body = '<html><body><p style="font-size:20px;">Buen día<br/><br/>Adjuntamos la cotización solicitada para el fraccionamiento '+acc.Fraccionamiento_cta__r.Name+'<br/><br/> Saludos.</p></body></html>';
            mail.setHTMLBody(body);
            List<String> address = new List<String>{acc.CorreoElectronico__c}; 
                mail.setToAddresses(address);
            mail.setSaveAsActivity(true);
            mail.setFileAttachments(attachments);
            emailList.add(mail);
            if(!emailList.isEmpty()){
                Messaging.sendEmail(emailList);
            }
        }
      /*  Attachment att = new Attachment();
        att.Body= blobContent;
        att.ParentId = pId;
        att.Name = 'Propuesta'+' '+acc.QUOTE_Folio_Cotizacion__c+' '+'-'+' '+acc.QUOTE_Nombre_Fracc__c+' '+'-'+' '+acc.Nombre__c;
        att.IsPrivate = false;
        att.ContentType = 'application/pdf';
        insert att; */
         ContentVersion cv = new ContentVersion();
        cv.Title = 'Propuesta'+' '+acc.QUOTE_Folio_Cotizacion__c+' '+'-'+' '+acc.QUOTE_Nombre_Fracc__c+' '+'-'+' '+acc.Nombre__c+'.pdf';
        cv.PathOnClient = '/' + 'Propuesta'+' '+acc.QUOTE_Folio_Cotizacion__c+' '+'-'+' '+acc.QUOTE_Nombre_Fracc__c+' '+'-'+' '+acc.Nombre__c+'.pdf';
        cv.VersionData = blobContent;
        cv.IsMajorVersion = true;
        cv.ContentLocation = 'S';
        cv.Origin = 'H';
        Insert cv;
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;
        cDocLink.LinkedEntityId = pId;
        cDocLink.ShareType = 'I';
        cDocLink.Visibility = 'AllUsers';
        Insert cDocLink;
        ContentDistribution conDis = new ContentDistribution( ContentVersionId = cv.Id,Name = cv.Title, PreferencesAllowViewInBrowser = true,PreferencesLinkLatestVersion=true,PreferencesAllowOriginalDownload= true, PreferencesNotifyOnVisit =false);
        insert conDis; 
        system.debug('cv'+cv);
       system.debug('cDocLink'+cDocLink); 
        system.debug('conDis'+conDis);
        return base64Pdf;
    }
    @AuraEnabled
    public static void  UpdateNote(String title,String body,String pId){
        ContentNote cn = new ContentNote();
        cn.Title = title;
        cn.Content = Blob.valueOf(body);
        insert(cn);
        ContentDocument cd=[select id from ContentDocument where id=:cn.Id];
        ContentDocumentLink cdl=new ContentDocumentLink();
        cdl.ContentDocumentId=cd.id;
        cdl.LinkedEntityId=pId;
        cdl.ShareType='V';
        cdl.Visibility='AllUsers';
        insert cdl;
    }
    @AuraEnabled
    public static attachmentWrapper  fetchWappConvo(String pId){
        attachmentWrapper aw = new attachmentWrapper();
        List<WhatsApp__c> wtApplist = [Select Id, Message__c, Prospect__c, createdDate, Attachment_Caption__c,(select id, name, CreatedDate from Attachments) from WhatsApp__c where Prospect__c =: pId Order by CreatedDate Desc];
        Set<Id> wpIds = new Set<Id>();
        for(WhatsApp__c wp : wtApplist){
            wpIds.add(wp.Id);
        }
        list<Attachment> attList = [select id, name, CreatedDate from Attachment where ParentId IN :wpIds];
        if(wtApplist != null && wtApplist.size()>0){
            aw.wList = wtApplist;   
        }
        if(attList != null && attList.size()>0){
            aw.attachments = attList;
        }
        return aw;
    }
    @AuraEnabled
    public static List<docWrapper > fetchDocs(String pId){
        List<DocWrapper> docList = new List<DocWrapper>();
        List<Attachment> attList = [SELECT Id, Name, CreatedDate FROM Attachment WHERE ParentId = :pId order by CreatedDate desc];
        system.debug('attList'+attList);
        for (Attachment att : attList) {
            DocWrapper doc = new DocWrapper();
            doc.attachment = att;
            doc.CreatedDate = att.CreatedDate;
            docList.add(doc);
        }
        Set<Id> cdset = new Set<Id>();
        List<ContentDocumentLink> cdList = [SELECT Id, ContentDocument.Title, ContentDocument.CreatedDate FROM ContentDocumentLink WHERE LinkedEntityId = :pId AND ContentDocument.FileType != 'SNOTE'  order by ContentDocument.CreatedDate desc];
         system.debug('cdList'+cdList);
        for (ContentDocumentLink cdl : cdList) {
            cdset.add(cdl.ContentDocumentId);
        }
        List<ContentDistribution> cd =[Select Id,CreatedDate,ContentVersion.Title,ContentVersion.VersionData,ContentDownloadUrl,DistributionPublicUrl from ContentDistribution where ContentDocumentId In : cdset];
        for (ContentDistribution cdl : cd) {
            DocWrapper doc = new DocWrapper();
            doc.contentDocumentLink = cdl;
            doc.CreatedDate = cdl.CreatedDate;
            docList.add(doc);
        }
        system.debug('docList'+docList);
        //  docList.sort();
        return docList;
    }
    @AuraEnabled
    public static void SendEmailToPros( String pId, String subject , String msg){
        Account acc = [Select Id,Tipo__c, FirstName,Lastname ,Name,Phone, CorreoElectronico__c from Account  where Id =: pId];
        User u =[Select Id,Name,SenderEmail,Email from User where Id=:UserInfo.getUserId()];
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> address = new List<String>();
        address.add(acc.CorreoElectronico__c); //acc.CorreoElectronico__c
        if(address != null && address.size()>0){
            mail.setToAddresses(address);
            mail.setSubject(subject);
            mail.setHtmlBody(msg);
            mail.setSaveAsActivity(true);
            mails.add(mail);
            Messaging.sendEmail(mails); 
            EmailMessage emailMessage = new EmailMessage();
            emailMessage.status = '3';
            emailMessage.relatedToId = acc.Id;
            emailMessage.fromAddress = u.Email; 
            emailMessage.fromName = U.Name; 
            emailMessage.subject = subject; 
            emailMessage.htmlBody = msg; 
            emailMessage.toAddress = acc.CorreoElectronico__c;//acc.CorreoElectronico__c
            insert emailMessage;
        }
    }
    @AuraEnabled
    public static List<Notes>  fetchEmailconvo(String pId){
        Set<Id> contentDocumentIds = new Set<Id>();  List<Notes> ntlist = new List<Notes>();
        for(ContentDocumentLink conDoc : [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:pId]){
            contentDocumentIds.add(conDoc.ContentDocumentId);
        }
        for(ContentNote contentNotes : [SELECT Id, Title,Content, CreatedDate, CreatedBy.Name from ContentNote where Id In: contentDocumentIds ORDER BY CreatedDate DESC]){
            Notes nt = new Notes();
            nt.Title = contentNotes.Title;
            nt.CreatedBy = contentNotes.CreatedBy.Name;
            nt.Content = contentNotes.Content.toString().replaceAll('<[^>]+>',' ');
            nt.CreatedDate = contentNotes.CreatedDate;
            ntlist.add(nt);
        }
        return ntlist;
    }
    @AuraEnabled
    @future(callout = true)
    public static void sendWhatsappSms(String phone){
        String  phone1 = phone;
        if(phone.contains('+')){
            phone1 = phone.substring(1, phone.length());
        }
        String accessToken = System.Label.WhatsappToken;
        String endpoint = System.Label.Whatsapp_Endpoint;
        String template = System.Label.Whatsapp_Template;
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndPoint(endpoint);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer '+accessToken);
        req.setBody('{"messaging_product":"whatsapp", "to": '+phone1+', "type" : "template", "template" : {"name" : "/'+template+'/", "language" : {"code" : "en_US"}}}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
    }
      @AuraEnabled
    public static String updateOwner(string pId){
         String msg = '';
        try{
            List<Account> acc = [Select Id,Asesor__c,Prospectador__c from Account where Id=:pId LIMIT 1];
            if(acc != null && acc.size()>0){
                system.debug(acc);
                acc[0].OwnerId = UserInfo.getUserId();
                update acc[0];
                msg = 'Dueño actualizado';
            }
        }
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            throw new AuraHandledException(msg);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
            return msg;
    }
    @AuraEnabled
    public static String updateFraccAss(string pId, String frac){
        String msg = JaverClass.updateFraccAsessor(pId, frac);
        return msg;
    }
    public class wrap{
        @AuraEnabled public List<Task> Taskslist;
        @AuraEnabled public List<Event> eventslist;
    }
    public class wrapAccount{
        @AuraEnabled public Account account;
        @AuraEnabled public String recTypeId;
        @AuraEnabled public Boolean recTypeName;
        @AuraEnabled public List<String> fracsList;
        @AuraEnabled public String userEmail;
        @AuraEnabled public String postal;
        @AuraEnabled public String UserId;
        @AuraEnabled public String recordTypeId;
        @AuraEnabled public String ProfileName;
        @AuraEnabled public List<Prototipo__c> proplist;
        @AuraEnabled public List<String> tipoList;
    }
    public class attachmentWrapper {
        @AuraEnabled public List<WhatsApp__c> wList;
        @AuraEnabled public List<Attachment> attachments;
    }
    public class Subjectwrap{
        @AuraEnabled public List<String> statusList ;	
        @AuraEnabled public List<String> subList ;	
        @AuraEnabled public List<String> eventsubList ;	 
    }
    public class Notes {
        @AuraEnabled public String Title;
        @AuraEnabled public String Content;
        @AuraEnabled public String CreatedBy;
        @AuraEnabled public Datetime CreatedDate;
    }
    public class docWrapper {
        @AuraEnabled public Attachment attachment ;
        @AuraEnabled public ContentDistribution contentDocumentLink ;
        @AuraEnabled public Datetime CreatedDate;
    }
}