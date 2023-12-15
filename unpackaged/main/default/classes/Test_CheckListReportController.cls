@isTest(SeeAllData = true)
public class Test_CheckListReportController {
    static testMethod void validar(){
        Test.startTest();
        
        Id rt = [select id from RecordType where name = 'Planta 3'].id;
        
        Inventario__c inventario = new Inventario__c();
        inventario.NumeroInterior__c ='123132';
        insert inventario;
        
         Check_List__c cl = new Check_List__c();
        cl.CorreEnvio__c = 'correo@prueba.com';
        cl.Vivienda__c = inventario.ID;
        cl.RecordTypeId = rt;
        insert cl;
        
        PageReference page = Page.CheckList_Report;
        page.getParameters().put('id',cl.Id);
        Test.setCurrentPageReference(page);
        new CheckListReportController();
        Test.stopTest();
    }
}