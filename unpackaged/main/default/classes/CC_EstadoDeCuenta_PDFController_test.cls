@isTest
public class CC_EstadoDeCuenta_PDFController_test {
    static testmethod void TicketMethod(){
          Opportunity opp = new Opportunity(Name = 'Test Opportunity');
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        Cobranza_Comercial__c cc = new Cobranza_Comercial__c();
        cc.Proceso_Venta__c = opp.Id;
        insert cc;
         test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(cc);
        CC_EstadoDeCuenta_PDFController testAccPlan = new CC_EstadoDeCuenta_PDFController(sc);
        test.stopTest();
    }
}