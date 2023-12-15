@isTest 
public  class ContentDocumentLinkHandler_Test {
    
    @testSetup
    public static void setup(){
         //Id ATCRecordTypeId = [SELECT Id, Name FROM RecordType WHERE Name = 'AFLUENTE PERSONA MORAL' AND IsPersonType=True].Id;
        Id idTipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Account cuenta = new Account(Apellidomaterno_cta__c = 'materno',FirstName = 'fName',LastName = 'lName',Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES',
                                     TelefonoCelular__c = '+525656566567',phone = '+525656566567',Sub_canal_de_venta__c = 'COLABORADOR JAVER',
                                     RecordTypeId = idTipoRegistroProspectoPersonaFisica);
        insert cuenta;
        
        
        ContentVersion contentVersionInsert = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true);
        insert contentVersionInsert;
        Account ac = new Account();
        ac.name= 'test';
        ac.Phone = '+528119928819';
        ac.Otro_Telefono__c = '+528119928819'; 
        ac.Apellidomaterno_cta__c = 'materno';
        ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert ac;
        Contact con = new Contact(LastName ='testCon',AccountId = ac.Id);
        insert con; 
    }
    @isTest
    private static void ContentDocumentLinkHandler(){
          Test.startTest();
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        List<ContentVersion> contentVersions = [SELECT Id, ContentDocumentId, VersionData FROM ContentVersion WHERE ContentDocumentId IN: documents];
        List<ContentDocumentLink> documentLinks = [SELECT Id FROM ContentDocumentLink WHERE ContentDocumentId =: contentVersions[0].Id];
        Account account = [SELECT Id FROM Account LIMIT 1];
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Asesor' LIMIT 1].Id;
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        User user = [Select Id,UserRoleId from User where UserRoleId=:portalRole.Id LIMIT 1];
        System.runAs(user) {
            ContentWorkspace testWorkspace = new ContentWorkspace(Name='All_Files', DeveloperName='All_Files');
            insert testWorkspace;
            // List< ContentWorkspace> testWorkspace = [SELECT Id FROM ContentWorkspace Where Name = 'All Files']; 
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = contentVersions[0].ContentDocumentId;
            cdl.ShareType = 'V';
            cdl.Visibility = 'AllUsers';
            cdl.LinkedEntityId = account.Id; 
          
            insert cdl;
            
            try{
                delete cdl; 
            }
            catch(Exception e){
                Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
                System.assertEquals(expectedExceptionThrown, true);
            }
        }
        try{
            delete documents;
        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        Test.stopTest();
    }
    
}