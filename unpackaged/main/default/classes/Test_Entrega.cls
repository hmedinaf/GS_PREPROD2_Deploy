@isTest
public class Test_Entrega {
    static testMethod void runUpdateInventario(){
        Test.startTest();
        Id usuar = [SELECT Id FROM User WHERE Name LIKE 'Admin J%' LIMIT 1].ID;
        
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.parse('11/09/1991');
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        
        Fraccionamiento__c fra = new Fraccionamiento__c();
        fra.Name = 'TEST';
        fra.Residente1__c = usuar;
        insert fra;
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Fracc__c = fra.Id;
        inventario.Entregada__c = 'Entregado';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = acc.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        insert inventario;
        
        inventario.Name = 'test';
        update inventario;
        Check_List__c checklist = new Check_List__c();
        checklist.Name = 'test';
        insert checklist;
        //recursionCheck rc = new recursionCheck();
        recursionCheck.canIRun();
        recursionCheck.stopRecursion();
        recursionCheck.allowTorun();
        
        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventario.id;
        entrega.FechaEntrega__c = System.today();
        entrega.Cuenta__c = acc.Id;
        insert entrega;
        UpdateInventario.guardar(inventario.Id);    
        Test.stopTest();
    }
}