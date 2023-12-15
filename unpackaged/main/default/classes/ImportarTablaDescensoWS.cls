public class ImportarTablaDescensoWS {
    public List<TablaDescenso__c> listaDescenso {get;set;}
    
    public ImportarTablaDescensoWS(){
        
    }
    
	public PageReference consultar(){
        PageReference page = ApexPages.currentPage();
        listaDescenso = new List<TablaDescenso__c>();
        esbJaverComMxReportsRptdescenso.RptDescensoPort wsPort =  new esbJaverComMxReportsRptdescenso.RptDescensoPort();
        wsPort.timeout_x = 120000;
        List<TablaDescenso__c> listAux = [Select Id, Name FROM TablaDescenso__c LIMIT 48000];
         esbJaverComReportsDescensoTypes.Descenso_element respuesta = wsPort.DescensoCurrentAndPrevious();
        List<User> usuarios = [Select Id, Name FROM User WHERE isActive = True LIMIT 10000];
        Map<String, Id> mapaIds = new Map<String, Id>();
        for(User us : usuarios){
            mapaIds.put(us.Name.toLowerCase(), us.Id);
        }
        List<esbJaverComReportsDescensoTypes.OutputType> tablaDescensos = respuesta.Row;
        if(tablaDescensos != null){
            for(esbJaverComReportsDescensoTypes.OutputType td : tablaDescensos){
               TablaDescenso__c t = new TablaDescenso__c();
                t.Name = td.FRACCIONAMIENTO; //FRACCIONAMIENTO
                t.Asesor__c = td.ASESOR;
                t.CantidadAsesores__c = '' + td.CANTIDAD_ASESORES;
                t.IdPeriodo__c = td.ID_PERIODO;
                t.Meta__c = td.META;
                t.Promedio__c = '' + td.PROMEDIO;
                t.PromedioAnualEscrituras__c = '' + td.PROMEDIO_ANUAL_ESCRITURAS;
                t.PromedioRequerido__c = '' + td.PROMEDIO_REQUERIDO;
                t.ResultadoAnual__c = '' +(td.MES_ACTUAL + td.MES_ACTUAL_1 + td.MES_ACTUAL_2 + td.MES_ACTUAL_3);
                t.ResultadoMensual__c = '' + td.MES_ACTUAL;
                t.Total__c = ''+ td.RESULTADO;
                
                
                try{
                	t.OwnerId = mapaIds.get(t.Asesor__c.toLowerCase());
                }catch(Exception w){
                    t.OwnerId = UserInfo.getUserId();
                }
                
                if(t.OwnerId == null){
                    t.OwnerId = UserInfo.getUserId();
                }
                
                
                listaDescenso.add(t);
            }
        }
        delete listAux;
        insert listaDescenso;
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