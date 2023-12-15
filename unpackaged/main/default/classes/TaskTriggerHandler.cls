/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Handler de TaskTrigger
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      25/10/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class TaskTriggerHandler extends TriggerHandler {
    
    private Map<Id, Task> newMap;
    private Map<Id, Task> oldMap;
    private List<Task> newList;
    private List<Task> oldList;
    
    public TaskTriggerHandler() {
        this.newMap = (Map<Id, Task>) trigger.newMap;
        this.oldMap = (Map<Id, Task>) trigger.oldMap;
        this.newList = (List<Task>) trigger.new;
        this.oldList = (List<Task>) trigger.old;
    }
    
    public override void beforeInsert() {
        asignarCuenta();
        asignarTarea();
        //asignarActividad();
        formatCallStartTime();
    }

    public override void afterInsert() {
    }

    public override void beforeUpdate() {
    }

    public override void afterUpdate() {
    }
    
    public override void beforeDelete() {
        validarPerfil();
    }

    public void asignarCuenta(){
        Map<String, Task> TaskPhone = new Map<String, Task>();
        for(Task newTask : newList){
            if(newTask.Telefono__c != null && newTask.Telefono__c != '+'){
                TaskPhone.put(newTask.Telefono__c, newTask);
            }
        }

        List<Account> cuentasGenericas = [SELECT Id FROM Account WHERE Name = 'CUENTA ASIGNACION GENERICA' LIMIT 1];
        List<Agente_Call_Center_Default__mdt> agenteCallCenter = [SELECT Username__c FROM Agente_Call_Center_Default__mdt WHERE Label = 'Default'];
        List<User> defaultUser = new List<User>();

        if(!agenteCallCenter.isEmpty()){
            defaultUser = [SELECT Id FROM User WHERE Username =: agenteCallCenter[0].Username__c];
        }

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
        
          Id  talkdeskRT = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Talkdesk').getRecordTypeId();
        
        for(Task task : TaskPhone.values()){
            if(task.Subject != null && !task.Subject.contains('Email') && task.RecordTypeId == talkdeskRT){
                Account cuenta = mapAccounts.get(task.Telefono__c);
                task.WhatId = cuenta == null ? cuentasGenericas.isEmpty() ? null : cuentasGenericas[0].Id : cuenta.Id;
                task.WhoId = null;
                if(!defaultUser.isEmpty() && cuenta == null && 
                ((String.isNotBlank(task.Id_Agente__c) && task.Id_Agente__c.length() != 18) ||
                String.isBlank(task.Id_Agente__c))){ task.OwnerId = defaultUser[0].Id; }
            }
        }
    }

	public void asignarTarea(){
        try{
            Map<Id, Task> TaskAccount = new Map<Id, Task>();
            for(Task newTask : newList){
                if(newTask.Tipificacion_nivel_2__c == 'Solicita Fecha de Entrega'){
                    TaskAccount.put(newTask.WhatId, newTask);
                }
            }
    
            if(!TaskAccount.isEmpty()){
                List<Visita__c> citas = [SELECT Id, Cuenta__c FROM Visita__c WHERE Cuenta__c IN: TaskAccount.keySet()];
                List<Account> cuentas = [SELECT Id, Programadora_de_Vivienda_Id__c FROM Account WHERE Id IN: TaskAccount.keySet()];
                Map<Id, Account> mapAccounts = new Map<Id, Account>( cuentas );
                if(!citas.isEmpty()){
                    for(Visita__c cita : citas){
                        if(TaskAccount.containsKey(cita.Cuenta__c)){
                            TaskAccount.remove(cita.Cuenta__c);
                        }
                    }
                }
    
                for(Task task : TaskAccount.values()){
                    Account cuenta = mapAccounts.get(task.WhatId);
                    task.OwnerId = cuenta.Programadora_de_Vivienda_Id__c == null ? UserInfo.getUserId() : cuenta.Programadora_de_Vivienda_Id__c;
                }
            }
        }catch(Exception e){
            System.debug(e);

        }
    }
    
    public void validarPerfil(){
        String ProfileId = UserInfo.getProfileId();  
   		List<Profile> profiles = [SELECT Id FROM Profile WHERE Name = 'System Administrator' OR Name = 'Administrador del sistema' OR  Name ='Asesor' OR
                                  Name ='Collaborator' OR  Name ='Prospectator'];
        
        if(!profiles.isEmpty()){
            Map<Id, Profile> mapProfiles = new Map<Id, Profile>( profiles );
            if(!mapProfiles.containsKey(profileId)){
                for(Task oldTask : oldList){
                    oldTask.addError('No se puede eliminar este registro');
                }
            }
            
        }
    }

    /* void asignarActividad(){
        Map<String, Task> TaskActivity = new Map<String, Task>();
        for(Task newTask : newList){
            if(String.isNotBlank(newTask.talkdesk__Talkdesk_Id__c)){
                TaskActivity.put(newTask.talkdesk__Talkdesk_Id__c, newTask);
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
    }*/

    public void formatCallStartTime(){
        for(Task newTask : newList){
            if(String.isNotBlank(newTask.TD_Tiempo_Inicio_de_Llamada__c)){
                Long timestamp = Long.valueOf(newTask.TD_Tiempo_Inicio_de_Llamada__c) * 1000;
                DateTime gmtDatetime = DateTime.newInstance(timestamp);
                System.TimeZone myTz = UserInfo.getTimeZone();
                Integer millisecondOffsetGmt = myTz.getOffset(gmtDateTime);
                DateTime localDatetime = DateTime.newInstance(timeStamp - millisecondOffsetGmt);
                newTask.TD_Tiempo_Inicio_de_Llamada__c = String.valueOfGmt(localDateTime);
            }
        }
    }
    
}