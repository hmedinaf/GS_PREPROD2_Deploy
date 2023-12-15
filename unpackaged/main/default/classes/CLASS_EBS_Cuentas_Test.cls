@isTest
public class CLASS_EBS_Cuentas_Test {
    @isTest(seeAlldata=true)
    public static void Test1() {
        Compania__c  comp = new Compania__c(Name = 'CASAS JAVER, S.A. DE C.V.'); 
        insert comp;
        Ubicacion__c u = new Ubicacion__c(Compania__c=comp.Id, Estado__c='Nuevo León',Telefono__c='2224456677', Direccion_Fisica__c='Pabellon M, Humberto Jiménez López 190, Centro, 64000 Monterrey, N.L., México', Direccion_Fiscal__c='Pabellon M, Humberto Jiménez López 190, Centro, 64000 Monterrey, N.L., México', Referencia_FEMSA__c='Ejemplo Referencia FEM', Representante_Legal__c='Ejemplo Representante Legal Completo', RFC__c='Ejemplo RFC', Representante_Legal_Nombre__c='Ejemplo Representante Legal Nombre', Representante_Legal_Apellido_Paterno__c='Ejemplo Representante Legal Apellido Paterno', Representante_Legal_Apellido_Materno__c='Ejemplo Representante Legal Apellido Materno',
                                          Referencia_Santander__c='Ejemplo Referencia San', Referencia_HSBC__c='Ejemplo Referencia HSB', SPEI_Santander__c='Ejemplo SPEI Santander', SPEI_HSBC__c='Ejemplo SPEI HSBC', Municipio__c='Monterrey', Convenio_Empresa__c='Ejemplo Convenio / Emp', Clave_RAP_HSBC__c='Ejemplo Clave RAP HSBC', Banco_Intermediario__c='Ejemplo Banco Intermed', Cuenta_Extranjera__c='Ejemplo Cuenta Extranj', Telefono_Cobranza__c='(81) 11-33-66-99', Email_Cobranza__c='cobranza@javer.com.mx', CLABE_Santander__c='CLABESANTANDER', CLABE_HSBC__c='CLABEHSBC');
        insert u;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Ubicacion_Compania__c= u.id, Name='BOSQUE REAL');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Account acc = new Account(FirstName= 'Lopez', LastName= 'test', CorreoElectronico__c = 'test@prospects.com', Apellidomaterno_cta__c = 'dahuoh', PersonBirthdate=date.today().addyears(-20),Phone = '+528119928819',Otro_Telefono__c = '+528119928819',TelefonoCelular__c='+525530303030',Canal_de_Venta__c = 'PROSPECTO ASESOR', Estatus_Lista_Negra_QEQ__c = 'VALIDADO');
        Account acc1 = acc.clone(false, true, false, false);
        acc1.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc1.Canal_de_Venta__c = 'MEDIOS DIGITALES';
        acc1.Sub_canal_de_venta__c = '';
        acc1.Check_Apellido__c = true;
        acc1.Sexo__c = 'MASCULINO';
        acc1.Nacionalidad__c = 'MEXICANA';
        acc1.Lugar_Nacimiento__c = 'AGUASCALIENTES';
        acc1.CorreoElectronico__c = 'test@portal123453.com';
        acc1.Fecha_de_Afluencia__c = date.today().addDays(-1);
        acc1.BillingPostalCode = '123456';
        acc1.Fraccionamiento_cta__c = f.id;
        acc1.Prototipo_lookup__c = proto.id;
        acc1.Aprobo_Check_Apellido__c = false;
        acc1.Apellidomaterno_cta__c = 'dahuoh';
        insert acc1;
        Inventario__c inventario = new Inventario__c(Condominio__c = 'Condominio', Entregada__c = 'Entregado', Cuenta__c = acc1.Id, Revisiones_en_Vivienda__c = '3');
        insert inventario;
        acc1.Apellidomaterno_cta__c = 'test';
        acc1.Aprobo_Check_Apellido__c  = false;
        acc1.Vivienda_Mas_Reciente__c = inventario.Id;
        
