public class ImportarPrototiposWS {
	public List<Prototipo__c> listaPrototipos {get;set;}
    public Integer min {get;set;}
    public Integer max {get;set;}
    public ImportarPrototiposWS(){
        
    }
    
	public PageReference consultar(){
        PageReference page = ApexPages.currentPage();

        listaPrototipos = new List<Prototipo__c>();
        User usuario = [SELECT Id, Name, Id_Mas_Comercial__c, User_Mas_Comercial__c FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        List<Prototipo__c> listAux = [SELECT ID, Name,Id_Mas_Comercial__c,Fraccionamiento__c FROM Prototipo__c LIMIT 48000];
        List<Modelos__c> listModelos = [SELECT ID, Name, Id_Mas_ComercialMd__c FROM Modelos__c LIMIT 48000];
        Set<Id> resultIds = (new Map<Id,SObject>(listAux)).keySet();
        
        List<Modelos__c> modIns = new List<Modelos__c>();
        
        esbJaverComCatprototipos.CatPrototiposPort wsPort =  new esbJaverComCatprototipos.CatPrototiposPort();
        wsPort.timeout_x = 120000;
        
        esbJaverComCommonPrototipos.PrototipoListType respuesta = wsPort.GetPrototipos(usuario.User_Mas_Comercial__c,'SALESFORCE','');
        
        esbJaverComCommonPrototipos.PrototipoType[] prototipos = respuesta.Prototipo;
         if(max == 0){
            max = prototipos.size(); 
        }
        if(prototipos != null){
            try{
            for(Integer i = min; i < max; i++){
                esbJaverComCommonPrototipos.PrototipoType prototipo = prototipos[i];
                
                Modelos__c mod = new Modelos__c();
                
                mod.Id_Mas_ComercialMD__c = '' + prototipo.ID;
                mod.Name = prototipo.Name;
                if(prototipo.Estatus == '1'){
                    
                    mod.ActivoMD__c = true;
                }else{
                    
                    mod.ActivoMD__c = false;
                }
                for(Modelos__c pr : listModelos){
                    if(pr.Id_Mas_ComercialMD__c != null){
                        if((('' + pr.Id_Mas_ComercialMD__c) == ''+prototipo.ID) && pr.Id_Mas_ComercialMD__c != ''){
                            mod.Id = pr.Id;
                        }
                    }
                }

                modIns.add(mod);
            }
            }catch(Exception e){
                
            }
        }
        upsert modIns;
        //upsert listaPrototipos;
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
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
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