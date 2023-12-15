@isTest
public class CONTROL_PlanPagosCobranzaComercial_Test {
    @isTest
    static void test1(){
        Opportunity opp = new Opportunity(Name = 'Test Opportunity');
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        Cobranza_Comercial__c cc = new Cobranza_Comercial__c();
        cc.Proceso_Venta__c = opp.Id;
        insert cc;
        Test.startTest();
        PageReference page = Page.PlanPagosCobranzaComercial;
        Test.setCurrentPageReference(page);
        ApexPages.StandardController controller = new ApexPages.StandardController(cc);
        CONTROL_PlanPagosCobranzaComercial co = new CONTROL_PlanPagosCobranzaComercial(controller);
        co.cancelar();
        Test.stopTest();
    }
}