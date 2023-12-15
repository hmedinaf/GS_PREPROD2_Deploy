@isTest
public class Promotions_Test {
    @testSetup static void setup() {
    Id profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;
        user u = new user(Fraccionamientos__c = 'ACACIAS',
                         Username = 'abc@dbvhej.com',  LastName = 'JAVER',  Email = 'abc@dbvhej.com',  Alias = 'CJAVE',  TimeZoneSidKey = 'America/Mexico_City',  LocaleSidKey = 'es_MX',
                          EmailEncodingKey = 'ISO-8859-1', ProfileId = profileId, LanguageLocaleKey = 'es_MX');
        insert u;
    }
    @isTest
    static void Test1() {
                Test.startTest();
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        user u2= [select id from user where Username =: 'abc@dbvhej.com'];
        u2.Fraccionamientos__c = f.Name;
        update u2;                 
        Promocion__c promo = new Promocion__c(Fraccionamiento__c = f.id, Imagen__c = '<p> <img src="https://example.com/image.png"></p>');
        insert promo;

        Promotions.fetchPromotions();
        Promotions.userInfoMethod();
        Promotions.fetchSelectedPromotions(f.Name);
        Promotions.download('124sdcxy374');
        Promotions.sendEmail(promo.id,'abc@dbvhej.com');
        Promotions.searchDivision('test');
        Test.stopTest();
    }
    @isTest static void Test2() {
        user u2= [select id from user where Username =: 'abc@dbvhej.com'];
        Test.startTest();
        Promotions.fetchSelectedPromotions('test');
        System.runAs(u2) {
            Promotions.fetchPromotions();
        }
        Test.stopTest();
    }
}