public class LeadsBusiness_ctrl {
	
    public LeadsBusiness_ctrl(){}
        
    public LeadService_SOAP.leads mapConstLead(String idLead) {
        LeadService_SOAP.leads lstLeads = new LeadService_SOAP.leads();
        LeadService_SOAP.lead objLead = new LeadService_SOAP.lead();
        Lead objGetLead= LeadsUtils_ctrl.getObjLead(idLead);
        if(objGetLead!=null){ 
            objLead.NombreCompleto =  objGetLead.Name + ' '+objGetLead.JMC_ApellidoMaterno__c;
            objLead.LeadProfiler = objGetLead.Owner.Name;
            objLead.EstatusLead =  objGetLead.JMC_EstatusLead__c;
            objLead.Asesor =  objGetLead.JMC_AsesorAsignado__c;
            objLead.EstatusProceso =  objGetLead.status;
            objLead.Fuente =  objGetLead.JMC_Fuente__c;
            objLead.Nombre =  objGetLead.FirstName;
            objLead.ApellidoPaterno =  objGetLead.LastName;
            objLead.ApellidoMaterno =  objGetLead.JMC_ApellidoMaterno__c;
            objLead.FechaNacimiento =  objGetLead.JMC_FechaNacimiento__c!=null ? String.valueOf(objGetLead.JMC_FechaNacimiento__c) : '';
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
            lstLeads.Lead = objLead;   
        }
        return lstLeads;
        
    }
       
}