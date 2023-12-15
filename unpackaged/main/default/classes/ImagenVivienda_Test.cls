@isTest
public class ImagenVivienda_Test {
    @isTest
    static void test1(){
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
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Fracc__c = f.Id;
        inventario.Entregada__c = 'Por Entregar';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = acc.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        insert inventario;
        Test.startTest();
        ApexPages.StandardController controller = new ApexPages.StandardController(inventario);
        ImagenVivienda imagenVivienda = new ImagenVivienda(controller);
        imagenVivienda.latitude = 10.00;
        imagenVivienda.longitude = 20.00;
        Test.stopTest();
    }
}