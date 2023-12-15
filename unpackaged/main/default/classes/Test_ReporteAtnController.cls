@isTest
public class Test_ReporteAtnController {
    static testMethod void validar(){
        Test.startTest();
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.FechaEntregaEsperada__c = System.today();
        inventario.FechaEntrega__c=system.today()-1;
        insert inventario;
        
        Id usuar = [SELECT Id FROM User WHERE Name LIKE 'Admin%' LIMIT 1].ID;
        
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
        
        Casos_Residente__c caso = new Casos_Residente__c();
        caso.Detalledelreporte__c = 'asdasd';
        caso.Cuenta__c = acc.Id;
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
        
        PageReference page = Page.AtnCliente_Reporte;
        page.getParameters().put('id',caso.Id);
        Test.setCurrentPageReference(page);
        ReporteAtnController ctr = new ReporteAtnController();
        ctr.prepare();
        Test.stopTest();
    }
}