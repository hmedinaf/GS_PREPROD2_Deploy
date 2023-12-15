trigger TRIGGER_Oportunidad on Opportunity (before insert, before update, after insert, after update) {
    
        CLASS_Oportunidad classOportunidad = new CLASS_Oportunidad();
        new OpportunityTriggerHandler().run();
        
        Integer campos = 0;
        
        if(Trigger.IsBefore && Trigger.IsInsert){
            List<Pricebook2> stdPBL =  [select id from Pricebook2 where IsStandard = TRUE];
            if(!stdPBL.isEmpty()){
                for(Opportunity o: Trigger.new)
                    o.PriceBook2Id = stdPBL[0].id;
            }
        }
    
    //if(Trigger.isAfter && Trigger.IsUpdate){
    if(Trigger.isAfter){    
        
        //if(checkRecursiveAfter.runOnce()) {
            if(Trigger.IsUpdate){
                List <Opportunity> newList = new List<Opportunity>();
                for (Opportunity o : Trigger.new) {
                    if (o.ValidationBypassDateTime__c < DateTime.Now().addSeconds(-15)) {
                        newList.add(o);
                    }
                }
                if (!newList.isEmpty()) {
                    system.debug('*** Entro a asignaValoresAutomaticosCuenta');
                    classOportunidad.asignaValoresAutomaticosCuenta(newList);
                }
                // classOportunidad.crearCobranzaComercial(Trigger.new,Trigger.oldMap);
               
                CLASS_lookupOppValorPrevio.executeAfter();
            }
        //}
        
        // ::: Flujo para "Pagaré Financiera"
        // CLASS_Oportunidad classOportunidad = new CLASS_Oportunidad();
        // classOportunidad.creaPagaresFinanciera(trigger.oldMap, trigger.new);
    }
        
    //if(Trigger.isBefore && Trigger.IsUpdate){
    if(Trigger.isBefore){    
        
        if(checkRecursive.runOnce()) {
            
            if(Trigger.IsUpdate){
                
                // classOportunidad.validaRepLegal(Trigger.OldMap, Trigger.new);
                // classOportunidad.validaCoAcreditado(trigger.OldMap, trigger.new);
                List <Opportunity> newList = new List<Opportunity>();
                for (Opportunity o : Trigger.new) {
                    if (o.ValidationBypassDateTime__c < DateTime.Now().addSeconds(-15)) {
                        newList.add(o);
                    }
                }
                if (!newList.isEmpty()) {      
                    system.debug('*** Entro a CLASS_lookupOppValorPrevio');          
                    CLASS_lookupOppValorPrevio.executeBefore(newList,Trigger.oldMap);
                }                
            }
            
        }
        
    }
}