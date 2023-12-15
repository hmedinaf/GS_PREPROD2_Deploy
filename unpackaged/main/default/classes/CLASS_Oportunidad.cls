public with sharing class CLASS_Oportunidad {
    // Valores utilizados en el metodo "validaCoAcreditado"
    // Tipo_de_Tramite__c 
    private static final String CONYUGAL = 'CONYUGAL';
    // Producto_financiero__c
    private static final Set<String> PRODUCT_NAME_SET = new Set<String> {
        'FOVISSSTE PARA TODOS',
        'COFINAVIT CONYUGAL',
        'CONYUGAL',
        'CONYUGAL C/SUBSIDIO 2.6 VSM',
        'CONYUGAL C/SUBSIDIO 5 VSM',
        'UNAMOS CREDITOS'
	};
                
    //Metodo que asigna valores a la cuenta despues de haberse creado la oportunidad
    public void asignaValoresAutomaticosCuenta(List<Opportunity> oportunidadesNuevas){

        System.debug('*****asignaValoresAutomaticosCuenta');
        //Se obtienen los ids de las cuentas asociadas a las nuevas oportunidades
        Set<Id> idsCuentas = new Set<Id>();
        for(Opportunity oportunidadNueva : oportunidadesNuevas){

            idsCuentas.add(oportunidadNueva.AccountId);
        }
        System.debug('*****idsCuentas:' + idsCuentas);

        //Se obtienen los datos de las cuentas asociadas a las nuevas oportunidades
        Map<Id,Account> cuentas = new Map<Id,Account>([SELECT Id, Afluencia_Virtual__c, RecordTypeId FROM Account WHERE Id IN : idsCuentas]);
        System.debug('*****cuentas:' + cuentas);

        Id tipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Id tipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Moral').getRecordTypeId();
        Account cuenta = new Account();
        List<Account> cuentasActualizar = new List<Account>();
        for(Opportunity oportunidadNueva : oportunidadesNuevas){
          
            cuenta = cuentas.get(oportunidadNueva.AccountId);

            //Si la cuenta asociada a las nuevas oportunidades es de tipo prospecto (Prospecto Persona Fisica o Prospecto Persona Moral) se le asigna el valor en el campo afluencia virtual
            /* HMF - EFB me lo dijo porque YAZ se lo dijo
            if(cuenta.recordTypeId == tipoRegistroProspectoPersonaFisica || cuenta.recordTypeId == tipoRegistroProspectoPersonaMoral){
                cuenta.Afluencia_Virtual__c = oportunidadNueva.CreatedDate;
                cuentasActualizar.add(cuenta);
            }
            */
            
        }

        //Si hay cuentas a actualizar se actualizan
        if(cuentasActualizar.size() > 0){

            update cuentasActualizar;
        }        
    }

    //Metodo para crear registro de Cobranza Comercial cuando la oportunidad paso a estatus Formalizado, aun no tiene creado un registro de Cobranza Comercial y tiene un registro de Titulacion
    public void crearCobranzaComercial(List<Opportunity> oportunidadesNuevas,Map<Id,Opportunity> oportunidadesExistentes){

        //Se obtienen los ids de las oportunidades que se modificaron a estatus Formalizado y aun no tiene creado un registro de Cobranza Comercial
        Set<Opportunity> oportunidadesFormalizacion = new Set<Opportunity>();
        Set<Id> idsOportunidadesFormalizacion = new Set<Id>();
        for(Opportunity oportunidadNueva : oportunidadesNuevas){

            System.debug('*****oportunidadNueva.StageName:' + oportunidadNueva.StageName);
            System.debug('*****oportunidadesExistentes.get(oportunidadNueva.Id).StageName:' + oportunidadesExistentes.get(oportunidadNueva.Id).StageName);
            System.debug('*****oportunidadNueva.Cantidad_Cobranzas_Comerciales__c:' + oportunidadNueva.Cantidad_Cobranzas_Comerciales__c);
            if(oportunidadNueva.StageName == 'Formalizado' && oportunidadNueva.StageName != oportunidadesExistentes.get(oportunidadNueva.Id).StageName && oportunidadNueva.Cantidad_Cobranzas_Comerciales__c == 0){
                oportunidadesFormalizacion.add(oportunidadNueva);
                idsOportunidadesFormalizacion.add(oportunidadNueva.Id);
            }            
        }

        //Si hay oportunidades que pasaron a estatus Formalizado y
        //aun no tienen creado un registro de Cobranza Comercial
        //se valida si la oportunidad tiene asociado un registro de Titulacion
        if(oportunidadesFormalizacion.size() > 0){

            //Se obtienen los datos de las titulaciones relacionadas a las oportunidades relacionadas a los registros a crear de Cobranza Comercial
            /*Map<Id,Titulacion__c> titulaciones = new Map<Id,Titulacion__c>();
            for(Titulacion__c titulacion : [SELECT Id, Proceso_de_Venta__c FROM Titulacion__c WHERE Proceso_de_Venta__c IN : idsOportunidadesFormalizacion]){
                titulaciones.put(titulacion.Proceso_de_Venta__c, titulacion);
            }

            Set<Opportunity> oportunidadesFormalizacionTitulacion = new Set<Opportunity>();
            for(Opportunity oportunidadNueva : oportunidadesFormalizacion){

                //Si la oportunidad no cuenta con un registro de Titulacion se envia mensaje de error
                if(titulaciones.containsKey(oportunidadNueva.Id) == false){
                    oportunidadNueva.addError('No se puede crear el registro de Cobranza Comercial pues el Proceso de Venta no cuenta con un registro de Titulación.');
                }
                else{
                    oportunidadesFormalizacionTitulacion.add(oportunidadNueva);
                }
            }*/ 

            //Si hay oportunidades que pasaron a estatus Formalizado y
            //aun no tienen creado un registro de Cobranza Comercial y
            //tienen registro de titulacion
            //se les crea su registro de Cobranza Comercial
            /*if(oportunidadesFormalizacionTitulacion.size() > 0){*/

                List<Cobranza_Comercial__c> nuevasCobranzasComerciales = new List<Cobranza_Comercial__c>();
                for(Opportunity oportunidadFormalizacion : oportunidadesFormalizacion){

                    Cobranza_Comercial__c nuevaCobranzaComercial = new Cobranza_Comercial__c();
                    nuevaCobranzaComercial.Proceso_Venta__c = oportunidadFormalizacion.Id;
                    nuevasCobranzasComerciales.add(nuevaCobranzaComercial);
                }
                //Si hay nuevos registros de Cobranza Comercial se crean
                if(nuevasCobranzasComerciales.size() > 0){
                    insert nuevasCobranzasComerciales;
                }
            /*}*/
        }
    }
    
    //Metodo que valida lo necesario para cambiar de estatus a "Formalizado"
    public void validaRepLegal(Map<Id,Opportunity> mapOld, list<Opportunity> lstNew){
    	set<String> idsOpp = new set<String>();
        
        for(Opportunity opp : lstNew ){
            if(mapOld.get(opp.Id).StageName != opp.StageName && opp.StageName == 'Formalizado'){
            	idsOpp.add(opp.Id);    
            }
        }

        if(!idsOpp.isEmpty()){
       		
            Map<Id,Opportunity> mapOppInfo = new Map<Id,Opportunity>([SELECT Id, AccountId, Account.Tipo_Contribuyente__c  FROM Opportunity WHERE Id IN: idsOpp]);
        	
            List<Contract> lstContract = new List<Contract>();
        	lstContract = [SELECT Id, Oportunidad__c FROM Contract WHERE Oportunidad__c IN: idsOpp];
        	Map<String,List<Contract>> mapContractByOpp = new Map<String,List<Contract>>();
        
        	if(!lstContract.isEmpty()){
            	for(Contract contrato : lstContract){
            		if(!mapContractByOpp.containsKey(contrato.Oportunidad__c)){
                   		List<Contract> lstTemp = new List<Contract>();
                   		lstTemp.add(contrato);
                   		mapContractByOpp.put(contrato.Oportunidad__c,lstTemp); 
                	}else{
                 		List<Contract> lstTemp = mapContractByOpp.get(contrato.Oportunidad__c);
                		lstTemp.add(contrato);
                		mapContractByOpp.put(contrato.Oportunidad__c,lstTemp);   
            		}    
            	}
        	}
        
        
        	List<Informacion_representante_legal__c> lstRepLegal = new List<Informacion_representante_legal__c>();
        	lstRepLegal = [SELECT Id, Contrato__c, Contrato__r.Oportunidad__c FROM Informacion_representante_legal__c WHERE Contrato__r.Oportunidad__c IN: idsOpp];
        	Map<String,List<Informacion_representante_legal__c>> mapRepLegalByContract = new Map<String,List<Informacion_representante_legal__c>>();
        
        	if(!lstRepLegal.isEmpty()){
            	for(Informacion_representante_legal__c repLeg : lstRepLegal){
            		if(!mapRepLegalByContract.containsKey(repLeg.Contrato__r.Oportunidad__c)){
                   		List<Informacion_representante_legal__c> lstTemp = new List<Informacion_representante_legal__c>();
                   		lstTemp.add(repLeg);
                   		mapRepLegalByContract.put(repLeg.Contrato__r.Oportunidad__c,lstTemp); 
                	}else{
                 		List<Informacion_representante_legal__c> lstTemp = mapRepLegalByContract.get(repLeg.Contrato__r.Oportunidad__c);
                		lstTemp.add(repLeg);
                		mapRepLegalByContract.put(repLeg.Contrato__r.Oportunidad__c,lstTemp);   
            		}    
            	}
        	}
        
        	for(Opportunity oportunity : lstNew ){
            	if(mapOppInfo.get(oportunity.Id).Account.Tipo_Contribuyente__c == 'Persona Física' && 
               	!mapRepLegalByContract.ContainsKey(oportunity.Id) &&
                 mapContractByOpp.containsKey(oportunity.Id)){
                     for(Contract contract : mapContractByOpp.get(oportunity.Id)){
                         if(contract.Firma_Directa_Cliente__c == 'NO' || contract.Firma_Directa_Apoderado_Legal__c == 'SI'){
                         	oportunity.addError('Es necesario capturar al menos un representante legal en la dictaminacion.');   
                         }
                     }
            	}else if(mapOppInfo.get(oportunity.Id).Account.Tipo_Contribuyente__c == 'Persona Moral' && 
               	!mapRepLegalByContract.ContainsKey(oportunity.Id) &&
                 mapContractByOpp.containsKey(oportunity.Id)){
                     for(Contract contract : mapContractByOpp.get(oportunity.Id)){
                         if(contract.Es_usted_el_Titular_de_Recursos__c == 'NO' || 
                            contract.Es_usted_el_Titular_de_Recursos__c == 'SI' ||
                            contract.Escritura_a_favor_de_un_Tercero__c == 'NO' ||
                            contract.Escritura_a_favor_de_un_Tercero__c == 'SI' ||
                            contract.Firma_Directa_Cliente__c == 'NO' ||
                            contract.Firma_Directa_Cliente__c == 'SI' ||
                            contract.Firma_Directa_Apoderado_Legal__c == 'NO' ||
                            contract.Firma_Directa_Apoderado_Legal__c == 'SI'){
                         	oportunity.addError('Es necesario capturar al menos un representante legal en la dictaminacion.');   
                         }
                     }
            	}
        	}
        }

        for(Opportunity opp : lstNew ){
            if(mapOld.get(opp.Id).StageName != opp.StageName && opp.StageName == 'Cancelado'){
            	opp.Fecha_Cancelacion__c = Date.today();    
            }
        }
    }
    
    // ::: Metodo para validar que se tenga un registro de CoAcreditado cuando se cumplan las condiciones
    public void validaCoAcreditado(map<Id, Opportunity>mapOld, list<Opportunity>lstNew) {
        list<String> opportunityIds = new list<String>();
        map<Id, Integer> coAcreditadoMap = new Map<Id, Integer>();
        
        for(Opportunity forData : lstNew) {
            if(forData.Tipo_de_Tramite__c == CONYUGAL || PRODUCT_NAME_SET.contains(forData.Producto_financiero__c)) {
            	opportunityIds.add(forData.Id);
            }
        }
        system.debug('opportunityIds: ' + opportunityIds);
        
        if(!opportunityIds.isEmpty()) {
        	list<Co_Acreditado__c> coAcreditadoList = [select Id, Contrato__c, Contrato__r.Oportunidad__c from Co_Acreditado__c where Contrato__r.Oportunidad__c IN : opportunityIds];
            system.debug('coAcreditadoMap: ' + coAcreditadoMap);
            
            if(!coAcreditadoList.isEmpty()) {
        		for(Co_Acreditado__c forData : coAcreditadoList) {
                    if(!coacreditadoMap.containsKey(forData.Contrato__r.Oportunidad__c)) {
                        coacreditadoMap.put(forData.Contrato__r.Oportunidad__c, 1);
                    }
                    else {
                        coacreditadoMap.put(forData.Contrato__r.Oportunidad__c, coacreditadoMap.get(forData.Contrato__r.Oportunidad__c)+1);
                    }
                }
            }
        }
        system.debug('coacreditadoMap: ' + coacreditadoMap);
        
        if(!coacreditadoMap.isEmpty()) {
        	for(Opportunity forData : lstNew) {
            	system.debug('Salida: ' + coacreditadoMap.get(forData.Id));
                if(coacreditadoMap.get(forData.Id) != 0) {
                    //forData.addError('No se encontraron registros de Co Acreditado(s)');
                }
        	}
        }
    }
    
    // ::: Metodo para crear Pagares una vez que la Oportunidad pase a "Formalización"
    public void creaPagaresFinanciera(Map<Id, Opportunity> triggerOldMap, list<Opportunity> triggerNew) {
        /*
        list<String> idOportunidadFormalizada = new list<String>();
        list<Documento__c> pagaresNuevos = new list<Documento__c>();
        map<String, String> idCobranzaComercial = new map<String, String>();
        map<String, Plan_de_Venta__c> idPlanDeVenta = new map<String, Plan_de_Venta__c>();

        // Se guardan los Id de Oportunidad que cumplen con la condición para generar "Pagaré Financiera"
        for(Opportunity forData : triggerNew) {
            if(forData.StageName == 'Formalizado' && triggerOldMap.get(forData.Id).StageName != forData.StageName) {
                idOportunidadFormalizada.add(forData.Id);
			}
		}

        // Se consulta Cobranza Comercial y Plan de Venta desde Oportunidad
        if(!idOportunidadFormalizada.isEmpty()) {
            list<Opportunity> oportunidad = [select Id, (select Id, Proceso_Venta__c from Cobranza_Comercial__r), (select Id, Oportunidad__c, Credito_Neto_Final_1__c, Credito_Neto_Final_2__c, Credito_Neto_Final_3__c from Plan_de_Venta__r) from Opportunity where Id IN : idOportunidadFormalizada];
            for(Opportunity forData : oportunidad) {
                // Cobranza Comercial
                for(Cobranza_Comercial__c forData2 : forData.Cobranza_Comercial__r) {
                    if(!idCobranzaComercial.containsKey(forData2.Proceso_Venta__c)) {
                        idCobranzaComercial.put(forData2.Proceso_Venta__c, forData2.Id);
                    }
                }
                // Plan de Venta
                for(Plan_de_Venta__c forData3 : forData.Plan_de_Venta__r) {
                    if(!idPlanDeVenta.containsKey(forData3.Oportunidad__c)) {
                        idPlanDeVenta.put(forData3.Oportunidad__c, forData3);
                    }
                }
            }
        }
        
        for(String forData : idPlanDeVenta.keySet()) {
            Documento__c pagareNuevo;
            Plan_de_Venta__c pdv_tmp = idPlanDeVenta.get(forData);
            system.debug('pdv_tmp: ' + pdv_tmp);
            
            if(pdv_tmp.Credito_Neto_Final_1__c > 0) {
                pagareNuevo = new Documento__c();            
            	pagareNuevo.Cobranza_Comercial__c = idCobranzaComercial.get(forData);
            	pagareNuevo.Importe__c = pdv_tmp.Credito_Neto_Final_1__c;
            	pagareNuevo.Tipo__c = 'PAGARE_FINANCIERA';
            	pagareNuevo.Estatus__c = 'Abierto';
            	pagareNuevo.RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByDeveloperName().get('Pagare').getRecordTypeId();
            	pagaresNuevos.add(pagareNuevo);
            }
            
            if(pdv_tmp.Credito_Neto_Final_2__c > 0) {
                pagareNuevo = new Documento__c();            
            	pagareNuevo.Cobranza_Comercial__c = idCobranzaComercial.get(forData);
            	pagareNuevo.Importe__c = pdv_tmp.Credito_Neto_Final_2__c;
            	pagareNuevo.Tipo__c = 'PAGARE_FINANCIERA';
            	pagareNuevo.Estatus__c = 'Abierto';
            	pagareNuevo.RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByDeveloperName().get('Pagare').getRecordTypeId();
            	pagaresNuevos.add(pagareNuevo);
            }
            
            if(pdv_tmp.Credito_Neto_Final_3__c > 0) {
                pagareNuevo = new Documento__c();            
            	pagareNuevo.Cobranza_Comercial__c = idCobranzaComercial.get(forData);
            	pagareNuevo.Importe__c = pdv_tmp.Credito_Neto_Final_3__c;
            	pagareNuevo.Tipo__c = 'PAGARE_FINANCIERA';
            	pagareNuevo.Estatus__c = 'Abierto';
            	pagareNuevo.RecordTypeId = Schema.SObjectType.Documento__c.getRecordTypeInfosByDeveloperName().get('Pagare').getRecordTypeId();
            	pagaresNuevos.add(pagareNuevo);
            }
        }
        system.debug('pagaresNuevos: ' + pagaresNuevos);
        if(!pagaresNuevos.isEmpty()) {
            insert pagaresNuevos;
        }
        */
    }

    public static String CalculaDigitoVerificador (String iReferencia) {
        Map <integer, integer> mapDigPos = new Map <Integer, Integer> {
            1 => 11,
            2 => 13,
            3 => 17,
            4 => 19,
            5 => 23,
            6 => 11,
            7 => 13,
            8 => 17,
            9 => 19,
            10 => 23,
            11 => 11,
            12 => 13,
            13 => 17,
            14 => 19,
            15 => 23
        };

        String sReferencia; // = iReferencia;
        Integer iPosicion = 0;
        Integer iMultiplicadorPosicion = 0;
        Integer iValorTotal = 0;
        Integer iValorPosicion = 0;
        Integer iSumBaseValorTot = 0;
        Integer iModulo = 0;
        String iDigitoVerificador = '';
        
        //try {
            sReferencia = iReferencia.replaceAll('[^0-9]', '');
            //sReferencia = agregarCeros(sReferencia);
            for(Integer i = 0; i < sReferencia.length(); i++) {
                iPosicion = sReferencia.length() - i;
                iMultiplicadorPosicion = mapDigPos.get(iPosicion);
                iValorPosicion = Integer.valueOf(sReferencia.substring(i, i + 1));
                iValorTotal += (iMultiplicadorPosicion * iValorPosicion);
            }

            iSumBaseValorTot = iValorTotal + 333;
            iModulo = math.mod(iSumBaseValorTot, 97);
            iDigitoVerificador = String.valueOf(iModulo + 1);
            if (iDigitoVerificador.length() == 1) {
                iDigitoVerificador = '0' + iDigitoVerificador;
            }
            sReferencia = sReferencia + iDigitoVerificador;
            system.debug('** return sReferencia: '+sReferencia);
            return (sReferencia);
        // } catch(Exception e) {
        //     System.debug(e.getMessage());
        //     return (iReferencia);
        // }
    }

    private static String agregarCeros(String num) {
    /*
    Funcion para rellenar el numero con ceros hasta que sea de 15 digitos.
    */
    try {
        Integer digit = num.length();
        for(Integer i = digit; i < 15; i++) {
            num = '0' + num;
        }
        return num;
        } catch(Exception e) {
            System.debug(LoggingLevel.ERROR, e.getMessage());
            return num;
        }
    }
    /* substituido por nuevo calculo de Digito Verificador
    public static String calculateValidationDigit(String numberString) {
        // String numberString = '0000000000' + String.valueOf(intNumber);
        integer lng = numberString.length();
        Integer[] digits = new Integer[12];
        for (Integer i = 0; i < lng; i++) {
            digits[i] = Integer.valueOf(numberString.substring(i, i+1));
        }
        
        Integer sum = 0;
        for (Integer i = 0; i < lng; i++) {
            if (math.mod(i , 2) == 0) {
                digits[i] *= 2;
                if (digits[i] > 9) {
                    digits[i] = math.mod(digits[i] , 10) + 1;
                }
            }
            sum += digits[i];
        }
        
        Integer validationDigit = 10 - math.mod(sum , 10);
        if (validationDigit == 10) {
            validationDigit = 0;
        }
        
        return String.ValueOf(validationDigit);
    }
    */

    @InvocableMethod (label='Genera digito verificador' description='Genera digito verificador')
    public static List<Result> calculateValidationDigitInvocable(List<Request> requests) {
        List<Result> result = new List<Result>();
        
        for (Request req : requests) {
            String num = req.num;
            
            String validationDigit = CalculaDigitoVerificador(num);
            string vdOnly = validationDigit.substring(validationDigit.length() - 2);
            result.add(new Result(vdOnly));
        }
        
        return result;
    }
    
    public class Request {
        @InvocableVariable(required=true)
        public String num;
    }
    
    public class Result {
        @InvocableVariable
        public String validationDigit;
        
        public Result(String validationDigit) {
            this.validationDigit = validationDigit;
        }
    }
}