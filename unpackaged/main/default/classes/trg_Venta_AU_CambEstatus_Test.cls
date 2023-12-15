@isTest
public class trg_Venta_AU_CambEstatus_Test {
 static TestMethod void testMethod1() {
        Venta__c Venta_new = new Venta__c();
        Venta_new.name='Test';
        Venta_new.Token__c='987654321';
        insert Venta_new;
        Test.startTest();
        Venta_new.Estatus__c = 'Aprobada';
        update Venta_new;
        Test.stopTest();
    }
}