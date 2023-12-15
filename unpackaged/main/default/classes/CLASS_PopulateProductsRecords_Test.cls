@isTest
public class CLASS_PopulateProductsRecords_Test {
    static TestMethod void Test1() {
        Id rtd =  Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.RecordTypeId = rtd;
        insert prod1;
        PricebookEntry st = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = prod1.Id, UnitPrice = 100 ,IsActive = true );
        insert st;
        Pricebook2 pb1  = new Pricebook2();
        pb1.Name = 'Standard122';
        pb1.Description = 'test';
        pb1.Periodo_Inicio__c='JUNIO 2023';
        pb1.Periodo_Fin__c='DICIEMBRE 2023';
        pb1.Vigente_Desde__c = system.today() ;
        pb1.Vigente_Hasta__c= Date.newInstance(2023, 08, 30);
        pb1.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosBydevelopername().get('Producto_Generico').getRecordTypeId();
        insert pb1;
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pb1.Id, Product2Id = prod1.Id, UnitPrice = 100 ,IsActive = true ,UseStandardPrice = false);
        insert standardPrice;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='BOSQUE REAL');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Proveedor__c p = new Proveedor__c(name = 'new prov',Rfc__c = 'rfc', Contacto__c = 'contact', Correo__c = 'abc@abc.com', Nombre_Comercial__c = 'nom');
        insert p;
        Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c(Producto__c = prod1.id,Proveedor__c = p.id);
        insert prov;
        Relacion_Producto_Plaza__c rpp = new Relacion_Producto_Plaza__c(name = 'test',Producto__c = prod1.id,Plaza__c = plaza.id);
        insert rpp;
        Relacion_Producto_Fraccionamiento__c rpf = new Relacion_Producto_Fraccionamiento__c(name = 'test',Producto__c = prod1.id, Fraccionamiento__c = f.id,Vigencia_Hasta__c = system.today().addDays(-1),
                                                                                            Relacion_Producto_Plaza_Fraccionamiento__c = rpp.id);
        insert rpf;
        Test.startTest();
        CLASS_PopulateProductsRecords.getProductByPricebook(pb1.Id);
        CLASS_PopulateProductsRecords.getProductByPricebook(null);
        CLASS_PopulateProductsRecords.populaCamposProducto(prod1.Id);
        CLASS_PopulateProductsRecords.createRecord('Otros Gastos', true, 'test', 'OFICIAL','test3', 10, 20, 30,'test12','test',String.valueOf(prod1.Id), String.valueOf(rtd));
        Test.stopTest();
    }
}