global class AccountHandler_ctrl {
    
    
     /*
    * @description método realiza la validación de criterios para ejecutar el WS
    * @param List<Lead> arrLeadsN
    * @param List<Lead> arrLeadso
    * @param Map<Id, Lead> newLeadMap
    * @param Map<Id, Lead> oldLeadMap
    * @return "Metodo void"
    */
    global static void valWSUpd(List<Lead> arrLeadsN, List<Lead> arrLeadso, Map<Id, Lead> newLeadMap , Map<Id, Lead> oldLeadMap) {
        for(Lead l : arrLeadsN){
            if((String.isNotBlank(l.JMC_Analisisinterno__c) && l.JMC_Analisisinterno__c.equals('Perfilado'))
              && (!oldLeadMap.get(l.Id).Status.equals('Envío MAS Comercial') && l.Status.equals('Envío MAS Comercial'))) {
             //   LeadHandler_cls.executeWS(l.Id);
            }
            if(String.isNotBlank(l.JMC_Analisisinterno__c) && l.JMC_Analisisinterno__c.equals('Perfilado') 
               && (!oldLeadMap.get(l.Id).JMC_ValidardatosSiebel__c && l.JMC_ValidardatosSiebel__c)) {
             //   LeadHandler_cls.executeWS(l.Id);
            }
        }
    }
    
    /*
    * @description parsea el objeto json y almacena los datos en objetos custom Salesforce.
    * @param String json
    * @return String strResponse
    */
    public Map<String,String> upAccount(Map<String, Object> mapJson) {
        final Map<String,String> mapResponse =  new  Map<String,String>();
        String mail = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('mailLead'));
        System.debug(mail);
        boolean notProcess = true;
        Account l = new Account();
        List<Account> lstAcct = new List<Account>();
        if(String.isNotBlank(mail)) {
            lstAcct = AccountUtils_ctrl.getObjAccount(mail); 
            if(lstAcct!=null && lstAcct.size()>0){
                l = lstAcct[0];
                notProcess =false;
            }            
        }
        if(notProcess) {
            mapResponse.put('idRespuesta', '2');          
            mapResponse.put('respuesta', 'Mail es requerido para poder realizar la actualización');          
            mapResponse.put('idSalesforce','');
        } else {
            l.PersonBirthdate = String.isNotBlank((String)mapJson.get('fechaNac')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaNac')) : l.PersonBirthdate;
            l.FirstName = String.isNotBlank((String)mapJson.get('nombre')) ? String.valueOf((String)mapJson.get('nombre')) : l.FirstName;
            /*l.Middlename = String.isNotBlank((String)mapJson.get('apellidoPaterno')) ? String.valueOf((String)mapJson.get('apellidoPaterno')) : l.Middlename;*/
            l.LastName = String.isNotBlank((String)mapJson.get('apellidoMaterno')) ? String.valueOf((String)mapJson.get('apellidoMaterno')) : l.LastName;
            l.JMC_AsesorAsignado__c = String.isNotBlank((String)mapJson.get('asesor')) ? (String)mapJson.get('asesor') : l.JMC_AsesorAsignado__c;
            l.CanalVenta__c = String.isNotBlank((String)mapJson.get('canalVenta')) ? (String)mapJson.get('canalVenta') : l.CanalVenta__c;
            l.SubCanalVenta__c = String.isNotBlank((String)mapJson.get('subCanal')) ? (String)mapJson.get('subCanal') : l.SubCanalVenta__c;
            l.Tipo__c = String.isNotBlank((String)mapJson.get('estatusCliente')) ? (String)mapJson.get('estatusCliente') : l.Tipo__c; 
            String fracName =  LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('fraccionamiento'));
            if(String.isNotBlank(fracName)){
                Fraccionamiento__c frac = LeadsUtils_ctrl.getFracc(fracName);
                l.Fraccionamiento_cta__c = frac.Id;
            }
            l.Sexo__c = String.isNotBlank((String)mapJson.get('genero')) ? (String)mapJson.get('genero') : l.Sexo__c;
            l.PersonEmail = String.isNotBlank((String)mapJson.get('mailLead')) ? (String)mapJson.get('mailLead') : l.PersonEmail;
            l.NSS__c = String.isNotBlank((String)mapJson.get('nss')) ? (String)mapJson.get('nss') : l.NSS__c;
            l.phone = String.isNotBlank((String)mapJson.get('phone')) ? LeadsUtils_ctrl.getFilteredPhone((String)mapJson.get('phone')) : l.phone;
            l.PersonHomePhone = String.isNotBlank((String)mapJson.get('telefono')) ? LeadsUtils_ctrl.getFilteredPhone((String)mapJson.get('telefono')) : l.PersonHomePhone;
            l.TelefonoCelular__c = String.isNotBlank((String)mapJson.get('telefono')) ? LeadsUtils_ctrl.getFilteredPhone((String)mapJson.get('telefono')) : l.TelefonoCelular__c;
            l.TipoCredito__c = String.isNotBlank((String)mapJson.get('tipoCredito')) ? (String)mapJson.get('tipoCredito') : l.TipoCredito__c;
            l.JMC_Fecha_Visita__c = String.isNotBlank((String)mapJson.get('fechaVisita')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaVisita')) : l.JMC_Fecha_Visita__c;
            l.JMC_Fecha_Afluencia__c = String.isNotBlank((String)mapJson.get('fechaAfluencia')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaAfluencia')) : l.JMC_Fecha_Afluencia__c;
            l.JMC_Lote__c = String.isNotBlank((String)mapJson.get('lote')) ? ((String)mapJson.get('lote')) : l.JMC_Lote__c;
            l.JMC_Manzana__c = String.isNotBlank((String)mapJson.get('manzana')) ? ((String)mapJson.get('manzana')) : l.JMC_Manzana__c;
            l.JMC_Fecha_Cancelacion__c = String.isNotBlank((String)mapJson.get('fechaCancelacion')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaCancelacion')) : l.JMC_Fecha_Cancelacion__c;
            l.FechaEscrituracion__c = String.isNotBlank((String)mapJson.get('fechaEscrituracion')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaEscrituracion')) : l.FechaEscrituracion__c;
            l.JMC_Fecha_Entrega__c = String.isNotBlank((String)mapJson.get('fechaEntrega')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaEntrega')) : l.JMC_Fecha_Entrega__c;
            l.FechaReserva__c = String.isNotBlank((String)mapJson.get('fechaReserva')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaReserva')) : l.FechaReserva__c;
            l.NumeroInterior__c = String.isNotBlank((String)mapJson.get('numeroInterior')) ? (String)mapJson.get('numeroInterior') : l.NumeroInterior__c;
            l.NumProceso__c = String.isNotBlank((String)mapJson.get('numeroProceso')) ? (String)mapJson.get('numeroProceso') : l.NumProceso__c;
            l.EstatusProceso__c = String.isNotBlank((String)mapJson.get('estatusProceso')) ? (String)mapJson.get('estatusProceso') : l.EstatusProceso__c;
            //l.JMC_Estatus_Proceso__c = String.isNotBlank((String)mapJson.get('EstatusProceso')) ? (String)mapJson.get('EstatusProceso') : l.JMC_Estatus_Proceso__c;
            l.Numerodecliente__c = String.isNotBlank((String)mapJson.get('numeroCliente')) ? (String)mapJson.get('numeroCliente') : l.Numerodecliente__c;
            l.NumCliente__c = String.isNotBlank((String)mapJson.get('numeroCliente')) ? (String)mapJson.get('numeroCliente') : l.NumCliente__c;
            l.FechaFormalizacion__c = String.isNotBlank((String)mapJson.get('fechaFormalizacion')) ? LeadsUtils_ctrl.getDate((String)mapJson.get('fechaFormalizacion')) : l.FechaFormalizacion__c;

            
            
            String leadName = LeadsUtils_ctrl.validaDatoVacio((String)mapJson.get('leadProfiler'));
            if(String.isNotBlank(leadName)){
                //User usr = LeadsUtils_ctrl.getUser(leadName);
                //l.OwnerId = usr.Id;
            }
            update l;
            mapResponse.put('idRespuesta', '0');          
            mapResponse.put('respuesta', 'Actualización de Account exitosa');          
            mapResponse.put('idSalesforce',l.Id);
        } 
        return mapResponse;
    }
    
    /*
    * @description método realiza la conversión de un account al objeto del WS SOAP
    * @param String idLead
    * @return SalesforceLeads_SOAP.leads lstLead 
    */
    public LeadService_SOAP.leads mapConstLead(Account objAccount) { 
        LeadService_SOAP.leads lstLeads = new LeadService_SOAP.leads();
        LeadService_SOAP.lead objLead = new LeadService_SOAP.lead();
        if(objAccount!=null){
            objLead.SalesForceId = objAccount.Id;
            /*objLead.NombreCompleto =  objAccount.FirstName + ' '+objAccount.MiddleName+ ' '+objAccount.LastName;*/
            objLead.NombreCompleto =  objAccount.FirstName + ' '+objAccount.LastName;
            objLead.LeadProfiler = objAccount.Owner.Name; 
            objLead.EstatusLead =  objAccount.JMC_EstatusLead__c;
            objLead.Asesor =  objAccount.Asesor__c;
            objLead.EstatusProceso =  objAccount.EstatusProceso__c;
            objLead.Nombre =  objAccount.FirstName;
            /*objLead.ApellidoPaterno =  objAccount.MiddleName;*/
            objLead.ApellidoMaterno =  objAccount.lastname;
            objLead.FechaNacimiento =  objAccount.FechaNacimiento__c!= null ? String.valueof(objAccount.FechaNacimiento__c) : '';            
            objLead.TelefonoOtro =  objAccount.PersonMobilePhone;
            objLead.Telefono =  objAccount.PersonHomePhone;
            objLead.MailLead =  objAccount.PersonEmail;
            objLead.TipoCredito =  objAccount.TipoCredito__c;
            objLead.NSS =  objAccount.NSS__c; 
            objLead.Genero =  objAccount.Sexo__c; 
            objLead.Fraccionamiento =  objAccount.Fraccionamiento_cta__r.Name;
            objLead.CanalVenta =  objAccount.CanalVenta__c;
            objLead.SubCanal =  objAccount.SubCanalVenta__c;
            System.debug(objLead);
            lstLeads.Lead = objLead;   
        }
        System.debug(lstLeads);
        return lstLeads; 
    }
    
    
}