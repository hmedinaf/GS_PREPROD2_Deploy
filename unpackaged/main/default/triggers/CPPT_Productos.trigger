trigger CPPT_Productos on Product2 (before insert, after insert, before update, after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            List<Product2> pdlist =  [SELECT Numero_Filtro__c FROM Product2 ORDER BY CreatedDate DESC LIMIT 1];
            for(Product2 prd : Trigger.New){
                //Se valida el tipo de producto para asignar valor "OFICIAL" cuando el tipo sea 'Casa Muestra', 'Complementos' o 'Otros Gastos'
                Decimal numeroConsecutivo = 0;
                if(pdlist != null && pdlist.size()>0){
                    numeroConsecutivo =  pdlist[0].Numero_Filtro__c;
                }
                if(prd.Tipo_de_Producto__c == 'Casa Muestra' || prd.Tipo_de_Producto__c == 'Complementos' || prd.Tipo_de_Producto__c == 'Otros Gastos'){
                    if(prd.Marca__c != 'OFICIAL'){
                        prd.addError('La marca para este tipo de producto, debe ser "OFICIAL"');
                    }
                }
                prd.isActive = prd.Activo__c;
                if(prd.Nuevo__c && !prd.Clonado__c){
                    prd.Producto_Original__c = prd.Name;
                }
                String recordtypename = Schema.SObjectType.Product2.getRecordTypeInfosById().get(prd.RecordTypeId).getname();
                prd.Family = recordtypename;
                prd.Numero_Filtro__c = numeroConsecutivo + 1;
                prd.ProductCode = prd.Codigo_de_Producto__c;
            }
        }
        if(Trigger.isUpdate){
            Map<String, String> fracMap = new Map<String, String>();
            Map<String, String> fracMap1 = new Map<String, String>();
            
            Map<String, String> plazaMap = new Map<String, String>();
            Map<String, String> plazaMap1 = new Map<String, String>();
            Map<String, List<Relacion_Precio_Proveedor__c>> provMap = new Map<String, List<Relacion_Precio_Proveedor__c>>();
            
            List<Relacion_Producto_Fraccionamiento__c> rsFracc = [SELECT Id, Name, Producto__c,Vigencia_Hasta__c, Sin_vigencia__c, Vencido__c FROM Relacion_Producto_Fraccionamiento__c WHERE Producto__c In : Trigger.newMap.keySet()];
            for(Relacion_Producto_Fraccionamiento__c rf : rsFracc){
                if(rf.Vencido__c){
                    if(!fracMap.containsKey(rf.Producto__c)){
                        fracMap.put(rf.Producto__c, rf.Name);
                    }
                    else{
                        fracMap.put(rf.Producto__c, fracMap.get(rf.Producto__c)+';'+rf.Name);
                    }
                }
                else{
                    if(!fracMap1.containsKey(rf.Producto__c)){
                        fracMap1.put(rf.Producto__c, rf.Name);
                    }
                    else{
                        fracMap1.put(rf.Producto__c, fracMap1.get(rf.Producto__c)+';'+rf.Name);
                    }
                }
            }
            
            List<Relacion_Producto_Plaza__c> rsPlazas = [SELECT Id, Name,Producto__c, Tiene_Fraccionamiento__c FROM Relacion_Producto_Plaza__c WHERE Producto__c In: Trigger.newMap.KeySet()];
            for(Relacion_Producto_Plaza__c plaz : rsPlazas){
                if( plaz.Name != null){
                    if(plaz.Tiene_Fraccionamiento__c == true){
                        if(!plazaMap.containsKey(plaz.Producto__c)){
                            plazaMap.put(plaz.Producto__c, plaz.Name);
                        }
                        else{
                            plazaMap.put(plaz.Producto__c, plazaMap.get(plaz.Producto__c)+';'+plaz.Name);
                        }
                    }
                    else{
                        if(!plazaMap1.containsKey(plaz.Producto__c)){
                            plazaMap1.put(plaz.Producto__c, plaz.Name);
                        }
                        else{
                            plazaMap1.put(plaz.Producto__c, plazaMap1.get(plaz.Producto__c)+';'+plaz.Name);
                        }
                    }
                } 
            }
            List<Relacion_Precio_Proveedor__c> records = [SELECT Id, Producto__c FROM Relacion_Precio_Proveedor__c WHERE Producto__c In : Trigger.newMap.keySet()];
            if(records != null && records.size()>0){
                for(Relacion_Precio_Proveedor__c rrpv : records){
                    if(!provMap.containsKey(rrpv.Producto__c)){
                        provMap.put(rrpv.Producto__c, new list<Relacion_Precio_Proveedor__c>());
                    }
                    provMap.get(rrpv.Producto__c).add(rrpv);
                }
            }
            for(Product2 prd : Trigger.New){
                String recordtypename = Schema.SObjectType.Product2.getRecordTypeInfosById().get(prd.RecordTypeId).getname();
                prd.ProductCode = prd.Codigo_de_Producto__c;
                if(prd.Activo__c){
                    prd.isActive = true;
                }
                else{
                    prd.isActive = false;
                }
                String fraccs; String fraccsVencidos;     String fechas;   String plazasCF;   String plazasSF;
                if(fracMap.containsKey(prd.Id)){
                    fraccsVencidos = fracMap.get(prd.id);
                    if(recordtypename != 'Productos Genéricos'){
                         Integer maxSize = 255;
                        if(fraccsVencidos.length() > maxSize ){
                            fraccsVencidos = fraccsVencidos.substring(0, maxSize);
                        }

                        prd.Fraccionamientos_Vencidos__c = fraccsVencidos;
                    }
                }
                else{
                    fraccsVencidos = 'N/A';
                }
                if(fracMap1.containsKey(prd.Id)){
                    fraccs = fracMap1.get(prd.id);
                    if(recordtypename != 'Productos Genéricos'){
                        Integer maxSize = 255;
                        if(fraccs.length() > maxSize ){
                            fraccs = fraccs.substring(0, maxSize);
                        }
                        prd.Fraccionamientos__c = fraccs;
                        system.debug('prd'+ prd.Fraccionamientos__c);
                    }
                }
                else{
                    fraccs = 'N/A';
                }
                if(plazaMap.containsKey(prd.Id)){
                    plazasCF = plazaMap.get(prd.id);
                    if(recordtypename != 'Productos Genéricos'){
                        prd.Plazas__c = plazasCF;
                    }
                }
                if(plazaMap1.containsKey(prd.Id)){
                    plazasSF = plazaMap1.get(prd.id);
                    if(recordtypename != 'Productos Genéricos'){
                        prd.Plazas_Sin_Fracc__c = plazasSF;
                    }
                }
                if(prd.Tipo_de_Producto__c == 'Casa Muestra' || prd.Tipo_de_Producto__c == 'Complementos' || prd.Tipo_de_Producto__c == 'Otros Gastos'){
                    if(prd.Marca__c != 'OFICIAL'){
                        prd.addError('La marca para este tipo de producto, debe ser "OFICIAL"');
                    }
                }
                else{
                    if(!provMap.containsKey(prd.Id)){
                        prd.addError('Es necesario un proveedor para actualizar cualquier dato del producto.'); 
                    }
                } 
            }
            
            
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            List<PriceBook2> priceBooks = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book' ORDER BY IsStandard DESC]; 
            List<PricebookEntry> pbeList = new List<PricebookEntry>();
            List<Relacion_Precio_Proveedor__c> proveedoresAsignar = new List<Relacion_Precio_Proveedor__c>();
            List<Relacion_Producto_Plaza__c> plazasAsignar = new List<Relacion_Producto_Plaza__c>();
            List<Relacion_Producto_Fraccionamiento__c> fraccionamientosAsignar = new List<Relacion_Producto_Fraccionamiento__c>();
            Set<String> pName =  new Set<String>();  
            Set<String> codigoProd =  new Set<String>();
            Set<Id> idFraccionamientos = new Set<Id>();
            Map<String,   List<Relacion_Precio_Proveedor__c> > provMap = new Map<String ,   List<Relacion_Precio_Proveedor__c> >();
            Map<String,   List<Relacion_Producto_Plaza__c> > plazaMap = new Map<String ,   List<Relacion_Producto_Plaza__c> >();
            Map<String, Id> mapaPlazasAsignadas = new Map<String,Id>();
            Map<String,  List<Relacion_Producto_Fraccionamiento__c>> fracMap = new Map<String,List<Relacion_Producto_Fraccionamiento__c>>();
            for(Product2 p:  Trigger.New){
                pName.add(p.Producto_Original__c); 
                codigoProd.add(p.Codigo_Producto_Original__c);
            }
            List<Relacion_Precio_Proveedor__c> rsProveedores = [SELECT Id,Producto__r.Name, Producto__r.Codigo_de_Producto__c,Producto__r.Codigo_Producto_Original__c,Proveedor__c FROM Relacion_Precio_Proveedor__c WHERE Producto__r.Name In :pName AND Producto__r.Codigo_Producto_Original__c In : codigoProd ];
            if(rsProveedores.size() > 0){                    
                for(Relacion_Precio_Proveedor__c idProv: rsProveedores){
                    if(!provMap.containsKey(idProv.Producto__r.Name+'-'+idProv.Producto__r.Codigo_de_Producto__c)){
                        provMap.put(idProv.Producto__r.Name+'-'+idProv.Producto__r.Codigo_de_Producto__c, new List<Relacion_Precio_Proveedor__c>());
                    }
                    provMap.get(idProv.Producto__r.Name+'-'+idProv.Producto__r.Codigo_de_Producto__c).add(idProv); 
                }
            }  
            List<Relacion_Producto_Plaza__c> rsPlazas = [SELECT Id,Name,Producto__r.Name, Plaza__c, Producto__r.Codigo_de_Producto__c,Plaza__r.Name FROM Relacion_Producto_Plaza__c WHERE Producto__r.Name In : pName AND Producto__r.Codigo_Producto_Original__c In : codigoProd];
            for(Relacion_Producto_Plaza__c rpf : rsPlazas){
                idFraccionamientos.add(rpf.Id);
                if(!plazaMap.containsKey(rpf.Producto__r.Name+'-'+rpf.Producto__r.Codigo_de_Producto__c)){
                    plazaMap.put(rpf.Producto__r.Name+'-'+rpf.Producto__r.Codigo_de_Producto__c, new List<Relacion_Producto_Plaza__c>());
                }
                plazaMap.get(rpf.Producto__r.Name+'-'+rpf.Producto__r.Codigo_de_Producto__c).add(rpf); 
            }
            List<Relacion_Producto_Fraccionamiento__c> rsFraccionamientos = [SELECT Id, Name,Producto__c, Vigencia_Hasta__c, Fraccionamiento__c, Fraccionamiento__r.Estado_fracc__c, Relacion_Producto_Plaza_Fraccionamiento__c FROM Relacion_Producto_Fraccionamiento__c WHERE Relacion_Producto_Plaza_Fraccionamiento__c IN: idFraccionamientos];
            if(rsFraccionamientos.size() > 0){                    
                for(Relacion_Producto_Fraccionamiento__c idProv: rsFraccionamientos){
                    if(!fracMap.containsKey(idProv.Producto__c)){
                        fracMap.put(idProv.Producto__c, new List<Relacion_Producto_Fraccionamiento__c>());
                    }
                    fracMap.get(idProv.Producto__c).add(idProv); 
                }
            }  
            for(Product2 p:  Trigger.New){
                for (PriceBook2 priceBook : priceBooks) {
                    pbeList.add(new PricebookEntry( UnitPrice = p.Precio_Venta__c,  Pricebook2Id = priceBook.Id,  product2Id = p.Id,  UseStandardPrice = false,   isActive = true));
                }
                if(provMap.containsKey(p.Name+'-'+p.Codigo_de_Producto__c)){                    
                    for(Relacion_Precio_Proveedor__c idProv:  provMap.get(p.Name+'-'+p.Codigo_de_Producto__c)){
                        Relacion_Precio_Proveedor__c newProv = New Relacion_Precio_Proveedor__c();
                        newProv.Proveedor__c =   idProv.Proveedor__c;
                        newProv.Producto__c = p.Id;
                        proveedoresAsignar.add(newProv);
                    }
                    for(Relacion_Producto_Plaza__c idPlaza: plazaMap.get(p.Name+'-'+p.Codigo_de_Producto__c)){
                        Relacion_Producto_Plaza__c newPlaza = New Relacion_Producto_Plaza__c();
                        newPlaza.Name__c = idPlaza.Plaza__r.Name;
                        newPlaza.Name = idPlaza.Plaza__r.Name;
                        newPlaza.Plaza__c = idPlaza.Plaza__c;
                        newPlaza.Producto__c = p.Id;
                        plazasAsignar.add(newPlaza);
                    }
                }
                
            }
            upsert pbeList;
            insert proveedoresAsignar;
            insert plazasAsignar; 
            for(Relacion_Producto_Plaza__c pa : plazasAsignar){
                mapaPlazasAsignadas.put(pa.Name, pa.Id);
            }
            for(Product2 p:  Trigger.New){
                if(fracMap.containsKey(p.Id)){
                    if(fracMap.get(p.id).size()>0){
                        for(Relacion_Producto_Fraccionamiento__c idFracc: fracMap.get(p.id)){
                            Relacion_Producto_Fraccionamiento__c newFrac = New Relacion_Producto_Fraccionamiento__c();
                            newFrac.Relacion_Producto_Plaza_Fraccionamiento__c = mapaPlazasAsignadas.get(idFracc.Fraccionamiento__r.Estado_fracc__c);
                            newFrac.Fraccionamiento__c = idFracc.Fraccionamiento__c;
                            newFrac.Producto__c = p.Id;
                            newFrac.Vigencia_Hasta__c = idFracc.Vigencia_Hasta__c;
                            fraccionamientosAsignar.add(newFrac);
                        }
                    }
                }
            }
            insert fraccionamientosAsignar;
            
        }
        if(Trigger.isUpdate){
            Map<String,  List<PricebookEntry>> pbmap = new   Map<String,    List<PricebookEntry>>();
            List<PricebookEntry> elpToUpdate = New List<PricebookEntry>();
            List<PricebookEntry> rsElp = [SELECT Id, Product2Id FROM PricebookEntry WHERE Product2Id In : Trigger.newMap.KeySet() ORDER BY CreatedDate DESC];
            for(PricebookEntry pb: rsElp){
                if(!pbmap.containsKey(pb.Product2Id)){
                    pbmap.put(pb.Product2Id, new List<PricebookEntry>());
                }
                pbmap.get(pb.Product2Id).add(pb);
            }
            for(Product2 p:  Trigger.New){                
                if(trigger.oldMap.get(p.Id).Precio_Venta__c != p.Precio_Venta__c){
                    for(PricebookEntry pbe : pbmap.get(p.Id)){
                        pbe.UnitPrice = p.Precio_Venta__c;
                        elpToUpdate.add(pbe);
                    }
                }
            }
            update elpToUpdate;
        }
    }
    
}