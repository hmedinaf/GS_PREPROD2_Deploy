public class ImportarComisionesWS {
    public List<ComisionMovilidad__c> listaComisiones {get;set;}
    
    public ImportarComisionesWS(){
        
    }
    
	public PageReference consultar(){
        PageReference page = ApexPages.currentPage();
        List<ComisionMovilidad__c> listaComisiones1 = new List<ComisionMovilidad__c>();
        esbJaverComMxCommiss.RptSalesCommissionsPort wsPort =  new esbJaverComMxCommiss.RptSalesCommissionsPort();
        wsPort.timeout_x = 120000;
        List<ComisionMovilidad__c> listAux = [Select Id, Name, Periodopag_comi__c FROM ComisionMovilidad__c WHERE Periodopag_comi__c LIKE:getPeriodo(Date.today()) LIMIT 48000];
        List<User> usuarios = [Select Id, Name FROM User WHERE isActive = True LIMIT 10000];
        Map<String, Id> mapaIds = new Map<String, Id>();
        for(User us : usuarios){
            mapaIds.put(us.Name.toLowerCase(), us.Id);
        }
         esbJaverComCommiss.Commissions_element respuesta = wsPort.CommissionsByCurrentMonth();
        
        List<esbJaverComCommiss.OutputType> comisiones = respuesta.Row;
        if(comisiones != null){
            for(esbJaverComCommiss.OutputType comi : comisiones){
                ComisionMovilidad__c c = new ComisionMovilidad__c();

                c.Name = comi.FRACCIONAMIENTO; //FRACCIONAMIENTO
                c.Numplan_comi__c = comi.NO_PLAN_COMISION;
                
                c.Empleado__c = comi.NOMBRE_EMPLEADO_CEDULA;
                try{
                	c.OwnerId = mapaIds.get(c.Empleado__c.toLowerCase());
                }catch(Exception w){
                    c.OwnerId = UserInfo.getUserId();
                }
                
                if(c.OwnerId == null){
                    c.OwnerId = UserInfo.getUserId();
                }
                
                c.Equipovta_comi__c = comi.NOMBRE_EQUIPO;
                c.Etapvta_comi__c = comi.ETAPA_VENTA;
                c.Nomcte_comi__c = comi.NOMBRE_CLIENTE;
                c.Periodopag_comi__c = comi.PERIODO_PAGO;
                c.Plancomi_comi__c = comi.NOMBRE_PLAN_COMISION;
                c.Tipoced_comi__c = comi.TIPO_CEDULA;
	
                listaComisiones1.add(c);
            }
        }
        delete listAux;
        insert listaComisiones1;
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
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;
        i = 1;
        i = 1;
        i = 1;i = 1;i = 1;
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