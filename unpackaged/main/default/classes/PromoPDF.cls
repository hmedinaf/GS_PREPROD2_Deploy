public class PromoPDF {
    public Promocion__c promo{get;set;}
    public string pId{get;set;}
    public PromoPDF (){
        pId = ApexPages.currentPage().getParameters().get('id') ;
        promo = [Select Id ,Asunto__c, Name,Fraccionamiento__c,Fecha_de_Inicio__c,Fecha_Final__c,Descripcion__c,Imagen__c,Fraccionamiento__r.Name  from Promocion__c Where Id = :pId];
    }
    
}