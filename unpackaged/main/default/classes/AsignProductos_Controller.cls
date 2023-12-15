public with sharing class AsignProductos_Controller {
    public class CustomException extends Exception {}
    
    @AuraEnabled
    public static List<Product2> getProductos(String idPricebook, String searchKey) {
        if (searchKey == '') {
            searchKey = '%';
        } else {
            searchKey = '%' + searchKey + '%';
        }
        system.debug('searchKey: '+searchKey);
        
        // Obtener Fraccionamientos y Tipo de Registro del Id
        PriceBook2 pb = [SELECT Fraccionamiento__r.Name, RecordType.Name FROM Pricebook2 WHERE Id = :idPricebook LIMIT 1];
        
        system.debug ('*** getProductos Pricebook2 Id: '+pb);
        // Traducir el RecordType a tipo RecordType de Productos (Pricebook2->Product2)
        Map<String, String> mapTipoReg = new Map<String, String>{
            'Promoción Venta'=>'Promoción de Venta',
                'Regalo MKT'=>'Regalos MKT',
                'Producto Genérico'=>'Productos Genéricos',
                'Paquete'=>'Paquetes'
                };
                    
                    Set <id> setPE = new Set <Id>();
        for (PricebookEntry lPE : [SELECT ID, Product2Id FROM PricebookEntry WHERE Pricebook2Id = :idPricebook]) {
            setPE.add (lPE.Product2Id);
        }
        String strFrac = '%';
        if (pb.Fraccionamiento__c != null) {
            strFrac = '%' + pb.Fraccionamiento__r.Name + '%';
        }
        system.debug ('*** strFrac '+strFrac);
        system.debug ('*** pb.RecordType.Name: '+pb.RecordType.Name);
        
        List <Product2> lstProduct = new List <Product2>();
        if (pb.Fraccionamiento__c == null) {
            lstProduct = [SELECT Id, Name, Marca__c,Precio_Venta__c, Precio_de_Venta_Sugerido__c, Tipo_de_Producto__c 
                FROM Product2
                WHERE Activo__c = TRUE
                AND RecordTypeId IN (SELECT Id FROM RecordType WHERE SobjectType = 'Product2' AND Name = :mapTipoReg.get(pb.RecordType.Name))
                AND Fraccionamientos__c = null
                AND Id NOT IN :setPE
                AND Tipo_de_Producto__c <> null
                AND (Sin_Vigencia__c = TRUE OR Vigencia_Hasta__c >= TODAY)
                AND Name like :searchKey
                ORDER BY Name ];
        } else {
            lstProduct = [SELECT Id, Name, Marca__c,Precio_Venta__c, Precio_de_Venta_Sugerido__c, Tipo_de_Producto__c 
                FROM Product2
                WHERE Activo__c = TRUE
                AND RecordTypeId IN (SELECT Id FROM RecordType WHERE SobjectType = 'Product2' AND Name = :mapTipoReg.get(pb.RecordType.Name))
                AND Fraccionamientos__c LIKE :strFrac
                AND Id NOT IN :setPE
                AND Tipo_de_Producto__c <> null
                AND (Sin_Vigencia__c = TRUE OR Vigencia_Hasta__c >= TODAY)
                AND Name like :searchKey
                ORDER BY Name ];
        }
        
        system.debug ('**** lstProduct' + lstProduct);
        return (lstProduct);
    }
    
    @AuraEnabled
    public static void asignaProductos(Id PricebookId, List<Map<String, Object>> selectedRecords) {
        system.debug('*** id pricebook: '+PricebookId);
        
        // Double Precio_superficie_excedente = [SELECT Precio_superficie_excedente__c FROM Pricebook2 WHERE ID = :PricebookId].Precio_superficie_excedente__c;
        // Precio_superficie_excedente = Precio_superficie_excedente == null ? 0 : Precio_superficie_excedente;
        
        Set <String> setProdId = new Set <String>();
        List<PriceBookEntry> pbeToInsert = new List<PriceBookEntry>();
        
        for (Map<String, Object> fields : selectedRecords) {
            system.debug('*** params en asignaProductos id: '+fields.get('Id'));
            system.debug('*** params en asignaProductos: '+fields.get('Name'));
            String sPrdId = (String) fields.get('Id');
            setProdId.add(sPrdId);
        }
        system.debug ('*** setProdID: '+setProdId);
        
        for (Product2 prd : [SELECT id, Name, Fraccionamientos__c, Plazas_Sin_Fracc__c,Precio_Total__c //, Vivienda__r.Superficie_Excedente__c
                             FROM Product2 WHERE id IN :setPRodId]) {
                                 pbeToInsert.add(
                                     new PriceBookEntry(
                                         IsActive = true,
                                         Pricebook2Id = PricebookId,
                                         Product2Id = prd.id,
                                         UnitPrice = prd.Precio_Total__c
                                         //Total_M2_Excedentes__c = prd.Vivienda__r.Superficie_Excedente__c!=null ? prd.Vivienda__r.Superficie_Excedente__c*Precio_superficie_excedente : 0
                                     )
                                 );
                             }
        system.debug ('*** pbeToInsert in :'+pbeToInsert);
        if (pbeToInsert.size() > 0) {
            
            try {
                insert pbeToInsert;
            } catch (DMLException e) {
                string errorMessage = e.getDmlMessage(0) == null
                    ? e.getMessage()
                    : e.getDmlMessage(0);
                
                system.debug('####catch DML Exception errorMessage: ' + errorMessage);
                system.debug('####catch DML Exception e.getDmlStatusCode: ' +        e.getDmlStatusCode(0));
                throw new CustomException(errorMessage);
            }
        }
        
        // Actualizar Pricebook, marcar como "En Progreso"
        List <Pricebook2> updPricebook = [SELECT Id, Estatus__c FROM Pricebook2 where id = :PricebookId];
        
        if (updPricebook.size()>0) {
            updPricebook[0].Estatus__c = 'En Progreso';
            
            try {
                update updPricebook;
            } catch (DmlException e) {
                string errorMessage = e.getDmlMessage(0) == null ? e.getMessage() : e.getDmlMessage(0);
                
                system.debug('####catch DML Exception errorMessage: ' + errorMessage);
                system.debug('####catch DML Exception e.getDmlStatusCode: ' +        e.getDmlStatusCode(0));
            }
        }
    }
    @AuraEnabled
    public static Boolean borraProducto (Id pbId, Id prodId){
        List <PriceBookentry> lstPbe = [SELECT Id from Pricebookentry WHERE Pricebook2Id = :pbId AND Product2Id = :prodId];
        delete lstPbe;
        
        List <Pricebook2> updPricebook = [SELECT Id, Estatus__c FROM Pricebook2 where id = :pbId];
        if (updPricebook.size()>0) {
            updPricebook[0].Estatus__c = 'En Progreso';
            
            try {
                update updPricebook;
            }
            catch (DmlException e) {
                string errorMessage = e.getDmlMessage(0) == null ? e.getMessage() : e.getDmlMessage(0);
            }
        }
        return true;
    }
    
}