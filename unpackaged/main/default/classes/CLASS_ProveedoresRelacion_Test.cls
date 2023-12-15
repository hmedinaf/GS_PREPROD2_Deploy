@isTest
public class CLASS_ProveedoresRelacion_Test {
    static TestMethod void testMethod1() {
        Id rtd =  Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.RecordTypeId = rtd;
        insert prod1;
        Proveedor__c Proveedor = new Proveedor__c();
        Proveedor.name = 'Proveedor';
        Proveedor.Rfc__c = 'Rfc';
        Proveedor.Contacto__c = 'Contacto';
        Proveedor.Correo__c = 'test@abc.com';
        Proveedor.Nombre_Comercial__c = 'Nombre_Comercial';
        Test.startTest();
        CLASS_ProveedoresRelacion.creaProveedor(Proveedor, prod1.Id);
        CLASS_ProveedoresRelacion.getRelatedList(prod1.Id);
        Test.stopTest();
    }
}