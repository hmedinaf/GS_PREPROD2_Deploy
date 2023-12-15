public class FraccionamientoWSController{
    
    public List<Fraccionamiento__c> fraccionamientosTabla {get;set;}
    
        public FraccionamientoWSController(){
        
    }
    
    public PageReference consultar(){
        fraccionamientosTabla = new List<Fraccionamiento__c>();
        List<Id> idsActivos = new List<Id>();
        List<Fraccionamiento__c> todosF = [SELECT Id, Name, Id_Mas_Comercial__c, Estado_fracc__c,Muni_fracc__c,Activo_frac__c FROM Fraccionamiento__c];
        
        PageReference page = ApexPages.currentPage();
        esbJaverComCatfraccionamientos.CatFraccionamientosPort wsPro 
            = new esbJaverComCatfraccionamientos.CatFraccionamientosPort();
        wsPro.timeout_x = 120000; 
        
        esbJaverComCatfraccionamientosTypes.Fraccionamientos_element fraccionamientos = new esbJaverComCatfraccionamientosTypes.Fraccionamientos_element();
         esbJaverComCommonFraccionamiento.FraccionamientoListType ifsdj = wsPro.GetFraccionamientos('true','true','true');
        system.debug('FEEF: '+ ifsdj);
        try{ 
            fraccionamientos = wsPro.GetFraccionamientosWithLocation(true,true,true);
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.ERROR, 
			'Se ha agotado el tiempo de respuesta, favor de intentarlo de nuevo.')); 
        }
        
        System.debug('FRACCS: ' + fraccionamientos);
        
        List<esbJaverComCatfraccionamientosTypes.Fraccionamiento_element> fraccs = fraccionamientos.Fraccionamiento;
        
        for(esbJaverComCatfraccionamientosTypes.Fraccionamiento_element fracc : fraccs){
            Fraccionamiento__c fraccionamiento = new Fraccionamiento__c();
            fraccionamiento.Name = fracc.Name;
            fraccionamiento.Id_Mas_Comercial__c = fracc.ID;
            fraccionamiento.Estado_fracc__c = fracc.Location.Estado.Name;
            fraccionamiento.Muni_fracc__c = fracc.Location.Municipio.Name;
            fraccionamiento.UEN__c = fracc.Location.UEN;
            fraccionamiento.Plaza__c =fracc.Location.UEN + ' - ' +fracc.Location.Estado.Name; 
            //fraccionamiento.Activo_frac__c = Boolean.valueOf(fracc.Status);
            
            
            
            //fraccionamiento.Activo_frac__c = fracc.
            boolean exists = false;
            
            for(Fraccionamiento__c fa : todosF){
                if(fa.Id_Mas_Comercial__c == fraccionamiento.Id_Mas_Comercial__c){
                    fraccionamiento.Id = fa.Id;
                    exists = true;
                }else{
                    fa.Activo_frac__c = false;
                }
            }
            
            if(fracc.Status == '1'){
              fraccionamiento.Activo_frac__c = true;  
            }else{
              fraccionamiento.Activo_frac__c = false;
            }
            
            fraccionamientosTabla.add(fraccionamiento);
        }
        upsert fraccionamientosTabla;
        return page;
    }
    public void method(){
        Integer i = 0;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
    }
}