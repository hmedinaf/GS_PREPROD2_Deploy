@isTest
public class ActasPrototipoCtrl_Test {
    @testSetup static void setup() {
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
        Ecotecnologia__c EcoT = new Ecotecnologia__c();
        EcoT.Name =  proto.Name + ' - ' + f.Name;
        insert EcoT ;
    }
    static TestMethod void testMethod1() {
        Fraccionamiento__c f = [Select Id, Name from Fraccionamiento__c Where Name = 'BOSQUE REAL' LIMIT 1];
        Prototipo__c p = [Select Id, Name from Prototipo__c Where Name = 'TAMARINDO' LIMIT 1];
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        Ecotecnologia__c EcoT = new Ecotecnologia__c();
        EcoT.Name =  p.Name + ' - ' + f.Name;
        EcoT.AccesoriosBano__c = 10;
        EcoT.AsientoWC__c =20.0;
        EcoT.Bano__c = 30;
        EcoT.BoteBasura__c = 20;
        EcoT.CalentadorSolar__c = 10;
        EcoT.Cocina__c = 10;
        EcoT.Comedor__c = 20;
        EcoT.ContratacionServicios__c = true;
        EcoT.Exteriores__c = 'test';
        EcoT.ExterioresNum__c = 10;
        EcoT.FiltroAgua__c = 20;
        EcoT.FocoAhorrador__c =10;
        EcoT.FocoLED__c = 10;
        EcoT.Fraccionamiento__c = f.Id;
        EcoT.Interiores__c = 'teste';
        EcoT.InterioresNum__c = 10;
        EcoT.Jabonera__c = 10;
        EcoT.LlaveChorro__c = 10;
        EcoT.LlaveTarja__c = 20;
        EcoT.ManualUsuario__c = true;
        EcoT.Mejoras__c = 'test';
        EcoT.MejorasNum__c= 10;
        EcoT.NombreFraccionamiento__c = f.Name;
        EcoT.NombrePrototipo__c = p.Name;
        EcoT.Observaciones__c ='text';
        EcoT.OtrosDoc__c = 'test';
        EcoT.OtrosEco__c = 'doc';
        EcoT.OtrosEcoNum__c =10;
        EcoT.Paquetes__c=  'text';
        EcoT.PaquetesNum__c = 10;
        EcoT.Plano__c = true;
        EcoT.PortaRollos__c = 10;
        // EcoT.Proceso_ATC__c = 10;
        EcoT.Prototipo__c = p.Id;
        EcoT.RecamaraPosterior__c = 10;
        EcoT.RecamaraPrincipal__c = 10;
        EcoT.Reglamento__c = true;
        EcoT.Sala__c = 10;
        EcoT.ServiciosDigitales__c = true;
        EcoT.ServiciosPublicos__c= true;
        EcoT.TapaWC__c = 10;
        EcoT.Toallero__c = 10;
        insert EcoT ;
        Inventario__c inv = [SELECT Id, Prototipo__c ,Fraccionamiento__c FROM Inventario__c WHERE Name = 'AABBCCDDEE-Prueba'];
        Test.startTest();
        ActasPrototipoCtrl.MobilCheck(f.Name);
        ActasPrototipoCtrl.getPrototiposList(f.Name);
        ActasPrototipoCtrl.getFraccionamientos();
        ActasPrototipoCtrl.getActas(p.Name , f.Name);
        ActasPrototipoCtrl.newActa(p.Name, f.Name , EcoT);
        ActasPrototipoCtrl.getActasPATC(inv.Id);
        ActasPrototipoCtrl.newActaPATC(inv.Id, EcoT);
        ActasPrototipoCtrl.testing();
        Test.stopTest();
    }
    static TestMethod void testMethod2() {
        Fraccionamiento__c f = [Select Id, Name from Fraccionamiento__c Where Name = 'BOSQUE REAL' LIMIT 1];
        Prototipo__c p = [Select Id, Name from Prototipo__c Where Name = 'TAMARINDO' LIMIT 1];
        Inventario__c inv = [SELECT Id, Prototipo__c ,Fraccionamiento__c FROM Inventario__c WHERE Name = 'AABBCCDDEE-Prueba'];
        Test.startTest();
        Ecotecnologia__c EcoT = new Ecotecnologia__c();
        ActasPrototipoCtrl.newActa(p.Name, f.Name , EcoT);
        ActasPrototipoCtrl.newActaPATC(inv.Id, EcoT);
        Test.stopTest();
    }
}