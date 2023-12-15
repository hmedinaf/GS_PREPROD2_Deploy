@isTest
public class trg_Insumo_AU_CambEstatus_Test {
	static TestMethod void Test1() {
        Insumo__c ins = new Insumo__c(name = 'test cancel');
        insert ins;
        Test.startTest();
        ins.Estatus__c = 'Aprobada';
        update ins;
        Test.stopTest();
    }
}