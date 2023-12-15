@isTest
public class EnviarCorreoEntrega_Test {
    static TestMethod void testMethod1(){
        Account acc = new Account();
        acc.Name = 'CUENTA ASIGNACION GENERICA';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        Inventario__c inventario = new Inventario__c();
        inventario.Name = 'Test Inventario';
        insert inventario;
        contact con = new contact();
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        con.Email = 'test@mail.com';
        insert con;
        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventario.Id;
        entrega.FechaEntrega__c = Date.today();
        insert entrega;
        Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
        ContentVersion contentVersion_1 = new ContentVersion(  Title='Header_Picture1',    PathOnClient ='test.pdf',VersionData = bodyBlob,   origin = 'H'  );
        insert contentVersion_1;
        Id conDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersion_1.Id].ContentDocumentId;
        
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = entrega.Id;
        cdl.ContentDocumentId = conDocId;
        cdl.shareType = 'V';
        Insert cdl;
        Test.startTest();
        EnviarCorreoEntrega.run(inventario.Id, JSON.serialize(entrega));
        Test.stopTest();
    }
    
}