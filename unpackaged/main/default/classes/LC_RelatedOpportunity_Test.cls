@isTest
public class LC_RelatedOpportunity_Test {
@isTest(seeAllData=true)
    static void testMeth() {
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.today().addyears(-20);
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+525530303030'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
        insert acc;
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        Test.startTest();
        LC_RelatedOpportunity.getOpportunities(acc.Id);
        Test.stopTest();
    }
    @isTest
    static void testMeth1() {
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.today().addyears(-20);
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+525530303030'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
        insert acc;
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        List<Contract> contracts = new List<Contract>();
        for (Integer i = 0; i < 5; i++) {
        contracts.add(new Contract(Name = 'Test Contract ' + i, AccountId = acc.Id, Oportunidad__c = opp.id));
        }
        insert contracts;
        List<Direcciones__c> addresses = new List<Direcciones__c>();
        for (Contract contract : contracts) {
            addresses.add(new Direcciones__c(Contrato__c = contract.Id, Tipo__c = 'Dirección Laboral'));
        }
        insert addresses;
        Perfil_Tercero_Moral__c perTer = new Perfil_Tercero_Moral__c();
        perTer.Dictaminacion__c = contracts[0].id;
        perTer.Porcentaje_Accionistas_1__c = 12;
        perTer.Miembros_del_Consejo_1__c = 'Test';
        insert perTer;
        Perfil_Tercero_Fisico__c perTerFis = new Perfil_Tercero_Fisico__c();
        perTerFis.Dictaminacion__c = contracts[0].id;
        insert perTerFis;
        Cesion_a_Otra_Persona_Fisica_o_Moral__c ces = new Cesion_a_Otra_Persona_Fisica_o_Moral__c();
        ces.Contrato__c = contracts[0].id;
        insert ces;
        Co_Acreditado__c acr = new Co_Acreditado__c();
        acr.Contrato__c = contracts[0].id;
        acr.Apellido_Paterno_CO_Acreditado__c = 'test';
        acr.Apellido_Materno_CO_Acreditado__c = 'test';
        acr.Sexo__c = 'MASCULINO';
        insert acr;
        Referencia_familiar__c reference = new Referencia_familiar__c();
        reference.Contrato__c = contracts[0].Id;
        reference.Apellido_Paterno__c = 'test';
        reference.Apellido_Materno__c = 'Test';
        reference.Telefono_1__c = '+525530303030';
        reference.Telefono_2__c = '+528119928819'; 
        insert reference;
        Test.startTest();
        OpportunityTriggerHandler oppT = new OpportunityTriggerHandler();
        oppT.validateContracts(new List<Opportunity>{opp});        
        Test.stopTest();
    }
     @isTest(seeAllData=true)
    static void testMeth2() {
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.today().addyears(-20);
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+525530303030'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
        insert acc;
        opportunity opp = new opportunity();
        opp.Name = 'Test1';
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        Compania__c  comp = new Compania__c(Name = 'CASAS JAVER, S.A. DE C.V.'); 
        insert comp;
        Ubicacion__c u = new Ubicacion__c(Compania__c=comp.Id, Estado__c='Nuevo León',Telefono__c='2224456677', Direccion_Fisica__c='Pabellon M, Humberto Jiménez López 190, Centro, 64000 Monterrey, N.L., México', Direccion_Fiscal__c='Pabellon M, Humberto Jiménez López 190, Centro, 64000 Monterrey, N.L., México', Referencia_FEMSA__c='Ejemplo Referencia FEM', Representante_Legal__c='Ejemplo Representante Legal Completo', RFC__c='Ejemplo RFC', Representante_Legal_Nombre__c='Ejemplo Representante Legal Nombre', Representante_Legal_Apellido_Paterno__c='Ejemplo Representante Legal Apellido Paterno', Representante_Legal_Apellido_Materno__c='Ejemplo Representante Legal Apellido Materno',
                                          Referencia_Santander__c='Ejemplo Referencia San', Referencia_HSBC__c='Ejemplo Referencia HSB', SPEI_Santander__c='Ejemplo SPEI Santander', SPEI_HSBC__c='Ejemplo SPEI HSBC', Municipio__c='Monterrey', Convenio_Empresa__c='Ejemplo Convenio / Emp', Clave_RAP_HSBC__c='Ejemplo Clave RAP HSBC', Banco_Intermediario__c='Ejemplo Banco Intermed', Cuenta_Extranjera__c='Ejemplo Cuenta Extranj', Telefono_Cobranza__c='(81) 11-33-66-99', Email_Cobranza__c='cobranza@javer.com.mx', CLABE_Santander__c='CLABESANTANDER', CLABE_HSBC__c='CLABEHSBC');
        insert u;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Ubicacion_Compania__c= u.id, Name='ACACIAS');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Id devRecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByName().get('Vivienda').getRecordTypeId(); 
        priceBook2 pb = new PriceBook2(Name='VIV BOSQUE REAL TAMARINDO 2023-06-01 2023-06-30', IsActive=true, Description='LISTA BSQUE REAL', Solicitar_Aprobaci_n__c=false, Prototipo__c=proto.Id, Vigente_Desde__c=date.today(), Vigente_Hasta__c=date.today().addDays(25), Fraccionamiento__c=f.Id, Estatus__c='Aprobado', Periodo_Inicio__c='JUNIO 2023', Periodo_Fin__c='JUNIO 2023', Precio_Instalaciones__c=25000.00, Precio_esquina__c=0.00, Precio_frente_area_municipal__c=10000.00, Precio_frente_a_praque__c=10000.00, Precio_lado_sol__c=20000.00, Precio_lado_sombra__c=25000.00, Precio_sobre_avenida__c=25000.00, Precio_superficie_excedente__c=2500.00, Porcentaje_Precio_instalaciones__c=0.00,
                                       Porcentaje_Precio_esquina__c=1.50, Prcentaje_Precio_frente_area_municipal__c=0.00, Precio_frente_a_parque__c=0.00, Procentaje_Precio_lado_sol__c=0.00, Porcentaje_Precio_lado_sombra__c=0.00, Porcentaje_Precio_sobre_avenida__c=0.00, Precio_Presupuesto__c=0.00, Ilimitado__c=false, Precio_Lista__c=1800000.00, Presupuesto__c=1800000.00, IVA__c=0.00, Beneficio__c=0.00, Tipo_de_Producto__c='Vivienda', Casa_Amueblada__c=false, Check_Precio_Unitario__c=false, Porcentaje_Precio_Superficie_Excedente__c=0.00, Nombre_Lista_Validacion__c='VIV BOSQUE REAL TAMARINDO 2023-05-31 2023-06-30', Solicitd_de_Aprobacion__c=false, Lista_Duplicada__c=false, RecordTypeId=devRecordTypeId);
        insert pb;
    }
}