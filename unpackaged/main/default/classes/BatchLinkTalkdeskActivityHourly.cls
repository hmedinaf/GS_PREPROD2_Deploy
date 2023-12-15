/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Relaciona tareas con talkdesk activities cada media hora
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      12/01/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
global class BatchLinkTalkdeskActivityHourly implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id, talkdesk__Talkdesk_Id__c, Talkdesk_Activity__c ' + 
                        'FROM Task ' + 
                        'WHERE CreatedDate = TODAY AND Talkdesk_Activity__c = Null AND talkdesk__Talkdesk_Id__c != null';
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
        List<CronTrigger> lstCronTrigger = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'LinkTalkdeskActivityHourly' LIMIT 1];
        if(lstCronTrigger.size()>0){
            // First abort the old Job and then only schedule the new Job.
            System.abortJob(lstCronTrigger[0].Id);
            DateTime currentDateTime = DateTime.now().addMinutes(30);
            String strSchedule = '0 '+ currentDateTime.minute()+' '+currentDateTime.hour()+' '+currentDateTime.day()+' '+currentDateTime.month()+' ? '+currentDateTime.year();
            System.schedule('LinkTalkdeskActivityHourly', strSchedule, new BatchLinkTalkdeskActivityHourly_Schedule());
        }
    }
}