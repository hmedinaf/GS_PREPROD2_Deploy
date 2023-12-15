@isTest
public class CLASS_Plan_Venta_Test {
    @testSetup static void setup() {
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
        Opportunity opp = new Opportunity(Name = 'Test Opportunity');
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        opp.AccountId = acc.Id;
        update opp;
        Contract c =  new Contract();
        c.Name = 'Test Contract ' ;
        c.AccountId = acc.Id;
        c.Oportunidad__c = opp.id;
        c.Empresa__c = 'test';
        c.RFC_Compania__c = 'test';
        c.Fecha_de_Constituci_n__c = system.today();
        c.No_Escritura__c = 'test';
        c.Notaria__c = 'test';
        insert c;
        Co_Acreditado__c acr = new Co_Acreditado__c();
        acr.Contrato__c = c.Id;
        acr.Apellido_Paterno_CO_Acreditado__c = 'test';
        acr.Apellido_Materno_CO_Acreditado__c = 'test';
        acr.Sexo__c = 'MASCULINO';
        insert acr;
        Informacion_representante_legal__c irl = new Informacion_representante_legal__c();
        irl.Contrato__c = c.Id;
        irl.RFC__c = 'RFC';
        insert irl;
        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 6;
        pdv.Frecuencia__c = 'Mensual';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(6);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        pdv.Oportunidad__c = opp.Id;
        pdv.En_aprobacion__c = false;
        pdv.Estatus_Plan_de_venta__c = 'APROBADO';
        insert pdv;
    }
    static TestMethod void testMethod1() {
        Opportunity opp = [Select id, name from Opportunity Where Name = 'Test Opportunity' LIMIT 1];
        List<Plan_de_Venta__c> pdvlist =  [Select id, Name ,Oportunidad__c from Plan_de_Venta__c Where Oportunidad__c =: opp.Id];
        Plan_de_Venta__c pdv = pdvlist[0];
        test.startTest();
        pdv.Plazo__c = 4;
        pdv.Frecuencia__c ='Quincenal';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        pdv.Modificacion_Automatica__c = 10;
        pdv.En_aprobacion__c = true;
        pdv.Oportunidad__c = opp.Id;
        pdvlist.add(pdv);
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
    static TestMethod void testMethod2() {
        Opportunity opp = [Select id, name from Opportunity Where Name = 'Test Opportunity' LIMIT 1];
        List<Plan_de_Venta__c> pdvlist =  [Select id, Name ,Oportunidad__c from Plan_de_Venta__c Where Oportunidad__c =: opp.Id];
        Plan_de_Venta__c pdv = pdvlist[0];
        test.startTest();
        pdv.Plazo__c = 4;
        pdv.Frecuencia__c ='Quincenal';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        pdv.Modificacion_Automatica__c = 10;
        pdv.En_aprobacion__c = true;
        //pdv.Oportunidad__c = opp.Id;
        pdvlist.add(pdv);
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