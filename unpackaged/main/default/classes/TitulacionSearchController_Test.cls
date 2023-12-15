@isTest
public class TitulacionSearchController_Test {
    static TestMethod void testMethod1() {
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.parse('11/09/1991');
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        Test.startTest();
        TitulacionSearchController tc = new TitulacionSearchController();
        tc.search();
        tc.clear();
        Test.stopTest();
    }
    static TestMethod void testMethod2() {
        Test.startTest();
        TitulacionSearchController tc = new TitulacionSearchController();
        tc.searchField = 'Apellidopaterno_cta__c';
        tc.search();
        Test.stopTest();
    }
    static TestMethod void testMethod3() {
        Test.startTest();
        TitulacionSearchController tc = new TitulacionSearchController();
        tc.searchField = 'FechaNacimiento_Formula__c';
        tc.search();
        Test.stopTest();
    }
    static TestMethod void testMethod4() {
        Test.startTest();
        TitulacionSearchController tc = new TitulacionSearchController();
        tc.searchField = 'ParentId';  
        tc.search();
        Test.stopTest();
    }
     static TestMethod void testMethod5() {
        Test.startTest();
        TitulacionSearchController tc = new TitulacionSearchController();
        tc.searchField = 'Lead_Profiler__c';   
        tc.search();
        Test.stopTest();
    }
}