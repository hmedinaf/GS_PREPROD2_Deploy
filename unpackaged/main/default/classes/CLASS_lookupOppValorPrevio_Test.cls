@isTest 
public class CLASS_lookupOppValorPrevio_Test {
    @testSetup
    public static void testSetUpMeth(){
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        profile p = [Select Id From Profile Where Name='System Administrator'];
        User user = new User();
        user.ProfileID = p.id;
        user.Title = 'GENERICO';
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
            opp.Estado_de_aprobacion__c = 'Aprobado';
            insert opp;     
        }
    }
    static testMethod void Testmethod1() {
        user u = [select id from user where Username = 'test@portal123453.com'];
        String accId = [SELECT Id, Name FROM Account WHERE Name = 'Lopez test'].Id;
        opportunity opp = [select id,Name,StageName,CloseDate from Opportunity Limit 1];
        opp.Asesor__c = u.id;
        opp.Motivo_cambio_asesor__c = 'asesor';
        opp.Prospectador__c = u.id;
        opp.Motivo_cambio_prospectador__c = 'prospectador';
        opp.Estado_de_aprobacion__c = 'Rechazado';
        opp.AccountId = accId;
        Test.startTest();
        update opp;             
        Test.stopTest();
    }
    static testMethod void Testmethod2() {
        user u = [select id from user where Username = 'test@portal123453.com'];
        String accId = [SELECT Id, Name FROM Account WHERE Name = 'Lopez test'].Id;
        opportunity opp = [select id,Name,StageName,CloseDate from Opportunity Limit 1];
        opp.Motivo_cambio_Lead_Profiler__c = 'lead';
        opp.Lead_Profiler__c = u.id;
        opp.AccountId = accId;
        Test.startTest();
        update opp;             
        Test.stopTest();
    }
    static testMethod void Testmethod3() {
        String accId = [SELECT Id, Name FROM Account WHERE Name = 'Lopez test'].Id;
        opportunity opp = [select id,Name,StageName,CloseDate from Opportunity Limit 1];
        Colaborador_Javer__c colab = new Colaborador_Javer__c(Name = 'Javer');
        insert colab;
        opp.Colaborador_Javer__c = colab.id;
        opp.Motivo_cambio_Colaborador_Javer__c = 'Javer';
        opp.AccountId = accId;
        Test.startTest();
        update opp;             
        Test.stopTest();
    }
    
}