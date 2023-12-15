trigger CPPT_Proveedor on Proveedor__c (before insert, before delete) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
            Map<Id, List<Relacion_Precio_Proveedor__c>> prdMap = new  Map<Id, List<Relacion_Precio_Proveedor__c>>();
            List<Relacion_Precio_Proveedor__c> prd = [SELECT Producto__c,Proveedor__c FROM Relacion_Precio_Proveedor__c WHERE Proveedor__c =:Trigger.oldMap.keyset()];
            if(prd != null && prd.size()>0){
                for(Relacion_Precio_Proveedor__c p : prd){
                    if(!prdMap.containskey(p.Proveedor__c)){
                        prdMap.put(p.Proveedor__c,new List<Relacion_Precio_Proveedor__c> ());
                    }
                    prdMap.get(p.Proveedor__c).add(p);
                }
            }
            for(Proveedor__c pr : Trigger.old){
                if(prdMap.containsKey(pr.Id)){
                    if(prdMap.get(pr.Id) != null && prdMap.get(pr.Id).size()>0){
                        pr.addError('No se puede eliminar un proveedor con productos relacionados');
                    }
                }
            }
        }
    }
}