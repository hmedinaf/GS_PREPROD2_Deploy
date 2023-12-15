/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Envia recordatorios de tareas por vencer via notificiaciones web y movil 
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      17/12/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
global class BatchIVRReminder implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id, ActivityDate, OwnerId, Agente_Call_Center__c, Folio__c ' + 
                        'FROM Task ' + 
                        'WHERE ActivityDate = TOMORROW AND Status != \'Completed\' AND Status != \'Cerrada\'';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Task> scope) { 
        CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'IVR'];
        OrgWideEmailAddress owea = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'noreply.atc@javer.com.mx' LIMIT 1];
        EmailTemplate template = [SELECT Id, Body, Subject from EmailTemplate WHERE DeveloperName = 'IVR_Reminder' LIMIT 1];

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Task task : scope){
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setNotificationTypeId(type.id);
            notification.setTitle('Tarea ' + task.Folio__c + ' por vencer');
            notification.setBody('Haga click aquí para ver mas detalles');
            notification.setTargetId(task.Id);
            notification.send(new Set<String> { task.OwnerId });

            Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(template.Id, null, task.Id);

            List<Id> toAddresses = new List<Id>();
            toAddresses.add(task.OwnerId);

            List<Id> ccAddresses = new List<Id>();
            if(task.Agente_Call_Center__c != null){ ccAddresses.add(task.Agente_Call_Center__c); }

            email.setOrgWideEmailAddressId(owea.Id);
            email.saveAsActivity = false;
            email.setToAddresses(toAddresses);
            email.setCcAddresses(ccAddresses);
            emails.add(email);
        }

        if(!emails.isEmpty()){
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(emails);
        }
    }   

    global void finish(Database.BatchableContext BC) {

    }
}