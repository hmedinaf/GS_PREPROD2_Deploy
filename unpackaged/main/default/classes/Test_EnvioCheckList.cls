@isTest
public class Test_EnvioCheckList {
    @isTest
    static void validar(){
        Check_List__c cl = new Check_List__c();
        cl.CorreEnvio__c = 'correo@prueba.com';
        insert cl;
        Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
        ContentVersion contentVersion_1 = new ContentVersion(  Title='Header_Picture1',    PathOnClient ='test.jpg',VersionData = bodyBlob,   origin = 'H'  );
        insert contentVersion_1;
        
        Id conDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:contentVersion_1.Id].ContentDocumentId;
        
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = cl.Id;
        cdl.ContentDocumentId = conDocId;
        cdl.shareType = 'V';
        Insert cdl;
        contact con = new contact();
        con.FirstName = 'Test';
        con.LastName = 'Contact';
        insert con;
        PageReference page = Page.CheckList_Envio;
        page.getParameters().put('id',cl.Id);
        Test.setCurrentPageReference(page);
        Test.startTest();
        EnvioCheckList ev =  new EnvioCheckList();
        ev.corre();
        ev.getChecklist(cl.Id, cl.Name);
        EnvioCheckList.validateEmail('test@mail.com');
        Test.stopTest();
    }
    @isTest
    static void validar1(){
        EmailTemplate e = new EmailTemplate (developerName = 'CheckList',  folderId = userInfo.getUserId() , TemplateType= 'Text', Name = 'CheckList');
        insert e;
        
        Test.startTest();
        EnvioCheckList ev =  new EnvioCheckList();
        ev.corre();
        Test.stopTest();
    }
}