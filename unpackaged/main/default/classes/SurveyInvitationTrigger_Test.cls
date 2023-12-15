@isTest
public class SurveyInvitationTrigger_Test {
   @isTest(seeAllData=true)
    public static  void Test1() {
        Account acc = new Account(FirstName= 'Lopez', LastName= 'test', CorreoElectronico__c = 'test@prospects.com', Apellidomaterno_cta__c = 'dahuoh', PersonBirthdate=date.today().addyears(-20),Phone = '+528119928819',Otro_Telefono__c = '+528119928819',TelefonoCelular__c='+525530303030',Canal_de_Venta__c = 'PROSPECTO ASESOR', Estatus_Lista_Negra_QEQ__c = 'VALIDADO');
        Account acc1 = acc.clone(false, true, false, false);
        acc1.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc1.Canal_de_Venta__c = 'MEDIOS DIGITALES';
        acc1.Sub_canal_de_venta__c = '';
        acc1.Check_Apellido__c = true;
        acc1.Sexo__c = 'MASCULINO';
        acc1.Nacionalidad__c = 'MEXICANA';
        acc1.Lugar_Nacimiento__c = 'AGUASCALIENTES';
        acc1.CorreoElectronico__c = 'test@portal123453.com';
        acc1.Fecha_de_Afluencia__c = date.today().addDays(-1);
        acc1.BillingPostalCode = '123456';
        insert acc1;
        Inventario__c inventario = new Inventario__c(Condominio__c = 'Condominio', Entregada__c = 'Entregado', Cuenta__c = acc1.Id, Revisiones_en_Vivienda__c = '3');
        insert inventario;
        acc1.Apellidomaterno_cta__c = 'test';
        acc1.Aprobo_Check_Apellido__c  = false;
        acc1.Vivienda_Mas_Reciente__c = inventario.Id;
        update acc1; 
        Survey S1 = [Select Id from Survey where Name =: 'Entrega vivienda' LIMIT 1];
        Survey S2 = [Select Id from Survey where Name =: 'Entrega 3 meses vivienda' LIMIT 1];
        Survey S3 = [Select Id from Survey where Name =: 'Entrega 1 año' LIMIT 1];
        Test.startTest();
        SurveyInvitation SI = new SurveyInvitation(Name = 'TEST', Email__c = 'test@Test.com', Proceso_ATC__c = inventario.Id, SurveyId = S1.Id);
        insert SI;
        SurveyInvitation SI2 = new SurveyInvitation(Name = 'TEST', Email__c = 'test@Test.com', Proceso_ATC__c = inventario.Id, SurveyId = S2.Id);
        insert SI2;
        SurveyInvitation SI3 = new SurveyInvitation(Name = 'TEST', Email__c = 'test@Test.com', Proceso_ATC__c = inventario.Id, SurveyId = S3.Id);
        insert SI3;
        SI3.Email__c = 'test1@Test.com';
        SI3.No_Migrada__c = true;
        update SI3;
        Survey_Migration_Schedule BIR = new Survey_Migration_Schedule();
        String sch = '0 30 * * * ?';
        System.schedule('BATCH_WorkdayOficialFirmada', sch, BIR);
        Test.stopTest();
    }
}