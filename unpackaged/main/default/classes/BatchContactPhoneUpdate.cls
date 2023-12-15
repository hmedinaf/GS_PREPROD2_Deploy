/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Filtra y elimina el prefijo +52 del campo Contact Phone del TalkdeskActivities 
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      25/01/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
global class BatchContactPhoneUpdate implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT talkdesk__Contact_Phone__c ' + 
                        'FROM talkdesk__Talkdesk_Activity__c ' + 
                        'WHERE Phone_Length__c = TRUE';
        query = !Test.isRunningTest() ? query : 'SELECT talkdesk__Contact_Phone__c FROM talkdesk__Talkdesk_Activity__c LIMIT 1';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<talkdesk__Talkdesk_Activity__c> scope) { 
        for(talkdesk__Talkdesk_Activity__c activity : scope){
            activity.talkdesk__Contact_Phone__c = '+' + activity.talkdesk__Contact_Phone__c.Substring(3, activity.talkdesk__Contact_Phone__c.length());
        }

        update scope;
    }   

    global void finish(Database.BatchableContext BC) {

    }
}