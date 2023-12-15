public class ImagenVivienda {
    
    public Inventario__c inventario {get;set;}
    
    public Double latitude {get;set;}
    public Double longitude {get;set;}
    
	public ImagenVivienda(ApexPages.StandardController controller){
        inventario = (Inventario__c) controller.getRecord();
        inventario = [SELECT 
                      Proto__r.ImgPrototipo__c, 
                      Proto__r.PlanoArquitectonico__c,
                      Fracc__r.LigaLogoFracc__c,
                      Fracc__r.Name,
                      Fracc__r.Coordenadas__c,
                      Fracc__r.Sembrado__c
                      FROM Inventario__c 
                      WHERE Id = :inventario.Id];
        if(inventario.Fracc__r.Coordenadas__c != null){
            latitude = Double.valueOf(inventario.Fracc__r.Coordenadas__c.split(', ')[0]);
            longitude = Double.valueOf(inventario.Fracc__r.Coordenadas__c.split(', ')[1]);
        }else{
            
        }
    }
}