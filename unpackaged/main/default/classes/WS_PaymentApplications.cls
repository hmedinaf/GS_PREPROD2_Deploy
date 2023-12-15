@RestResource(urlMapping='/RestService/Payments/Applications/*')
global with sharing class WS_PaymentApplications{

    @HttpPost
    global static ResponseService upsertApplications(RequestService request){

        set<String> idsPayments =  new set<String>();
        set<String> idsInvoices =  new set<String>();
        set<String> idsAccounts =  new set<String>();
        set<String> idsSellProcess =  new set<String>();
        ResponseService response = new ResponseService();
        Map<String,ApplicationItem> mapAppItem = new Map<String,ApplicationItem>();
        List<Aplicacion_Pago__c> appPayToUpsert = new List<Aplicacion_Pago__c>();
        List<ApplicationItem> lstResponseItems = new List<ApplicationItem>();

        for(ApplicationItem app : request.APPLICATIONS){
            
            idsPayments.add(String.valueOf( app.ID_RECIBO_AR ));
            idsInvoices.add(String.valueOf( app.ID_FACTURA_AR ));
            idsAccounts.add(String.valueOf( app.ID_CLIENTE_AR ));
            idsSellProcess.add(String.valueOf( app.ID_PROCESO_AR ));
            mapAppItem.put( String.valueOf( app.ID_APLICACION_AR ) , app);
        }
        
        
        
        for(ApplicationItem appFin : request.APPLICATIONS){
            
            Aplicacion_Pago__c appNew = new Aplicacion_Pago__c();
            
            appNew.CONFLICT_ID__c 				= appFin.CONFLICT_ID;
            appNew.CREATED__c 					= appFin.CREATED;
            appNew.CREATED_BY__c 				= appFin.CREATED_BY;
            appNew.DB_LAST_UPD__c	 			= appFin.DB_LAST_UPD;
            appNew.DB_LAST_UPD_SRC__c 			= appFin.DB_LAST_UPD_SRC;
            appNew.FECHA_APLICACION__c 			= appFin.FECHA_APLICACION;
            appNew.FECHA_CONTABLE__c 			= appFin.FECHA_CONTABLE;
            appNew.ID_APLICACION_AR__c 			= String.valueOf( appFin.ID_APLICACION_AR );
            appNew.ID_CLIENTE_AR__c 			= String.valueOf( appFin.ID_CLIENTE_AR );
            appNew.ID_FACTURA_AR__c 			= String.valueOf( appFin.ID_FACTURA_AR );
            appNew.ID_INTERFACE__c 				= String.valueOf( appFin.ID_INTERFACE );
            appNew.ID_INTERFACE_CRM__c 			= String.valueOf( appFin.ID_INTERFACE_CRM );
            appNew.ID_NOTA_CRED_AR__c 			= String.valueOf( appFin.ID_NOTA_CRED_AR );
            appNew.ID_PROCESO_AR__c 			= String.valueOf( appFin.ID_PROCESO_AR );
            appNew.ID_RECIBO_AR__c 				= String.valueOf( appFin.ID_RECIBO_AR );
            appNew.IMPORTE_A_CUENTA__c 			= appFin.IMPORTE_A_CUENTA;
            appNew.IMPORTE_ANTICIPO__c 			= appFin.IMPORTE_ANTICIPO;
            //appNew.IMPORTE_APLICADO__c 			= appFin.IMPORTE_APLICADO;
            appNew.IMPORTE_FUNCIONAL__c 		= appFin.IMPORTE_FUNCIONAL;
            appNew.IMPORTE_NO_APLICADO__c 		= appFin.IMPORTE_NO_APLICADO;
            appNew.IMPORTE_NO_IDENTIFICADO__c 	= appFin.IMPORTE_NO_IDENTIFICADO;
            appNew.IMPORTE_ORIGINAL__c 			= appFin.IMPORTE_ORIGINAL;
            appNew.IMPORTE_RECLAMO__c 			= appFin.IMPORTE_RECLAMO;
            appNew.IMPORTE_RESTO__c 			= appFin.IMPORTE_RESTO;
            appNew.LAST_UPD__c 					= appFin.LAST_UPD;
            appNew.LAST_UPD_BY__c 				= appFin.LAST_UPD_BY;
            appNew.MENSAJE_API__c 				= appFin.MENSAJE_API;
            appNew.MODIFICATION_NUM__c 			= String.valueOf( appFin.MODIFICATION_NUM );
            appNew.NUM_PROCESO__c 				= appFin.NUM_PROCESO;
            appNew.REQUISICION_CRM__c 			= appFin.REQUISICION_CRM;
            appNew.RESPUESTA_API__c 			= appFin.RESPUESTA_API;
            appNew.RETRY_COUNT__c 				= String.valueOf( appFin.RETRY_COUNT );
            appNew.ROW_ID__c 					= appFin.ROW_ID;
            appNew.TIPO_APLICATION__c 			= appFin.TIPO_APLICATION;
            
            appPayToUpsert.add(appNew);
        }
        
        
        try{
            
           	Schema.SObjectField ftoken = Aplicacion_Pago__c.Fields.ID_APLICACION_AR__c;
            Database.UpsertResult [] cr = Database.upsert(appPayToUpsert, ftoken, false);
            
        	Map<Id, Aplicacion_Pago__c> appMap = new Map<Id, Aplicacion_Pago__c>(appPayToUpsert);
        	// I want to see what was updated / created        
        	for(Database.upsertResult result : cr){
            	System.debug(result);
            	if(result.isSuccess()){
                	if(result.isCreated()){
                        
                        ApplicationItem itemFin = mapAppItem.get(appMap.get(result.getId()).ID_APLICACION_AR__c);
                        itemFin.MENSAJE_API = 'El registro con identificador ' + itemFin.ID_APLICACION_AR + ' ha sido creado exitosamente';
                        itemFin.RESPUESTA_API = '0';
                    	lstResponseItems.add(itemFin);
                        
                	} else {
                        
                    	ApplicationItem itemFin = mapAppItem.get(appMap.get(result.getId()).ID_APLICACION_AR__c);
                        itemFin.MENSAJE_API = 'El registro con identificador ' + itemFin.ID_APLICACION_AR + ' ha sido actualizado exitosamente';
                        itemFin.RESPUESTA_API = '0';
                    	lstResponseItems.add(itemFin);
                	}
                
                }else{
                    
        			// Operation failed, so get all errors                
        			for(Database.Error err : result.getErrors()) {
                        
                        ApplicationItem itemFin = mapAppItem.get(appMap.get(result.getId()).ID_APLICACION_AR__c);
                        itemFin.MENSAJE_API = 'El registro con identificador ' + itemFin.ID_APLICACION_AR + ' no pudo ser procesado Err: ' + err.getStatusCode() + ' ' + err.getMessage() + ' ' + err.getFields();
                        itemFin.RESPUESTA_API = '300';
                    	lstResponseItems.add(itemFin);
                        
            			System.debug('error has occurred.' + err.getStatusCode() + ': ' + err.getMessage());                    
            			System.debug('fields that affected this error: ' + err.getFields());
        			}
    			}
                
        	}
            
            response.APPLICATIONS = lstResponseItems;
            response.MENSAJE_API = 'Registros procesados';
            response.CODIGO_ERROR = 0;
            
            
        }catch(Exception e){
            response.APPLICATIONS = lstResponseItems;
            response.MENSAJE_API = 'Ocurrio un error desconocido y no se pudieron procesar los registros: ' + e.getStackTraceString();
            response.CODIGO_ERROR = 302;
        }
        
        return response;

    }

    global class ApplicationItem{
        
        public String CONFLICT_ID {get;set;}
        public Date CREATED {get;set;}
        public String CREATED_BY {get;set;}
        public Date DB_LAST_UPD {get;set;}
        public String DB_LAST_UPD_SRC {get;set;}
        public Date FECHA_APLICACION {get;set;}
        public Date FECHA_CONTABLE {get;set;}
        public Integer ID_APLICACION_AR {get;set;}
        public Integer ID_CLIENTE_AR {get;set;}
        public Integer ID_FACTURA_AR {get;set;}
        public Integer ID_INTERFACE {get;set;}
        public Integer ID_INTERFACE_CRM {get;set;}
        public Integer ID_NOTA_CRED_AR {get;set;}
        public Integer ID_PROCESO_AR {get;set;}
        public Integer ID_RECIBO_AR {get;set;}
        public Decimal IMPORTE_A_CUENTA {get;set;}
        public Decimal IMPORTE_ANTICIPO {get;set;}
        public Decimal IMPORTE_APLICADO {get;set;}
        public Decimal IMPORTE_FUNCIONAL {get;set;}
        public Decimal IMPORTE_NO_APLICADO {get;set;}
        public Decimal IMPORTE_NO_IDENTIFICADO {get;set;}
        public Decimal IMPORTE_ORIGINAL {get;set;}
        public Decimal IMPORTE_RECLAMO {get;set;}
        public Decimal IMPORTE_RESTO {get;set;}
        public Date LAST_UPD {get;set;}
        public String LAST_UPD_BY {get;set;}
        public String MENSAJE_API {get;set;}
        public Integer MODIFICATION_NUM {get;set;}
        public String NUM_PROCESO {get;set;}
        public String REQUISICION_CRM {get;set;}
        public String RESPUESTA_API {get;set;}
        public Integer RETRY_COUNT {get;set;}
        public String ROW_ID {get;set;}
        public String TIPO_APLICATION {get;set;}



    }
    
    
    global class RequestService{
   		public List<ApplicationItem> APPLICATIONS {get;Set;}
        
        public RequestService(){
        	System.debug('Rquest');
        }
        
        public RequestService(List<ApplicationItem> lstApplys){
            try{
                this.APPLICATIONS = lstApplys;
            }catch(JSONException e){
             	
                ResponseService resp = new ResponseService();
                resp.APPLICATIONS = new List<ApplicationItem>();
            	resp.MENSAJE_API = 'Error en la peticion: ' + e.getStackTraceString();
            	resp.CODIGO_ERROR = 302;
                
                RestResponse res = new RestResponse();
                res.statusCode = 301;
            	String jsonResponse = json.serialize(resp);
            	res.responseBody = blob.valueOf(jsonResponse);
            	return;
                
            }
        }
  	}		
    
    
    global class ResponseService{
       public List<ApplicationItem> APPLICATIONS 	{get;Set;}
       public String MENSAJE_API  		{get;Set;}
       public Integer CODIGO_ERROR  	{get;Set;}
        
        public ResponseService(){
            System.debug('Response');
        }
        
        public ResponseService(List<ApplicationItem> lstApplys, String mensaje, Integer codigoError){
            this.APPLICATIONS = lstApplys;
            this.MENSAJE_API = mensaje;
            this.CODIGO_ERROR = codigoError;
        }
   }

}