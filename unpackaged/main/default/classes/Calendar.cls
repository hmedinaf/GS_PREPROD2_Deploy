public class Calendar {
    @AuraEnabled
    public static list<Event> getAllEvents(){
        TimeZone tz = UserInfo.getTimeZone();
        list<Event> eventlist =[Select id,IsAllDayEvent, EndDateTime,StartDateTime,Subject,OwnerId from Event where OwnerId=:Userinfo.getUserId() ORDER BY CreatedDate DESC] ;
        return eventlist;
    }
    @AuraEnabled
    public static Event EditEvents(string currentEventRecordId){
        Event UpdateEvent =  [Select id, EndDateTime,StartDateTime,Subject,OwnerId,Description,WhatId from Event where Id =: currentEventRecordId LIMIT 1];
        return UpdateEvent;
    }
    @AuraEnabled
    public static Task EditTask(string currentTaskRecordId){
          Id redtId = [Select Id,developername, Name from recordtype where developername = 'Tarea'].Id;
        Task UpdateTask =  [SELECT Id,OwnerId, WhoId,ActivityDate,Subject,Status,Who.Name,Description,WhatId, recordtypeId FROM Task  WHERE Id=: currentTaskRecordId  AND recordtypeId = : redtId LIMIT 1];
        return UpdateTask;
    }
    @AuraEnabled
    public static void changeEveTasks(string idTask){
        Task task1  = [select id,status from task where id=:idTask];
        task1.status = 'Completada';
        task1.Solucion__c = 'test';
        update task1;
    }
    @AuraEnabled
    public static wrap fetchEveTasks(Date filterDate){  
        id userId =  UserInfo.getUserId();
        List<Task> tasklist = new List<Task>();    list<Event> eventlist = new list<Event>();
        List<Task>  tasklists = new List<Task>();
        String redtId;
        List<recordtype> rtlist = [Select Id,developername, Name from recordtype where developername = 'Tarea'];
        if(rtlist != null && rtlist.size()>0){
            redtId = rtlist[0].id;
        }
        if(redtId != null && redtId != ''){
            tasklists =  [SELECT Id,OwnerId, WhoId,ActivityDate,Subject,Status,Who.Name FROM Task  WHERE Subject != null AND Subject != '' AND OwnerId=:Userinfo.getUserId() AND recordtypeId = : redtId order by CreatedDate Desc ];
        }
        list<Event> eventlists =[Select id, EndDateTime,StartDateTime,Subject,OwnerId from Event where Subject != null AND Subject != '' AND OwnerId=:Userinfo.getUserId() order by CreatedDate Desc] ;
        Date dToday = Date.today();
        Date dt = Date.newInstance(dToday.year(), dToday.month(),dToday.day());
        if(filterDate != null){
            Date fd = date.newinstance(filterDate.year(), filterDate.month(), filterDate.day());
            if(tasklists != null && tasklists.size()>0){
                for(Task t : tasklists){
                    if(t.ActivityDate == fd){
                        tasklist.add(t); 
                    }
                }
            }
            if(eventlists != null && eventlists.size()>0){
                for(Event ev : eventlists){
                    Date sd = date.newinstance(ev.StartDateTime.year(), ev.StartDateTime.month(), ev.StartDateTime.day());
                    Date ed = date.newinstance(ev.EndDateTime.year(), ev.EndDateTime.month(), ev.EndDateTime.day());
                    if(sd == fd || ed == fd ||(sd <fd && fd < ed) ){ 
                        eventlist.add(ev); 
                    }
                }
            }
        }
        else{
            if(tasklists != null && tasklists.size()>0){
                for(Task t : tasklists){
                    if(t.ActivityDate ==dt){
                        tasklist.add(t); 
                    }
                }
            }
            if(eventlists != null && eventlists.size()>0){
                for(Event ev : eventlists){
                    Date sd = date.newinstance(ev.StartDateTime.year(), ev.StartDateTime.month(), ev.StartDateTime.day());
                    Date ed = date.newinstance(ev.EndDateTime.year(), ev.EndDateTime.month(), ev.EndDateTime.day());
                    if(sd == dt){
                        eventlist.add(ev); 
                    }
                }
            }
        } 
        User currntUser = [Select Id, Name from User where Id = : Userinfo.getUserId()];
        List<String> statustype = new List<String>();   List<String> subtype = new List<String>();  List<String> Eventsubtype = new List<String>();
        wrap wr  = new wrap();
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Task');
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('Status').getDescribe();
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues) {
            statustype.add(plv.getValue());
        }
        Schema.DescribeFieldResult objFieldInfo1 = objDescribe.fields.getMap().get('Subject').getDescribe();
        List<Schema.PicklistEntry> picklistvalues1 = objFieldInfo1.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues1) {
            subtype.add(plv.getValue());
        }        
        Schema.SObjectType objType1 = Schema.getGlobalDescribe().get('Event');
        Schema.DescribeSObjectResult objDescribe1 = objType1.getDescribe();
        Schema.DescribeFieldResult objFieldInfo2 = objDescribe1.fields.getMap().get('Subject').getDescribe();
        List<Schema.PicklistEntry> picklistvalues2 = objFieldInfo2.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues2) {
            Eventsubtype.add(plv.getValue());
        }
        wr.Taskslist = tasklist;
        wr.eventslist = eventlist;
        wr.statusList = statustype;
        wr.subList = subtype;
        wr.eventsubList = Eventsubtype;
        wr.user = currntUser;
        return wr;
    }
    @AuraEnabled
    public static string saveEvents(String Subject,DateTime StartTime,DateTime EndTime, String Description){  
        string message = '';
        try {
            Event ev = new Event();
            ev.OwnerId = Userinfo.getUserId();
            ev.EndDateTime = EndTime;
            ev.StartDateTime = StartTime;
            ev.Subject = Subject;
            ev.Description = Description;
            insert ev;
            message = 'Evento Creado';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =   e.getDmlMessage(0);
            return message;
        }
    }
    @AuraEnabled
    public static String updateEvents(String Subject,DateTime StartTime,DateTime EndTime, String Description, string currentEventRecordId){ 
        string message = '';
        try {
            Event ev = new Event();
            ev.Id=currentEventRecordId;
            ev.EndDateTime = EndTime;
            ev.StartDateTime = StartTime;
            ev.Subject = Subject;
            ev.Description = Description;
            update ev;
            message = 'Evento Actualizado';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    } 
    @AuraEnabled 
    public static String saveTasks(String Subject,Date Dates,String Status, String Description){ 
         Id redtId = [Select Id,developername, Name from recordtype where developername = 'Tarea'].Id;
        string message = '';
        try {
            Task t = new Task();
            t.OwnerId = Userinfo.getUserId();
            t.ActivityDate = Dates;
            t.Subject = Subject;
            t.Status =Status;
            t.Description = Description;
            t.Origen__c = 'Portal Web';
            t.RecordTypeId = redtId;
            if(t.status == 'Completada'){
                t.Solucion__c = 'test';
            }
            insert t;
            message = 'Tarea Creada';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    } 
    @AuraEnabled 
    public static String updateTask(String Subject,Date Dates,String Status, String Description, string UpadtedTaskId){ 
        string message = '';
        try {
            Task t = new Task();
            t.Id = UpadtedTaskId;
            t.ActivityDate = Dates;
            t.Subject = Subject;
            t.Status =Status;
            t.Description = Description;
            if(t.status == 'Completada'){
                t.Solucion__c = 'test';
            }
            Update t;
            message = 'Tarea Actualizada';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    }
    @AuraEnabled 
    public static String deletetaskRecord(String taskid){
        string message = '';
        try {
            Task task =  [SELECT Id,OwnerId, WhoId,ActivityDate,Subject,Status,Who.Name,Description,WhatId FROM Task  WHERE Id=: taskid];
            delete task; 
            message = 'Tarea Eliminada';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    }
    @AuraEnabled 
    public static String deleteEventRecord(String eventId){
        string message = '';
        try {
            Event ev =  [Select id, EndDateTime,StartDateTime,Subject,OwnerId,Description,WhatId from Event where Id =: eventId ];
            delete ev;
            message = 'Evento Eliminado';
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    }
    public class wrap{
        @AuraEnabled public List<String> statusList ;	
        @AuraEnabled public List<String> subList ;	
        @AuraEnabled public List<String> eventsubList ; 
        @AuraEnabled public List<Task> Taskslist;
        @AuraEnabled public List<Event> eventslist;
        @AuraEnabled public User  user;
    }
}