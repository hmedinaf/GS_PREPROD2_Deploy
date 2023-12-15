// for CPPT_Rel_Prod_Frac, CPPT_Rel_Prod_Prov and CPPT_Rel_Prod_Plaza
@isTest
public class CPPT_Rel_Prod_Frac_Test {
    static TestMethod void Test1() {
        Id rtd =  Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        Product2 prod = new Product2(name = 'test prod',Precio_Venta__c = 12,Description = 'test',Numero_Filtro__c = 1267446,RecordTypeId = rtd);
        insert prod;
        Fraccionamiento__c f = new Fraccionamiento__c(name = 'fracc',Estado_Fracc__c = 'Nuevo León');
        insert f;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Proveedor__c p = new Proveedor__c(name = 'new prov',Rfc__c = 'rfc', Contacto__c = 'contact', Correo__c = 'abc@abc.com', Nombre_Comercial__c = 'nom');
        insert p;
        Test.startTest();
        Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c(Producto__c = prod.id,Proveedor__c = p.id);
        insert prov;
        Relacion_Producto_Plaza__c rpp = new Relacion_Producto_Plaza__c(name = 'test',Producto__c = prod.id,Plaza__c = plaza.id);
        insert rpp;
        Relacion_Producto_Fraccionamiento__c rpf = new Relacion_Producto_Fraccionamiento__c(name = 'test', Fraccionamiento__c = f.id,
                                                                                            Relacion_Producto_Plaza_Fraccionamiento__c = rpp.id);
        insert rpf;
        rpf.Vigencia_Hasta__c = system.today();
        update rpf;
        Fraccionamiento__c f1 = new Fraccionamiento__c(name = 'fracc',Estado_Fracc__c = 'test');
        insert f1;
        rpf.Fraccionamiento__c = f1.id;
        try{
            update rpf;
        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        Relacion_Producto_Plaza__c rpp1 = new Relacion_Producto_Plaza__c(name = 'test');
        try{
            insert rpp1;
        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        Test.stopTest();
    }
    
}