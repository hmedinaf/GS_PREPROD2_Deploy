trigger CPPT_Rel_Prod_Prov on Relacion_Precio_Proveedor__c (before insert, before update, after insert, after update) {
    if(Trigger.isBefore){
        Set<Id> rf = new Set<Id>();
        for(Relacion_Precio_Proveedor__c rpf : Trigger.New){
            if(rpf.Proveedor__c != null){
                rf.add(rpf.Proveedor__c);
            }
        }
        Map<Id ,Proveedor__c> provMap = new Map<Id,Proveedor__c>([SELECT Name FROM Proveedor__c WHERE Id IN :rf]);
        
        for(Relacion_Precio_Proveedor__c rpf :Trigger.New){
            if(provMap.containskey(rpf.Proveedor__c)){
                if(Trigger.isInsert || Trigger.isUpdate){
                    rpf.Name__c = provMap.get(rpf.Proveedor__c).Name;
                }
            }
        }
        
    }
}