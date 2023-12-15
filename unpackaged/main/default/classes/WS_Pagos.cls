@RestResource(urlMapping='/RestService/Payments/*')
global with sharing class WS_Pagos {

       
    private static Integer codError = 200;
    private static String msgError = 'Registros procesados correctamente';

    @HttpPost
    global static ResponseService upsertPagos(RequestService request){
        
        set<String> idsProcesos= new set<String>();
        set<String> idsCuentas= new set<String>();
        set<String> idsOpp= new set<String>();
        ResponseService response = new ResponseService();
        map<String,Consumo_Servicios__c> mapConsumos= new map<String,Consumo_Servicios__c>();
        
        for(PaymentItem acoItm : request.PAGOS){
            idsProcesos.add(acoItm.ID_INTERFACE_CRM);
        }

        try{
            
        	List<Consumo_Servicios__c> lstConsumos = new List<Consumo_Servicios__c>();
        	lstConsumos = [SELECT Id,Name, Cuenta__c, Nombre_del_servicio__c, Proceso_de_Venta__c FROM Consumo_Servicios__c WHERE Id IN:  idsProcesos]; 
			
            if(!lstConsumos.isEmpty()){
            	
                for(Consumo_Servicios__c consumo : lstConsumos){
            		idsCuentas.add(consumo.Cuenta__c);
            		idsOpp.add(consumo.Proceso_de_Venta__c);
            		mapConsumos.put(consumo.Id,consumo);
        		}
       	
            	List<PaymentItem> pagosRespuesta = new List<PaymentItem>();
            
            	for(PaymentItem acoItm : request.PAGOS){
            	
                    PaymentItem payment = new PaymentItem();
				
                	payment.CONFLICT_ID					= acoItm.CONFLICT_ID;
					payment.CREATED						= acoItm.CREATED;
					payment.CREATED_BY					= acoItm.CREATED_BY;
					payment.DB_LAST_UPD					= acoItm.DB_LAST_UPD;
					payment.DB_LAST_UPD_SRC				= acoItm.DB_LAST_UPD_SRC;
					payment.DESC_TIPO_DOCTO				= acoItm.DESC_TIPO_DOCTO;
					payment.FECHA_CONTABLE				= acoItm.FECHA_CONTABLE;
					payment.FECHA_DEPOSITO				= acoItm.FECHA_DEPOSITO;
					payment.FECHA_RECIBO				= acoItm.FECHA_RECIBO;
					payment.ID_CLIENTE_AR				= acoItm.ID_CLIENTE_AR;
					payment.ID_COBRANZA_MULTIPLE		= acoItm.ID_COBRANZA_MULTIPLE;
					payment.ID_ESTADO_VENTA				= acoItm.ID_ESTADO_VENTA;
					payment.ID_INTERFACE				= acoItm.ID_INTERFACE;
					payment.ID_INTERFACE_CRM			= acoItm.ID_INTERFACE_CRM;
					payment.ID_MONEDA					= acoItm.ID_MONEDA;
					payment.ID_PROCESO_AR				= acoItm.ID_PROCESO_AR;
					payment.ID_RECIBO_AR				= acoItm.ID_RECIBO_AR;
					payment.ID_RECIBO_CRM				= acoItm.ID_RECIBO_CRM;
					payment.ID_REESTRUCTURA				= acoItm.ID_REESTRUCTURA;
           	 		payment.ID_SECTOR					= acoItm.ID_SECTOR;
					payment.ID_TIPO_DOCTO				= acoItm.ID_TIPO_DOCTO;
					payment.IMPORTE_RECIBO				= acoItm.IMPORTE_RECIBO;
					payment.IND_ANTICIPO				= acoItm.IND_ANTICIPO;
					payment.IND_REVERSA					= acoItm.IND_REVERSA;
					payment.LAST_UPD					= acoItm.LAST_UPD;
					payment.LAST_UPD_BY					= acoItm.LAST_UPD_BY;
					payment.METODO						= acoItm.METODO;
					payment.MODIFICATION_NUM			= acoItm.MODIFICATION_NUM;
					payment.NUM_RECIBO					= acoItm.NUM_RECIBO;
					payment.REFERENCIA					= acoItm.REFERENCIA;
					payment.REQUISICION_CRM				= acoItm.REQUISICION_CRM;
					payment.RETRY_COUNT					= acoItm.RETRY_COUNT;
					payment.ROW_ID						= acoItm.ROW_ID;
					payment.SESION_CAJA_ID				= acoItm.SESION_CAJA_ID;
					payment.TIPO_PAGO					= acoItm.TIPO_PAGO;
                    
                    if(mapConsumos.ContainsKey(acoItm.ID_INTERFACE_CRM)){
					
                        payment.RESPUESTA_API				= 'Registro actualizado correctamente';
						payment.MENSAJE_API					= 'Success';
                        
                    }else{
                        payment.RESPUESTA_API				= 'Registro no encontrado';
						payment.MENSAJE_API					= 'Error';
                    }
                
                	pagosRespuesta.add(payment);
        		}   
                
                response.PAGOS = pagosRespuesta;
        		response.MENSAJE_API  = 'Registros procesados';
       			response.CODIGO_ERROR   = 0; 
                
            }else{
                response.PAGOS = request.PAGOS;
                response.CODIGO_ERROR = 1;
                response.MENSAJE_API = 'No se encontraron registros con los identificadores ingresados.';
            }
            
            
        }catch(Exception e){
            response.MENSAJE_API  = 'Error al procesar la solicitud: ' + e.getStackTraceString();
       		response.CODIGO_ERROR   = 1; 
        }
        
        
        return response;
    }
    

   //Se generan las sub-clases a utilizar
    global class PaymentItem{
        
        public String CONFLICT_ID					{get;set;}
        public Date CREATED							{get;set;}
        public String CREATED_BY					{get;set;}
        public Date DB_LAST_UPD						{get;set;}
        public String DB_LAST_UPD_SRC				{get;set;}
        public String DESC_TIPO_DOCTO				{get;set;}
        public Date FECHA_CONTABLE					{get;set;}
        public Date FECHA_DEPOSITO					{get;set;}
        public Date FECHA_RECIBO					{get;set;}
        public Integer ID_CLIENTE_AR				{get;set;}
        public Integer ID_COBRANZA_MULTIPLE			{get;set;}
        public Integer ID_ESTADO_VENTA				{get;set;}
        public Integer ID_INTERFACE					{get;set;}
        public String ID_INTERFACE_CRM				{get;set;}
        public String ID_MONEDA						{get;set;}
        public String ID_PROCESO_AR					{get;set;}
        public Integer ID_RECIBO_AR					{get;set;}
        public String ID_RECIBO_CRM					{get;set;}
        public Integer ID_REESTRUCTURA				{get;set;}
        public Integer ID_SECTOR					{get;set;}
        public Integer ID_TIPO_DOCTO				{get;set;}
        public Integer IMPORTE_RECIBO				{get;set;}
        public Integer IND_ANTICIPO					{get;set;}
        public Integer IND_REVERSA					{get;set;}
        public Date LAST_UPD						{get;set;}
        public String LAST_UPD_BY					{get;set;}
        public String MENSAJE_API					{get;set;}
        public String METODO						{get;set;}
        public Integer MODIFICATION_NUM				{get;set;}
        public String NUM_RECIBO					{get;set;}
        public String REFERENCIA					{get;set;}
        public String REQUISICION_CRM				{get;set;}
        public String RESPUESTA_API					{get;set;}
        public Integer RETRY_COUNT					{get;set;}
        public String ROW_ID						{get;set;}
        public String SESION_CAJA_ID				{get;set;}
        public String TIPO_PAGO						{get;set;}
        
    }
    
    
    global class RequestService{
   		public List<PaymentItem> PAGOS {get;Set;}
        
        public RequestService(){
        	System.debug('Rquest');
        }
        
        public RequestService(List<PaymentItem> lstPagos){
            this.PAGOS = lstPagos;
        }
  	}		
    
    
    global class ResponseService{
       public List<PaymentItem> PAGOS 	{get;Set;}
       public String MENSAJE_API  		{get;Set;}
       public Integer CODIGO_ERROR  	{get;Set;}
        
        public ResponseService(){
            System.debug('Response');
        }
        
        public ResponseService(List<PaymentItem> lstPagos, String mensaje, Integer codigoError){
            this.PAGOS = lstPagos;
            this.MENSAJE_API = mensaje;
            this.CODIGO_ERROR = codigoError;
        }
   }
    
}