@isTest
public class WhatsAppIntegration_Test {
@isTest
    public static void Test1() {
        Account A = new Account(Name = 'AccName',Apellidomaterno_cta__c = 'materno',Phone = '+528119928819',Otro_Telefono__c = '+528119928819',Canal_de_Venta__c = 'PROSPECTO ASESOR');
        insert A;
        contact con = new contact(LastName = 'Lname',AccountId = A.id, MobilePhone = '+525656565656');
        insert con;
        Colonia__c C = new Colonia__c();
        C.Name = 'test';
        insert C;
        WhatsApp__c W = new WhatsApp__c();
        W.Message__c = 'Hi';
        W.Prospect__c = a.id;
        insert W;
        Test.setMock(HttpCalloutMock.class, new MockHttpProspects());     
        Test.startTest();
        WhatsAppIntegration.sendSms(con.Id);
        Test.stopTest();
    }
}