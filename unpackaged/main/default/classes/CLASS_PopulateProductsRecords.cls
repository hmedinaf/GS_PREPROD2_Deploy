public class CLASS_PopulateProductsRecords {
    @AuraEnabled(cacheable=true)
    public static wrap populaCamposProducto(String idProd){
        Product2 p = new Product2();
        wrap wr = new wrap();
        if(idProd != null && idProd != ''){
            p = [SELECT Id, Name, Activo__c, IsActive, Beneficio__c, Codigo_de_Producto__c, ProductCode, Description, Direccion__c, Family, Codigo_de_Producto_Javer__c, ExternalId, Fraccionamientos__c,
                 Id_Externo__c, Inactivo__c, IVA__c, Lote__c, Manzana__c, Marca__c, Num_Interior__c, Num_Interno__c, Plaza__c, Precio_de_Compra__c, Precio_de_Venta_Sugerido__c, Producto_Original__c,
                 Precio_Total__c, Precio_Venta__c, StockKeepingUnit, Tipo_de_Producto__c, RecordTypeId, QuantityUnitOfMeasure, Unidad_Privada__c, DisplayUrl, Vigencia_Hasta__c, Codigo_Producto_Original__c
                 FROM Product2 WHERE Id =: idProd ];
            wr.prod = JSON.serialize(p);
        }
        else{
            System.debug('Error al duplicar');
        }
        return wr;
    }
   @AuraEnabled 
    public static String createRecord(String tipo,Boolean activo, String Name, String Marca, String Description, Decimal compra, Decimal Precio_Venta, Decimal IVA, String ProductoOriginal, String Codigo,String oldId, String recType){
        String msg = '';
        List<Relacion_Precio_Proveedor__c> relP = new  List<Relacion_Precio_Proveedor__c>();
        List<Relacion_Producto_Plaza__c> relPlaza = new  List<Relacion_Producto_Plaza__c>();
        List<Relacion_Producto_Fraccionamiento__c> relf = new  List<Relacion_Producto_Fraccionamiento__c>();
        List<Relacion_Precio_Proveedor__c> newRelP = new  List<Relacion_Precio_Proveedor__c>();
        List<Relacion_Producto_Plaza__c> newRelPlaza = new  List<Relacion_Producto_Plaza__c>();
        List<Relacion_Producto_Fraccionamiento__c> newRelf = new  List<Relacion_Producto_Fraccionamiento__c>();
        Set<Id> idFraccionamientos = new Set<Id>();
        Map<String, Id> mapaPlazasAsignadas = new Map<String,Id>();
        try{
            Product2 pd =  new Product2();
            pd.Tipo_de_Producto__c = tipo;
            pd.Activo__c = activo;
            pd.Name = Name;
            pd.Marca__c = Marca;
            pd.Description = Description;
            pd.Precio_de_Compra__c = compra;
            pd.Precio_Venta__c = Precio_Venta;
            pd.IVA__c = IVA;
            pd.Producto_Original__c = ProductoOriginal;
            pd.Codigo_Producto_Original__c = Codigo;
            pd.RecordTypeId = recType;
            insert pd;
            msg = pd.Id;
            if(oldId != null){
                Product2 oldRecord = [select id, Name  from Product2 where Id = : oldId];
                relP = [Select Id,Name, Name__c,Producto__c,Proveedor__c,Proveedor2__c FROM Relacion_Precio_Proveedor__c WHERE Producto__c =: oldRecord.Id];
                relPlaza = [SELECT Id, Name,Producto__c,Check_actualizacion__c,Name__c,Nombre_Filtro__c,Plaza__c,Plaza2__c,Producto_Numero_Filtro__c, Tiene_Fraccionamiento__c
                            FROM Relacion_Producto_Plaza__c WHERE Producto__c =: oldRecord.Id];
                if(relPlaza != null && relPlaza.size()>0){
                    for(Relacion_Producto_Plaza__c rpf : relPlaza){
                        idFraccionamientos.add(rpf.Id);
                    }
                }
                relf = [SELECT Id, Name, Name__c,Producto__c,Vigencia_Hasta__c, Sin_vigencia__c, Vencido__c,Fraccionamiento2__c,Fraccionamiento__c,Plaza_Filtro__c 
                        ,Relacion_Producto_Plaza_Fraccionamiento__c,Producto_Numero_Filtro__c ,Fraccionamiento__r.Estado_fracc__c
                        FROM Relacion_Producto_Fraccionamiento__c Where Relacion_Producto_Plaza_Fraccionamiento__c In :idFraccionamientos/*Producto__c =: oldRecord.Id*/];
                if(relP != null && relP.size()>0){
                    for(Relacion_Precio_Proveedor__c rel : relP){
                        Relacion_Precio_Proveedor__c newRp = new Relacion_Precio_Proveedor__c();
                        newRp.Name__c = rel.Name__c;
                        newRp.Producto__c =pd.Id;
                        newRp.Proveedor__c = rel.Proveedor__c;
                        newRelP.add(newRp);
                    }
                }
                if(relPlaza != null && relPlaza.size()>0){
                    for(Relacion_Producto_Plaza__c rel : relPlaza){
                        Relacion_Producto_Plaza__c newRp = new Relacion_Producto_Plaza__c();
                        newRp.Name__c = rel.Name;
                        newRp.Name = rel.Name;
                        newRp.Producto__c = pd.Id;
                        newRp.Check_actualizacion__c = rel.Check_actualizacion__c;
                        newRp.Nombre_Filtro__c = rel.Nombre_Filtro__c;
                        newRp.Plaza__c = rel.Plaza__c;
                        newRp.Producto_Numero_Filtro__c = rel.Producto_Numero_Filtro__c;
                        newRp.Tiene_Fraccionamiento__c = rel.Tiene_Fraccionamiento__c;
                        newRelPlaza.add(newRp);
                    }
                }
                if(newRelP != null && newRelP.size()>0){
                    insert newRelP;
                }
                if(newRelPlaza != null && newRelPlaza.size()>0){
                    insert newRelPlaza;
                }
                if(newRelPlaza != null && newRelPlaza.size()>0){
                    for(Relacion_Producto_Plaza__c pa : newRelPlaza){
                        mapaPlazasAsignadas.put(pa.Name, pa.Id);
                    }
                }
                if(relf != null && relf.size()>0){
                    for(Relacion_Producto_Fraccionamiento__c rel : relf){
                        Relacion_Producto_Fraccionamiento__c newRp = new Relacion_Producto_Fraccionamiento__c();
                        newRp.Name__c = rel.Name__c;
                        newRp.Producto__c = pd.Id;
                        newRp.Vigencia_Hasta__c = rel.Vigencia_Hasta__c;
                        newRp.Sin_vigencia__c = rel.Sin_vigencia__c;
                        newRp.Fraccionamiento__c = rel.Fraccionamiento__c;
                        newRp.Plaza_Filtro__c = rel.Plaza_Filtro__c;
                        newRp.Relacion_Producto_Plaza_Fraccionamiento__c = mapaPlazasAsignadas.get(rel.Fraccionamiento__r.Estado_fracc__c);
                        newRp.Producto_Numero_Filtro__c = rel.Producto_Numero_Filtro__c;
                        newRelf.add(newRp);
                    }
                }
                 if(newRelf != null && newRelf.size()>0){
                     insert newRelf;
                }
            }
        }
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            throw new AuraHandledException(msg);
        }
        return msg;
    }
    
    @AuraEnabled(cacheable=true)
    public static List <Product2> getProductByPricebook(String idPricebook){
        Set <Id> setProducts = new Set <Id>();
        
        if (idPricebook != null) {
            // Obtener los productos relacionados en un Pricebook determinado
            for (PricebookEntry pbe : [SELECT Product2Id FROM PricebookEntry WHERE Pricebook2Id = :idPricebook]) {
                setProducts.add (pbe.Product2Id);
            }
            
            List <Product2> lProd = [
                SELECT Activo__c, Beneficio__c, Codigo_de_Producto__c, Codigo_Producto_Original__c, Description, Family, 
                Fraccionamientos__c, Id, IsActive, IVA__c, Lote__c, Manzana__c, Marca__c, Name, Nuevo__c, Numero_Filtro__c, Plaza__c, 
                Precio_de_Compra__c, Precio_de_Venta_Sugerido__c, Precio_Total__c, Precio_Venta__c, ProductCode, Proveedor__c, 
                RecordTypeId, Relaci_n_Precio_Producto__c, Tipo_de_Producto__c, Vigencia_Hasta__c, Vivienda__c
                FROM Product2
                WHERE Id in :setProducts
                AND Activo__c = TRUE
            ];
            
            return (lProd);
        }
        else {
            return (null);
        }
    }
    
    public class wrap{
        @AuraEnabled public String prod;
        @AuraEnabled public String random;
    }
}