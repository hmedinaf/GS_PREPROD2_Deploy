@isTest(SeeAllData=true)
public class Test_Survey2 {
    static testmethod void testMigrate2(){
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
        acc.CorreoElectronico__c ='test@mail.com';
        insert acc; 
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Entregada__c = 'Por Entregar';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = acc.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        inventario.FechaEntrega__c = date.today().addMonths(-11).toStartofMonth();
        inventario.FechaEntrega__c =  date.today().addMonths(-11).toStartofMonth().addDays(-1);
        insert inventario;
        Test.startTest();
        EncuestaAnual EA = new EncuestaAnual();
        Id batchId2 = Database.executeBatch(EA,9); 
        EncuestaAnualSchedule eAS = new EncuestaAnualSchedule();
        String sch = '0 0 23 * * ?';
        system.schedule('Test Check', sch, eAS); 
        Test.stopTest();  
    }
}