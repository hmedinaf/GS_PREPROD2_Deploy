@isTest(seeAllData = true)
public class Test_ConsolaVF {
    static testMethod void runSemaforo(){
        Test.startTest();
        Id usuar = [SELECT Id FROM User WHERE Name LIKE 'Admin%' LIMIT 1].ID;
        Id rtATC = [SELECT Id FROM RecordType WHERE Name LIKE 'PROSPECTO PERSONA MORAL%' LIMIT 1].ID;
        Id rtG = [SELECT Id FROM RecordType WHERE Name LIKE 'Garantías%' LIMIT 1].ID;
        
        Account cuenta = new Account();
        cuenta.isATC__c = true;
        cuenta.Numerodecliente__c = 'AA';
        cuenta.Nombre_cta__c = 'PRUEBA';
        cuenta.Apellidopaterno_cta__c = 'PRUEBA';
        cuenta.Apellidomaterno_cta__c = 'PRUEBA';
        cuenta.ProductoFinanciero__c = 'PRUEBA';
        cuenta.TipoCredito__c = 'BANJERCITO';
        cuenta.CorreoElectronico__c = 'prueba@prueba.com';
        cuenta.Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES';
        cuenta.Sub_canal_de_venta__c = 'COLABORADOR JAVER';
        cuenta.Notaria__c = 'PRUEBA';
        cuenta.Notario__c = 'PRUEBA';
        cuenta.ReferenciaBancariaCliente__c = 'PRUEBA';
        cuenta.Name = cuenta.Nombre_cta__c + ' ' + cuenta.Apellidopaterno_cta__c + ' ' + cuenta.Apellidomaterno_cta__c;
        cuenta.RecordTypeId = rtATC;
        cuenta.TelefonoCelular__c = '+525656566567';
        cuenta.phone = '+525656566567';
        
        insert cuenta;
        
        System.assertNotEquals(null, cuenta.Id);
        
        Fraccionamiento__c fra = new Fraccionamiento__c();
        fra.Name = 'TEST';
        fra.Residente1__c = usuar;
        fra.Coordenadas__c ='25, -100';
        insert fra;
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Fracc__c = fra.Id;
        inventario.Entregada__c = 'Entregado';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = cuenta.Id;
        insert inventario;
        
        
        
        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventario.id;
        entrega.FechaEntrega__c = System.today();
        entrega.Cuenta__c = cuenta.Id;
        insert entrega;
        
        PageReference pager = Page.SemaforoInventario;
        
        Test.setCurrentPageReference(pager);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(inventario);
        SemaforoInventario vs = new SemaforoInventario(sc);
        
        delete entrega;
        
        vs = new SemaforoInventario(sc);
        
        PageReference page1 = Page.ImagenViviendaPage;
        
        Test.setCurrentPageReference(page1);
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController(inventario);
        ImagenVivienda vs1 = new ImagenVivienda(sc1);
        
        Test.stopTest();
    }
}