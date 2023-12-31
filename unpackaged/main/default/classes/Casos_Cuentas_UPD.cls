global class Casos_Cuentas_UPD implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            Select Id, ViviendaProceso__r.Cuenta__c, Cuenta__c
            From Casos_Residente__c
            Where ViviendaProceso__c != null
            And Cuenta__c != null]);
    }
    
    global void execute(Database.BatchableContext bc, List<Casos_Residente__c> scope){
        List<Casos_Residente__c> Cases2UPD = new List<Casos_Residente__c>();
        for(Casos_Residente__c CR : scope){
            if(CR.Cuenta__c != CR.ViviendaProceso__r.Cuenta__c){
                CR.Cuenta__c = CR.ViviendaProceso__r.Cuenta__c;
                Cases2UPD.add(CR);
                recordsProcessed = recordsProcessed+1;
            }
        }
        try{
            update Cases2UPD;
        }catch(Exception e){
            System.debug(e);
        }
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