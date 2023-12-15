@isTest
public class CLASS_Visita_Fraccionamiento_Test {
    @isTest
    static void test1(){
        List<Visita_Fraccionamiento__c> visitasNuevasNoAutomaticas = new List<Visita_Fraccionamiento__c>();
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
        Visita_Fraccionamiento__c vf = new Visita_Fraccionamiento__c();
        vf.Fraccionamiento__c = f.Id;
        vf.Automatica__c = false;
        vf.Cuenta__c = acc.Id;
        insert vf;
        visitasNuevasNoAutomaticas.add(vf);
        Test.startTest();
        CLASS_Visita_Fraccionamiento cv = new CLASS_Visita_Fraccionamiento();
        cv.asignaValoresAutomaticos(visitasNuevasNoAutomaticas);
        Test.stopTest();
    }
}