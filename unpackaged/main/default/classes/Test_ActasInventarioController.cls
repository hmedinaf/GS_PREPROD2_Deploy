@isTest 
public class Test_ActasInventarioController {
    @testSetup
    public static void setup(){
        Id idTipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Account acc = new Account(Apellidomaterno_cta__c = 'materno',FirstName = 'fName',LastName = 'lName',Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES', Nombre_cta__c = 'PRUEBA',
                                  TelefonoCelular__c = '+525656566567',phone = '+525656566567',Sub_canal_de_venta__c = 'COLABORADOR JAVER',Apellidopaterno_cta__c = 'PRUEBA',
                                  RecordTypeId = idTipoRegistroProspectoPersonaFisica);
        insert acc;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='BOSQUE REAL');
        insert f;
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Entregada__c = 'Por Entregar';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = acc.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        inventario.Fraccionamiento__c = f.Name;
        inventario.Prototipo__c = proto.Name;
        insert inventario;
    }
    static testMethod void validar(){
        Test.startTest();
        Account ac  = [Select Id, Name from Account where FirstName = 'fName'];
        Inventario__c inv = [SELECT Id, Prototipo__c ,Fraccionamiento__c FROM Inventario__c WHERE Name = 'AABBCCDDEE-Prueba'];
        List<User> usuar = [SELECT Id FROM User WHERE Name LIKE 'Admin J%' LIMIT 1];
        Visita__c vis = new Visita__c();
        vis.Fechaprogramadadevisita__c = System.today();
        vis.Horaprogramadadevisita__c = time.newInstance(15, 0, 0, 0);
        vis.Horafindevisita__c = time.newInstance(17, 0, 0, 0);        
        vis.OwnerID = usuar[0].Id;
        vis.Inventario__c = inv.Id;
        insert vis;
        Ecotecnologia__c EcoT = new Ecotecnologia__c();
        EcoT.Name =  inv.Prototipo__c + ' - ' + inv.Fraccionamiento__c;
        insert EcoT ; 
        PageReference page = Page.actas_Inventario;
        page.getParameters().put('id',inv.Id);
        Test.setCurrentPageReference(page);
        ActasInventarioController c = new ActasInventarioController();
        c.PDFActa();
        Test.stopTest();
    }
    static testMethod void Test_PATCListCtrl(){
        Test.startTest();
        PATCListCtrl.getInventarioList(20, 10);
        PATCListCtrl.getPrototiposList('');
        PATCListCtrl.getFraccionamientos();
        PATCListCtrl.getFilteredPATC(20, 10, '', '', Date.today(), Date.today());
        PATCListCtrl.testing();
        Test.stopTest();
    }
    public static testMethod void Test_ActasPDFCtrl(){
        Test.startTest();
        Ecotecnologia__c EcoT = new Ecotecnologia__c();
        EcoT.Name = 'default';
        insert EcoT ;
        PageReference page = Page.ActasPDFGenerator;
        page.getParameters().put('ActaName', 'test');
        Test.setCurrentPageReference(page);
        ActasPDFCtrl controller = new ActasPDFCtrl();
        Test.stopTest();
    }
    
    public static testMethod void Test_ActasPrototipoCtrl(){
        Test.startTest();  
        Inventario__c inv = [SELECT Id, Prototipo__c ,Fraccionamiento__c FROM Inventario__c WHERE Name = 'AABBCCDDEE-Prueba'];
        Ecotecnologia__c EcoT = new Ecotecnologia__c();
        EcoT.Name =  inv.Prototipo__c + ' - ' + inv.Fraccionamiento__c;
        insert EcoT ;
        ActasPrototipoCtrl.MobilCheck('');
        ActasPrototipoCtrl.getPrototiposList('');
        ActasPrototipoCtrl.getFraccionamientos();
        ActasPrototipoCtrl.getActas('', '');
        ActasPrototipoCtrl.newActa('AGUILA', 'BELCANTO', EcoT);
        ActasPrototipoCtrl.getActasPATC(inv.Id);
        ActasPrototipoCtrl.newActaPATC(inv.Id, EcoT);
        ActasPrototipoCtrl.testing();
        Test.stopTest();
    }
}