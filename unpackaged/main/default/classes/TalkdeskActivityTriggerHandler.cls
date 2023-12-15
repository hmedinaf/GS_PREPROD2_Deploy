/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Handler de TalkdeskActivityTrigger
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      05/01/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class TalkdeskActivityTriggerHandler extends TriggerHandler{

    private Map<Id, talkdesk__Talkdesk_Activity__c> newMap;
    private Map<Id, talkdesk__Talkdesk_Activity__c> oldMap;
    private List<talkdesk__Talkdesk_Activity__c> newList;
    private List<talkdesk__Talkdesk_Activity__c> oldList;
    
    public TalkdeskActivityTriggerHandler() {
        this.newMap = (Map<Id, talkdesk__Talkdesk_Activity__c>) trigger.newMap;
        this.oldMap = (Map<Id, talkdesk__Talkdesk_Activity__c>) trigger.oldMap;
        this.newList = (List<talkdesk__Talkdesk_Activity__c>) trigger.new;
        this.oldList = (List<talkdesk__Talkdesk_Activity__c>) trigger.old;
    }

    public override void beforeInsert() {
        //validarTelefono();
        asignarCuenta();
    }

    public override void afterInsert() {
        //asignarActividad();
    }

    /*public void validarTelefono(){
        Map<String, talkdesk__Talkdesk_Activity__c> TaskActivity = new Map<String, talkdesk__Talkdesk_Activity__c>();
        List<Task> TasksUpdate = new List<Task>();
        for(talkdesk__Talkdesk_Activity__c newTask : newList){
            if(newTask.talkdesk__Contact_Phone__c != null && newTask.talkdesk__Contact_Phone__c.Substring(0,3) == '+52' && newTask.talkdesk__Contact_Phone__c.length() > 11){
                newTask.talkdesk__Contact_Phone__c = '+52' + newTask.talkdesk__Contact_Phone__c.Substring(3, newTask.talkdesk__Contact_Phone__c.length());
            }
        }
    }*/

    public void asignarCuenta(){
        Map<String, talkdesk__Talkdesk_Activity__c> TaskPhone = new Map<String, talkdesk__Talkdesk_Activity__c>();
        for(talkdesk__Talkdesk_Activity__c newTask : newList){
            if(newTask.talkdesk__Contact_Phone__c != null && newTask.talkdesk__Contact_Phone__c != '+'){
                TaskPhone.put(newTask.talkdesk__Contact_Phone__c, newTask);
            }
        }

        List<Account> cuentasGenericas = [SELECT Id FROM Account WHERE Name = 'CUENTA ASIGNACION GENERICA' LIMIT 1];
        List<Agente_Call_Center_Default__mdt> agenteCallCenter = [SELECT Username__c FROM Agente_Call_Center_Default__mdt WHERE Label = 'Default'];
        List<User> defaultUser = new List<User>();

        List<Account> cuentasTCasa = [SELECT Id, Phone FROM Account WHERE Phone IN: TaskPhone.keySet() 
                                        AND Phone != '0' AND Phone != '+' AND Phone != null LIMIT 1000];
        List<Account> cuentasTCelular = [SELECT Id, TelefonoCelular__c FROM Account WHERE TelefonoCelular__c IN: TaskPhone.keySet() 
                                            AND TelefonoCelular__c != '0' AND TelefonoCelular__c != '+' AND TelefonoCelular__c != null LIMIT 1000];
        List<Account> cuentasTOtro = [SELECT Id, TelefonoOtro__c FROM Account WHERE TelefonoOtro__c IN: TaskPhone.keySet() 
                                            AND TelefonoOtro__c != '0' AND TelefonoOtro__c != '+' AND TelefonoOtro__c != null LIMIT 1000]; 

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

        for(talkdesk__Talkdesk_Activity__c task : TaskPhone.values()){
            Account cuenta = mapAccounts.get(task.talkdesk__Contact_Phone__c);
            task.talkdesk__Account__c = cuenta == null ? cuentasGenericas.isEmpty() ? null : cuentasGenericas[0].Id : cuenta.Id;
        }
    }

    /*public void asignarActividad(){
        Map<String, talkdesk__Talkdesk_Activity__c> TaskActivity = new Map<String, talkdesk__Talkdesk_Activity__c>();
        List<Task> TasksUpdate = new List<Task>();
        for(talkdesk__Talkdesk_Activity__c newTask : newList){
            if(String.isNotBlank(newTask.talkdesk__Talkdesk_Id__c)){
                TaskActivity.put(newTask.talkdesk__Talkdesk_Id__c, newTask);
            }
        }

        if(!TaskActivity.isEmpty()){
            List<Task> activities = [SELECT Id, talkdesk__Talkdesk_Id__c, Talkdesk_Activity__c FROM Task WHERE talkdesk__Talkdesk_Id__c IN: TaskActivity.keySet() AND Talkdesk_Activity__c = NULL];
            
            if(!activities.isEmpty()){
                Map<String, Task> activitiesMap = new Map<String, Task>();
                for(Task activity : activities){
                    activitiesMap.put(activity.talkdesk__Talkdesk_Id__c, activity);
                }

                for(Task task : activitiesMap.values()){
                    if(TaskActivity.containsKey(task.talkdesk__Talkdesk_Id__c)){
                        talkdesk__Talkdesk_Activity__c activity = TaskActivity.get(task.talkdesk__Talkdesk_Id__c);
                        task.Talkdesk_Activity__c = activity.Id;
                        TasksUpdate.add(task);
                    }
                    
                }
    
            }

            if(!activities.isEmpty()){ update TasksUpdate;}
        }
    }*/

}