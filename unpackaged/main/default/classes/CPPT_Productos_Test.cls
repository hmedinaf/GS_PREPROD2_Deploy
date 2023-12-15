@isTest
public class CPPT_Productos_Test {
    static TestMethod void testMethod1() {
        Id rtd =  Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        Product2 prod2 = new Product2();
        prod2.name = 'testp2';
        prod2.Numero_Filtro__c = 2;
        prod2.IsActive = true;
        prod2.Precio_Venta__c = 10.0;
        prod2.Description = 'test2';
        prod2.Tipo_de_Producto__c = 'Casa Muestra';
        prod2.Marca__c = 'Marca__c';
        prod2.RecordTypeId = rtd;
        Boolean exceptionThrown = false;
        try {
            insert prod2;
        } 
        catch (Exception e) {
            exceptionThrown = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains(' La marca para')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='ACACIAS');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Proveedor__c p = new Proveedor__c(name = 'new prov',Rfc__c = 'rfc', Contacto__c = 'contact', Correo__c = 'abc@abc.com', Nombre_Comercial__c = 'nom');
        insert p;
        
        Id devRecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByName().get('Vivienda').getRecordTypeId(); 
        priceBook2 pb = new PriceBook2(Name='VIV BOSQUE REAL TAMARINDO 2023-06-01 2023-06-30', IsActive=true, Description='LISTA BSQUE REAL', Solicitar_Aprobaci_n__c=false, Prototipo__c=proto.Id, Vigente_Desde__c=date.today(), Vigente_Hasta__c=date.today().addDays(25), Fraccionamiento__c=f.Id, Estatus__c='Aprobado', Periodo_Inicio__c='JUNIO 2023', Periodo_Fin__c='JUNIO 2023', Precio_Instalaciones__c=25000.00, Precio_esquina__c=0.00, Precio_frente_area_municipal__c=10000.00, Precio_frente_a_praque__c=10000.00, Precio_lado_sol__c=20000.00, Precio_lado_sombra__c=25000.00, Precio_sobre_avenida__c=25000.00, Precio_superficie_excedente__c=2500.00, Porcentaje_Precio_instalaciones__c=0.00,
                                       Porcentaje_Precio_esquina__c=1.50, Prcentaje_Precio_frente_area_municipal__c=0.00, Precio_frente_a_parque__c=0.00, Procentaje_Precio_lado_sol__c=0.00, Porcentaje_Precio_lado_sombra__c=0.00, Porcentaje_Precio_sobre_avenida__c=0.00, Precio_Presupuesto__c=0.00, Ilimitado__c=false, Precio_Lista__c=1800000.00, Presupuesto__c=1800000.00, IVA__c=0.00, Beneficio__c=0.00, Tipo_de_Producto__c='Vivienda', Casa_Amueblada__c=false, Check_Precio_Unitario__c=false, Porcentaje_Precio_Superficie_Excedente__c=0.00, Nombre_Lista_Validacion__c='VIV BOSQUE REAL TAMARINDO 2023-05-31 2023-06-30', Solicitd_de_Aprobacion__c=false, Lista_Duplicada__c=false, RecordTypeId=devRecordTypeId);
        insert pb;
        Product2 prod = new Product2();
        prod.name = 'test11';
        prod.Numero_Filtro__c = 2;
        prod.IsActive = true;
        prod.Precio_Venta__c = 10.0;
        prod.Description = 'test';
        prod.Producto_Original__c = 'testP';
        prod.Codigo_Producto_Original__c = 'testProd';
        prod.RecordTypeId = rtd;
        insert prod;
        Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c(Producto__c = prod.id,Proveedor__c = p.id);
        insert prov;
        Relacion_Producto_Plaza__c rpp = new Relacion_Producto_Plaza__c(name = 'test',Producto__c = prod.id,Plaza__c = plaza.id);
        insert rpp;
        Relacion_Producto_Fraccionamiento__c rpf = new Relacion_Producto_Fraccionamiento__c(name = 'test',Producto__c = prod.id, Fraccionamiento__c = f.id,Vigencia_Hasta__c = system.today().addDays(-1),
                                                                                            Relacion_Producto_Plaza_Fraccionamiento__c = rpp.id);
        insert rpf;
        Relacion_Producto_Fraccionamiento__c rpf1 = new Relacion_Producto_Fraccionamiento__c(name = 'test',Producto__c = prod.id, Fraccionamiento__c = f.id,Vigencia_Hasta__c = system.today().addDays(2),
                                                                                             Relacion_Producto_Plaza_Fraccionamiento__c = rpp.id);
        insert rpf1;
        Relacion_Producto_Fraccionamiento__c rpf3 = new Relacion_Producto_Fraccionamiento__c(name = 'test', Fraccionamiento__c = f.id,Vigencia_Hasta__c = system.today().addDays(2),
                                                                                             Relacion_Producto_Plaza_Fraccionamiento__c = rpp.id);
        insert rpf3;
        Relacion_Producto_Fraccionamiento__c rpf2 = new Relacion_Producto_Fraccionamiento__c(name = 'test', Fraccionamiento__c = f.id,Vigencia_Hasta__c = system.today().addDays(-1),
                                                                                             Relacion_Producto_Plaza_Fraccionamiento__c = rpp.id);
        insert rpf2;
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.Producto_Original__c = 'testP';
        prod1.Codigo_Producto_Original__c = 'testProd';
        prod1.RecordTypeId = rtd;
        Test.startTest();
        insert prod1;
        prod1.Precio_Venta__c = 10.0;
        PricebookEntry st = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = prod1.Id, UnitPrice = 100 ,IsActive = true );
        insert st;
        Pricebook2 pb1  = new Pricebook2();
        pb1.Name = 'Standard Price Book';
        pb1.Description = 'test';
        pb1.Periodo_Inicio__c='JUNIO 2023';
        pb1.Periodo_Fin__c='JUNIO 2023';
        pb1.Vigente_Desde__c = system.today() ;
        pb1.Vigente_Hasta__c= Date.newInstance(2023, 10, 30);
        pb1.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosBydevelopername().get('Producto_Generico').getRecordTypeId();
        insert pb1;
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pb1.Id, Product2Id = prod1.Id, UnitPrice = 100 ,IsActive = true ,UseStandardPrice = false);
        Boolean exceptionThrown2 = false;
        try {
            insert standardPrice;
        } 
        catch (Exception e) {
            exceptionThrown2 = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('anterior al día de hoy')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Boolean exceptionThrown1 = false;
        try {
            prod1.Tipo_de_Producto__c = 'Casa Muestra';
            prod1.Marca__c = 'Marca__c';
            update prod1;
        } 
        catch (Exception e) {
            exceptionThrown1 = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('La marca para este tipo de producto, debe ser ')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Boolean exceptionThrownP = false;
        try {
            prod1.Tipo_de_Producto__c = 'Paquete';
            update prod1;
        } 
        catch (Exception e) {
            exceptionThrownP = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('Es necesario un proveedor para actualizar ')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Test.stopTest();
    }
}