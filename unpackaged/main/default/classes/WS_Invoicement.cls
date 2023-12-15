@RestResource(urlMapping='/RestService/Invoicement/*')
global with sharing class WS_Invoicement {
	   
    private static Integer codError = 200;
    private static String msgError = 'Registros procesados correctamente';

    @HttpPost
    global static ResponseService upsertInvoices(RequestService request){
        
        set<String> idsProcesos= new set<String>();
        set<String> idsCuentas= new set<String>();
        set<String> idsOpp= new set<String>();
        ResponseService response = new ResponseService();
        map<String,Consumo_Servicios__c> mapConsumos= new map<String,Consumo_Servicios__c>();
        
        for(InvoiceItem facItm : request.INVOICES){
            idsProcesos.add(facItm.ID_INTERFACE_CRM);
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
       	
            	List<InvoiceItem> facturasRespuesta = new List<InvoiceItem>();
            
            	for(InvoiceItem facItm : request.INVOICES){
            	
                    InvoiceItem invoice = new InvoiceItem();
				
                	invoice.ID_FACTURA_AR				= facItm.ID_FACTURA_AR;
					invoice.LAST_UPD					= facItm.LAST_UPD;
					invoice.LAST_UPD_BY					= facItm.LAST_UPD_BY;
					invoice.RESPUESTA_API				= facItm.RESPUESTA_API;
					invoice.CATEGORIA_DESC				= facItm.CATEGORIA_DESC;
					invoice.CONFLICT_ID					= facItm.CONFLICT_ID;
					invoice.CREATED						= facItm.CREATED;
					invoice.CREATED_BY					= facItm.CREATED_BY;
					invoice.DB_LAST_UPD					= facItm.DB_LAST_UPD;
					invoice.DB_LAST_UPD_SRC				= facItm.DB_LAST_UPD_SRC;
					invoice.DOCUMENTO_APLICADO			= facItm.DOCUMENTO_APLICADO;
					invoice.DOCUMENTO_CLASE				= facItm.DOCUMENTO_CLASE;
					invoice.DOCUMENTO_DESC				= facItm.DOCUMENTO_DESC;
					invoice.DOCUMENTO_REF				= facItm.DOCUMENTO_REF;
					invoice.ENTIDAD_LEGAL				= facItm.ENTIDAD_LEGAL;
					invoice.ESTATUS_FACTURA				= facItm.ESTATUS_FACTURA;
					invoice.ESTATUS_PROCESO				= facItm.ESTATUS_PROCESO;
					invoice.ESTATUS_REG					= facItm.ESTATUS_REG;
					invoice.FECHA_CONTABLE				= facItm.FECHA_CONTABLE;
           	 		invoice.FECHA_CREACION				= facItm.FECHA_CREACION;
					invoice.FECHA_REESTRUCTURA			= facItm.FECHA_REESTRUCTURA;
					invoice.FECHA_VENCIMIENTO			= facItm.FECHA_VENCIMIENTO;
					invoice.FIDEICOMISO_DESC			= facItm.FIDEICOMISO_DESC;
					invoice.FIDEICOMISO_FACT			= facItm.FIDEICOMISO_FACT;
					invoice.FINANCIERA_DESC				= facItm.FINANCIERA_DESC;
					invoice.FINANCIERA_NUM				= facItm.FINANCIERA_NUM;
					invoice.ID_APLICAR_DOCTO			= facItm.ID_APLICAR_DOCTO;
					invoice.ID_CLASE					= facItm.ID_CLASE;
					invoice.ID_CLIENTE_AR				= facItm.ID_CLIENTE_AR;
					invoice.ID_COBRANZA_MULTIPLE		= facItm.ID_COBRANZA_MULTIPLE;
					invoice.ID_DIRECCION_REGIONAL		= facItm.ID_DIRECCION_REGIONAL;
					invoice.ID_DOCUMENTO_TIPO			= facItm.ID_DOCUMENTO_TIPO;
					invoice.ID_FACTURA_CRM				= facItm.ID_FACTURA_CRM;
					invoice.ID_FRACCIONAMIENTO			= facItm.ID_FRACCIONAMIENTO;
					invoice.ID_INTERFACE_CRM			= facItm.ID_INTERFACE_CRM;
                    invoice.ID_INTERFACE				= facItm.ID_INTERFACE;
					invoice.ID_LOTE						= facItm.ID_LOTE;
					invoice.ID_MANZANA					= facItm.ID_MANZANA;
					invoice.ID_MUNICIPIO				= facItm.ID_MUNICIPIO;
					invoice.ID_PAGARE_CONTA				= facItm.ID_PAGARE_CONTA;
					invoice.ID_PAGARE_REVERSA			= facItm.ID_PAGARE_REVERSA;
					invoice.ID_PROCESO_AR				= facItm.ID_PROCESO_AR;
					invoice.ID_PROTOTIPO				= facItm.ID_PROTOTIPO;
					invoice.ID_REESTRUCTURA				= facItm.ID_REESTRUCTURA;
					invoice.ID_TIPO_FACTURA				= facItm.ID_TIPO_FACTURA;
					invoice.IMPORTE_FACTURA				= facItm.IMPORTE_FACTURA;
					invoice.IND_ANTES_ESCRITURA			= facItm.IND_ANTES_ESCRITURA;
					invoice.IND_GASTO_ADMIN				= facItm.IND_GASTO_ADMIN;
					invoice.IND_REEMBOLSO				= facItm.IND_REEMBOLSO;
					invoice.IND_REESTRUCTURADO			= facItm.IND_REESTRUCTURADO;
					invoice.MODIFICATION_NUM			= facItm.MODIFICATION_NUM;
					invoice.MONEDA						= facItm.MONEDA;
					invoice.MONTO_FINANCIADO			= facItm.MONTO_FINANCIADO;
					invoice.NUM_CREDITO					= facItm.NUM_CREDITO;
					invoice.NUM_FACTURA					= facItm.NUM_FACTURA;
					invoice.ORIGEN_DESC					= facItm.ORIGEN_DESC;
					invoice.REQUISICION_CRM				= facItm.REQUISICION_CRM;
					invoice.RETRY_COUNT					= facItm.RETRY_COUNT;
					invoice.ROW_ID						= facItm.ROW_ID;
					invoice.TERM_PAGO					= facItm.TERM_PAGO;
					invoice.TIPO_FACTURA				= facItm.TIPO_FACTURA;
					invoice.VALOR_COB_JAVER				= facItm.VALOR_COB_JAVER;
					invoice.VALOR_OPERACION				= facItm.VALOR_OPERACION;
                    invoice.MENSAJE_API					= facItm.MENSAJE_API;
                    invoice.IND_INTERESES				= facItm.IND_INTERESES;
                    
                    if(mapConsumos.ContainsKey(facItm.ID_INTERFACE_CRM)){
					
                        invoice.RESPUESTA_API				= 'Success';
						invoice.MENSAJE_API					= 'Registro actualizado correctamente';
                        
                    }else{
                        invoice.RESPUESTA_API				= 'Error';
						invoice.MENSAJE_API					= 'Registro no encontrado';
                    }
                
                	facturasRespuesta.add(invoice);
        		}   
                
                response.INVOICES = facturasRespuesta;
        		response.MENSAJE_API  = 'Registros procesados';
       			response.CODIGO_ERROR   = 0; 
                
            }else{
                response.INVOICES = request.INVOICES;
                response.CODIGO_ERROR = 1;
                response.MENSAJE_API = 'No se encontraron registros con los identificadores ingresados.';
            }
            
            
        }catch(Exception e){
            response.MENSAJE_API  = 'Error al procesar la solicitud: ' + e.getStackTraceString();
       		response.CODIGO_ERROR   = 2; 
        }
        
        
        return response;
    }
    
    
    @HttpGet
    global static ResponseService getInvoice(){
        
        ResponseService response = new ResponseService();
        RestRequest req = RestContext.request;
        Map<String,String> dataIds = req.params;
        List<String> ids = new List<String>();
        
        System.debug('&&& ' + json.serialize(req.params) );
        System.debug('&&& ' + dataIds.containsKey('idsAObtener') );
        System.debug('&&& ' + dataIds.get('idsAObtener') );
        
        if(dataIds == null || dataIds.containsKey('idsAObtener') == false){
            response.INVOICES = new List<InvoiceItem>();
            response.CODIGO_ERROR = 301;
            response.MENSAJE_API = 'El parametro idsAObtener debe venir en la peticion.';
        }else if(dataIds.get('idsAObtener') == ''){
            response.INVOICES = new List<InvoiceItem>();
            response.CODIGO_ERROR = 301;
            response.MENSAJE_API = 'El parametro idsAObtener debe de contener al menos un Id para buscar.';
        }else{
        	if(dataIds.get('idsAObtener').indexOf(',') != -1){
            	ids = dataIds.get('idsAObtener').split(',');
        	}else if(dataIds.containsKey('idsAObtener')){
            	ids.add(dataIds.get('idsAObtener'));
        	}   
        }
        
        
        set<String> idsProcesos= new set<String>();
        set<String> idsCuentas= new set<String>();
        set<String> idsOpp= new set<String>();
        
        map<String,Consumo_Servicios__c> mapConsumos= new map<String,Consumo_Servicios__c>();
        

        try{
            
        	List<Consumo_Servicios__c> lstConsumos = new List<Consumo_Servicios__c>();
        	lstConsumos = [SELECT Id,Name, Cuenta__c, Nombre_del_servicio__c, Proceso_de_Venta__c FROM Consumo_Servicios__c WHERE Id IN:  ids]; 
			
            if(!lstConsumos.isEmpty()){
            	
                List<InvoiceItem> facturasRespuesta = new List<InvoiceItem>();
                
                for(String str : ids){
                    
                    Boolean  esta = false;
                    
                    for(Consumo_Servicios__c consum : lstConsumos){
            			if(str.equals(consum.Id)){
                        	esta = true;
                     	}
        			}
                     
                    
                    if(esta == false){
                        InvoiceItem invoice = new InvoiceItem();
                        invoice.ID_INTERFACE_CRM = str;
                        invoice.MENSAJE_API	= 'El Id ' + str + ' no existe o esta equivocado, favor de validar.';
                        invoice.RESPUESTA_API = '300';
                        facturasRespuesta.add(invoice);
                    }
        		}
                
       	
            	
            
            	for(Consumo_Servicios__c consumo : lstConsumos){
            	
                    InvoiceItem invoice = new InvoiceItem();
				
                	invoice.ID_FACTURA_AR				= 012341;
					invoice.LAST_UPD					= Date.today();
					invoice.LAST_UPD_BY					= 'testData';
					invoice.RESPUESTA_API				= 'testData';
					invoice.CATEGORIA_DESC				= 'testData';
					invoice.CONFLICT_ID					= 'testData';
					invoice.CREATED						= Date.today();
					invoice.CREATED_BY					= 'testData';
					invoice.DB_LAST_UPD					= Date.today();
					invoice.DB_LAST_UPD_SRC				= 'testData';
					invoice.DOCUMENTO_APLICADO			= 'testData';
					invoice.DOCUMENTO_CLASE				= 'testData';
					invoice.DOCUMENTO_DESC				= 'testData';
					invoice.DOCUMENTO_REF				= 'testData';
					invoice.ENTIDAD_LEGAL				= 'testData';
					invoice.ESTATUS_FACTURA				= 'testData';
					invoice.ESTATUS_PROCESO				= 012342;
					invoice.ESTATUS_REG					= 012343;
					invoice.FECHA_CONTABLE				= Date.today();
           	 		invoice.FECHA_CREACION				= Date.today();
					invoice.FECHA_REESTRUCTURA			= Date.today();
					invoice.FECHA_VENCIMIENTO			= Date.today();
					invoice.FIDEICOMISO_DESC			= 'testData';
					invoice.FIDEICOMISO_FACT			= 012344;
					invoice.FINANCIERA_DESC				= 'testData';
					invoice.FINANCIERA_NUM				= 'testData';
					invoice.ID_APLICAR_DOCTO			= 012345;
					invoice.ID_CLASE					= 012346;
					invoice.ID_CLIENTE_AR				= 012347;
					invoice.ID_COBRANZA_MULTIPLE		= 012348;
					invoice.ID_DIRECCION_REGIONAL		= 012349;
					invoice.ID_DOCUMENTO_TIPO			= 0123410;
					invoice.ID_FACTURA_CRM				= 'testData';
					invoice.ID_FRACCIONAMIENTO			= 0123412;
					invoice.ID_INTERFACE_CRM			= 'testData';
                    invoice.ID_INTERFACE				= 0123413;
					invoice.ID_LOTE						= 0123414;
					invoice.ID_MANZANA					= 0123415;
					invoice.ID_MUNICIPIO				= 0123416;
					invoice.ID_PAGARE_CONTA				= 0123417;
					invoice.ID_PAGARE_REVERSA			= 0123418;
					invoice.ID_PROCESO_AR				= 0123419;
					invoice.ID_PROTOTIPO				= 0123420;
					invoice.ID_REESTRUCTURA				= 0123421;
					invoice.ID_TIPO_FACTURA				= 0123422;
					invoice.IMPORTE_FACTURA				= 0123423;
					invoice.IND_ANTES_ESCRITURA			= 0123424;
					invoice.IND_GASTO_ADMIN				= 0123425;
					invoice.IND_REEMBOLSO				= 0123426;
					invoice.IND_REESTRUCTURADO			= 0123427;
					invoice.MODIFICATION_NUM			= 0123428;
					invoice.MONEDA						= 'testData';
					invoice.MONTO_FINANCIADO			= 0123429;
					invoice.NUM_CREDITO					= 'testData';
					invoice.NUM_FACTURA					= 'testData';
					invoice.ORIGEN_DESC					= 'testData';
					invoice.REQUISICION_CRM				= 'testData';
					invoice.RETRY_COUNT					= 0123430;
					invoice.ROW_ID						= 'testData';
					invoice.TERM_PAGO					= 'testData';
					invoice.TIPO_FACTURA				= 'testData';
					invoice.VALOR_COB_JAVER				= 0123431;
					invoice.VALOR_OPERACION				= 0123432;
                    invoice.MENSAJE_API					= 'testData';
                    invoice.IND_INTERESES				= 0123433;
                    
                	facturasRespuesta.add(invoice);
        		}   
                
                response.INVOICES = facturasRespuesta;
        		response.MENSAJE_API  = 'Registros obtenidos';
       			response.CODIGO_ERROR   = 0; 
                
            }else if( dataIds.containsKey('idsAObtener') == true && dataIds.get('idsAObtener') != ''){
                response.INVOICES = new List<InvoiceItem>();
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
    global class InvoiceItem{
        
        public Integer ID_FACTURA_AR			{get;set;}
        public Date LAST_UPD					{get;set;}
        public String LAST_UPD_BY				{get;set;}
        public String RESPUESTA_API				{get;set;}
        public String CATEGORIA_DESC			{get;set;}
        public String CONFLICT_ID				{get;set;}
        public Date	CREATED						{get;set;}
        public String CREATED_BY				{get;set;}
        public Date	DB_LAST_UPD					{get;set;}
        public String DB_LAST_UPD_SRC			{get;set;}
        public String DOCUMENTO_APLICADO		{get;set;}
        public String DOCUMENTO_CLASE			{get;set;}
        public String DOCUMENTO_DESC			{get;set;}
        public String DOCUMENTO_REF				{get;set;}
        public String ENTIDAD_LEGAL				{get;set;}
        public String ESTATUS_FACTURA			{get;set;}
        public Integer ESTATUS_PROCESO			{get;set;}
        public Integer ESTATUS_REG				{get;set;}
        public Date FECHA_CONTABLE				{get;set;}
        public Date FECHA_CREACION				{get;set;}
        public Date FECHA_REESTRUCTURA			{get;set;}
        public Date FECHA_VENCIMIENTO			{get;set;}
        public String FIDEICOMISO_DESC			{get;set;}
        public Integer FIDEICOMISO_FACT			{get;set;}
        public String FINANCIERA_DESC			{get;set;}
        public String FINANCIERA_NUM			{get;set;}
        public Integer ID_APLICAR_DOCTO			{get;set;}
        public Integer ID_CLASE					{get;set;}
        public Integer ID_CLIENTE_AR			{get;set;}
        public Integer ID_COBRANZA_MULTIPLE		{get;set;}
        public Integer ID_DIRECCION_REGIONAL	{get;set;}
        public Integer ID_DOCUMENTO_TIPO		{get;set;}
        public String ID_FACTURA_CRM			{get;set;}
        public Integer ID_FRACCIONAMIENTO		{get;set;}
        public Integer ID_INTERFACE				{get;set;}
        public String ID_INTERFACE_CRM			{get;set;}
        public Integer ID_LOTE					{get;set;}
        public Integer ID_MANZANA				{get;set;}
        public Integer ID_MUNICIPIO				{get;set;}
        public Integer ID_PAGARE_CONTA			{get;set;}
        public Integer ID_PAGARE_REVERSA		{get;set;}
        public Integer ID_PROCESO_AR			{get;set;}
        public Integer ID_PROTOTIPO				{get;set;}
        public Integer ID_REESTRUCTURA			{get;set;}
        public Integer ID_TIPO_FACTURA			{get;set;}
        public Decimal IMPORTE_FACTURA			{get;set;}
        public Integer IND_ANTES_ESCRITURA		{get;set;}
        public Integer IND_GASTO_ADMIN			{get;set;}
        public Integer IND_INTERESES			{get;set;}
        public Integer IND_REEMBOLSO			{get;set;}
        public Integer IND_REESTRUCTURADO		{get;set;}
        public Integer MODIFICATION_NUM			{get;set;}
        public String MONEDA					{get;set;}
        public Integer MONTO_FINANCIADO			{get;set;}
        public String NUM_CREDITO				{get;set;}
        public String NUM_FACTURA				{get;set;}
        public String ORIGEN_DESC				{get;set;}
        public String REQUISICION_CRM			{get;set;}
        public Integer RETRY_COUNT				{get;set;}
        public String ROW_ID					{get;set;}
        public String TERM_PAGO					{get;set;}
        public String TIPO_FACTURA				{get;set;}
        public Integer VALOR_COB_JAVER			{get;set;}
        public Decimal VALOR_OPERACION			{get;set;}
        public String MENSAJE_API				{get;set;}

    }
    
    
    global class RequestService{
   		public List<InvoiceItem> INVOICES {get;Set;}
        
        public RequestService(){
        	System.debug('Rquest');
        }
        
        public RequestService(List<InvoiceItem> lstInvoices){
            this.INVOICES = lstInvoices;
        }
  	}		
    
    
    global class ResponseService{
       public List<InvoiceItem> INVOICES 	{get;Set;}
       public String MENSAJE_API  		{get;Set;}
       public Integer CODIGO_ERROR  	{get;Set;}
        
        public ResponseService(){
            System.debug('Response');
        }
        
        public ResponseService(List<InvoiceItem> lstInvoices, String mensaje, Integer codigoError){
            this.INVOICES = lstInvoices;
            this.MENSAJE_API = mensaje;
            this.CODIGO_ERROR = codigoError;
        }
   }
}