@isTest 
public without sharing class AccountTriggerHandler_Test {
    @testSetup static void setup() {
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        Account ac = new Account();
        ac.name= 'test';
        ac.Phone = '+528119928819';
        ac.Otro_Telefono__c = '+528119928819'; 
        ac.Apellidomaterno_cta__c = 'materno';
        ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        ac.Fraccionamiento_cta__c = f.id; 
        ac.Nombre_Fraccionamiento__c='ACACIAS';
        insert ac;
    }
    static TestMethod void testMethod1() {
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.parse('11/09/1991');
        acc.Phone = '+528119928819';
        acc.TelefonoOtro__c = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        profile p = [Select Id From Profile Where Name='System Administrator'];
        User user = new User();
        user.ProfileID = p.id;
        user.EmailEncodingKey = 'ISO-8859-1';
        user.LanguageLocaleKey = 'en_US';
        user.TimeZoneSidKey = 'America/New_York';
        user.LocaleSidKey = 'en_US';
        user.is_Data_Migration_User__c = true;
        user.FirstName = 'ADMIN';
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
            acc.Phone = '+529999999909';
            acc.TelefonoOtro__c = '+527856675678';
            acc.Otro_Telefono__c = '+527856675678';
            acc.TelefonoCelular__c = '+529909999909';
            Test.startTest();
            update acc;
            AccountTriggerHandler ac = new AccountTriggerHandler();
            ac.getFilteredPhoneWPrefix('1234567890');
            ac.getFilteredPhoneWPrefix('+522234567890');
            Test.stopTest();
        }
    }
    static TestMethod void testMethod2() { 
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Asesor' LIMIT 1].Id;
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        User currentUser = [Select Id, Name from User Where Id =: UserInfo.getUserId()];
        currentUser.UserRoleId = portalRole.Id;
        update currentUser;
        User user ;
        System.runAs(currentUser) {
            Account acc = new Account();
            acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Company_Javer').getRecordTypeId();
            acc.name= 'Lopez S';
            acc.Phone = '+528119928819';
            acc.Otro_Telefono__c = '+528119928819'; 
            acc.Apellidomaterno_cta__c = 'materno';
            acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
            insert acc;
            Contact con = new Contact(LastName ='testCon',AccountId = acc.Id);
            insert con; 
            user = new User(alias = 'test123', email='test123@noemail.com',
                            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                            localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,ContactId =con.id,
                            timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                            Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
            insert user;
            Test.startTest();
            if(user != null){
                Account ac = [Select Id, Name from Account Where Name = 'test'];
                ac.Asesor__c =user.Id;
                update ac;
            }
            Test.stopTest();
        } 
    }
}