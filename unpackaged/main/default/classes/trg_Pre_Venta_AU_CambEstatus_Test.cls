@isTest
public class trg_Pre_Venta_AU_CambEstatus_Test {
static TestMethod void Test1() {
        Pre_Venta__c pre = new Pre_Venta__c(name = 'test');
        insert pre;
        Test.startTest();
        pre.Estatus__c = 'Aprobada';
        update pre;
        Test.stopTest();
    }
}