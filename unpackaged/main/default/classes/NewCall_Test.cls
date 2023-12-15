@isTest
public class NewCall_Test {
    static TestMethod void testMethod1(){
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
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.FechaEntregaEsperada__c = System.today();
        inventario.FechaEntrega__c=system.today()-1;
        insert inventario;
        Task t = new Task(Status = 'In Progress',Priority = 'Normal',Subject = 'subject' ,whatId=acc.Id,ActivityDate = system.today().addDays(+3));
        insert t;
    }
}