@isTest
public class trg_Provee_AU_CambEstatus_Test {
    static TestMethod void Test1() {
        Proveedor__c Proveedor = new Proveedor__c();
        Proveedor.name = 'Proveedor';
        Proveedor.Rfc__c = 'Rfc';
        Proveedor.Contacto__c = 'Contacto';
        Proveedor.Correo__c = 'test@abc.com';
        Proveedor.Nombre_Comercial__c = 'Nombre_Comercial';
        insert Proveedor;
        
        Test.startTest();
        Proveedor.Estatus__c = 'Aprobada';
        update Proveedor;
        Test.stopTest();
    }
}