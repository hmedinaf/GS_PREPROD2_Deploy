@isTest
public class trg_Planning_AU_CambEstatus_Test {
	static TestMethod void Test1() {
        Planning__c plan = new Planning__c(name = 'test');
        insert plan;
        Test.startTest();
        plan.Estatus__c = 'Aprobada';
        update plan;
        Test.stopTest();
    }
}