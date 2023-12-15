public class AddProducts {
    @AuraEnabled
    public static List<Product2> fetchProducts(){
        List<Product2> prodList = [SELECT Id,Name,ProductCode, Family FROM Product2  Order by CreatedDate desc LIMIT 10 ];
        return prodList;
    }
    @AuraEnabled
    public static List<PriceBook2> fetchPbRecords(String prods){
        List<Product2> prodList = [SELECT Id,Name,Fraccionamientos__c, ProductCode,  RecordType.Name,Family FROM Product2 Where Id = : prods];
        String frac ; String recordtype;
        if(prodList != null && prodList.size()>0){
            frac = prodList[0].Fraccionamientos__c;
            recordtype = prodList[0].RecordType.Name;
        }
        List<PriceBook2> pblist = [select id, Name, Fraccionamiento__c, Description,Prototipo__c, Vigente_Desde__c,Vigente_Hasta__c, IsActive from PriceBook2 
                                   where/* Fraccionamiento__c = :frac AND Prototipo__c IN :ProtoViv   RecordType.Name = :frac AND*/ IsActive = true 
                                   AND Vigente_Desde__c <= : Date.today() AND Vigente_Hasta__c >= : Date.today()  LIMIT 5];
        return pblist;
    }
    @AuraEnabled
    public static void updateProdRecords(String pb, String prods){ 
        List<Product2> prodList = [SELECT Id,Name,Fraccionamientos__c, ProductCode,  RecordType.Name,Family FROM Product2 Where Id = : prods];
        PricebookEntry pb1 = new PricebookEntry();
        pb1.Pricebook2Id=pb;
        pb1.Product2Id=prodList[0].Id;
        pb1.IsActive=true;
        pb1.UnitPrice=0;
        insert pb1;
    }
}