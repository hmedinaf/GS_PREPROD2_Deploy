@RestResource(urlMapping='/RestService/Accounts/*')
global with sharing class WS_UpsertAccounts {
    
    private static Integer codError = 200;
    private static String msgError = 'Registros procesados correctamente';

    @HttpPost
    global static ResponseService updateCuentas(RequestService request){
        
        set<String> idsProcesos= new set<String>();
        set<String> idsCuentas = new set<String>();
        set<String> idsOpps = new set<String>();
        ResponseService response = new ResponseService();
        map<String,Consumo_Servicios__c> mapConsumos= new map<String,Consumo_Servicios__c>();
        map<String,AccountItem> mapAcoIt= new map<String,AccountItem>();


        List<AccountItem> cuentasRespuesta = new List<AccountItem>();
        
        for(AccountItem acoItm : request.CUENTAS){
            idsProcesos.add(acoItm.IdInterfaceCrm);
            mapAcoIt.put(acoItm.IdInterfaceCrm,acoItm);
        }
        
        List<Consumo_Servicios__c> lstConsumos = new List<Consumo_Servicios__c>();
        lstConsumos = [SELECT Id,Name, Cuenta__c, Nombre_del_servicio__c, Proceso_de_Venta__c FROM Consumo_Servicios__c WHERE Id IN:  idsProcesos]; 

        for(Consumo_Servicios__c consumo : lstConsumos){
            idsCuentas.add(consumo.Cuenta__c);
            idsOpps.add(consumo.Proceso_de_Venta__c);
            mapConsumos.put(consumo.Id,consumo);
        }


		List<Account> lstAccount = new List<Account>();
        
        try{

           lstAccount = [SELECT Id, ID_CLIENTE_AR__c, ROW_ID__c, ID_PROCESO_AR__c,MENSAJE_API__c, RESPUESTA_API__c  FROM Account WHERE Id IN: idsCuentas];
           Map<String,Account> mapAccount = new Map<String,Account>();
            
        	if(!lstAccount.isEmpty()){
                
                for(Account aco : lstAccount){
                    mapAccount.put(aco.Id, aco);
        		}

                for(AccountItem acoItm : request.CUENTAS){
                    if(mapAccount.containsKey(mapConsumos.get(acoItm.IdInterfaceCrm).Cuenta__c)){
                        mapAccount.get(mapConsumos.get(acoItm.IdInterfaceCrm).Cuenta__c).ROW_ID__c = acoItm.IdInterfaceCrm;
                        mapAccount.get(mapConsumos.get(acoItm.IdInterfaceCrm).Cuenta__c).ID_CLIENTE_AR__c = String.valueOf(acoItm.ID_CLIENTE_AR);
                        mapAccount.get(mapConsumos.get(acoItm.IdInterfaceCrm).Cuenta__c).ID_PROCESO_AR__c = String.valueOf(acoItm.ID_PROCESO_AR);
                        mapAccount.get(mapConsumos.get(acoItm.IdInterfaceCrm).Cuenta__c).MENSAJE_API__c = acoItm.MENSAJE_API;
                        mapAccount.get(mapConsumos.get(acoItm.IdInterfaceCrm).Cuenta__c).RESPUESTA_API__c = acoItm.RESPUESTA_API;
                    }
                    
                }
            
                lstAccount = mapAccount.Values();

                List<Database.SaveResult> results = Database.update(lstAccount, false);
                
                for(Integer index = 0, size = results.size(); index < size; index++) {
                    AccountItem acoResp = new AccountItem();
                    if(results[index].isSuccess()) {
                        acoResp.ID_CLIENTE_AR = Integer.valueOf(lstAccount[index].ID_CLIENTE_AR__c);
                        acoResp.IdInterfaceCrm = lstAccount[index].ROW_ID__c;
                        acoResp.ID_PROCESO_AR = Integer.valueOf(lstAccount[index].ID_PROCESO_AR__c);
                        acoResp.RESPUESTA_API = '0';
                        acoResp.MENSAJE_API = 'Registro actualizado correctamente';
                        cuentasRespuesta.add(acoResp);
                    }else{
                        Database.Error error = results.get(index).getErrors().get(0);
                        
                        acoResp.ID_CLIENTE_AR = Integer.valueOf(lstAccount[index].ID_CLIENTE_AR__c);
                        acoResp.IdInterfaceCrm = lstAccount[index].ROW_ID__c;
                        acoResp.ID_PROCESO_AR = Integer.valueOf(lstAccount[index].ID_PROCESO_AR__c);
                        acoResp.RESPUESTA_API = '301';
                        acoResp.MENSAJE_API = 'El registo no pudo ser procesado: ' + error.getMessage();
                        cuentasRespuesta.add(acoResp);
                    }
                }
                
                response.CUENTAS = cuentasRespuesta;
        		response.MENSAJE_API  = 'Registros procesados';
       			response.CODIGO_ERROR   = 0; 
            	
            }else{
                response.CUENTAS = request.CUENTAS;
                response.CODIGO_ERROR = 300;
                response.MENSAJE_API = 'No se encontraron registros con los identificadores ingresados.';
            }
            
            
        }catch(Exception e){
            response.MENSAJE_API  = 'Error al procesar la solicitud: ' + e.getStackTraceString();
       		response.CODIGO_ERROR   = 302; 
        }
        
        
        
        return response;
    }
    

   //Se generan las sub-clases a utilizar
    global class AccountItem{
        
        public Integer ID_CLIENTE_AR				{get;set;}
        public String IdInterfaceCrm				{get;set;}
        public Integer ID_PROCESO_AR				{get;set;}
        public String MENSAJE_API					{get;set;}
        public String RESPUESTA_API					{get;set;}
        
        
    }
    
    
    global class RequestService{
   		public List<AccountItem> CUENTAS {get;Set;}
        
        public RequestService(){
        	System.debug('Rquest');
        }
        
        public RequestService(List<AccountItem> lstCuentas){
            this.CUENTAS = lstCuentas;
        }
  	}		
    
    
    global class ResponseService{
       public List<AccountItem> CUENTAS {get;Set;}
       public String MENSAJE_API  	{get;Set;}
       public Integer CODIGO_ERROR  	{get;Set;}
        
        public ResponseService(){
            System.debug('Response');
        }
        
        public ResponseService(List<AccountItem> lstCuentas, String mensaje, Integer codigoError){
            this.CUENTAS = lstCuentas;
            this.MENSAJE_API = mensaje;
            this.CODIGO_ERROR = codigoError;
        }
   }
   
}