/**
 * @description       : 
 * @author            : Jose V. Aguilar Tlaseca
 * @group             : 
 * @last modified on  : 2023-06-12
 * @last modified by  : Jose V. Aguilar Tlaseca
**/
public without sharing class CLASS_EBS_Cuentas {
	
    @InvocableMethod(label='Consume EBS Service Accounts by OPP' description='' category='Opportunity')
  	public static List<Output> getAccountNames(List<Input> datos) {
    	
        Integer requisicionCrm = datos.get(0).requisicion;
        List<Output> lstRespuestas = new List<Output>();
		Request lstData = new Request();
		List<Output> lstOutputs = new List<Output>();
		Savepoint sp = Database.setSavepoint();
		
        
        lstData = generaDatos(datos.get(0).identificadores, datos.get(0).requisicion);

		if(lstData != null){
			Output out = new Output();

			String payload = JSON.serialize(lstData);

			System.debug('https://qesb.javer.com.mx:11962/services/EBS/ClientesSfCRMtoERPReq/rest REQUEST: ' + payload);
			
			Try{
        	
            HttpRequest request = new HttpRequest();
     		request.setEndpoint('https://qesb.javer.com.mx:11962/services/EBS/ClientesSfCRMtoERPReq/rest');
     		request.setMethod('POST');
            request.setBody(payload);
			request.setTimeout(120000);
			
            
            Http http = new Http();
     		HTTPResponse res = http.send(request);
            Response resp = new Response();
            resp = (Response) JSON.deserialize(res.getBody(), Response.CLASS);
     		System.debug(res.getBody());
            
            out.codigoRespuesta = 0;
            out.MensajeRespuesta = 'Success';
    		lstOutputs.add(out);
            
        	}catch(Exception e){
            	out.codigoRespuesta = 1;
            	out.MensajeRespuesta = 'Error: ' + e.getMessage();
            	lstOutputs.add(out);    
        	}
		}
		
        
        return lstRespuestas; 
  	}


	  private Static Request generaDatos(List<String> idsRegistros, Integer requisicionCrm){ //private Static List<Request> generaDatos(List<String> idsRegistros, Integer requisicionCrm){ 
		
		Request lstData = new Request(); //List<Request> lstData = new List<Request>(); 
		
		//try{

			//Obtenemos los registros necesarios
        	
            //---Direcciones
        	DescribeSObjectResult describeResultDir = Direcciones__c.getSObjectType().getDescribe();	
			List<String> fieldNamesDir = new List<String>( describeResultDir.fields.getMap().keySet() );
        	String queryDir =' SELECT ' + String.join( fieldNamesDir, ',' ) + ' FROM ' + describeResultDir.getName() + ' WHERE ' + ' id IN :idsRegistros ';
        	List<Direcciones__c> lstDir = Database.query( queryDir );
            
        	//---Opportunidades
        	DescribeSObjectResult describeResultOpp = Opportunity.getSObjectType().getDescribe();	
			List<String> fieldNamesOpp = new List<String>( describeResultOpp.fields.getMap().keySet() );
        	String queryOpp =' SELECT ' + String.join( fieldNamesOpp, ',' ) + ' FROM ' + describeResultOpp.getName() + ' WHERE ' + ' id IN :idsRegistros ';
        	List<Opportunity> lstOpp = Database.query( queryOpp );
        
        	//---Dictaminaciones
        	DescribeSObjectResult describeResultContract = Contract.getSObjectType().getDescribe();	
			List<String> fieldNamesContract = new List<String>( describeResultContract.fields.getMap().keySet() );
        	String queryContr =' SELECT ' + String.join( fieldNamesContract, ',' ) + ' FROM ' + describeResultContract.getName() + ' WHERE ' + ' Oportunidad__c IN :idsRegistros ';
        	List<Contract> lstContract = Database.query( queryContr );
        
        	//---Planes de venta
        	DescribeSObjectResult describeResultPlanVenta = Plan_de_Venta__c.getSObjectType().getDescribe();	
			List<String> fieldNamesPlanVenta = new List<String>( describeResultPlanVenta.fields.getMap().keySet() );
        	String queryPlanVenta =' SELECT ' + String.join( fieldNamesPlanVenta, ',' ) + ' FROM ' + describeResultPlanVenta.getName() + ' WHERE ' + ' Oportunidad__c IN :idsRegistros ';
        	List<Plan_de_Venta__c> lstPlanesVenta = Database.query( queryPlanVenta );
        
        	//---Cuentas
        	set<String> idsCuentas = new set<String>();
        	for(Opportunity oppTemp : lstOpp){idsCuentas.add(oppTemp.AccountId);}
        	DescribeSObjectResult describeAccount = Account.getSObjectType().getDescribe();	
			List<String> fieldAccount = new List<String>( describeAccount.fields.getMap().keySet() );
        	String queryAccount =' SELECT ' + String.join( fieldAccount, ',' ) + ' FROM ' + describeAccount.getName() + ' WHERE ' + ' Id IN :idsCuentas ';
        	List<Account> lstAccounts = Database.query( queryAccount );

			//---Referencias
			set<String> idsDictaminaciones = new set<String>();
        	for(Contract contr : lstContract){idsDictaminaciones.add(contr.Id);}
        	DescribeSObjectResult describeRefer = Referencia_familiar__c.getSObjectType().getDescribe();	
			List<String> fieldRefer = new List<String>( describeRefer.fields.getMap().keySet() );
        	String queryRefer =' SELECT Contrato__r.Oportunidad__c, ' + String.join( fieldRefer, ',' ) + ' FROM ' + describeRefer.getName() + ' WHERE ' + ' Contrato__c IN :idsDictaminaciones ';
        	List<Referencia_familiar__c> lstReferencias = Database.query( queryRefer );

			//---ProductosOportunidad
			DescribeSObjectResult describeProdOpp = OpportunityLineItem.getSObjectType().getDescribe();	
			List<String> fieldProdOpp = new List<String>( describeProdOpp.fields.getMap().keySet() );
        	String queryProdOpp =' SELECT ' + String.join( fieldProdOpp, ',' ) + ' FROM ' + describeProdOpp.getName() + ' WHERE ' + ' OpportunityId IN :idsRegistros ';
        	List<OpportunityLineItem> lstProdOpp = Database.query( queryProdOpp );

			//---Viviendas
			set<String> idsViviendas = new set<String>();
        	for(OpportunityLineItem oppLin : lstProdOpp){idsViviendas.add(oppLin.Vivienda__c);}
        	DescribeSObjectResult describeViv = Vivienda__c.getSObjectType().getDescribe();	
			List<String> fieldViv = new List<String>( describeViv.fields.getMap().keySet() );
        	String queryViv =' SELECT ' + String.join( fieldViv, ',' ) + ' FROM ' + describeViv.getName() + ' WHERE ' + ' Id IN :idsViviendas ';
        	List<Vivienda__c> lstViv = Database.query( queryViv );


			//Generamos mapas de la informacion acomodada por id de la oportunidad a excepcion de la cuenta que esa es por id
        	Map<String,Contract> mapDictaminaciones = new Map<String,Contract>();
        	for(Contract cont : lstContract){
				mapDictaminaciones.put(cont.Oportunidad__c, cont);  
        	}
        
        	Map<String,List<Plan_de_Venta__c>> mapPlanesVenta = new Map<String,List<Plan_de_Venta__c>>();
    		for(Plan_de_Venta__c planVent : lstPlanesVenta){
            	if(!mapPlanesVenta.containsKey(planVent.Oportunidad__c)){
            		List<Plan_de_Venta__c> lstPlanVenta = new List<Plan_de_Venta__c>();
                	lstPlanVenta.add(planVent);
                	mapPlanesVenta.put(planVent.Oportunidad__c, lstPlanVenta);
            	}else{
                	List<Plan_de_Venta__c> lstPlanVenta = mapPlanesVenta.get(planVent.Oportunidad__c);
                	lstPlanVenta.add(planVent);
                	mapPlanesVenta.put(planVent.Oportunidad__c, lstPlanVenta);
            	}   
        	}
        
        	Map<String,Account> mapAccounts = new Map<String,Account>();
    		for(Account aco : lstAccounts){
            	mapAccounts.put(aco.Id, aco); 
        	}


			Map<String,List<Referencia_familiar__c>> mapReferencias = new Map<String,List<Referencia_familiar__c>>();
			if( null != lstReferencias && !lstReferencias.isEmpty()){
				for(Referencia_familiar__c ref : lstReferencias){
					if(!mapReferencias.containsKey(ref.Contrato__c)){
            			List<Referencia_familiar__c> lstRefTemp = new List<Referencia_familiar__c>();
                		lstRefTemp.add(ref);
                		mapReferencias.put(ref.Contrato__c, lstRefTemp);
            		}else{
                		List<Referencia_familiar__c> lstRefTemp = mapReferencias.get(ref.Contrato__c);
                		lstRefTemp.add(ref);
                		mapReferencias.put(ref.Contrato__c, lstRefTemp);
            		} 
				}
			}


			Map<String,List<OpportunityLineItem>> mapProdOpp = new Map<String,List<OpportunityLineItem>>();
			if( null != lstProdOpp && !lstProdOpp.isEmpty()){
				for(OpportunityLineItem prodOpp : lstProdOpp){
					if(!mapProdOpp.containsKey(prodOpp.OpportunityId)){
            			List<OpportunityLineItem> lstOppTemp = new List<OpportunityLineItem>();
                		lstOppTemp.add(prodOpp);
                		mapProdOpp.put(prodOpp.OpportunityId, lstOppTemp);
            		}else{
                		List<OpportunityLineItem> lstOppTemp = mapProdOpp.get(prodOpp.OpportunityId);
                		lstOppTemp.add(prodOpp);
                		mapProdOpp.put(prodOpp.OpportunityId, lstOppTemp);
            		} 
				}
			}

			Map<String,Vivienda__c> mapViviendas = new Map<String,Vivienda__c>();
			if( null != lstViv && !lstViv.isEmpty()){
				for(Vivienda__c viv : lstViv){
					mapViviendas.put(viv.Id, viv); 
				}
			}

			//Recorremos la lista de los procesos de venta a tratar y generamos los registros a mandar en la peticion
			List<Consumo_Servicios__c> lstConsumos = new List<Consumo_Servicios__c>();
			Map<String,Consumo_Servicios__c> mapConsumos = new Map<String,Consumo_Servicios__c>();
			for( Opportunity oppCon : lstOpp){
				Consumo_Servicios__c consumo = new Consumo_Servicios__c();
				consumo.Cuenta__c = oppCon.AccountId;
				consumo.Nombre_del_servicio__c = 'GDS_Cuentas';
				consumo.Proceso_de_Venta__c = oppCon.Id;
				mapConsumos.put(oppCon.Id, consumo);
			}

			insert mapConsumos.Values();

        	for( Opportunity opp : lstOpp){
            	
                Data data = new Data();
                
                //Datos de cuenta
            	data.ApellidoMaterno 			= mapAccounts.get(opp.AccountId).Apellidomaterno_cta__c != null ? mapAccounts.get(opp.AccountId).Apellidomaterno_cta__c : '' ;
            	data.ApellidoPaterno 			= mapAccounts.get(opp.AccountId).Apellidopaterno_cta__c != null ? mapAccounts.get(opp.AccountId).Apellidopaterno_cta__c : '' ;
            	data.Calle 						= mapAccounts.get(opp.AccountId).Calle__c != null ? mapAccounts.get(opp.AccountId).Calle__c : '' ;
            	data.Ciudad 					= mapAccounts.get(opp.AccountId).BillingCity != null ? mapAccounts.get(opp.AccountId).BillingCity : '' ;
            	data.CodigoPosta 				= mapAccounts.get(opp.AccountId).BillingPostalCode != null ? Integer.valueOf(mapAccounts.get(opp.AccountId).BillingPostalCode) : null ;
            	data.Colonia 					= mapAccounts.get(opp.AccountId).Colonia_cta__c != null ? mapAccounts.get(opp.AccountId).Colonia_cta__c : null ;
		    	data.Created 					= mapAccounts.get(opp.AccountId).CreatedDate != null ? Date.valueOf(mapAccounts.get(opp.AccountId).CreatedDate) : null ;
            	data.CreatedBy 					= mapAccounts.get(opp.AccountId).CreatedById != null ? mapAccounts.get(opp.AccountId).CreatedById : null ;
           		data.Curp 						= mapAccounts.get(opp.AccountId).CURP__c != null ? mapAccounts.get(opp.AccountId).CURP__c : '' ;
					String domicilioFiscal      = String.valueOf
					(
						mapAccounts.get(opp.AccountId).BillingStreet != null ? mapAccounts.get(opp.AccountId).BillingStreet : '' + ', ' + (mapAccounts.get(opp.AccountId).BillingCity != null ? mapAccounts.get(opp.AccountId).BillingCity : '') + ', ' + (mapAccounts.get(opp.AccountId).BillingState != null ? mapAccounts.get(opp.AccountId).BillingState : '') + ', ' + (mapAccounts.get(opp.AccountId).BillingPostalCode != null ? mapAccounts.get(opp.AccountId).BillingPostalCode : '') + ', ' + (mapAccounts.get(opp.AccountId).BillingCountry != null ? mapAccounts.get(opp.AccountId).BillingCountry : '')
					);

            	data.DomicilioOficial 			= domicilioFiscal;
            	data.EDAD 						= mapAccounts.get(opp.AccountId).Edad__c != null ? String.valueOf(mapAccounts.get(opp.AccountId).Edad__c) : '' ;
            	data.Estado 					= mapAccounts.get(opp.AccountId).Estado_cta__c != null ? mapAccounts.get(opp.AccountId).Estado_cta__c : null ;
            	data.FechaNacimiento	 		= mapAccounts.get(opp.AccountId).FechaNacimiento__c != null ? String.valueOf(mapAccounts.get(opp.AccountId).FechaNacimiento__c) : null ;
		    	data.FechaEscrituracion 		= mapAccounts.get(opp.AccountId).FechaEscrituracion__c != null ? mapAccounts.get(opp.AccountId).FechaEscrituracion__c : null ;
		    	data.FechaFormalizacion 		= mapAccounts.get(opp.AccountId).FechaFormalizacion__c != null ? mapAccounts.get(opp.AccountId).FechaFormalizacion__c : null ;
            	data.Fraccionamiento 			= mapAccounts.get(opp.AccountId).Fraccionamiento_cta__c != null ? mapAccounts.get(opp.AccountId).Fraccionamiento_cta__c : '' ;
            	data.IdClienteCrm				= mapAccounts.get(opp.AccountId).Id != null ? mapAccounts.get(opp.AccountId).Id : '' ;
				data.LugarNacimiento	 		= mapAccounts.get(opp.AccountId).Lugar_Nacimiento__c != null ? mapAccounts.get(opp.AccountId).Lugar_Nacimiento__c : '' ;
            	data.Nacionalidad 				= mapAccounts.get(opp.AccountId).Nacionalidad__c != null ? mapAccounts.get(opp.AccountId).Nacionalidad__c : '' ;
            	data.Nombre 					= mapAccounts.get(opp.AccountId).FirstName != null ? mapAccounts.get(opp.AccountId).FirstName : '' ;
            	data.Nombre_Cliente 			= mapAccounts.get(opp.AccountId).Name != null ? mapAccounts.get(opp.AccountId).Name : '' ;
            	data.Nss 						= mapAccounts.get(opp.AccountId).NSS__c != null ? mapAccounts.get(opp.AccountId).NSS__c : '' ;
            	data.NumProcesoAr 				= opp.Name != null ? opp.Name : '' ;
            	data.NumeroDomicilio	 		= mapAccounts.get(opp.AccountId).NumeroExterior__c != null ? mapAccounts.get(opp.AccountId).NumeroExterior__c : '' ;
            	data.NumeroInterno 				= mapAccounts.get(opp.AccountId).NumeroInterior__c != null ? mapAccounts.get(opp.AccountId).NumeroInterior__c : '' ;
            	data.Pais 						= mapAccounts.get(opp.AccountId).Pais_cta__c != null ? mapAccounts.get(opp.AccountId).Pais_cta__c : null ;
            	data.Prototipo 					= mapAccounts.get(opp.AccountId).Prototipo_lookup__c != null ? mapAccounts.get(opp.AccountId).Prototipo_lookup__c : '' ;
            	data.ReferenciaBancaria 		= mapAccounts.get(opp.AccountId).ReferenciaBancariaCliente__c != null ? mapAccounts.get(opp.AccountId).ReferenciaBancariaCliente__c : '' ;
            	data.RequisicionCrm	 			= String.valueOf(requisicionCrm) != null ? String.valueOf(requisicionCrm) : '' ;
            	data.Rfc 						= mapAccounts.get(opp.AccountId).RFC_Completo__c != null ? mapAccounts.get(opp.AccountId).RFC_Completo__c : '' ;
            	data.Sexo 						= mapAccounts.get(opp.AccountId).Sexo__c != null ? mapAccounts.get(opp.AccountId).Sexo__c : '' ;
            	data.TelefonoCelular	 		= mapAccounts.get(opp.AccountId).TelefonoCelular__c != null ? mapAccounts.get(opp.AccountId).TelefonoCelular__c : '' ;
            	data.TelefonoParticular 		= mapAccounts.get(opp.AccountId).TelefonoCelular__c != null ? mapAccounts.get(opp.AccountId).TelefonoCelular__c : '' ;
            	data.TelefonoRefOtro1 			= mapAccounts.get(opp.AccountId).TelefonoOtro__c != null ? mapAccounts.get(opp.AccountId).TelefonoOtro__c : '' ;
            	data.TelefonoRefOtro2 			= mapAccounts.get(opp.AccountId).TelefonoTrabajo__c != null ? mapAccounts.get(opp.AccountId).TelefonoTrabajo__c : '' ;
            	data.TipoCredito				= mapAccounts.get(opp.AccountId).Tipo_Credito__c != null ? mapAccounts.get(opp.AccountId).Tipo_Credito__c : '' ;
            	data.Uen 						= mapAccounts.get(opp.AccountId).UEN__c != null ? mapAccounts.get(opp.AccountId).UEN__c : '' ;
            	data.LastUpd 					= mapAccounts.get(opp.AccountId).LastModifiedDate != null ? Date.valueOf(mapAccounts.get(opp.AccountId).LastModifiedDate) : null ;
		    	data.LastUpdBy	 				= String.valueOf(mapAccounts.get(opp.AccountId).LastModifiedById) != null ? String.valueOf(mapAccounts.get(opp.AccountId).LastModifiedById) : null ;
            	data.DbLastUpd	 				= null;
            	data.DbLastUpdSrc 				= '';
            	data.Fideicomiso 				= String.valueOf(mapDictaminaciones.get(opp.Id).Cliente_Fideicomiso__c) != null ? String.valueOf(mapDictaminaciones.get(opp.Id).Cliente_Fideicomiso__c) : '' ;
            	data.IdInterfase	 			= '';
            	data.IdInterfaseCrm	 			= mapConsumos.get(opp.Id).Id != null ? mapConsumos.get(opp.Id).Id : '' ;
            	data.IdPago 					= '';
            	data.IndExigible 				= 0;
            	data.Interior 					= mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Num_Interior__c != null ? mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Num_Interior__c : '' ;
            	data.Lote 						= mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Lote__c != null ? mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Lote__c : '' ;
            	data.Manzana					= mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Manzana__c != null ? mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Manzana__c : '' ;
		    	data.MetrosTerrenoExcedente		= mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Excendente_M2__c != null ? mapViviendas.get(mapProdOpp.get(opp.Id)[0].Vivienda__c).Excendente_M2__c : null ;
            	data.NombreReferencia1 			= mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[0].Nombre__c != null ? mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[0].Nombre__c : '' ;
            	data.NombreReferencia2 			= mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[1].Nombre__c != null ? mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[1].Nombre__c : '' ;
            	data.NombreReferencia3 			= mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[2].Nombre__c != null ? mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[2].Nombre__c : '' ;
            	data.RowId 						= '';
            	data.TelefonoRefOtro3 			= '';
            	data.TelefonoReferencia1		= mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[0].Telefono_1__c != null ? mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[0].Telefono_1__c : '' ;
            	data.TelefonoReferencia2		= mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[1].Telefono_1__c != null ? mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[1].Telefono_1__c : '' ;
            	data.TelefonoReferencia3		= mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[2].Telefono_1__c != null ? mapReferencias.get(mapDictaminaciones.get(opp.Id).Id)[2].Telefono_1__c : '' ;
            	data.TipoLote		 			= '';
            	data.IdClienteAr	 			= '';
            	data.IdProcesoAr 				= 0;
            	data.MensajeApi 				= '';
            	data.RespuestaApi 				= '';

				lstData.InsClientesSfCRMtoERP = data;
                //lstData.add(data);
        	}

		/*}catch(Exception e){
			System.debug('Error: ' + e.getMessage());
		}*/
	
		return lstData; 
	}
    
    
	public class Data {
        String ApellidoMaterno 				{get;set;}
        String ApellidoPaterno 				{get;set;}
        String Calle 						{get;set;}
        String Ciudad 						{get;set;}
        Integer CodigoPosta 				{get;set;}
        String Colonia 						{get;set;}
		Date Created 						{get;set;}
        String CreatedBy 					{get;set;}
        String Curp 						{get;set;}
		Date DbLastUpd	 					{get;set;}
        String DbLastUpdSrc 				{get;set;}
        String DomicilioOficial 			{get;set;}
        String EDAD 						{get;set;}
        String Estado 						{get;set;}
        String FechaNacimiento	 			{get;set;}
		Date FechaEscrituracion 			{get;set;}
		Date FechaFormalizacion 			{get;set;}
        String Fideicomiso 					{get;set;}
        String Fraccionamiento 				{get;set;}
        String IdClienteCrm		 			{get;set;}
        String IdInterfase	 				{get;set;}
        String IdInterfaseCrm	 			{get;set;}
        String IdPago 						{get;set;}
        Integer IndExigible 				{get;set;}
        String Interior 					{get;set;}
        String Lote 						{get;set;}
        String LugarNacimiento	 			{get;set;}
        String Manzana					 	{get;set;}
		Decimal MetrosTerrenoExcedente	 	{get;set;}
        String Nacionalidad 				{get;set;}
        String Nombre 						{get;set;}
        String Nombre_Cliente 				{get;set;}
        String NombreReferencia1 			{get;set;}
        String NombreReferencia2 			{get;set;}
        String NombreReferencia3 			{get;set;}
        String Nss 							{get;set;}
        String NumProcesoAr 				{get;set;}
        String NumeroDomicilio	 			{get;set;}
        String NumeroInterno 				{get;set;}
        String Pais 						{get;set;}
        String Prototipo 					{get;set;}
        String ReferenciaBancaria 			{get;set;}
        String RequisicionCrm	 			{get;set;}
        String Rfc 							{get;set;}
        String RowId 						{get;set;}
        String Sexo 						{get;set;}
        String TelefonoCelular	 			{get;set;}
        String TelefonoParticular 			{get;set;}
        String TelefonoRefOtro1 			{get;set;}
        String TelefonoRefOtro2 			{get;set;}
        String TelefonoRefOtro3 			{get;set;}
        String TelefonoReferencia1	 		{get;set;}
        String TelefonoReferencia2	 		{get;set;}
        String TelefonoReferencia3		 	{get;set;}
        String TipoCredito				 	{get;set;}
        String TipoLote		 				{get;set;}
        String Uen 							{get;set;}
        String IdClienteAr	 				{get;set;}
        Integer IdProcesoAr 				{get;set;}
		DATE LastUpd 						{get;set;}
		String LastUpdBy	 				{get;set;}
        String MensajeApi 					{get;set;}
        String RespuestaApi 				{get;set;}
  	}
    
    public class Request {
		String something {get;set;}
        Data InsClientesSfCRMtoERP 	{get;set;}
  	}
    
    public class Response {
        String MensajeApi 		{get;set;}
        String RespuestaApi 	{get;set;}
        Integer IdClienteAr 	{get;set;}
        Integer IdProcesoAr 	{get;set;}
        
  	}
    
    public class Input {
  		@InvocableVariable(label='Requisición CRM' description='' required=true)
  		public Integer requisicion;
        
        @InvocableVariable(label='Identificadores' description='' required=true)
  		public List<String> identificadores;
  	}
    
    public class Output {
  		@InvocableVariable(label='Código e respuesta' description='' required=true)
  		public Integer codigoRespuesta;
        
        @InvocableVariable(label='Mensaje respeusta' description='' required=true)
  		public String MensajeRespuesta;
  	}
    
}