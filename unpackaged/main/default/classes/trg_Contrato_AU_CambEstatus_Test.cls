@isTest
public class trg_Contrato_AU_CambEstatus_Test {
	static TestMethod void Test1() {
        Contrato__c contro = new Contrato__c(name = 'test cancel',Estatus__c= 'INICIAL');
        insert contro;
        Test.startTest();
        contro.Estatus__c = 'Aprobada';
        update contro;
        Test.stopTest();
    }
}