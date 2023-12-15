trigger CPPT_Viviendas on Vivienda__c (before insert, after insert, before update) {
if(Trigger.isAfter){
        if(Trigger.isInsert){
            for(Vivienda__c vv : Trigger.New){
                Id viviendaTR = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Vivienda').getRecordTypeId();
                               
                Product2 prodVivienda = new Product2();
                
                prodVivienda.Name = vv.Name;
                prodVivienda.Description = 'Producto Vivienda';
                prodVivienda.Precio_Venta__c = vv.Precio_Unitario__c;
                prodVivienda.RecordTypeId = viviendaTR;
                prodVivienda.Vivienda__c = vv.Id;
                
                insert prodVivienda;
             
                Id idProveedor = [SELECT Id, Name FROM Proveedor__c WHERE Name = 'PROVEEDOR JAVER' LIMIT 1].Id;
                Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c();
                //prov.Name = 'Nuevo';
                prov.Producto__c = prodVivienda.Id;
                prov.Proveedor__c = idProveedor;
                
                insert prov;
                
                String PlazaVivienda = [SELECT Id, Name, Estado_fracc__c FROM Fraccionamiento__c WHERE Id =: vv.Fraccionamiento__c LIMIT 1].Estado_fracc__c;
                Id idPlazaVivienda = [SELECt Id, Name FROM Plaza__c WHERE Name =: PlazaVivienda LIMIT 1].Id;
                
                Relacion_Producto_Plaza__c rpp = new Relacion_Producto_Plaza__c();
                rpp.Producto__c = prodVivienda.Id;
                rpp.Plaza__c = idPlazaVivienda;
                rpp.Name = 'Nuevo';
                
                insert rpp;
                
                
                Relacion_Producto_Fraccionamiento__c rpf = new Relacion_Producto_Fraccionamiento__c();
                rpf.Producto__c = prodVivienda.Id;
                rpf.Fraccionamiento__c = vv.Fraccionamiento__c;
                rpf.Relacion_Producto_Plaza_Fraccionamiento__c = rpp.Id;
                rpf.Name = 'Nuevo';
                
                insert rpf;
                
            }
                
        }
        if(Trigger.isUpdate){
            for(Vivienda__c vv : Trigger.New){
                if(trigger.oldMap.get(vv.Id).Precio_Unitario__c != vv.Precio_Unitario__c){
                    vv.Check_Precio_Unitario__c = true;
                }
            }
        }
    }
    if(Trigger.isBefore){
        
    }
    
}