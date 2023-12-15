@isTest 
public with sharing class BatchLinkAccountActivity_Test {

    @testSetup
    public static void setup(){
		 Account acc = new Account(Apellidomaterno_cta__c = 'materno',FirstName = 'fName',LastName = 'lName',Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES',
                                      TelefonoCelular__c = '+525656566567',phone = '+525656566567',Sub_canal_de_venta__c = 'COLABORADOR JAVER',
                                  CorreoElectronico__c = 'abc@test.com',TelefonoOtro__c = '+525656566567',
                                      RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId());
        insert acc;
        
        talkdesk__Talkdesk_Activity__c tda = new talkdesk__Talkdesk_Activity__c();
        tda.Name = 'test';
        tda.talkdesk__Talkdesk_Id__c = 'test';
        tda.talkdesk__Contact_Phone__c = '+525656566567';
        insert tda;
        
        tda.talkdesk__Account__c = null;
        update tda;

    }

    @isTest
    public static void BatchLinkAccountActivity(){
        BatchLinkAccountActivity BLTA = new BatchLinkAccountActivity();
        Id batchId = Database.executeBatch(BLTA);
    }
}