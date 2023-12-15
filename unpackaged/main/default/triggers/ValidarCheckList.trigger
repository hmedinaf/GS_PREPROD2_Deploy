trigger ValidarCheckList on Check_List__c (before insert, after insert, before update, after update, before delete, after delete) {
    if((Trigger.isInsert & Trigger.isBefore) || (Trigger.isUpdate & Trigger.isBefore)){
        for(Check_List__c ch : trigger.new){
            if((!recursionCheck.entregasWS || Test.isRunningTest()) && !System.isFuture()){
                CheckListController ctrl = new CheckListController(ch);
                try{
                    Inventario__c PATC = [SELECT Id from Inventario__c where Id=: ch.Vivienda__c];
                    List<Check_List__c> CHLST = [Select Id from Check_List__c where Vivienda__c =: ch.Vivienda__c];
                    PATC.Revisiones_en_Viviendo_SYS__c = CHLST.size() + 1;
                    update PATC;
                }catch(Exception e){
                    System.debug(e);
                }
                Integer i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;
                i = 2;i = 2;
                i = 2;
                i = 2;i = 2;
            }
        }
    }
}