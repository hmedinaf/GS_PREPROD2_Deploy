@isTest
public class CreateNewProcesoVentaController_Test {
    static TestMethod void Test1() {
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='BOSQUE REAL');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Account acc = new Account();
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c = f.id;
        acc.Prototipo_lookup__c = proto.Id;
        insert acc; 
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            CreateNewProcesoVentaController.crearNuevoProcVenta(acc.Id);
        } 
        catch (Exception e) {
            exceptionThrown = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('No se permite crear Proceso de Venta sin')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Test.stopTest();
    }
    static TestMethod void Test2() {
        Account acc = new Account();
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc; 
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            CreateNewProcesoVentaController.crearNuevoProcVenta(acc.Id);
        } 
        catch (Exception e) {
            exceptionThrown = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('No se permite crear Proceso de Venta sin')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Test.stopTest();
    }
    static TestMethod void Test3() {
        CreateNewProcesoVentaController.crearNuevoProcVenta(null);
    }
}