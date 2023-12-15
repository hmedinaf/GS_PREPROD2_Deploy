trigger TRIGGER_Plan_Venta on Plan_de_Venta__c (before insert, before update, after insert, after update) {
    
    // CLASS_Plan_Venta triggerClass = new CLASS_Plan_Venta();
    
    if(Trigger.IsBefore && Trigger.IsInsert){
       //triggerClass.validaCoaCreditados(Trigger.new);  // Esta estaba comentada desde antes
    }
    
    if(Trigger.IsBefore && Trigger.IsUpdate){
        // HMF Comentado el 6/19/23. Esta validacion está pegandole al flow ** REVISAR **
        //  triggerClass.validaCoaCreditadosUp(Trigger.OldMap, Trigger.new);

        list <Plan_de_Venta__c> newList = new List<Plan_de_Venta__c>();
        for (Plan_de_Venta__c p : Trigger.New) {
            if (p.FlowOverride__c.addSeconds(20)  < DateTime.Now()) {
                newList.add(p);
            }
        }
        CLASS_Plan_Venta.Aprobar_Plan_Venta(newList, Trigger.OldMap); 

        CLASS_Plan_Venta.validaRepLegal(Trigger.OldMap, newList);
        
    }

    if (Trigger.IsAfter) {
        List <Plan_de_Venta__c> newList = new List <Plan_de_Venta__c>();
        for (Plan_de_Venta__c p : trigger.new) {
            if (p.Calc_Precios_Bypass__c==null || p.Calc_Precios_Bypass__c.addSeconds(20) < DateTime.Now()) {
                newList.add(p);
            }
        }
        if (!newList.isEmpty()) {
            CLASS_Plan_Venta.CLASS_Calc_Precios(newList);
        }
    }
}