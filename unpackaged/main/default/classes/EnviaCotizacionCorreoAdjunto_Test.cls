@isTest
public class EnviaCotizacionCorreoAdjunto_Test {
    static TestMethod void testMethod1() {
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
        Test.startTest();
        EnviaCotizacionCorreoAdjunto.InputVariables testInput = new EnviaCotizacionCorreoAdjunto.InputVariables();
        testInput.AccountId = acc.Id;
        testInput.DocumentId = contentlink.Id;
        testInput.ToEmail = 'test@mail.com';
        testInput.Subject = 'Test Subject';
        testInput.bodyTemplate = '<p>Test </p>';
        EnviaCotizacionCorreoAdjunto.Envia(new List<EnviaCotizacionCorreoAdjunto.InputVariables>{ testInput });
        Test.stopTest();
    }
}