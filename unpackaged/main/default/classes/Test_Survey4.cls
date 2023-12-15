@isTest
public class Test_Survey4 {
    static void setup() {
        
    }
    @isTest(SeeAllData=true)
    public static void testMigrate4(){
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
        Survey S1 = [Select Id from Survey where Name = 'Entrega vivienda' LIMIT 1];
        SurveyInvitation SI1 = new SurveyInvitation(Name = 'TEST', Email__c = 'test@Test.com', Proceso_ATC__c = inventario.Id, SurveyId = S1.Id);
        insert SI1;
        SurveyInvitation SI = [Select Id, Proceso_ATC__c from SurveyInvitation where SurveyId =: S1.Id LIMIT 1];// new SurveyInvitation(Name = 'TEST', Email__c = 'test@Test.com', Proceso_ATC__c = inventario.Id, SurveyId = S1.Id);
        //insert SI;
        Test.startTest();
        SurveyResponse SR = [Select Id from SurveyResponse LIMIT 1];
        SurveyResponse__c srCust = new SurveyResponse__c(Survey_Invitation__c = SI.id);
        insert srCust;
        Survey_Migration_Monthly_Fix EM = new Survey_Migration_Monthly_Fix();
        Id batchId = Database.executeBatch(EM,9);
        Test.stopTest();
    }
}