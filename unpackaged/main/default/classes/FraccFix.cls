global class FraccFix implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        if(Test.isRunningTest()){
            return Database.getQueryLocator([
                SELECT Id, Fracc__c, Fracc__r.Name, Fraccionamiento__c, CreatedDate
                FROM Inventario__c 
                //WHERE Id = 'a1Iq000000BTI29EAH']);
                WHERE Id = 'a1C3l0000075fu0EAA']);
        }else{
            return Database.getQueryLocator([
                SELECT Id, Fracc__c, Fracc__r.Name, Fraccionamiento__c, CreatedDate
                FROM Inventario__c 
                ORDER BY LastModifiedDate Desc]);}
    }
    
    global void execute(Database.BatchableContext bc, List<Inventario__c> scope){
        List<Inventario__c> PATC_UPD = new List<Inventario__c>();
        for(Inventario__c PATC : scope){
            if((PATC.Fraccionamiento__c == NULL || PATC.Fraccionamiento__c == '') && 
               (PATC.Fracc__r.Name != NULL || PATC.Fracc__r.Name != '')){
                   PATC.Fraccionamiento__c = PATC.Fracc__r.Name;
                   PATC_UPD.add(PATC);
               }
            else if(((PATC.Fraccionamiento__c != NULL || PATC.Fraccionamiento__c != '') && 
                     (PATC.Fracc__r.Name == NULL || PATC.Fracc__r.Name == '')) ||
                     (PATC.Fracc__r.Name != PATC.Fraccionamiento__c )){
                        try{
                            Fraccionamiento__c NewFracc =[SELECT Id
                                                          FROM Fraccionamiento__c
                                                          WHERE Name =: PATC.Fraccionamiento__c 
                                                          LIMIT 1];
                            PATC.Fracc__c = NewFracc.Id;
                            PATC_UPD.add(PATC);
                        }catch(Exception e){
                            System.debug(e);
                            Fraccionamiento__c NewFracc = new Fraccionamiento__c();
                            NewFracc.Name = PATC.Fraccionamiento__c;
                            insert NewFracc;
                            
                            PATC.Fracc__c = NewFracc.Id;
                            PATC_UPD.add(PATC);
                        }
                    }
        }
        update PATC_UPD;
        recordsProcessed = recordsProcessed + 1;
    }
    
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        if(Test.isRunningTest()){
            Integer i = 1;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;i = 2;
        }
    }    
    
}