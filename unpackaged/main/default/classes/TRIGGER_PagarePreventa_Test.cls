@isTest
public class TRIGGER_PagarePreventa_Test {
    static TestMethod void testMethod1() {
        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 10;
        pdv.Frecuencia__c = 'Quincenal';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Estatus_Plan_de_venta__c = 'En Progreso';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        insert pdv;
        Pagare_Preventa__c pagares = new Pagare_Preventa__c();
        pagares.Plan_de_Venta__c = pdv.id;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pagares.Creado_Manualmente__c = true;
        pagares.Importe__c = 10.0;
        pagares.Eliminado_Manualmente__c = false;
        insert pagares; 
        pagares.Modificado_Manualmente_Importe__c =  true;
        pagares.Modificado_Manualmente_Fecha_Vencimiento__c = true;
        pagares.Importe__c = 15.0;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(10);
        update pagares;
        
    }
    static TestMethod void testMethod2() {
        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 10;
        pdv.Frecuencia__c = 'Quincenal';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Estatus_Plan_de_venta__c = 'En Progreso';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        pdv.Subsidio__c  = 10;
        pdv.Anticipo__c = 20;
        insert pdv;
        Pagare_Preventa__c p1 = new Pagare_Preventa__c();
        p1.Plan_de_Venta__c = pdv.id;
        p1.Fecha_de_Vencimiento__c = system.today().addDays(1);
        p1.Eliminado_Manualmente__c = true;
        p1.Modificado_Manualmente_Importe__c = true;
        p1.Importe__c = 10.0;
        insert p1;
        Pagare_Preventa__c pagares = new Pagare_Preventa__c();
        pagares.Plan_de_Venta__c = pdv.id;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pagares.Eliminado_Manualmente__c = true;
        pagares.Importe__c = 1.0;
        insert pagares;  
        Test.startTest();
        Delete pagares;
        Test.stopTest();
    }
    static TestMethod void testMethod3() {
        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 10;
        pdv.Frecuencia__c = 'Quincenal';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Estatus_Plan_de_venta__c = 'En Progreso';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        insert pdv;
        Pagare_Preventa__c pagares = new Pagare_Preventa__c();
        pagares.Plan_de_Venta__c = pdv.id;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pagares.Creado_Manualmente__c = false;
        pagares.Eliminado_Manualmente__c = true;
        insert pagares;   
    }
    static TestMethod void testMethod4() {
        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 10;
        pdv.Frecuencia__c = 'Semanal';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Estatus_Plan_de_venta__c = 'En Progreso';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        insert pdv;
        Pagare_Preventa__c pagares = new Pagare_Preventa__c();
        pagares.Plan_de_Venta__c = pdv.id;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pagares.Creado_Manualmente__c = true;
        pagares.Importe__c = 10.0;
        pagares.Eliminado_Manualmente__c = false;
        insert pagares; 
        pagares.Modificado_Manualmente_Importe__c =  true;
        pagares.Modificado_Manualmente_Fecha_Vencimiento__c = true;
        pagares.Importe__c = 15.0;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(10);
        Test.startTest();
        update pagares;
        test.stopTest();
    }
}