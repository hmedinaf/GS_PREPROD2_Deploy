@isTest
public class Casos_Cuenta_Vacias_UPD_Test {
@testSetup
    public static void setup(){
        Id usuar = [SELECT Id FROM User WHERE Name LIKE 'Admin J%' LIMIT 1].ID;
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.today().addyears(-20);
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+525530303030'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Notaria__c = 'PRUEBA';
        acc.Notario__c = 'PRUEBA';
        acc.isATC__c = true;
        acc.Numerodecliente__c = 'AA';
        acc.Nombre_cta__c = 'PRUEBA';
        acc.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
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
        Casos_Residente__c caso = new Casos_Residente__c();
        caso.Detalledelreporte__c = 'asdasd';
        //caso.Cuenta__c = acc.Id;
        caso.ViviendaProceso__c = inventario.Id;
        caso.ContactEmail__c='correo@prueba.com';
        caso.ContactMobile__c='88888888';
        //caso.OwnerId = usuar;
        caso.Origendegarantia__c = 'Producto';
        caso.Fecha_Cierre_Cancelacion__c = system.today()-1;
        insert caso;
    }
    @isTest
    private static void BATCH_WorkdayWorking(){   
        Test.startTest();
        Casos_Cuenta_Vacias_UPD BWW = new Casos_Cuenta_Vacias_UPD();
        Id batchId3 = Database.executeBatch(BWW,10);
        Test.stopTest();
    }
}