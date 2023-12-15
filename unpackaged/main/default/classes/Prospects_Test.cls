@isTest
public class Prospects_Test {
    @isTest(seeAllData=true)
    public static void Test1() {  
        UserRole userrole = [Select Id, DeveloperName From UserRole Where PortalType= 'None' Limit 1];
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'JAVER - Generico' LIMIT 1].Id;
        system.debug('profileId='+profileId);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserroleId = userrole.id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'BOSQUE REAL;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'BOSQUE REAL', FraccionamientoAutorizados__c = 'BOSQUE REAL');
        insert user;
        
        
        System.runAs(user) {
            Fraccionamiento__c f = new Fraccionamiento__c( Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                          Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='BOSQUE REAL');
            insert f;
            
            Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
            insert proto;
            
            Account acc = new Account();
            acc.FirstName= 'Lopez';
            acc.LastName= 'test';
            acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
            acc.CorreoElectronico__c = 'test@prospects.com';
            acc.Apellidomaterno_cta__c = 'dahuoh';
            acc.PersonBirthdate=date.parse('11/09/1991');
            acc.Phone = '+528119928819';
            acc.Fraccionamiento_cta__c = f.id;
            acc.Otro_Telefono__c = '+528119928819';
            acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
            insert acc;
            Attachment attach=new Attachment();   	
            attach.Name='Unit Test Attachment';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach.body=bodyBlob;
            attach.parentId=acc.id;
            insert attach;
            ContentVersion content=new ContentVersion(); 
            content.Title='Header_Picture1'; 
            content.PathOnClient='/' + content.Title + '.jpg'; 
            Blob bodyBlob1=Blob.valueOf('Unit Test ContentVersion Body'); 
            content.VersionData=bodyBlob1; 
            content.origin = 'H';
            insert content;
            ContentDocumentLink contentlink=new ContentDocumentLink();
            contentlink.LinkedEntityId=acc.id;
            contentlink.contentdocumentid=[select contentdocumentid from contentversion where id =: content.id].contentdocumentid;
            contentlink.ShareType = 'I';
            contentlink.Visibility = 'AllUsers'; 
            insert contentlink;
            Account A = new Account(name= 'Lopez',
                                    RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Company_Javer').getRecordTypeId(),
                                    Apellidomaterno_cta__c = 'materno',Phone = '+528119928819',Otro_Telefono__c = '+528119928819',Canal_de_Venta__c = 'PROSPECTO ASESOR');
            insert A;
            contact con = new contact(LastName = 'Lname',AccountId = A.id, MobilePhone = '+525656565656');
            insert con;
            WhatsApp__c W = new WhatsApp__c();
            W.Message__c = 'Hi';
            W.Prospect__c = acc.id;
            insert W;
            Datetime startDateTime = Datetime.newInstance(2023, 3, 14,23, 0, 0);
            Datetime EndDateTime = Datetime.newInstance(2023, 3, 15,23, 0, 0);
            Test.setMock(HttpCalloutMock.class, new MockHttpProspects());     
            Test.startTest();
            Prospects.fetchProspectsDetails(acc.Id);
            Prospects.fetchEveTaskSubject();
            Prospects.saveEvents(acc.Id,'Subject',startDateTime,EndDateTime,'Description');
            Prospects.saveTasks(acc.Id, 'Subject', system.today(), 'Test', 'Description');
            Prospects.fetchActivities(acc.Id);
            Prospects.UpdateNote('title','body',acc.Id);
            Prospects.fetchWappConvo(acc.Id);
            Prospects.fetchDocs(acc.Id);
            Prospects.SendEmailToPros(acc.Id, 'subject' , 'msg');
            Prospects.fetchEmailconvo(acc.Id);
            Prospects.sendWhatsappSms('+525656565656');
            //WhatsAppIntegration.sendSms(con.Id);
            Prospects.updatePorpFields(acc.Id,acc, f.Id, proto.Id, '');
            Prospects.pdfGen(acc.Id , true);
            Prospects.updateMethod(acc.Id, f.Id);            
            Test.stopTest();
        }
    }
    
    public static void Test_updateOwner() {  
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.parse('11/09/1991');
        acc.Phone = '+528119928819';            
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        Prospects.updateOwner(acc.Id);   
    }
    
    
}