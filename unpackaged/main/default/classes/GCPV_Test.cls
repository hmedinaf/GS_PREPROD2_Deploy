@isTest(SeeAllData=true)
public class GCPV_Test {
    static void setup() {
        Id rtATC = [SELECT Id FROM RecordType WHERE Name LIKE 'Clientes ATC%' AND IsPersonType=True LIMIT 1].ID;
        
        Account cuenta = new Account();
        cuenta.isATC__c = true;
        cuenta.Numerodecliente__c = 'AA';
        cuenta.Nombre_cta__c = 'PRUEBA';
        cuenta.Apellidopaterno_cta__c = 'PRUEBA';
        cuenta.Apellidomaterno_cta__c = 'PRUEBA';
        cuenta.ProductoFinanciero__c = 'PRUEBA';
        cuenta.TipoCredito__c = 'BANJERCITO';
        cuenta.CorreoElectronico__c = 'prueba@prueba.com';
        cuenta.Notaria__c = 'PRUEBA';
        cuenta.Notario__c = 'PRUEBA';
        cuenta.ReferenciaBancariaCliente__c = 'PRUEBA';
        cuenta.FirstName = 'PRUEBA';
        /*cuenta.MiddleName = 'PRUEBA';*/
        cuenta.LastName = 'PRUEBA';
        //cuenta.Name = cuenta.Nombre_cta__c + ' ' + cuenta.Apellidopaterno_cta__c + ' ' + cuenta.Apellidomaterno_cta__c;
        cuenta.RecordTypeId = rtATC;
        cuenta.Phone = '+8888888888';
        insert cuenta;
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Entregada__c = 'Por Entregar';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = cuenta.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        insert inventario;
        
    }
    
    static testmethod void test() {        
        Test.startTest();
                        
        User adminJVR = [SELECT Id FROM User WHERE Name LIKE 'Admin J%' LIMIT 1];
        System.runAs(adminJVR) {
            Inventario__c inventario = [Select Id From Inventario__c Limit 1];
            
            Test.setMock(HttpCalloutMock.class, new GCPV_PagaresMock());
            GCPV_PagaresWS PWS = new GCPV_PagaresWS();
            GCPV_PagaresWS_Schedule EM = new GCPV_PagaresWS_Schedule();
            EM.execute(null);
           
            
            Test.stopTest();
            
             
            
            PageReference page = Page.CartaNoAdeudo;
            page.getParameters().put('id',inventario.Id);
            Test.setCurrentPageReference(page);
            CartaNoAdeudoController ctr = new CartaNoAdeudoController();
        }
    }
    
    static testmethod void testSR() {  
        GCPV_Recordatorios_Schedule RS = new GCPV_Recordatorios_Schedule();
        RS.execute(null);
    }
}