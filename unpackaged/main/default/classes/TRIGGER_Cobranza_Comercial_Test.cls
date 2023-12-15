@isTest
public class TRIGGER_Cobranza_Comercial_Test {
    static TestMethod void testMethod1() {
         Opportunity opp = new Opportunity(Name = 'Test Opportunity');
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        Cobranza_Comercial__c cc = new Cobranza_Comercial__c();
        cc.Proceso_Venta__c = opp.Id;
        insert cc;
		delete cc;
    }
}