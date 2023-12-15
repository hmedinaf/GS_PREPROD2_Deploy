@isTest
public class trg_Comision_AU_CambEstatus_Test {
    static TestMethod void testMethod1() {
        Comision__c Comision_new = new Comision__c();
        Comision_new.name='Test';
        Comision_new.Token__c='987654321';
        insert Comision_new;
        Test.startTest();
        Comision_new.Estatus__c = 'Aprobada';
        update Comision_new;
        Test.stopTest();
    }
}