@isTest
public class SemaforoInventario_Test {
    @testSetup static void methodName() {
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
        inventario.Fracc__c = f.Id;
        inventario.Entregada__c = 'Por Entregar';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = acc.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        insert inventario;
    }
    @isTest
    static void test1(){
        Fraccionamiento__c f = [select id from Fraccionamiento__c where Name = 'ACACIAS'];
        Account acc = [select id from Account where FirstName= 'Lopez'];
        Inventario__c inventario = [select id from Inventario__c where Name = 'AABBCCDDEE-Prueba'];
        Casos_Residente__c caso = new Casos_Residente__c();
        caso.Clasificacion__c = 'A1. Corto circuito';
        caso.Tipo__c = 'A. Instalación eléctrica';
        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventario.Id;
        entrega.FechaEntrega__c = Date.today();
        insert entrega;
        caso.ViviendaProceso__c = entrega.Inventario__c;
        insert caso;
        Vencimiento__c v = new Vencimiento__c();
        v.VencimientoDias__c = 20;
        v.Consola__c = 'Puertas';
        insert v;
        Test.startTest();
        PageReference page = Page.SemaforoInventario;
        Test.setCurrentPageReference(page);
        ApexPages.StandardController controller = new ApexPages.StandardController(inventario);
        SemaforoInventario co = new SemaforoInventario(controller);
        
        Test.stopTest();
    }
    @isTest
    static void test2(){
        Fraccionamiento__c f = [select id from Fraccionamiento__c where Name = 'ACACIAS'];
        Account acc = [select id from Account where FirstName= 'Lopez'];
        Inventario__c inventario = [select id from Inventario__c where Name = 'AABBCCDDEE-Prueba'];
        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventario.Id;
        entrega.FechaEntrega__c = null;
        insert entrega;
                 
        Test.startTest();
        PageReference page = Page.SemaforoInventario;
        Test.setCurrentPageReference(page);
        ApexPages.StandardController controller = new ApexPages.StandardController(inventario);
        try {
            SemaforoInventario co = new SemaforoInventario(controller);  
        }catch(DmlException d){
            Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, d.getMessage())) ;
        }
        Test.stopTest();
    }
    @isTest
    static void test3(){
        Fraccionamiento__c f = [select id from Fraccionamiento__c where Name = 'ACACIAS'];
        Account acc = [select id from Account where FirstName= 'Lopez'];
        Inventario__c inventario = [select id from Inventario__c where Name = 'AABBCCDDEE-Prueba'];        
        Entrega__c entrega = new Entrega__c();
        insert entrega;         
        Test.startTest();
        PageReference page = Page.SemaforoInventario;
        Test.setCurrentPageReference(page);
        ApexPages.StandardController controller = new ApexPages.StandardController(inventario);
        try {
            SemaforoInventario co = new SemaforoInventario(controller);  
        }catch(DmlException d){
            Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, d.getMessage())) ;
        }
        Test.stopTest();
    }
}