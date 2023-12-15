@isTest
public class CPPT_Proveedor_Test {
    @isTest
    public static void Test1() {
         Id rtd =  Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        Product2 p = new Product2(Precio_Venta__c = 12, name = 'prod', Description = 'Prod Description',RecordTypeId = rtd);
        insert p;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Proveedor__c Proveedor = new Proveedor__c(name = 'Proveedor', Rfc__c = 'Rfc', Contacto__c = 'Contacto', Correo__c = 'test@test.com', Nombre_Comercial__c = 'Nombre_Comercial');
        insert Proveedor;
        Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c(Proveedor__c = Proveedor.id, Producto__c =  p.id);
        insert prov;
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            Database.DeleteResult result = Database.delete(Proveedor, false);
        } catch (Exception e) {
            exceptionThrown = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('No se puede')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Test.stopTest();
        System.assertEquals(false, exceptionThrown, 'No exception was thrown');
    }
}