@isTest
public class PropuestaPdf_Test {
    @isTest
    static void test1(){
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
        acc.Zona__c = '23434';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        pagereference pf = Page.PropuestaPdf;
        Test.setCurrentPageReference(pf);
        ApexPages.currentPage().getParameters().put('accId', acc.id) ;
        Test.startTest();
        PropuestaPdf pc = new PropuestaPdf();
        Test.stopTest();
    }
}