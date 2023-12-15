@isTest
public class FraccPickList_Test {
    static TestMethod void testMethod1() {
        Account acc = new Account();
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c = f.id;
        insert acc;
        List<String> flist = new List<String>();  
        flist.add('ACACIAS');
        Test.startTest();
        FraccPickList.getPicklistValues();
        FraccPickList.SaveFracc(flist, acc.Id);
        Test.stopTest();
    }
}