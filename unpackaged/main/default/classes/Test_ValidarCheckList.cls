@isTest
public class Test_ValidarCheckList {
    static testMethod void validar(){
        Test.startTest();
        Check_List__c cl = new Check_List__c();
        cl.CorreEnvio__c = 'aaa@mail.com';
        insert cl;
        Test.stopTest();
    }
}