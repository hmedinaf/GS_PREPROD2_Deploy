@isTest(SeeAllData=true)
public class Test_Survey {
    static testmethod void test() {        
        Account acc = new Account();
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c = f.id;
        acc.CorreoElectronico__c ='test@mail.com';
        insert acc;
        Inventario__c PATC = new Inventario__c();
        PATC.Cuenta__c = acc.Id;
        insert PATC;
        Survey S1 = [Select Id from Survey where Name =: 'Entrega vivienda' LIMIT 1];
        Survey S2 = [Select Id from Survey where Name =: 'Entrega 3 meses vivienda' LIMIT 1];
        Survey S3 = [Select Id from Survey where Name =: 'Entrega 1 año' LIMIT 1];
        SurveyInvitation SI = new SurveyInvitation();
        SI.Name = 'TEST';
        SI.Email__c = 'test@Test.com';
        SI.Proceso_ATC__c = PATC.Id;
        SI.SurveyId = S1.Id;
        Test.startTest();
        insert SI;
        SurveyInvitation SI2 = new SurveyInvitation();
        SI2.Name = 'TEST';
        SI2.Email__c = 'test@Test.com';
        SI2.Proceso_ATC__c = PATC.Id;
        SI2.SurveyId = S2.Id;
        insert SI2;
        SurveyInvitation SI3 = new SurveyInvitation();
        SI3.Name = 'TEST';
        SI3.Email__c = 'test@Test.com';
        SI3.Proceso_ATC__c = PATC.Id;
        SI3.SurveyId = S3.Id;
        insert SI3;
        
        SurveyResponse SR = [Select Id, InvitationId, CreatedDate from SurveyResponse ORDER BY CreatedDate ASC LIMIT 1];
        SurveyInvitation SI0 = [Select Id, InviteExpiryDateTime from SurveyInvitation Where Id=: SR.InvitationId];
        datetime myDate = Date.today();
        datetime newDate = mydate.addDays(1);
        SI0.InviteExpiryDateTime = newDate;
        update SI0;
        try{
            delete SR;
        }catch(Exception e){
            System.debug(e);
        }
        Test.stopTest();
    }
    
    
}