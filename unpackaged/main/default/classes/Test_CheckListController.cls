@isTest
public class Test_CheckListController {
    static testMethod void validar(){
        Test.startTest();
        Check_List__c lista1 = new Check_List__c();
        lista1.RecordTypeId = [select id from RecordType where name = 'Planta 1'].id;
        new CheckListController(lista1);
        Check_List__c lista2 = new Check_List__c();
        lista2.RecordTypeId = [select id from RecordType where name = 'Planta 2'].id;
        new CheckListController(lista2);
        Check_List__c lista3 = new Check_List__c();
        lista3.RecordTypeId = [select id from RecordType where name = 'Planta 3'].id;
        new CheckListController(lista3);
        Test.stopTest();
    }
}