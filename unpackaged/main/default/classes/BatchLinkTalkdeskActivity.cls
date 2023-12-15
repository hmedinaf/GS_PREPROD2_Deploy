/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Relaciona tareas con talkdesk activities
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      27/12/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
global class BatchLinkTalkdeskActivity implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id, talkdesk__Talkdesk_Id__c, Talkdesk_Activity__c ' + 
                        'FROM Task ' + 
                        'WHERE Talkdesk_Activity__c = Null AND talkdesk__Talkdesk_Id__c != null';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Task> scope) { 
        Map<String, Task> TaskActivity = new Map<String, Task>();
        for(Task task : scope){
            if(String.isNotBlank(task.talkdesk__Talkdesk_Id__c)){
                TaskActivity.put(task.talkdesk__Talkdesk_Id__c, task);
            }
        }

        if(!TaskActivity.isEmpty()){
            List<talkdesk__Talkdesk_Activity__c> activities = [SELECT Id, talkdesk__Talkdesk_Id__c FROM talkdesk__Talkdesk_Activity__c WHERE talkdesk__Talkdesk_Id__c IN: TaskActivity.keySet()];
            
            if(!activities.isEmpty()){
                Map<String, talkdesk__Talkdesk_Activity__c> activitiesMap = new Map<String, talkdesk__Talkdesk_Activity__c>();
                for(talkdesk__Talkdesk_Activity__c activity : activities){
                    activitiesMap.put(activity.talkdesk__Talkdesk_Id__c, activity);
                }

                for(Task task : TaskActivity.values()){
                    talkdesk__Talkdesk_Activity__c activity = activitiesMap.get(task.talkdesk__Talkdesk_Id__c);
                    task.Talkdesk_Activity__c = activity == null ? null : activity.Id;
                }
            }
        }

        update TaskActivity.values();
    }   

    global void finish(Database.BatchableContext BC) {

    }
}