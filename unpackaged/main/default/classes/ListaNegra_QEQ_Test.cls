@isTest
public class ListaNegra_QEQ_Test {
    static TestMethod void Test2() {
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        Account acc = new Account();
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName = 'test';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819'; 
        acc.Apellidomaterno_cta__c = 'materno';
        acc.BillingCity = 'test';
        acc.BillingState = 'test';
        acc.BillingCountry = 'test';
        acc.BillingPostalCode = '456';
        acc.BillingColony__c = 'tst';
        acc.BillingStreet = 'test';
        acc.Zona__c = '23434';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Empresa__c = 'test';
        acc.Puesto__c = 'test';
        insert acc;
        Test.setMock(HttpCalloutMock.class, new ListaNegra_QEQ_MockHttpResponse());     
        Test.startTest();
        ListaNegra_QEQ.sentToQeq(acc.Id); 
        Test.stopTest();
    }
}