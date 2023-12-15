/*
----------------------------------------------------------
* Nombre: UtilsTEST_test
* Autor Saúl González	
* Proyecto: Kavak
* Descripción : Clase con metódos test 
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           19/03/2021     Saúl González           	Creación
* --------------------------------------------------------------------------------
*/
@isTest
public class UtilsTEST_test {

    /*
    * @description Method que devuelve un Lead
    * @param String idLead
	* @return Lead
    */ 
    public static Lead getObjLeadAcct(String idAcct) {
        Lead objLead = new Lead();
			objLead = [SELECT id, Name, JMC_ApellidoMaterno__c,JMC_LeadProfile__c,JMC_EstatusLead__c,JMC_AsesorAsignado__c,status, Asesores__r.name,
        		JMC_Fuente__c,FirstName,LastName, OwnerId, Owner.Name,MobilePhone,ErrorCodeResponseSOAP__c, MsgResponseWS__c,IsConverted,
                JMC_FechaNacimiento__c,Phone,Email,JMC_TipoCredito__c,JMC_NSS__c, LastModifiedById,JMC_ProspectadorMASComercial__c,JMC_Manzana__c,
                JMC_Genero__c,JMC_UEN__c,JMC_Estado__c,JMC_Fraccionamiento__c,JMC_Fraccionamiento__r.name,JMC_CanalVenta__c,JMC_Lote__c, JCM_Carga_inicial__c,
                JMC_SubCanalVenta__c,JMC_Asunto__c,JMC_CapacidadCompra__c,JMC_Edad__c,ID_CUENTA__c FROM Lead Where ID_CUENTA__c =: idAcct];     
        return objLead;
    }
    
    /*
    * @description Method que devuelve un Lead
    * @param String idLead
	* @return Lead
    */ 
    public static Lead getObjLeadName(String name) {
        Lead objLead = new Lead();
			objLead = [SELECT id, Name, JMC_ApellidoMaterno__c,JMC_LeadProfile__c,JMC_EstatusLead__c,JMC_AsesorAsignado__c,status, Asesores__r.Name,
        		JMC_Fuente__c,FirstName,LastName, OwnerId, Owner.Name,MobilePhone,ErrorCodeResponseSOAP__c, MsgResponseWS__c,IsConverted,
                JMC_FechaNacimiento__c,Phone,Email,JMC_TipoCredito__c,JMC_NSS__c, LastModifiedById,JMC_ProspectadorMASComercial__c,JMC_Manzana__c,
                JMC_Genero__c,JMC_UEN__c,JMC_Estado__c,JMC_Fraccionamiento__c,JMC_Fraccionamiento__r.name,JMC_CanalVenta__c,JMC_Lote__c,JCM_Carga_inicial__c,
                JMC_SubCanalVenta__c,JMC_Asunto__c,JMC_CapacidadCompra__c,JMC_Edad__c,ID_CUENTA__c FROM Lead Where ID_CUENTA__c =: name];     
        return objLead;
    }
}