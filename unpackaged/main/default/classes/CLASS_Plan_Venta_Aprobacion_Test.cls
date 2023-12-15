@isTest
public class CLASS_Plan_Venta_Aprobacion_Test {
    @isTest 
    static void testPlanVentaAprobacion() {
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
        Plan_de_Venta__c planVenta = new Plan_de_Venta__c(Oportunidad__c = opp.Id, 
                                                          Exepcion_Fondo_de_Garantia_Aprobado__c = true, Fecha_Proyeccion_escritura__c = Date.today(),
                                                          Plan_de_Venta_Aprobado__c = false);
        insert planVenta; //Vivienda__c = vv.Id,
      
        CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper input = new CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper();
        input.PlanVentaId = planVenta.Id;
        List<CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper> inputList = new List<CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper>();
        inputList.add(input);
        Test.startTest();
        List<CLASS_Plan_Venta_Aprobacion.PlanVentaDetailsWrapper> outputList = CLASS_Plan_Venta_Aprobacion.CLASS_Plan_Venta_Aprobacion(inputList);
        Test.stopTest();
      
    }
   /* @isTest
    static void testPlanVentaAprobacion2() {
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
        Plan_de_Venta__c planVenta = new Plan_de_Venta__c(Oportunidad__c = opp.Id,
                                                          Plan_de_Venta_Aprobado__c = false);
        insert planVenta;
        Contract contract = new Contract(Name = 'Test Contract ', AccountId = acc.Id, Oportunidad__c = opp.id);
        insert contract;
        Co_Acreditado__c acr = new Co_Acreditado__c();
        acr.Contrato__c = contract.id;
        acr.Apellido_Paterno_CO_Acreditado__c = 'test';
        acr.Apellido_Materno_CO_Acreditado__c = 'test';
        acr.Sexo__c = 'MASCULINO';
        insert acr;
        CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper input = new CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper();
        input.PlanVentaId = planVenta.Id;
        List<CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper> inputList = new List<CLASS_Plan_Venta_Aprobacion.PlanVentaInputWrapper>();
        inputList.add(input);
        Test.startTest();
        List<CLASS_Plan_Venta_Aprobacion.PlanVentaDetailsWrapper> outputList = CLASS_Plan_Venta_Aprobacion.CLASS_Plan_Venta_Aprobacion(inputList);
        Test.stopTest();
        System.assertEquals(1, outputList.size());
        CLASS_Plan_Venta_Aprobacion.PlanVentaDetailsWrapper output = outputList[0];
        System.assertNotEquals(null, output.PlanVentaResult);
        Plan_de_Venta__c updatedPlanVenta = [SELECT Plan_de_Venta_Aprobado__c FROM Plan_de_Venta__c WHERE Id = :planVenta.Id];
        System.assertEquals(false, updatedPlanVenta.Plan_de_Venta_Aprobado__c);
    } */
}