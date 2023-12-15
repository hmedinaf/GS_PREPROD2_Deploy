@isTest
public class Aprobaciones_Controller_Test {
    static TestMethod void testMethod1() {
         Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='BOSQUE REAL');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Inventario__c invt = new Inventario__c(Name = 'test', Proto__c = proto.id);
        insert invt;
        Id devRecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByName().get('Vivienda').getRecordTypeId(); 
        priceBook2 pb = new PriceBook2(Name='VIV BOSQUE REAL TAMARINDO 2023-06-01 2023-06-30', IsActive=true, Description='LISTA BSQUE REAL', Solicitar_Aprobaci_n__c=false, Prototipo__c=proto.Id, Vigente_Desde__c=date.today(), Vigente_Hasta__c=date.today().addDays(23), Fraccionamiento__c=f.Id, Estatus__c='Aprobado',
                                       Periodo_Inicio__c='JUNIO 2023', Periodo_Fin__c='JUNIO 2023', Precio_Instalaciones__c=25000.00, Precio_esquina__c=0.00, Precio_frente_area_municipal__c=10000.00, Precio_frente_a_praque__c=10000.00, Precio_lado_sol__c=20000.00, Precio_lado_sombra__c=25000.00, Precio_sobre_avenida__c=25000.00, Precio_superficie_excedente__c=2500.00, Porcentaje_Precio_instalaciones__c=0.00,
                                       Porcentaje_Precio_esquina__c=1.50, Prcentaje_Precio_frente_area_municipal__c=0.00, Precio_frente_a_parque__c=0.00, Procentaje_Precio_lado_sol__c=0.00, Porcentaje_Precio_lado_sombra__c=0.00, Porcentaje_Precio_sobre_avenida__c=0.00, Precio_Presupuesto__c=0.00, Ilimitado__c=false, Precio_Lista__c=1800000.00, Presupuesto__c=1800000.00, IVA__c=0.00, Beneficio__c=0.00, Tipo_de_Producto__c='Vivienda', Casa_Amueblada__c=false, Check_Precio_Unitario__c=false, Porcentaje_Precio_Superficie_Excedente__c=0.00, Nombre_Lista_Validacion__c='VIV BOSQUE REAL TAMARINDO 2023-05-31 2023-06-30', Solicitd_de_Aprobacion__c=false, Lista_Duplicada__c=false, RecordTypeId=devRecordTypeId);
        insert pb;
        Test.startTest();
        Aprobaciones_Controller.getPricebooks();
        Test.stopTest();
    }
}