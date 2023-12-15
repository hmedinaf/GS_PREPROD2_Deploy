public with sharing class CONTROL_LWC_Plan_de_Venta {
    
    //Check
    @AuraEnabled(cacheable=true)
    public static Pricebook2 getListaDePrecios(Id idPlanDeVenta){
        Plan_de_Venta__c pdv = [Select Id, Vivienda__c, Lista_de_Precios_Vivienda__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];
        Pricebook2 listaDePrecios = null;
        if(pdv.Lista_de_Precios_Vivienda__c != null){
            listaDePrecios = [Select Id, Name, Nombre_Trunc__c, Fraccionamiento__c, Prototipo__c, Precio_Lista__c, Estatus__c, IsActive, Tipo_Lista__c, Vigente_Desde__c, Vigente_Hasta__c From Pricebook2 Where Id = :pdv.Lista_de_Precios_Vivienda__c Limit 1];
        }
        return listaDePrecios;
    }

    //Check
    @AuraEnabled(cacheable=true)
    public static List<Pricebook2> getListasDePrecios(Id idPlanDeVenta){
        Plan_de_Venta__c pdv = [Select Id, Oportunidad__r.Fraccionamiento__c, Oportunidad__r.Prototipo__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];
        return validarPeriodo([Select Id, Name, Nombre_Trunc__c, Fraccionamiento__c, Prototipo__c, Precio_Lista__c, Estatus__c, IsActive, Tipo_Lista__c, Vigente_Desde__c, Vigente_Hasta__c From Pricebook2 Where Fraccionamiento__c = :pdv.Oportunidad__r.Fraccionamiento__c AND Prototipo__c = :pdv.Oportunidad__r.Prototipo__c  AND Tipo_Lista__c = 'Vivienda' AND IsActive = True AND Estatus__c = 'Aprobado' Limit 20]);
    }

    @AuraEnabled(cacheable=true)
    public static List<Plan_de_Venta__c> getPDV(Id idPlanDeVenta){
        return [Select Id, Vivienda__c, Reubicacion_Aux__c, Importe_Condiciones_Especiales__c, Precio_Seleccionado__c, Precio_Venta_Normal__c, Precio_Venta_Anticipada__c, Precio__c, 
        Lista_de_Precios_Vivienda__c, Lista_de_Precios_Vivienda__r.Vigente_Desde__c, Lista_de_Precios_Vivienda__r.Vigente_Hasta__c, Lista_de_Precios_Vivienda__r.Precio_Lista__c, Lista_de_Precios_Vivienda__r.Nombre_Trunc__c, Lista_de_Precios_Vivienda__r.Id, 
        Lista_de_Precios_Vivienda_Reciente__c, Lista_de_Precios_Vivienda_Reciente__r.Vigente_Desde__c, Lista_de_Precios_Vivienda_Reciente__r.Vigente_Hasta__c, Lista_de_Precios_Vivienda_Reciente__r.Precio_Lista__c, Lista_de_Precios_Vivienda_Reciente__r.Nombre_Trunc__c, Lista_de_Precios_Vivienda_Reciente__r.Id, 
        Venta_Anticipada__c, Tipo_de_Plan_de_Venta__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];
    }

    @AuraEnabled(cacheable=true)
    public static Vivienda__c getVivienda(Id idPlanDeVenta){
        Plan_de_Venta__c pdv = [Select Id, Vivienda__c, Lista_de_Precios_Vivienda__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];
        Vivienda__c v = null;
        if(pdv.Vivienda__c != null){
            v = [Select Id, Name, Nombre_Trunc__c, Num_Interno__c, Lote__c, Manzana__c, Num_Interior__c, Unidad_Privativa__c, Direccion_Trunc__c, Estatus__c, Fraccionamiento__c, Casa_Muestra__c From Vivienda__c Where Id = :pdv.Vivienda__c Limit 1];
        }
        return v;
    }

    @AuraEnabled(cacheable=true)
    public static List<Vivienda__c> getViviendas(Id idPlanDeVenta, String searchVal){
        searchVal = '%' + searchVal + '%';
        Plan_de_Venta__c pdv = [Select Id, Oportunidad__r.Fraccionamiento__c, Oportunidad__r.Prototipo__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];
        return [Select Id, Name, Nombre_Trunc__c, Num_Interno__c, Lote__c, Manzana__c, Num_Interior__c, Unidad_Privativa__c, Direccion_Trunc__c, Estatus__c, Fraccionamiento__c From Vivienda__c Where Estatus__c = '17' AND Inhabilitado_Venta__c=false AND Fraccionamiento__c = :pdv.Oportunidad__r.Fraccionamiento__c AND Prototipo__c = :pdv.Oportunidad__r.Prototipo__c AND (Name Like :searchVal OR Cadena_Busqueda__c Like :searchVal OR Num_Interior__c Like :searchVal) WITH SECURITY_ENFORCED Limit 20];
    }

    @AuraEnabled(cacheable=true)
    public static String getStatus(Id savedViviendaId){
        String r = '';
        List<Vivienda__c> vs = [Select Id, Estatus__c From Vivienda__c Where Id = :savedViviendaId Limit 1];
        if(vs.size()>0){
            r = vs[0].Estatus__c;
        }
        return r;
    }

    @AuraEnabled(cacheable=true)
    public static List<Producto_de_Plan_de_Venta__c> getProductosPDV(Id idPlanDeVenta){
        return [Select Id, Plan_de_Venta__c, Nombre_del_Producto__c, Precio_del_Producto__c, Cantidad__c, Precio_Total__c, Tipo_de_Producto__c From Producto_de_Plan_de_Venta__c WHERE Plan_de_Venta__c = :idPlanDeVenta WITH SECURITY_ENFORCED Limit 50];
    }


    //Deprecated
    @AuraEnabled(cacheable=true)
    public static List<Pricebook2> getPricebooksPDV(Id idPlanDeVenta){
        Plan_de_Venta__c pdv = [SELECT Id, Oportunidad__r.Fraccionamiento__c, Oportunidad__r.Prototipo__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];
        
        List<Pricebook2> pricebooks = validarPeriodo(
            [   SELECT Id, Name, Fraccionamiento__c, Prototipo__c, Precio_Lista__c, 
                    Estatus__c, IsActive, Tipo_Lista__c, Vigente_Desde__c, Vigente_Hasta__c 
                FROM Pricebook2 
                WHERE Fraccionamiento__c = : pdv.Oportunidad__r.Fraccionamiento__c 
                AND Prototipo__c = :pdv.Oportunidad__r.Prototipo__c     
                AND IsActive = true    
                AND  Tipo_Lista__c	 = 'Promoción Precio'
                AND Estatus__c = 'Aprobado' Limit 200]);

        return pricebooks;
    }

    //Deprecated
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductos(Id idPlanDeVenta, String searchVal, String type,  String subType){
        searchVal = '%' + searchVal + '%';
        Plan_de_Venta__c pdv = [Select Id, Oportunidad__r.Fraccionamiento__c, Oportunidad__r.Prototipo__c, Lista_de_Precios_Paquetes_Reciente__c, Lista_de_Precios_PromocionesV_Reciente__c, Lista_de_Precios_RegalosMKT_Reciente__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];
        if(subType == ''){
            return [Select Id, Name, RecordType.Name From Product2 WHERE RecordType.Name = :type AND Name Like :searchVal WITH SECURITY_ENFORCED Limit 20];
        }
        else{
            return [Select Id, Name, RecordType.Name, Tipo_de_Producto__c From Product2 WHERE RecordType.Name = :type AND Tipo_de_Producto__c = :subType AND Name Like :searchVal WITH SECURITY_ENFORCED Limit 20];
        }
    }

    
    @AuraEnabled(cacheable=true)
    public static List<PricebookEntry> getProductos2(Id idPlanDeVenta, String searchVal, String type,  String subType){
        searchVal = '%' + searchVal + '%';
        Plan_de_Venta__c pdv = [Select Id, Oportunidad__r.Fraccionamiento__c, Oportunidad__r.Prototipo__c, Lista_de_Precios_Paquetes_Reciente__c, Lista_de_Precios_PromocionesV_Reciente__c, Lista_de_Precios_RegalosMKT_Reciente__c, Lista_de_Precios_Complementos_Reciente__c, Lista_de_Precios_Otros_Gastos_Reciente__c, Lista_de_Precios_Casa_Muestra_Reciente__c From Plan_de_Venta__c Where Id = :idPlanDeVenta Limit 1];

        List<PricebookEntry> pEntries = new List<PricebookEntry>();

        if(subType == ''){
            if(type == 'Paquetes'){
                if(pdv.Lista_de_Precios_Paquetes_Reciente__c != null){
                    pEntries = [SELECT Id, Product2Id, Product2.Name, Product2.Description, Product2.IsActive, Product2.RecordType.Name, Product2.Tipo_de_Producto__c, UnitPrice, Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id = :pdv.Lista_de_Precios_Paquetes_Reciente__c AND Product2.IsActive = TRUE AND Product2.RecordType.Name = :type AND Product2.Name Like :searchVal WITH SECURITY_ENFORCED ORDER BY Product2.Name ASC Limit 20];
                }
            }
            else if(type == 'Promoción de Venta'){
                if(pdv.Lista_de_Precios_PromocionesV_Reciente__c != null){
                    pEntries = [SELECT Id, Product2Id, Product2.Name, Product2.Description, Product2.IsActive, Product2.RecordType.Name, Product2.Tipo_de_Producto__c, UnitPrice, Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id = :pdv.Lista_de_Precios_PromocionesV_Reciente__c AND Product2.IsActive = TRUE AND Product2.RecordType.Name = :type AND Product2.Name Like :searchVal WITH SECURITY_ENFORCED ORDER BY Product2.Name ASC Limit 20];
                }
            }
            else{
                if(pdv.Lista_de_Precios_RegalosMKT_Reciente__c != null){
                    pEntries = [SELECT Id, Product2Id, Product2.Name, Product2.Description, Product2.IsActive, Product2.RecordType.Name, Product2.Tipo_de_Producto__c, UnitPrice, Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id = :pdv.Lista_de_Precios_RegalosMKT_Reciente__c AND Product2.IsActive = TRUE AND Product2.RecordType.Name = :type AND Product2.Name Like :searchVal WITH SECURITY_ENFORCED ORDER BY Product2.Name ASC Limit 20];
                }
            }
        }
        else if(subType == 'Complementos'){
            if(pdv.Lista_de_Precios_Complementos_Reciente__c != null){
                pEntries = [SELECT Id, Product2Id, Product2.Name, Product2.Description, Product2.IsActive, Product2.RecordType.Name, Product2.Tipo_de_Producto__c, UnitPrice, Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id = :pdv.Lista_de_Precios_Complementos_Reciente__c AND Product2.IsActive = TRUE AND Product2.RecordType.Name = :type AND Product2.Tipo_de_Producto__c = :subType AND Product2.Name Like :searchVal WITH SECURITY_ENFORCED ORDER BY Product2.Name ASC Limit 20];
            }
        }
        else if(subType == 'Otros Gastos'){
            if(pdv.Lista_de_Precios_Otros_Gastos_Reciente__c != null){
                pEntries = [SELECT Id, Product2Id, Product2.Name, Product2.Description, Product2.IsActive, Product2.RecordType.Name, Product2.Tipo_de_Producto__c, UnitPrice, Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id = :pdv.Lista_de_Precios_Otros_Gastos_Reciente__c AND Product2.IsActive = TRUE AND Product2.RecordType.Name = :type AND Product2.Tipo_de_Producto__c = :subType AND Product2.Name Like :searchVal WITH SECURITY_ENFORCED ORDER BY Product2.Name ASC Limit 20];
            }
        }
        else{
            if(pdv.Lista_de_Precios_Casa_Muestra_Reciente__c != null){
                pEntries = [SELECT Id, Product2Id, Product2.Name, Product2.Description, Product2.IsActive, Product2.RecordType.Name, Product2.Tipo_de_Producto__c, UnitPrice, Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id = :pdv.Lista_de_Precios_Casa_Muestra_Reciente__c AND Product2.IsActive = TRUE AND Product2.RecordType.Name = :type AND Product2.Tipo_de_Producto__c = :subType AND Product2.Name Like :searchVal WITH SECURITY_ENFORCED ORDER BY Product2.Name ASC Limit 20];
            }
        }
        return pEntries;
    }
	@testVisible
    //Check
    private static List<Pricebook2> validarPeriodo(List<Pricebook2> listasDePrecios){
        list<Pricebook2> listasDePreciosVigentes = new list<Pricebook2>();
        for(Pricebook2 listaDePrecios : listasDePrecios){
            if(listaDePrecios.Vigente_Desde__c <= Date.TODAY()){
                if(listaDePrecios.Vigente_Hasta__c >= Date.TODAY()){
                    listasDePreciosVigentes.add(listaDePrecios);
                }
            }
        }
        return listasDePreciosVigentes;
    }
}