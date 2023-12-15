@isTest
public class Test_NewCall {
    static testMethod void validar(){
        Test.startTest();
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.FechaEntregaEsperada__c = System.today();
        inventario.FechaEntrega__c=system.today()-1;
        insert inventario;
        
        Id usuar = [SELECT Id FROM User WHERE Name LIKE 'Admin%' LIMIT 1].ID;
        Id rtATC = [SELECT Id FROM RecordType WHERE Name LIKE 'Clientes ATC%' LIMIT 1].ID;
        
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
        cuenta.Name = cuenta.Nombre_cta__c + ' ' + cuenta.Apellidopaterno_cta__c + ' ' + cuenta.Apellidomaterno_cta__c;
        cuenta.RecordTypeId = rtATC;
        cuenta.Phone = '88888888';
        insert cuenta;
        inventario.cuenta__c=cuenta.Id;
        update inventario;
        
        Casos_Residente__c caso = new Casos_Residente__c();
        caso.Detalledelreporte__c = 'asdasd';
        caso.Cuenta__c = cuenta.Id;
        caso.ViviendaProceso__c = inventario.Id;
        caso.ContactEmail__c='correo@prueba.com';
        caso.ContactMobile__c='88888888';
        caso.OwnerId = usuar;
        caso.Fecha_Cierre_Cancelacion__c = system.today()-1;
        insert caso;
        
        Visita__c v1 = new Visita__c();
        v1.Fechaprogramadadevisita__c = System.today()+1;
        v1.Horaprogramadadevisita__c = time.newInstance(15, 0, 0, 0);
        v1.Horafindevisita__c = time.newInstance(17, 0, 0, 0);        
        v1.OwnerID = usuar;
        v1.CasoResidente__c = caso.Id;
        insert v1;
        

        Task t = new Task(whatId=cuenta.Id);
        insert t;
        Test.stopTest();
    }
    static testMethod void taskTest(){
        
        GetTask.NewCall();
    }
    
}