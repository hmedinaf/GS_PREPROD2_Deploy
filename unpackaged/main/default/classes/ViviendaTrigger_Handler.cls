public class ViviendaTrigger_Handler {
    public static void inVivienda(List<Vivienda__c> newVivienda){
        string PROVEEDOR_JAVER = system.label.PROVEEDOR_JAVER;
        list<Product2> prods = new list<Product2>();            
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        list<Relacion_Precio_Proveedor__c>provList = new list<Relacion_Precio_Proveedor__c>();
        list<Relacion_Producto_Plaza__c> rppList = new list<Relacion_Producto_Plaza__c>();
        list<Relacion_Producto_Fraccionamiento__c> rpfList = new list<Relacion_Producto_Fraccionamiento__c>();
        Map<String, Id> plazaMap = new Map<String, Id>();
        Map<Id, Fraccionamiento__c> fraccionamientoEstadoMap = new Map<Id, Fraccionamiento__c>();
        Map<String, List<Pricebook2>> pbMap= new Map<String, List<Pricebook2>>();
        Map<Integer,PricebookEntry> prodMap = new Map<Integer,PricebookEntry>();
        Map<Integer,Product2> prodMap1 = new Map<Integer,Product2>();
        Map<String, Id> rPlazaMap = new Map<String,Id>();
        list<string>Estados = new list<string>();  set<id>fracViv = new set<id>(); set<id>ProtoViv = new set<id>();
        
        Id viviendaTR = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Vivienda').getRecordTypeId();
        // Llenar Sets fracViv y ProtoViv (Fraccionamientos y Prototipos Unicos)
        for(Vivienda__c vv : newVivienda){
            if(vv.Fraccionamiento__c != null){
                fracViv.add(vv.Fraccionamiento__c);  
            }
            if(vv.Prototipo__c != null){
                ProtoViv.add(vv.Prototipo__c);
            }
        }
        
        // Crea mapa de Fraccionamientos Estado
        List<Fraccionamiento__c>  fracc = [SELECT Id, Estado_fracc__c , (Select Id, name from Viviendas__r) FROM Fraccionamiento__c WHERE Id IN :fracViv];
        if(fracc != null && fracc.size()>0){
            for(Fraccionamiento__c f : fracc){
                Estados.add(f.Estado_fracc__c);
                if(f.Viviendas__r != null && f.Viviendas__r.size()>0){
                    for(Vivienda__c v :f.Viviendas__r ){
                        fraccionamientoEstadoMap.put(v.id,f);
                    }
                }
            }
        }
        // obtiene los pricebooks de fraccionamiento/prototipo
        Map<Id, Pricebook2> pricebookMap =  new Map<Id, Pricebook2>([select id, name,Fraccionamiento__r.Estado_fracc__c, Fraccionamiento__c, Prototipo__c, Vigente_Desde__c,Vigente_Hasta__c, IsActive, Precio_superficie_excedente__c from PriceBook2
                                                                     where Fraccionamiento__c IN :fracViv AND Prototipo__c IN :ProtoViv AND IsActive = true 
                                                                     AND Vigente_Desde__c <= : Date.today() AND Vigente_Hasta__c >= : Date.today() 
                                                                     AND Tipo_Lista__c = 'Vivienda']);
        system.debug('pricebookMap'+pricebookMap);
        if(pricebookMap != null && pricebookMap.size()>0){
            for(Pricebook2 pb : pricebookMap.values()){
                if(!pbMap.containsKey(pb.Fraccionamiento__c+'_' +pb.Prototipo__c)){
                    pbMap.put(pb.Fraccionamiento__c+'_' +pb.Prototipo__c, new List<Pricebook2>() );
                }
                pbMap.get(pb.Fraccionamiento__c+'_' +pb.Prototipo__c).add(pb);
            }
        }
        List<PriceBook2> priceBooks = [SELECT Id FROM Pricebook2 WHERE Name = 'Standard Price Book' ORDER BY IsStandard DESC]; 
        Integer count = 1;
        for(Vivienda__c vv : newVivienda){
            Product2 prodVivienda = new Product2();
            prodVivienda.Name = vv.Name;
            prodVivienda.Description = 'Producto Vivienda';
            prodVivienda.Precio_Venta__c = vv.Precio_Total__c; //HMF 7/25 ERA: vv.Precio_Unitario__c;
            prodVivienda.RecordTypeId = viviendaTR;
            prodVivienda.Vivienda__c = vv.Id;
            prodVivienda.Activo__c = true;
            prodVivienda.IsActive = true; 
          //  prodVivienda.Marca__c = 'OFICIAL';
           // prodVivienda.Tipo_de_Producto__c   =   'Casa Muestra';
            prods.add(prodVivienda);
            prodMap1.put(count, prodVivienda);
            
            // Relaciona pricebook al pricebook de la vivienda
            PricebookEntry pbe = new PricebookEntry();
            if(pbMap != null && pbMap.size()>0){
                pbe.Pricebook2Id = pbMap.get(vv.Fraccionamiento__c+'_'+vv.Prototipo__c)[0].id;
            }
            pbe.UnitPrice = vv.Precio_Unitario__c;
            // Cálculo de Total M2 Excedentes se guarda en Pricebook
            try {
                if (vv.Superficie_Excedente__c != null && pbMap.get(vv.Fraccionamiento__c+'_'+vv.Prototipo__c)[0].Precio_superficie_excedente__c != null) {
                    pbe.Total_M2_Excedentes__c = vv.Superficie_Excedente__c * pbMap.get(vv.Fraccionamiento__c+'_'+vv.Prototipo__c)[0].Precio_superficie_excedente__c;
                }
            } catch (Exception e) {
                pbe.Total_M2_Excedentes__c = 0;
            }
            pbe.IsActive = true;
            pbe.UseStandardPrice = false;
            // if (pbe.Pricebook2Id != null) {
                // Solo agregarlo a PricebookEntry si tiene Pricebook2Id
                pbeList.add(pbe); 
                prodMap.put(count, pbe);
                count++;    
            // }
        }
        system.debug('prodMap1'+prodMap1.values()[0]);
        Database.insert(prodMap1.values()) ;
        String idProveedor ;
        list<Plaza__c> PlazaViviendas = [SELECt Id, Name FROM Plaza__c WHERE Name IN: Estados];
        if(PlazaViviendas != null && PlazaViviendas.size()>0){
            for (Plaza__c plaza : plazaViviendas) {
                plazaMap.put(plaza.Name, plaza.Id);
            }
        }
        List<Proveedor__c> proveedorlist = [SELECT Id, Name FROM Proveedor__c WHERE Name =: PROVEEDOR_JAVER LIMIT 1];
        if(proveedorlist != null && proveedorlist.size()>0){
            idProveedor = proveedorlist[0].Id;
        }
        if(prodMap1.values() != null && prodMap1.values().size()>0){
            for(Product2 p : prodMap1.values()){
                Relacion_Precio_Proveedor__c prov = new Relacion_Precio_Proveedor__c();
                prov.Producto__c = p.Id;
                prov.Proveedor__c = idProveedor;
                provList.add(prov);
                if(PlazaViviendas != null && PlazaViviendas.size()>0){
                    for(Plaza__c plaza : PlazaViviendas){
                        if(plazaMap.containsKey(fraccionamientoEstadoMap.get(p.Vivienda__c).Estado_fracc__c)){
                            Relacion_Producto_Plaza__c rpp = new Relacion_Producto_Plaza__c();
                            rpp.Producto__c = p.Id;
                            rpp.Plaza__c = plazaMap.get(fraccionamientoEstadoMap.get(p.Vivienda__c).Estado_fracc__c);
                            rpp.Name = 'Nuevo';
                            rppList.add(rpp);
                        }
                    }
                }
            }
        }
        if(provList != null && provList.size()>0){
            insert provList;
        }
        if(rppList != null && rppList.size()>0){
            insert rppList;
        }
        if(rppList != null && rppList.size()>0){
            for(Relacion_Producto_Plaza__c rp :rppList){
                rPlazaMap.put(rp.Producto__c, rp.Id);
            }
        }
        for(Product2 p : prodMap1.values()){
            Relacion_Producto_Fraccionamiento__c rpf = new Relacion_Producto_Fraccionamiento__c();
            rpf.Producto__c = p.Id;
            rpf.Fraccionamiento__c = fraccionamientoEstadoMap.get(p.Vivienda__c).Id;
            if(rPlazaMap != null && rPlazaMap.size()>0){
                rpf.Relacion_Producto_Plaza_Fraccionamiento__c = rPlazaMap.get(p.Id);
            }
            rpf.Name = 'Nuevo';
            rpfList.add(rpf);
        }
        insert rpfList;
        for(Integer c: prodMap.keyset()){
            prodMap.get(c).Product2Id = prodMap1.get(c).Id;
        }
        insert prodMap.values();
    }
}