@isTest
public with sharing class TRIGGER_PlanDeVenta_Handler_Test {
    
    @isTest
    static void testPagarePreventaSemanal(){
        List<Contract> contracts = new List<Contract>();
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
        acc.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
        insert acc;
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Reservado';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        for (Integer i = 0; i < 5; i++) {
            contracts.add(new Contract
                          (Name = 'Test Contract ' + i, AccountId = acc.Id, Oportunidad__c = opp.id, Empresa__c = 'test', RFC_Compania__c = 'test'
                           ,Fecha_de_Constituci_n__c = system.today(),No_Escritura__c = 'test',Notaria__c = 'test'
                           /*  Escritura_a_favor_de_un_Tercero__c = 'SI',  Es_usted_el_Titular_de_Recursos__c = 'NO',Existe_un_Tercero_que_aporta_Recursos__c = 'SI' */));
        }
        
        insert contracts;
        List<Direcciones__c> addresses = new List<Direcciones__c>();
        for (Contract contract : contracts) {
            addresses.add(new Direcciones__c(Contrato__c = contract.Id, Tipo__c = 'Dirección Principal'));
        }
        insert addresses;
        List<Referencia_familiar__c> references = new List<Referencia_familiar__c>();
        for (Integer i = 0; i < 3; i++) {
            Referencia_familiar__c reference = new Referencia_familiar__c();
            reference.Contrato__c = contracts[0].Id;
            reference.Apellido_Paterno__c = 'test';
            reference.Apellido_Materno__c = 'Test';
            reference.Telefono_1__c = '+525530303030';
            reference.Telefono_2__c = '+528119928819'; 
            references.add(reference);
        }
        
        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 10;
        pdv.Frecuencia__c = 'Mensual';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Estatus_Plan_de_venta__c = 'En Progreso';
        pdv.Oportunidad__c = opp.Id;
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        insert pdv;
        Pagare_Preventa__c pagares = new Pagare_Preventa__c();
        pagares.Plan_de_Venta__c = pdv.id;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(1);
        insert pagares;
        pdv.Plazo__c = 4;
        pdv.Frecuencia__c = 'Semanal';
        pdv.Fecha_de_Vencimiento__c =  system.today().addDays(10);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        pdv.Modificacion_Automatica__c = 10;
        Test.startTest(); 
        Boolean exceptionThrown = false;
        try {
            update pdv; 
        } 
        catch (Exception e) {
            exceptionThrown = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('No')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        }   
        test.stopTest();
    }
    
}