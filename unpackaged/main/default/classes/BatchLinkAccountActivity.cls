/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Asigna una cuenta a los registros de TD Activity en base al valor de Contact Phone
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      08/01/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
global class BatchLinkAccountActivity implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id, talkdesk__Contact_Phone__c,talkdesk__Account__c ' + 
                        'FROM talkdesk__Talkdesk_Activity__c ' + 
                        'WHERE talkdesk__Contact_Phone__c != NULL AND talkdesk__Account__c = NULL';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<talkdesk__Talkdesk_Activity__c> scope) { 
        Map<String, talkdesk__Talkdesk_Activity__c> TaskPhone = new Map<String, talkdesk__Talkdesk_Activity__c>();

        for(talkdesk__Talkdesk_Activity__c newTask : scope){
            TaskPhone.put(newTask.talkdesk__Contact_Phone__c, newTask);
        }

        List<Account> cuentasGenericas = [SELECT Id FROM Account WHERE Name = 'CUENTA ASIGNACION GENERICA' LIMIT 1];

        List<Account> cuentasTCasa = [SELECT Id, Phone FROM Account WHERE Phone IN: TaskPhone.keySet() 
                                        AND Phone != '0' AND Phone != null LIMIT 1000];
        List<Account> cuentasTCelular = [SELECT Id, TelefonoCelular__c FROM Account WHERE TelefonoCelular__c IN: TaskPhone.keySet() 
                                            AND TelefonoCelular__c != '0' AND TelefonoCelular__c != null LIMIT 1000];
        List<Account> cuentasTOtro = [SELECT Id, TelefonoOtro__c FROM Account WHERE TelefonoOtro__c IN: TaskPhone.keySet() 
                                            AND TelefonoOtro__c != '0' AND TelefonoOtro__c != null LIMIT 1000]; 

        Map<String, Account> mapAccounts = new Map<String, Account>();

        if(!cuentasTCasa.isEmpty()){
            for(Account cuenta : cuentasTCasa){
                mapAccounts.put(cuenta.Phone, cuenta);
            }
        }

        if(!cuentasTCelular.isEmpty()){
            for(Account cuenta : cuentasTCelular){
                mapAccounts.put(cuenta.TelefonoCelular__c, cuenta);
            }
        }

        if(!cuentasTOtro.isEmpty()){
            for(Account cuenta : cuentasTOtro){
                mapAccounts.put(cuenta.TelefonoOtro__c, cuenta);
            }
        }

        for(talkdesk__Talkdesk_Activity__c task : scope){
            Account cuenta = mapAccounts.get(task.talkdesk__Contact_Phone__c);
            task.talkdesk__Account__c = cuenta == null ? cuentasGenericas.isEmpty() ? null : cuentasGenericas[0].Id : cuenta.Id;
        }
        
        update scope;
        
    }   

    global void finish(Database.BatchableContext BC) {

    }
}