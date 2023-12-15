@isTest
public class CalendarioPorFraccionamiento_Test {
    @testSetup static void setup() {
        Account acc = new Account();
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c = f.id;
        insert acc; 
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Entregada__c = 'Por Entregar';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = acc.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        insert inventario;
    }
    static TestMethod void Test1() {
         List<Profile> perfiles = [SELECT Id FROM Profile WHERE Name = 'Call Center' OR Name Like 'Administrador%'];
        Fraccionamiento__c f = [Select Id, Name from Fraccionamiento__c Where Name = 'ACACIAS' LIMIT 1];
        Inventario__c inventario = [SELECT Id FROM Inventario__c WHERE Name = 'AABBCCDDEE-Prueba'];
        inventario.Fracc__c = f.Id;
        update inventario;
          Event ev = new Event(EndDateTime =system.today().addDays(+5) , StartDateTime =system.today().addDays(+3),Subject = 'test');
        insert ev;
        Date testDate = Date.newInstance(2023, 6, 8);
        Time testTime = Time.newInstance(15, 30, 0, 0);
        Test.startTest();
        PageReference page = Page.CalendarioFraccionamiento;
        page.getParameters().put('eid', inventario.Id);
        Test.setCurrentPageReference(page);
        ApexPages.StandardController controller = new ApexPages.StandardController(inventario);
        CalendarioPorFraccionamiento cp = new CalendarioPorFraccionamiento(controller);
        cp.getCompleteDate(testDate, testTime);
        cp.idg = inventario.Id;
        cp.fraccElegido = f.Id;
        Test.stopTest();
    }
    static TestMethod void Test2() {
         List<Profile> perfiles= [SELECT Id FROM Profile WHERE Name = 'Call Center' OR Name Like 'Administrador%'];
        Fraccionamiento__c f = [Select Id, Name from Fraccionamiento__c Where Name = 'ACACIAS' LIMIT 1];
        Inventario__c inventario = [SELECT Id FROM Inventario__c WHERE Name = 'AABBCCDDEE-Prueba'];
        inventario.Fracc__c = f.Id;
        update inventario;
        Date testDate = Date.newInstance(2023, 6, 8);
        Time testTime = Time.newInstance(15, 30, 0, 0);
        Test.startTest();
        PageReference page = Page.CalendarioPorFraccionamiento;
        page.getParameters().put('eid', inventario.Id);
        Test.setCurrentPageReference(page);
        CalendarioPorFraccionamiento cp = new CalendarioPorFraccionamiento();
        cp.getCompleteDate(testDate, testTime);
        cp.idg = inventario.Id;
        cp.fraccElegido = f.Id;
        Test.stopTest();
    }
     static TestMethod void Test3() {
        Fraccionamiento__c f = [Select Id, Name from Fraccionamiento__c Where Name = 'ACACIAS' LIMIT 1];
        Inventario__c inventario = [SELECT Id FROM Inventario__c WHERE Name = 'AABBCCDDEE-Prueba'];
        inventario.Fracc__c = f.Id;
        update inventario;
        Test.startTest();
        PageReference page = Page.CalendarioPorFraccionamiento;
        Test.setCurrentPageReference(page);
        CalendarioPorFraccionamiento cp = new CalendarioPorFraccionamiento();
        Test.stopTest();
    }
  
}