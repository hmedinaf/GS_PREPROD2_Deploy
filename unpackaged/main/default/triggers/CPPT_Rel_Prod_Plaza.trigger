trigger CPPT_Rel_Prod_Plaza on Relacion_Producto_Plaza__c (before insert, before update, after insert, after update) {
    if(Trigger.isBefore){
        Set<Id> plaza = new Set<Id>();   Set<Id> prod = new Set<Id>();
        for(Relacion_Producto_Plaza__c rpf : Trigger.New){
            plaza.add(rpf.Plaza__c);
            prod.add(rpf.Producto__c);
        }
        Map<Id ,Plaza__c> plazaMap = new Map<Id,Plaza__c>([SELECT Name FROM Plaza__c WHERE Id In :plaza]);
        Map<Id ,Product2> prodMap = new Map<Id,Product2>([SELECT Name, Numero_Filtro__c FROM Product2 WHERE Id IN : prod]);
        for(Relacion_Producto_Plaza__c rpf :Trigger.New){
            if(Trigger.isInsert || Trigger.isUpdate){
                if(prodMap.size()>0 && plazaMap.size()>0){
                    rpf.Name = plazaMap.get(rpf.Plaza__c).Name;
                    rpf.Nombre_Filtro__c = plazaMap.get(rpf.Plaza__c).Name;
                    rpf.Producto_Numero_Filtro__c = prodMap.get(rpf.Producto__c).Numero_Filtro__c;
                }
            }
        }
    }
    if(Trigger.isAfter){
        Set<Id> prodSet = new Set<Id>(); Map<Id, List<Relacion_Precio_Proveedor__c>> prodMap = new Map<Id,  List<Relacion_Precio_Proveedor__c>>();
        for(Relacion_Producto_Plaza__c rpf : Trigger.New){
            prodSet.add(rpf.Producto__c);
        }
        List<Relacion_Precio_Proveedor__c> records = [SELECT Id, Producto__c FROM Relacion_Precio_Proveedor__c WHERE Producto__c In : prodSet];
        for(Relacion_Precio_Proveedor__c prov :records){
            if(! prodMap.containsKey(prov.Producto__c)){
                prodMap.put(prov.Producto__c, new  List<Relacion_Precio_Proveedor__c>());
            }
            prodMap.get(prov.Producto__c).add(prov);
        }
        
        Map<Id,Product2> productMap = new Map<Id,Product2>([SELECT Id, Plazas__c FROM Product2 WHERE Id IN : prodSet ]);
        for(Relacion_Producto_Plaza__c rpf : Trigger.New){
            if(Trigger.isInsert || Trigger.isUpdate){
                if(prodMap.containskey(rpf.Producto__c)){
                    if(prodMap.get(rpf.Producto__c).size()>0){
                        productMap.get(rpf.Producto__c).Plazas__c = 'Begin;';
                    }
                    else{
                        rpf.addError('Es necesario un proveedor para actualizar cualquier dato del producto.'); 
                    }
                }
                else{
                    rpf.addError('Es necesario un proveedor para actualizar cualquier dato del producto.'); 
                }
            }
        }
        update productMap.values();
    }  
    
}