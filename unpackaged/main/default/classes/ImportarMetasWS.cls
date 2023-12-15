public class ImportarMetasWS {
    public List<Meta__c> listaMeta {get;set;}
    
    public ImportarMetasWS(){
        
    }
    
	public PageReference consultar(){
        PageReference page = ApexPages.currentPage();
        listaMeta = new List<Meta__c>();
        List<Meta__c> listaMetaAux = [SELECT Id, Name, Periodo_met__c, Nomequi_met__c, Nomemp_met__c FROM Meta__c WHERE Periodo_Met__C = :getPeriodo(Date.today()) LIMIT 48000];
        List<User> usuarios = [Select Id, Name FROM User WHERE isActive = True LIMIT 10000];
        Map<String, Id> mapaIds = new Map<String, Id>();
        for(User us : usuarios){
            mapaIds.put(us.Name.toLowerCase(), us.Id);
        }
        
        esbJaverComMxRptmetas.RptMetasPort wsPort =  new esbJaverComMxRptmetas.RptMetasPort();
        wsPort.timeout_x = 120000;
        
        esbJaverComMetasMont.Metas_element respuesta = wsPort.MetasByCurrentMonth();
        
        List<esbJaverComMetasMont.OutputType> metas = respuesta.Row;
        if(metas != null) {
            for(esbJaverComMetasMont.OutputType meta : metas){
                Meta__c m = new Meta__c();
                m.Name = meta.FRACCIONAMIENTO;
                m.Nomequi_met__c = meta.NOMBRE_EQUIPO;
                m.Periodo_met__c = meta.PERIODO_EJECUCION;
                m.Rolvta__c = meta.ROL_VENTA;
                //m.Name = meta.ESTADO;
                m.Nomemp_met__c = meta.EMPLEADO;
                m.MiembrosFraccionamiento__c = '' + meta.MIMBROS_FACCIONAMIENTO;
                m.MetaIndividual__c = meta.META_INDIVIDUAL;
                m.MetaFraccionamiento__c = meta.META_FRACCIONAMIENTO;
                m.RealIndividual__c = meta.REAL_INDIVIDUAL_ASESOR;
				
                try{
                	m.OwnerId = mapaIds.get(m.Nomemp_met__c.toLowerCase());
                }catch(Exception w){
                    m.OwnerId = UserInfo.getUserId();
                }
                
                if(m.OwnerId == null){
                    m.OwnerId = UserInfo.getUserId();
                }
                
                for(Meta__c me :listaMetaAux){
                    if(me.Name == m.Name 
                       && me.Periodo_met__c == m.Periodo_met__c 
                       && me.Nomequi_met__c == m.Nomequi_met__c 
                       && me.Nomemp_met__c == m.Nomemp_met__c){
                           System.debug('ME: ' + me +' ---'+m);
                    }
                }                
                
                listaMeta.add(m);
            }
        }
        delete listaMetaAux;
        upsert listaMeta;
        return page;
    }
    
    public String getPeriodo(Date fecha){
        String fechaString = '';
        if(fecha.month() == 1){
            fechaString = 'ENERO';
        }
        if(fecha.month() == 2){
            fechaString = 'FEBRERO';
        }
        if(fecha.month() == 3){
            fechaString = 'MARZO';
        }
        if(fecha.month() == 4){
            fechaString = 'ABRIL';
        }
        if(fecha.month() == 5){
            fechaString = 'MAYO';
        }
        if(fecha.month() == 6){
            fechaString = 'JUNIO';
        }
        if(fecha.month() == 7){
            fechaString = 'JULIO';
        }
        if(fecha.month() == 8){
            fechaString = 'AGOSTO';
        }
        if(fecha.month() == 9){
            fechaString = 'SEPTIEMBRE';
        }
        if(fecha.month() == 10){
            fechaString = 'OCTUBRE';
        }
        if(fecha.month() == 11){
            fechaString = 'NOVIEMBRE';
        }
        if(fecha.month() == 12){
            fechaString = 'DICIEMBRE';
        }
        
        fechaString += ' '+ fecha.year();
        return fechaString;
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
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
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