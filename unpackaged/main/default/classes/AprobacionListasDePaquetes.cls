public class AprobacionListasDePaquetes {
    public Id recId{get;set;}
    public Aprobacion_Lista_de_Precios__c ap{get{
       return [SELECT Lista_de_precios__c, Lista_de_precios__r.Name, Fraccionamiento__c,  Prototipo__c,Solicitante__c FROM Aprobacion_Lista_de_Precios__c WHERE Id =:recId];
    }set;}
    public List<Product2> prodList{get{
        Aprobacion_Lista_de_Precios__c apr = [SELECT Lista_de_precios__c, Lista_de_precios__r.Name, Fraccionamiento__c,  Prototipo__c FROM Aprobacion_Lista_de_Precios__c WHERE Id =:recId];
        String priceBookId = apr.Lista_de_precios__c;
        Set<Id> productIds = new Set<Id>();
        for(PriceBookEntry pe : [SELECT Product2Id FROM PriceBookEntry WHERE PriceBook2Id =:priceBookId]){
            productIds.add(pe.Product2Id);
        }
        return [SELECT Name, Precio_Venta__c, Precio_de_Compra__c, IVA__c, Precio_Total__c, Beneficio2__c, Precio_de_Venta_Sugerido__c FROM Product2 WHERE Id IN:productIds];
    }set;}
    public String actorName{get{
         List<ProcessInstanceWorkitem> pworkList = new List<ProcessInstanceWorkitem>();
        pworkList = [SELECT Id, ProcessInstanceId, OriginalActor.Name, Actor.Name, ElapsedTimeInDays, ElapsedTimeInHours, ElapsedTimeInMinutes, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                     FROM ProcessInstanceWorkitem 
                     WHERE ProcessInstance.targetObjectId =: recId
                    ];
        if(pworkList.size() > 0){
            return pworkList[0].OriginalActor.Name;
        }
        else{
            return '';
        }
    }set;}
    
    
    public AprobacionListasDePaquetes(){
    }
    public void init(){
        prodList = new List<Product2>();
        
        
        List<ProcessInstanceWorkitem> pworkList = new List<ProcessInstanceWorkitem>();
        pworkList = [SELECT Id, ProcessInstanceId, OriginalActor.Name, Actor.Name, ElapsedTimeInDays, ElapsedTimeInHours, ElapsedTimeInMinutes, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                     FROM ProcessInstanceWorkitem 
                     WHERE ProcessInstance.targetObjectId =: recId
                    ];
        actorName = '';
        if(pworkList.size() > 0){
            actorName = pworkList[0].OriginalActor.Name;
        }
    }
}