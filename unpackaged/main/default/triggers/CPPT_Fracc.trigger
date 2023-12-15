trigger CPPT_Fracc on Fraccionamiento__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            for(Fraccionamiento__c f : Trigger.New){
                f.Plaza_Filtro__c = f.Plaza__c;
            }
        }
        if(Trigger.isUpdate){
            for(Fraccionamiento__c f : Trigger.New){
                f.Plaza_Filtro__c = f.Plaza__c;
            }
        }
    }
}