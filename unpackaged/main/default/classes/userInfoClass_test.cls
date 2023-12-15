@isTest
public class userInfoClass_test {
    @testSetup static void setup() {
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS II');
        insert f;
        Account ac = new Account();
        ac.name= 'test';
        ac.Phone = '+528119928819';
        ac.Otro_Telefono__c = '+528119928819'; 
        ac.Apellidomaterno_cta__c = 'materno';
        ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        ac.Fraccionamiento_cta__c = f.id; 
        insert ac;
        contact c = new contact(LastName = 'testCon', accountId= ac.id);
        insert c;  
    }
    static TestMethod void Test1() {
        Date fromDate= Date.newInstance(2023, 3, 14); Date EndDate = Date.newInstance(2023, 3, 15);
        Test.startTest();
        userInfoClass.userInfoMethod();
        userInfoClass.NeighMethod();
        userInfoClass.filterAccounts('Todos' , 'Prospecto',fromdate, enddate, 'This Week',true);
        userInfoClass.filterAccounts('ACACIAS' , 'Prospecto',fromdate, enddate, 'Last Week',false);
        userInfoClass.filterAccounts('ACACIAS' , 'Prospecto',fromdate, enddate, 'This Month',true);
        userInfoClass.filterAccounts('ACACIAS' , 'Prospecto',fromdate, enddate, 'Last Month',true);
        userInfoClass.filterAccounts('ACACIAS' , 'Prospecto',fromdate, enddate, 'Older',true);
        userInfoClass.searchDivision('DIVISION');
        userInfoClass.searchDivision('');
        Test.stopTest();
    }
    static TestMethod void Test2() {
        Test.startTest();
        UserRole userrole = [Select Id, DeveloperName From UserRole Where PortalType= 'None' Limit 1];
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'JAVER - Generico' LIMIT 1].Id;
        system.debug('profileId='+profileId);
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserroleId = userrole.id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;ACACIAS II',
                             FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        System.runAs(user) {
            Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS II');
            insert f;
            Account ac = new Account();
            ac.name= 'test';
            ac.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Company_Javer').getRecordTypeId();
            ac.Phone = '+528119928819';
            ac.Otro_Telefono__c = '+528119928819'; 
            ac.Apellidomaterno_cta__c = 'materno';
            ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
            ac.Fraccionamiento_cta__c = f.id; 
            insert ac;
            
            Historial_Asignacion__c h = new  Historial_Asignacion__c();
            h.Fraccionamiento__c = f.id;
            h.Asesor__c = user.id;
            h.Cuenta__c= ac.id;
            insert h; 
            userInfoClass.updateMethod(ac.Id, 'ACACIAS II');
            userInfoClass.logoutFromSite();
            userInfoClass.updateFA(ac.Id,'ACACIAS II');
            userInfoClass.updateFA(ac.Id,'');
            Boolean exceptionThrown = false;
            try  {
               userInfoClass.updateOwner(ac.Id);               
            }
            catch(Exception e) {
                exceptionThrown = true;
            }   
        }
        Test.stopTest();
    }
    static TestMethod void Test3() {
        Test.startTest();
        Date fromDate= Date.newInstance(2023, 3, 14); Date EndDate = Date.newInstance(2023, 3, 15);        
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'JAVER - Generico' LIMIT 1].Id;
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        UserRole userrole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserroleId = userrole.id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        System.runAs(user){
            Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS II');
            insert f;
            Account ac = new Account();
            ac.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Company_Javer').getRecordTypeId();
            ac.name= 'test';
            ac.Phone = '+528119928819';
            ac.Otro_Telefono__c = '+528119928819'; 
            ac.Apellidomaterno_cta__c = 'materno';
            ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
            ac.Fraccionamiento_cta__c = f.id; 
            insert ac;
            
            userInfoClass.logoutFromSite();
            Boolean exceptionThrown = false;
            try  {
                userInfoClass.updateOwner(ac.Id);               
            }
            catch(Exception e) {
                exceptionThrown = true;
            } 
            try {
                userInfoClass.filterAccounts('Todos' , 'Prospecto',fromdate, enddate, 'This Week',true);
                userInfoClass.updateMethod(ac.Id, 'ACACIAS II');               
            }
            catch(exception e) {}   
        }
        Test.stopTest();
    }
    static TestMethod void TestupdateMethod_Prospectador() {
        
        Date fromDate= Date.newInstance(2023, 3, 14); Date EndDate = Date.newInstance(2023, 3, 15);
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Prospectador' LIMIT 1].Id;
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        UserRole userrole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserRoleId = userrole.Id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,ContactId =con.id,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        Test.startTest();
        System.runAs(user){
            try {
                Account ac = [Select id, Name from Account Where name = 'test' LIMIT 1];
                userInfoClass.filterAccounts('Todos' , 'Prospecto',fromdate, enddate, 'This Week',true);
                userInfoClass.updateMethod(ac.Id, 'ACACIAS II');                            
            }
            catch(exception e) {}   
        }
        Test.stopTest();
    }
    static TestMethod void TestNeighMethod_Prospectador() {
        
        
        Date fromDate= Date.newInstance(2023, 3, 14); Date EndDate = Date.newInstance(2023, 3, 15);
        userInfoClass.filterAccounts('Todos' , 'Prospecto',fromdate, enddate, 'This Week',true);
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Prospectador' LIMIT 1].Id;
        UserRole userrole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserRoleId = userrole.Id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,ContactId =con.id,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        Test.startTest();
        System.runAs(user){
            try  { 
                Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS II');
                insert f;
                Account ac = new Account();
                ac.name= 'test';
                ac.Phone = '+528119928819';
                ac.Otro_Telefono__c = '+528119928819'; 
                ac.Apellidomaterno_cta__c = 'materno';
                ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
                ac.Fraccionamiento_cta__c = f.id; 
                insert ac;
                userInfoClass.NeighMethod();                
            }
            catch(exception e) {}   
        }
        Test.stopTest();
    }
    static TestMethod void TestNeighMethod_Asesor() {
        
        
        Date fromDate= Date.newInstance(2023, 3, 14); Date EndDate = Date.newInstance(2023, 3, 15);
        userInfoClass.filterAccounts('Todos' , 'Prospecto',fromdate, enddate, 'This Week',true);
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Asesor' LIMIT 1].Id;
        UserRole userrole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserRoleId = userrole.Id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,ContactId =con.id,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        Test.startTest();
        System.runAs(user){
            try  { 
                Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS II');
                insert f;
                Account ac = new Account();
                ac.name= 'test';
                ac.Phone = '+528119928819';
                ac.Otro_Telefono__c = '+528119928819'; 
                ac.Apellidomaterno_cta__c = 'materno';
                ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
                ac.Fraccionamiento_cta__c = f.id; 
                insert ac;
                userInfoClass.NeighMethod();                
            }
            catch(exception e) {}   
        }
        Test.stopTest();
    }
}