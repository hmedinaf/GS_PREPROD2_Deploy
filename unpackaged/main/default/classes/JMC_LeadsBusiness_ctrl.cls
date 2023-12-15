/*
----------------------------------------------------------
* Nombre: JMC_LeadsBusiness_ctrl
* Autor Saúl González
* Proyecto: MC - FreewayConsulting
* Descripción : Clase que verifica las reglas de negocio para un lead

* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           22/02/2021     Saúl González            Creación
* --------------------------------------------------------------------------------
*/


public class JMC_LeadsBusiness_ctrl {
    
    public JMC_LeadsBusiness_ctrl(){}
        
    /*
    * @description método realiza la conversión de un lead al objeto del WS SOAP
    * @param String idLead
    * @return SalesforceLeads_SOAP.leads lstLeads
    */
    public LeadService_SOAP.leads mapConstLead(Lead objGetLead) {
        LeadService_SOAP.leads lstLeads = new LeadService_SOAP.leads();
        LeadService_SOAP.lead objLead = new LeadService_SOAP.lead();
        if(objGetLead!=null){
            objLead.SalesForceId = objGetLead.Id;
            /*objLead.NombreCompleto =  objGetLead.FirstName + ' '+objGetLead.MiddleName+ ' '+objGetLead.LastName;*/
            objLead.NombreCompleto =  objGetLead.FirstName + ' '+objGetLead.LastName;
            objLead.LeadProfiler = objGetLead.Owner.Name; 
            objLead.EstatusLead =  objGetLead.JMC_EstatusLead__c;
            objLead.Asesor =  objGetLead.Asesores__r.name;
            objLead.EstatusProceso =  objGetLead.status;
            objLead.Fuente =  objGetLead.JMC_Fuente__c;
            objLead.Nombre =  objGetLead.FirstName;
            /*objLead.ApellidoPaterno =  objGetLead.MiddleName;*/
            objLead.ApellidoMaterno =  objGetLead.lastname;
            objLead.FechaNacimiento =  objGetLead.JMC_FechaNacimiento__c!= null ? String.valueof(objGetLead.JMC_FechaNacimiento__c) : '';            
            objLead.TelefonoOtro =  objGetLead.MobilePhone;
            objLead.Telefono =  objGetLead.Phone;
            objLead.MailLead =  objGetLead.Email;
            objLead.TipoCredito =  objGetLead.JMC_TipoCredito__c;
            objLead.NSS =  objGetLead.JMC_NSS__c; 
            objLead.Genero =  objGetLead.JMC_Genero__c; 
            objLead.UEN =  objGetLead.JMC_UEN__c;
            objLead.Estado =  objGetLead.JMC_Estado__c;
            objLead.Fraccionamiento =  objGetLead.JMC_Fraccionamiento__r.Name;
            objLead.CanalVenta =  objGetLead.JMC_CanalVenta__c;
            objLead.SubCanal =  objGetLead.JMC_SubCanalVenta__c;
            objLead.Asunto =  objGetLead.JMC_Asunto__c;     
            objLead.Edad =  LeadsUtils_ctrl.getStringDec(objGetLead.JMC_Edad__c);  
            System.debug(objLead);
            lstLeads.Lead = objLead;   
        }
        System.debug(lstLeads);
        return lstLeads; 
    }
    
    
    /*
    * @description parsea el objeto json y almacena los datos en objetos custom Salesforce.
    * @param String json
    * @return String strResponse
    */
    public Map<String,String> upLead(String strJson) {
        String strValid = '';
        Map<String,String> mapResponse =  new  Map<String,String>();
        Map<String, Object> mapJson = (Map<String, Object>) JSON.deserializeUntyped(strJson);
        System.debug(mapJson);
        String idLead = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('idSF'));
        System.debug(idLead);
        String mail = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('mailLead'));
        System.debug(mail);
        boolean notProcess = true;
        Lead l = new Lead();
        Lead[] arrL = new List<Lead>();
        if(String.isNotBlank(mail)) {
            arrL = LeadsUtils_ctrl.getObjLeadMail(mail);
            System.debug('Entrando a mail');
            if(arrL!=null && arrL.size()>0){
                System.debug('Entrando a size');
                l = arrL[0];
                if(arrL[0].isConverted) {
                    System.debug('Entrando a converted');
                    AccountHandler_ctrl aH = new AccountHandler_ctrl();
                    mapResponse = aH.upAccount(mapJson);
                    return mapResponse;
                }
            }
            notProcess =false;
        }
        if(notProcess) {
            mapResponse.put('idRespuesta', '2');          
            mapResponse.put('respuesta', 'Es requerido idSF o mailLead para poder realizar la actualización');          
            mapResponse.put('idSalesforce',''); 
        } else {
            System.debug(l);
            System.debug('Entrando a Lead');
            l.JMC_SBLAccntId__c = String.isNotBlank((String)mapJson.get('rowId')) ? (String)mapJson.get('rowId') : l.JMC_SBLAccntId__c;
            l.JMC_FechaNacimiento__c = String.isNotBlank((String)mapJson.get('fechaNac')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaNac')) : l.JMC_FechaNacimiento__c;
            l.FirstName = String.isNotBlank((String)mapJson.get('nombre')) ? String.valueOf((String)mapJson.get('nombre')) : l.FirstName;
            /*l.Middlename = String.isNotBlank((String)mapJson.get('apellidoPaterno')) ? String.valueOf((String)mapJson.get('apellidoPaterno')) : l.Middlename;*/
            l.LastName = String.isNotBlank((String)mapJson.get('apellidoMaterno')) ? String.valueOf((String)mapJson.get('apellidoMaterno')) : l.LastName;
            l.JMC_AsesorAsignado__c = String.isNotBlank((String)mapJson.get('asesor')) ? (String)mapJson.get('asesor') : l.JMC_AsesorAsignado__c;
            l.JMC_CanalVenta__c = String.isNotBlank((String)mapJson.get('canalVenta')) ? (String)mapJson.get('canalVenta') : l.JMC_CanalVenta__c;
            l.JMC_SubCanalVenta__c = String.isNotBlank((String)mapJson.get('subCanal')) ? (String)mapJson.get('subCanal') : l.JMC_SubCanalVenta__c;
            String fracName =  LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('fraccionamiento'));
            if(String.isNotBlank(fracName)){
                Fraccionamiento__c frac = LeadsUtils_ctrl.getFracc(fracName);
                if(frac!=null)
                    l.JMC_Fraccionamiento__c = frac.Id;
                else
                    strValid = ', Fraccionamiento incorrecto';
            }
            l.JMC_Genero__c = String.isNotBlank((String)mapJson.get('genero')) ? (String)mapJson.get('genero') : l.JMC_Genero__c;
            l.Email = String.isNotBlank((String)mapJson.get('mailLead')) ? (String)mapJson.get('mailLead') : l.Email;
            l.JMC_NSS__c = String.isNotBlank((String)mapJson.get('nss')) ? (String)mapJson.get('nss') : l.JMC_NSS__c;
            l.phone = String.isNotBlank((String)mapJson.get('phone')) ? '+'+((String)mapJson.get('phone')) :  l.phone;
            l.mobilephone = String.isNotBlank((String)mapJson.get('telefono')) ? '+'+(String)mapJson.get('telefono') : l.mobilephone;
            l.JMC_SBLAccntId__c = String.isNotBlank((String)mapJson.get('sblAccntId')) ? (String)mapJson.get('sblAccntId') : l.JMC_SBLAccntId__c;
            l.JMC_TipoCredito__c = String.isNotBlank((String)mapJson.get('tipoCredito')) ? (String)mapJson.get('tipoCredito') : l.JMC_TipoCredito__c;
            l.JMC_uen__c = String.isNotBlank((String)mapJson.get('uen')) ? (String)mapJson.get('uen') : l.JMC_uen__c;
            l.JMC_edad__c = String.isNotBlank((String)mapJson.get('edad')) ? LeadsUtils_ctrl.getDecimal((String)mapJson.get('edad')) : l.JMC_edad__c;
            l.JMC_asunto__c = String.isNotBlank((String)mapJson.get('asunto')) ? (String)mapJson.get('asunto') : l.JMC_asunto__c;
            String leadName = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('leadProfiler'));
            System.debug(leadName);
            if(String.isNotBlank(leadName)){
                User usr = LeadsUtils_ctrl.getUser(leadName);
                if(usr!=null)
                    l.OwnerId = usr.Id;
                else
                    strValid = ', Lead Profiler incorrecto';
            }
            upsert l;
            mapResponse.put('idRespuesta', '0');          
            mapResponse.put('respuesta', 'Actualización de Lead exitosa');          
            mapResponse.put('idSalesforce',l.Id);
        } 
        return mapResponse;
    }
    
    /*
    * @description parsea el objeto json y almacena los datos en objetos custom Salesforce.
    * @param String json
    * @return String strResponse
    */
    public Map<String,String> leadBot(String strJson) {
        String strValid = '';
        Map<String,String> mapResponse =  new  Map<String,String>();
        Map<String, Object> mapJson = (Map<String, Object>) JSON.deserializeUntyped(strJson);
        System.debug(mapJson);
        String mail = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('email'));
        System.debug(mail);
        boolean notProcess = true;
        Lead l = new Lead();
        Lead[] arrL = new List<Lead>();
        if(String.isNotBlank(mail)) {
            arrL = LeadsUtils_ctrl.getObjLeadMail(mail);
            System.debug('Entrando a mail');
            if(arrL!=null && arrL.size()>0){
                System.debug('Entrando size');
                l= arrL[0];
            }
        }
        l.FirstName = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('firstName'));
        /*l.Middlename = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('middleName'));*/
        l.LastName = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('lastName'));
        l.phone = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('phone'));
        //l.status = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('status'));
        l.email = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('email'));
        String fracName =  LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('fraccionamiento'));
        if(String.isNotBlank(fracName)){
            Fraccionamiento__c frac = LeadsUtils_ctrl.getFracc(fracName);
            if(frac!=null)
                l.JMC_Fraccionamiento__c = frac.Id;
            else
                strValid = ', Fraccionamiento incorrecto';
        } 
        l.JMC_FechaNacimiento__c = LeadsUtils_ctrl.getDate((String)mapJson.get('fechaNacimiento'));   
        String fn = (String)mapJson.get('fechaNacimiento');
        System.debug(fn);
        l.JMC_TipoCredito__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('tipoCredito'));      
        l.JMC_NSS__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('nss'));  
        l.JMC_CURP__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('curp'));
        l.JMC_Fuente__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('fuente'));
        l.JMC_CanalVenta__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('canal'));
        l.JMC_SubCanalVenta__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('subCanalVenta'));
        l.JMC_PresupuestoCompra__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('presupuestoCompra'));        
        l.JMC_Analisisinterno__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('analisisInterno'));
        l.JMC_ComentariosLead__c = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('comentarios'));
        l.JMC_CapacidadCompra__c = LeadsUtils_ctrl.getDecimal((String)mapJson.get('capacidadCompra'));
        String leadName = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('leadProfiler'));
        System.debug(leadName);
        if(String.isNotBlank(leadName)){
            User usr = LeadsUtils_ctrl.getUser(leadName);
            if(usr!=null)
                l.OwnerId = usr.Id;
            else
                strValid = ', Lead Profiler incorrecto';
        }
        upsert l;
        
        mapResponse.put('idRespuesta', '0');          
        mapResponse.put('respuesta', 'Lead exitosa'+strValid);          
        mapResponse.put('idSalesforce',l.Id);
        return mapResponse;
    }
    
    
    public Map<String, object> sendCalloutREST(String jsonParams){
        Map<String, object> results = new Map<String, object>();
        String jsonRps = '';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        try {
            request.setEndpoint(Gestion_EndPoint__mdt.getInstance('GetHorarios').endPoint__c+jsonParams);
            request.setMethod('GET');
            request.setHeader('Accept', '*/*');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            //Payload body = new Payload('', '2021-03-18T23:44:23.991-06:00','3'); 
            //String jsonString = JSON.serialize(body);
            System.debug(jsonParams);
            //request.setBody(jsonParams);
            response = http.send(request);
            if (response.getStatusCode() == 200) {
                results = (Map<String, object>) JSON.deserializeUntyped(response.getBody());
                System.debug(results);
            } else {
                results.put('@Success',false);
                results.put('@MsgWS',response.getStatusCode() + ' '+ response.getBody());
            }
        } catch(Exception e){
            System.debug('Error::'+e.getMessage());
            results.put('@Success',false);
            results.put('@MsgWS','Error:: '+e.getMessage());
        }
        return results;
    }






    
    public class Payload{
        String User;
        String SearchDate;
        String IdPlaza;
        public Payload(String us, String sDate, String idP){
            this.User = us;
            this.SearchDate = sDate;
            this.IdPlaza = idP;
        }
    }
    
    public class Horarios{
        public List<Horario> Horario;
    }
    
    public class Horario{ 
        public integer IdHorario;   
        public integer IdPlaza;   
        public String Plaza;   
        
        public String StartDate;   
        public String EndDate;   
        public String OutHour;   
        public boolean StatusDescanso;   
        public integer Status;   
        public String UserModificacion;   
        
        public Agente Agente;
    }
    
    public class Agente{
        public integer IdUser;
        public String User;
        public String AgenteName;
        public integer IdTypeAgente;
        public String Descripcion;
    }
    
    
}