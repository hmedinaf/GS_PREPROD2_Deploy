@isTest
public class CLASS_getViviendas_Test {
    @isTest(seeAllData=true)
    public static  void Test1() {
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        insert prod1;
        
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='ACACIAS');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        priceBook2 pb = new PriceBook2(Name='VIV BOSQUE REAL TAMARINDO 2023-06-01 2023-06-30',Prototipo__c=proto.Id,Fraccionamiento__c=f.Id, IsActive=true, Description='LISTA BSQUE REAL', Solicitar_Aprobaci_n__c=false, Vigente_Desde__c=date.today(), Vigente_Hasta__c=date.today().addDays(25), Estatus__c='Aprobado', Periodo_Inicio__c='JUNIO 2023', Periodo_Fin__c='JUNIO 2023', Precio_Instalaciones__c=25000.00, Precio_esquina__c=0.00, Precio_frente_area_municipal__c=10000.00, Precio_frente_a_praque__c=10000.00, Precio_lado_sol__c=20000.00, Precio_lado_sombra__c=25000.00, Precio_sobre_avenida__c=25000.000, Porcentaje_Precio_instalaciones__c=0.00,
                                      Precio_superficie_excedente__c = null,Porcentaje_Precio_Superficie_Excedente__c = 50.00, Porcentaje_Precio_esquina__c=1.50, Prcentaje_Precio_frente_area_municipal__c=0.00, Precio_frente_a_parque__c=0.00, Procentaje_Precio_lado_sol__c=0.00, Porcentaje_Precio_lado_sombra__c=0.00, Porcentaje_Precio_sobre_avenida__c=0.00, Precio_Presupuesto__c=0.00, Ilimitado__c=false, Precio_Lista__c=1800000.00, Presupuesto__c=1800000.00, IVA__c=0.00, Beneficio__c=0.00, Tipo_de_Producto__c='Vivienda', Casa_Amueblada__c=false, Check_Precio_Unitario__c=false, Nombre_Lista_Validacion__c='VIV BOSQUE REAL TAMARINDO 2023-05-31 2023-06-30', Solicitd_de_Aprobacion__c=false, Lista_Duplicada__c=false);
        insert pb;
        Vivienda__c vv = new Vivienda__c(Casa_Amueblada__c = false, Casa_Muestra__c = false, Check_Fideicomiso__c = false, Check_Precio_Unitario__c = false, Direccion__c = 'CALLE 1 # 2', Esquina__c = false, Estatus_Vivienda__c = 'Disponible', Estatus__c = '17', Excendente_M2__c = 24, Fecha_Ultimo_Avaluo__c = date.today().addmonths(-5), Fecha_Vencimiento_Avaluo__c = date.today().addmonths(6), Fideicomiso__c = '0', Fraccionamiento__c = f.Id, Frente_Parque__c = true, Frente_rea__c = false, Id_Vivienda__c = '4010002', Inhabilitado_Venta__c = false, Lado_Sol__c = false, Lado_Sombra__c = true, Lote__c = '2',
                                         M2_Superficie__c = 122.50, Manzana__c = '289', name = 'BOSQUE REAL TAMARINDO 4010002', Num_Interno__c = 'BOSQUE REAL TAMARINDO 4010002', Piso__c = 0, Porcentaje_Obra_Fisico__c = 8, Precio_Total_Unitario__c = 1650000, Precio_Total__c = 1650000, PRECIO_UNITARIO__C = 1650000, Prototipo__c = proto.Id, Sector__c = 'FRENTE 01', Sobre_Avenida__c = false, Superficie_Excedente__c = 250.00, Tiene_DTI__c = false, Tiene_DTU__c = false, Unidad_Privativa__c = '', Uno_Sembrado_Import__c = 'C', Valor_Vivienda__c = 2500000);
        insert vv;
        Test.startTest();
        CLASS_getViviendas.getProductosVivienda(pb.Id);
        CLASS_getViviendas.getRelatedList(pb.Id);
        Test.stopTest();
    }
}