@isTest 
public class EncuestasRecordatorioDiario_Test {
    
    @isTest(SeeAllData=true)
    public static void EncuestasRecordatorioDiario(){
        profile p = [Select Id From Profile Where Name='System Administrator'];
        User user = new User();
        user.ProfileID = p.id;
        user.EmailEncodingKey = 'ISO-8859-1';
        user.LanguageLocaleKey = 'en_US';
        user.TimeZoneSidKey = 'America/New_York';
        user.LocaleSidKey = 'en_US';
        user.is_Data_Migration_User__c = true;
        user.FirstName = 'first';
        user.LastName = 'last';
        user.Username = 'test@portal123453.com';
        user.CommunityNickname = 'testUser123';
        user.Alias = 't1';
        user.Email = 'no@email.com';
        user.IsActive = true;
        user.FRACCIONAMIENTOS__c = 'ACACIAS;ACACIAS II';
        user.FraccionamientoAutorizados__c = 'ACACIAS';
        insert user;
        System.runAs(user){   
            Account acc = new Account();
            acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
            acc.FirstName= 'Lopez';
            acc.LastName= 'test';
            acc.Phone = '+528119928819';
            acc.Check_Apellido__c = true;
            acc.Otro_Telefono__c = '+528119928819';
            acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
            //acc.Fraccionamiento_cta__c = f.id;
            acc.CorreoElectronico__c ='test@mail.com';
            insert acc; 
            
            Inventario__c PATC = new Inventario__c();
            PATC.Cuenta__c = acc.Id;
            insert PATC;
            
            Survey S1 = [Select Id from Survey where Name = 'Entrega vivienda'];
            Survey S2 = [Select Id from Survey where Name = 'Entrega 3 meses vivienda'];
            Survey S3 = [Select Id from Survey where Name = 'Entrega 1 año'];
            
            SurveyInvitation SI1 = new SurveyInvitation();
            SI1.Name = 'TEST';
            SI1.Email__c = 'test1@test1.com';
            SI1.Proceso_ATC__c = PATC.Id;
            SI1.SurveyId = S1.Id;
            
            SurveyInvitation SI2 = new SurveyInvitation();
            SI2.Name = 'TEST';
            SI2.Email__c = 'test@test.com';
            SI2.Proceso_ATC__c = PATC.Id;
            SI2.SurveyId = S2.Id;
            
            SurveyInvitation SI3 = new SurveyInvitation();
            SI3.Name = 'TEST';
            SI3.Email__c = 'test@Test.com';
            SI3.Proceso_ATC__c = PATC.Id;
            SI3.SurveyId = S3.Id;
            
            Test.startTest();
            insert SI1; insert SI2; insert SI3;
            
            SI1.Last_Email__c = system.today().addDays(-3);
            SI1.InviteExpiryDateTime = system.today().AddDays(3);
            update SI1;
            
            SI2.Last_Email__c = system.today().addDays(-3);
            SI2.InviteExpiryDateTime = system.today().AddDays(3);
            update SI2;
            
            SI3.Last_Email__c = system.today().addDays(-3);
            SI3.InviteExpiryDateTime = system.today().AddDays(3);
            update SI3;
            
            /*EmailTemplate validEmailTemplate1 = new EmailTemplate();
            validEmailTemplate1.isActive = true;
            validEmailTemplate1.Name = 'name';
            validEmailTemplate1.DeveloperName = 'Recordatorio1';
            validEmailTemplate1.TemplateType = 'text';
            validEmailTemplate1.FolderId = UserInfo.getUserId();
            //insert validEmailTemplate1; 
            
            EmailTemplate validEmailTemplate2 = new EmailTemplate();
            validEmailTemplate2.isActive = true;
            validEmailTemplate2.Name = 'name';
            validEmailTemplate2.DeveloperName = 'Recordatorio2';
            validEmailTemplate2.TemplateType = 'text';
            validEmailTemplate2.FolderId = UserInfo.getUserId();
            //insert validEmailTemplate2;
            
            EmailTemplate validEmailTemplate3 = new EmailTemplate();
            validEmailTemplate3.isActive = true;
            validEmailTemplate3.Name = 'name';
            validEmailTemplate3.DeveloperName = 'Recordatorio3';
            validEmailTemplate3.TemplateType = 'text';
            validEmailTemplate3.FolderId = UserInfo.getUserId();
            
            //insert validEmailTemplate3;*/
            SchedulableContext sc = null;
            EncuestasRecordatorioSchedule tsc = new EncuestasRecordatorioSchedule();
            tsc.execute(sc);
            Test.stopTest();
        }
    }
}