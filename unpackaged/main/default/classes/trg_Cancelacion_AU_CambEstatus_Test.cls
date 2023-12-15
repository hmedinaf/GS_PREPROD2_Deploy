@isTest
public class trg_Cancelacion_AU_CambEstatus_Test {
    static TestMethod void Test1() {
        Cancelacion__c cancel = new Cancelacion__c(name = 'test cancel');
        insert cancel;
        Test.startTest();
        cancel.Estatus__c = 'Aprobada';
        update cancel;
        Test.stopTest();
    }
}