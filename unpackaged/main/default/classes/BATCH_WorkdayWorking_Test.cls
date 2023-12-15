@isTest
public class BATCH_WorkdayWorking_Test {
    @testSetup
    public static void setup(){
        Account acc = new Account(FirstName= 'Lopez', LastName= 'test', CorreoElectronico__c = 'test@prospects.com', Apellidomaterno_cta__c = 'dahuoh', PersonBirthdate=date.today().addyears(-20),Phone = '+528119928819',Otro_Telefono__c = '+528119928819',TelefonoCelular__c='+525530303030',Canal_de_Venta__c = 'PROSPECTO ASESOR', Estatus_Lista_Negra_QEQ__c = 'VALIDADO');
        insert acc;
        opportunity opp = new opportunity(Name = 'Test1', StageName = 'Validación', CloseDate = Date.today().adddays(10));
        insert opp;
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
        Prototipo__c proto = new Prototipo__c(Id_Prototipo__c = '4567',Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
    }
    @isTest
    private static void BATCH_WorkdayWorking(){   
        Test.setMock(HttpCalloutMock.class, new MockHttpWorkday()); 
        Test.startTest();
        BATCH_WorkdayWorking BWW = new BATCH_WorkdayWorking();
        Id batchId3 = Database.executeBatch(BWW,10);
        Test.stopTest();
    }
    @isTest
    private static void BATCH_WorkdayWorking1(){   
        Test.setMock(HttpCalloutMock.class, new MockHttpWorkdayError()); 
        Test.startTest();
        BATCH_WorkdayWorking BWW = new BATCH_WorkdayWorking();
        Id batchId3 = Database.executeBatch(BWW,10);
        Test.stopTest();
    }
    @isTest
    private static void BATCH_WorkdayOficialFirmada(){   
        Test.setMock(HttpCalloutMock.class, new MockHttpWorkday()); 
        Test.startTest();
        BATCH_WorkdayOficialFirmada BWOF = new BATCH_WorkdayOficialFirmada();
        Id batchId3 = Database.executeBatch(BWOF,10);
        SCHEDULE_Workday BIR = new SCHEDULE_Workday();
        String sch = '0 30 * * * ?';
        System.schedule('BATCH_WorkdayOficialFirmada', sch, BIR);
        Test.stopTest();
    }
    @isTest
    private static void BATCH_WorkdayOficialFirmada1(){   
        Test.setMock(HttpCalloutMock.class, new MockHttpWorkdayError()); 
        Test.startTest();
        BATCH_WorkdayOficialFirmada BWOF = new BATCH_WorkdayOficialFirmada();
        Id batchId3 = Database.executeBatch(BWOF,10);
        Test.stopTest();
    }
}