/*
----------------------------------------------------------
* Nombre: AccountUtils_test
* Autor Saúl González   
* Proyecto: Javer
* Descripción : Clase con metódos test 
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           19/03/2021     Saúl González            Creación
* --------------------------------------------------------------------------------
*/
@isTest
private class AccountUtils_test {
    /*
    * @description Method que ejecuta setup
    */
    static testMethod void getObjAccount(){
        Account acc = new Account(Apellidomaterno_cta__c = 'materno',FirstName = 'fName',LastName = 'lName',Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES',
                                      TelefonoCelular__c = '+525656566567',phone = '+525656566567',Sub_canal_de_venta__c = 'COLABORADOR JAVER',
                                  CorreoElectronico__c = 'abc@test.com',
                                      RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId());
        insert acc;
        Set<Id> ids = new set<id>();
        ids.add(acc.id);
        Test.startTest();
        AccountUtils_ctrl lH = new AccountUtils_ctrl();
        AccountUtils_ctrl.getObjActId(ids);
        AccountUtils_ctrl.getObjAccount(acc.CorreoElectronico__c);
        Test.stopTest();
    } 
}