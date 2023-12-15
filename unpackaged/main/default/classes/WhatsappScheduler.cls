global class WhatsappScheduler implements Schedulable  {
    global void execute(SchedulableContext ctx) {
        Map<Id, List<WhatsApp__c>>prospectMap =  new Map<Id, List<WhatsApp__c>>();   Map<String, List<Attachment>>  attchMap =  new Map<String, List<Attachment>>();
        List<WhatsApp__c>updateList=  new List<WhatsApp__c>();                       List<WhatsApp__c>  deleteList=  new List<WhatsApp__c>();
        List<Attachment> attlist = new List<Attachment>();                           Set<Id> wtId = new Set<Id>();
        
        List<WhatsApp__c> wtApplist = [Select Id, Message__c, Prospect__c, createdDate from WhatsApp__c Where Prospect__c != null ];
        for(WhatsApp__c wp : wtApplist){
            wtId.add(wp.Id);
            if(!prospectMap.containsKey(wp.Prospect__c)){
                prospectMap.put(wp.Prospect__c, new List<WhatsApp__c>());
            }
            prospectMap.get(wp.Prospect__c).add(wp); 
        }
       List<Attachment> attachist = [select id, name, CreatedDate , Body,ContentType,ParentId,Description from Attachment Where ParentId IN : wtId];
        for(Attachment at : attachist){
            if(!attchMap.containsKey(at.ParentId)){
                attchMap.put(at.ParentId,  new List<Attachment>());
            }
            attchMap.get(at.ParentId).add(at);
        } 
        for(List<WhatsApp__c> wplist : prospectMap.values()){
            for(Integer i= 0; i<wplist.size()-1; i++){
                DateTime myDateTime = wplist[i].createdDate;  Date myDate = myDateTime.date();  Integer myMinute = myDateTime.minute();
                DateTime myDateTime1 = wplist[i+1].createdDate;  Date myDate1 = myDateTime1.date();  Integer myMinute1 = myDateTime1.minute();
                if(myDate == myDate1 && myMinute == myMinute1){
                    if(wplist[i+1].message__c != ''){
                        wplist[i].Message__c =  wplist[i+1].Message__c+ ' '+wplist[i].Message__c;
                    }
                    if(attchMap != null && attchMap.size()>0){
                        List<Attachment> atlist =  attchMap.get(wplist[i+1].Id);
                        if(atlist != null && atlist.size()>0){
                            for(Attachment att : atlist){
                                Attachment at = new Attachment();
                                at.ParentId = wplist[i].Id;
                                at.Body = att.body;
                                at.ContentType = att.ContentType;
                                at.Description = att.Description;
                                at.Name = att.Name;
                                at.isprivate = false;
                                attlist.add(at);
                            }
                        }
                    } 
                    updateList.add(wplist[i]);
                    deleteList.add( wplist[i+1]);
                }
            }
        } 
        system.debug('attlist'+attlist);  system.debug('deleteList'+deleteList);
        if(updateList != null && updateList.size()>0){
            update updateList ;
        }
        if(attlist != null && attlist.size()>0){
            insert attlist ;
        }
        if(deleteList != null && deleteList.size()>0){
            delete deleteList ;
        }
    }
}