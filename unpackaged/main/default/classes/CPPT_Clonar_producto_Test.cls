@isTest
public class CPPT_Clonar_producto_Test {
    @isTest
    public static void Test1() {
        Product2 prod = new Product2(Precio_Venta__c = 10.0, name = 'test11', IsActive = true, Numero_Filtro__c = 2, Description = 'test', Producto_Original__c = 'testP', Codigo_Producto_Original__c = 'testProd');
        insert prod;
        Proveedor__c p = new Proveedor__c(name = 'new prov',Rfc__c = 'rfc', Contacto__c = 'contact', Correo__c = 'abc@abc.com', Nombre_Comercial__c = 'nom');
        insert p;
        Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c(Producto__c = prod.id,Proveedor__c = p.id);
        insert prov;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='BOSQUE REAL');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Relacion_Producto_Plaza__c rpp = new Relacion_Producto_Plaza__c(name = 'test',Producto__c = prod.id,Plaza__c = plaza.id);
        insert rpp;
        Relacion_Producto_Fraccionamiento__c rpf = new Relacion_Producto_Fraccionamiento__c(name = 'test',Producto__c = prod.id, Fraccionamiento__c = f.id,Vigencia_Hasta__c = system.today().addDays(-1),
                                                                                            Relacion_Producto_Plaza_Fraccionamiento__c = rpp.id);
        insert rpf;
        Test.setCurrentPage(Page.CPPT_Clonar_producto);
        ApexPages.StandardController pbController = new ApexPages.StandardController(prod);
        CPPT_Clonar_producto producto = new CPPT_Clonar_producto(pbController);
        Test.startTest();
        producto.idProd = prod.Id;
        CPPT_Clonar_producto.creaProducto(prod.Id);
        Test.stopTest();
    }
}