        update acc1;
        opportunity opp = new opportunity(Name = 'Test', StageName = 'Validación', CloseDate = Date.today().adddays(10));
        insert opp;
        
        
        Id devRecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByName().get('Vivienda').getRecordTypeId(); 
        priceBook2 pb = new PriceBook2(Name='VIV BOSQUE REAL TAMARINDO 2023-06-01 2023-06-30', IsActive=true, Description='LISTA BSQUE REAL', Solicitar_Aprobaci_n__c=false, Prototipo__c=proto.Id, Vigente_Desde__c=date.today(), Vigente_Hasta__c=date.today().addDays(25), Fraccionamiento__c=f.Id, Estatus__c='Aprobado', Periodo_Inicio__c='JUNIO 2023', Periodo_Fin__c='JUNIO 2023', Precio_Instalaciones__c=25000.00, Precio_esquina__c=0.00, Precio_frente_area_municipal__c=10000.00, Precio_frente_a_praque__c=10000.00, Precio_lado_sol__c=20000.00, Precio_lado_sombra__c=25000.00, Precio_sobre_avenida__c=25000.00, Precio_superficie_excedente__c=2500.00, Porcentaje_Precio_instalaciones__c=0.00,
                                       Porcentaje_Precio_esquina__c=1.50, Prcentaje_Precio_frente_area_municipal__c=0.00, Precio_frente_a_parque__c=0.00, Procentaje_Precio_lado_sol__c=0.00, Porcentaje_Precio_lado_sombra__c=0.00, Porcentaje_Precio_sobre_avenida__c=0.00, Precio_Presupuesto__c=0.00, Ilimitado__c=false, Precio_Lista__c=1800000.00, Presupuesto__c=1800000.00, IVA__c=0.00, Beneficio__c=0.00, Tipo_de_Producto__c='Vivienda', Casa_Amueblada__c=false, Check_Precio_Unitario__c=false, Porcentaje_Precio_Superficie_Excedente__c=0.00, Nombre_Lista_Validacion__c='VIV BOSQUE REAL TAMARINDO 2023-05-31 2023-06-30', Solicitd_de_Aprobacion__c=false, Lista_Duplicada__c=false, RecordTypeId=devRecordTypeId);
        insert pb;
        Id pricebookId = Test.getStandardPricebookId();
        
        Vivienda__c vv = new Vivienda__c(Casa_Amueblada__c = false, Casa_Muestra__c = false, Check_Fideicomiso__c = false, Check_Precio_Unitario__c = false, Direccion__c = 'CALLE 1 # 2', Esquina__c = false, Estatus_Vivienda__c = 'Disponible', Estatus__c = '17', Excendente_M2__c = 24, Fecha_Ultimo_Avaluo__c = date.today().addmonths(-5), Fecha_Vencimiento_Avaluo__c = date.today().addmonths(6), Fideicomiso__c = '0', Fraccionamiento__c = f.Id, Frente_Parque__c = true, Frente_rea__c = false, Id_Vivienda__c = '4010002', Inhabilitado_Venta__c = false, Lado_Sol__c = false, Lado_Sombra__c = true, Lote__c = '2',
                                         M2_Superficie__c = 122.50, Manzana__c = '289', name = 'BOSQUE REAL TAMARINDO 4010002', Num_Interno__c = 'BOSQUE REAL TAMARINDO 4010002', Piso__c = 0, Porcentaje_Obra_Fisico__c = 8, Precio_Total_Unitario__c = 1650000, Precio_Total__c = 1650000, PRECIO_UNITARIO__C = 1650000, Prototipo__c = proto.Id, Sector__c = 'FRENTE 01', Sobre_Avenida__c = false, Superficie_Excedente__c = 250.00, Tiene_DTI__c = false, Tiene_DTU__c = false, Unidad_Privativa__c = '', Uno_Sembrado_Import__c = 'C', Valor_Vivienda__c = 2500000);
        insert vv;
        opp.AccountId = acc1.Id; 
        opp.Vivienda__c = vv.id;
        update opp;
        List<Contract> contracts = new List<Contract>();
        for (Integer i = 0; i < 1; i++) {
            contracts.add(new Contract(Name = 'Test Contract ' + i, AccountId = acc1.Id, Oportunidad__c = opp.id));
        }
        insert contracts;
        Referencia_familiar__c reference = new Referencia_familiar__c();
        reference.Nombre__c = 'test';
        reference.Contrato__c = contracts[0].Id;
        reference.Apellido_Paterno__c = 'test';
        reference.Apellido_Materno__c = 'Test';
        reference.Telefono_1__c = '+525530303030';
        reference.Telefono_2__c = '+528119928819'; 
        Insert reference;
        Referencia_familiar__c reference1 = new Referencia_familiar__c();
        reference1.Nombre__c = 'test1';
        reference1.Contrato__c = contracts[0].Id;
        reference1.Apellido_Paterno__c = 'test1';
        reference1.Apellido_Materno__c = 'Test1';
        reference1.Telefono_1__c = '+525530303030';
        reference1.Telefono_2__c = '+528119928819'; 
        Insert reference1;
        Referencia_familiar__c reference2 = new Referencia_familiar__c();
        reference2.Nombre__c = 'test2';
        reference2.Contrato__c = contracts[0].Id;
        reference2.Apellido_Paterno__c = 'test2';
        reference2.Apellido_Materno__c = 'Test2';
        reference2.Telefono_1__c = '+525530303030';
        reference2.Telefono_2__c = '+528119928819'; 
        Insert reference2;
        List<Direcciones__c> addresses = new List<Direcciones__c>();
        for (Contract contract : contracts) {
            addresses.add(new Direcciones__c(Contrato__c = contract.Id, Tipo__c = 'Dirección Principal'));
        }
        insert addresses;
        List<CLASS_EBS_Cuentas.Input> inpLt = new List<CLASS_EBS_Cuentas.Input>();
        CLASS_EBS_Cuentas.Input inp = new CLASS_EBS_Cuentas.Input();
        inp.requisicion = 1;
        inp.identificadores = new List<String>{'Lopez test',opp.Id};
            inpLt.add(inp); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpEBS_Cuentas());
        CLASS_EBS_Cuentas.getAccountNames(inpLt);   
        Test.stopTest();
    }
}