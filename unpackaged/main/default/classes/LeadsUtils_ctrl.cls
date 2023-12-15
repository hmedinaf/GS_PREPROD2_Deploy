/*
----------------------------------------------------------
* Nombre: LeadsUtils_ctrl
* Autor Saúl González
* Proyecto: MC - FreewayConsulting
* Descripción : Clase de utilerias reutilizable para leads

* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           19/02/2021     Saúl González		   	Creación
* --------------------------------------------------------------------------------
*/


public class LeadsUtils_ctrl {
    public LeadsUtils_ctrl(){}
   /*
    * @description Method que devuelve un Fraccionamiento__c
    * @param String nameFracc
	* @return Fraccionamiento__c
    */ 
    public static Fraccionamiento__c getFracc(String nameFracc){
        Fraccionamiento__c f;
        try{
          f = [SELECT Id, Name FROM Fraccionamiento__c Where Name =:nameFracc];
        } catch (Exception ex) {}
		Return f;
    }
     /*
    * @description Method que devuelve un Lead
    * @param String idLead
	* @return Lead
    */ 
    public static User getOwLead(String idUser){
        final User us = [SELECT Id, Name FROM User Where Id =:idUser];
		Return us;
    }
    
    /*
    * @description Method que devuelve un Lead
    * @param String idLead
	* @return Lead
    */ 
    public static Lead getObjLead(String idLead) {
        Lead objLead = new Lead();
			objLead = [SELECT id, Name, JMC_ApellidoMaterno__c,JMC_LeadProfile__c,JMC_EstatusLead__c,JMC_AsesorAsignado__c,status,
        		JMC_Fuente__c,FirstName,LastName, OwnerId, Owner.Name, /*middlename,*/MobilePhone,ErrorCodeResponseSOAP__c, MsgResponseWS__c,IsConverted,
                JMC_FechaNacimiento__c,Phone,Email,JMC_TipoCredito__c,JMC_NSS__c, LastModifiedById, Asesores__c,Asesores__r.name,
                JMC_Genero__c,JMC_UEN__c,JMC_Estado__c,JMC_Fraccionamiento__c,JMC_Fraccionamiento__r.name, JMC_Fraccionamiento__r.Id_Plaza__c, JMC_CanalVenta__c,
                JMC_SubCanalVenta__c,JMC_Asunto__c,JMC_CapacidadCompra__c,JMC_Edad__c,ID_CUENTA__c FROM Lead Where Id =: idLead];     
        return objLead;
    }
    
    /*
    * @description Method que devuelve un Lead
    * @param String mailLead
	* @return Lead
    */ 
    public static List<Lead> getObjLeadMail(String mailLead){
        System.debug('mailLead::: '+mailLead);
		 Lead[] objLead= [SELECT id, Name, JMC_ApellidoMaterno__c,JMC_LeadProfile__c,JMC_EstatusLead__c,JMC_AsesorAsignado__c,status,IsConverted,
            JMC_Fuente__c,FirstName,LastName, OwnerId, Owner.Name, /*middlename,*/ MobilePhone,ErrorCodeResponseSOAP__c, MsgResponseWS__c,
            JMC_FechaNacimiento__c,Phone,Email,JMC_TipoCredito__c,JMC_NSS__c, LastModifiedById,Asesores__c,Asesores__r.name,
            JMC_Genero__c,JMC_UEN__c,JMC_Estado__c,JMC_Fraccionamiento__c,JMC_Fraccionamiento__r.name,JMC_CanalVenta__c,
            JMC_SubCanalVenta__c,JMC_Asunto__c,JMC_CapacidadCompra__c,JMC_Edad__c,ID_CUENTA__c FROM Lead Where Email =: mailLead];
        return objLead;
    }
    
    /*
    * @description Method que valida que no este vacío el elemnto.
    * @param String obj
	* @return String strResponse
    */ 
    public static String validaDatoVacio(String obj) {
    	return String.isNotBlank(obj) ?  obj : '';
    }
 /*
    * @description valida que no este vacío el elemento y realiza el parse a DateTime
    * @param String obj
    * @return String strResponse
    */
    public static DateTime getDataTime(String obj) {
        return String.isNotBlank(obj) ? datetime.valueOf(obj) : null;
    }
    
    /*
    * @description valida que no este vacío el elemento y realiza el parse a Date
    * @param String obFec
    * @return String strResponse
    */
    public static Date getDate(String obFec) {
        return String.isNotBlank(obFec) ? Date.valueOf(obFec) : null;
    }
    
    /*
    * @description valida que no este vacío el elemento y realiza el parse a Decimal
    * @param String obFec
    * @return String strResponse
    */
    public static Decimal getDecimal(String obFec) {
        return String.isNotBlank(obFec) ? Decimal.valueOf(obFec) : null;
    }
    
    /*
    * @description valida que no este vacío el elemento y realiza el parse a Decimal
    * @param String obFec
    * @return String strResponse
    */
    public static Decimal getDobDecimal(Double obFec) {
        return obFec!=null ? Decimal.valueOf(obFec) : null;
    }
    
    /*
    * @description valida que no este vacío el elemento y realiza el parse a String
    * @param String obFec
    * @return String strResponse
    */
    public static String getStringDec(Decimal obFec) {
        return obFec!=null  ? String.valueOf(obFec) : null;
    }
    
    
    /*
    * @description valida que no este vacío el elemento y realiza el parse a String
    * @param String obFec
    * @return String strResponse
    */
    public static String getDouString(Double obFec) {
        return obFec!=null ? String.valueOf(obFec) : null;
    }
    
    /*
    * @description realiza el parse a Map
    * @param String strJsonObj
    * @return Map<String, Object>
    */
    public static Map<String, Object> getStrToMap(String strJsonObj){
        return String.isNotBlank(strJsonObj) ? (Map<String, Object>)JSON.deserializeUntyped(strJsonObj) : null;
    }
    
    /*
    * @description obtiene una lista de campos del objeto typeObject
    * @param String typeObject
    * @return List<String>
    */
    public static List<String> getAllLabels(String typeObject){
        List<String> AllLabels = new List<String>();
        Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(typeObject).getDescribe().fields.getMap();
        for(Schema.SObjectField sfield : fieldMap.Values()) {
            schema.describefieldresult dfield = sfield.getDescribe();
            AllLabels.add( dfield.getname());
        }
        return AllLabels;
    }
    
    /*
    * @description Method que devuelve un usuerio a partir del nombre completo
    * @param String name
	* @return User
    */ 
    public static User getUser(String name){
        User objUser;
        name = name.replace('C3', 'Ñ');
        try{
            objUser = [SELECT id, Name FROM User Where Name =: name limit 1];
        } catch (Exception ex) {}
        return objUser;
    }
    
    /*
    * @description Method que devuelve un string con un télefono validado con regex
    * @param String phone
	* @return String
    */ 
	public static String getFilteredPhone(String phone){
        //String filteredPhone = phone != null && String.valueOf(phone.replaceAll('[^0-9]', '')).length() == 10 ? String.valueOf(phone.replaceAll('[^0-9]', '')) : '';
        //return filteredPhone;
        System.debug(phone);
        if(!String.isBlank(phone) && phone.length() == 10 && phone.Substring(0,1) != '+' && phone.Substring(0,4) != '+521' && phone.Substring(0,2) != '52'){
            phone = '+52' + phone;
        }else if(!String.isBlank(phone) && phone.length() > 9){
            if(phone.Substring(0,2) == '52' || (phone.Substring(0,2) == '+1' && phone.length() == 12)){
                phone = '+52' + phone.Substring(2,phone.length());
            }else if(phone.Substring(0,1) == '1' && phone.length() ==  11){
                phone = '+52' + phone.Substring(1,phone.length());
            }else if(phone.Substring(0,3) == '521' && phone.length() ==  13){
                phone = '+52' + phone.Substring(3,phone.length());
            }else if(phone.Substring(0,3) == '+52' && phone.length() == 13){
            }else if(phone.Substring(0,4) == '+521' && phone.length() == 14){
                phone = '+52' + phone.Substring(4,phone.length());
            }else if(phone.length() == 11 && phone.Substring(0,1) == '+'){
                phone = '+52' + phone.Substring(1,phone.length());
            }else if(phone.length() == 10 && phone.Substring(0,1) != '+' && phone.Substring(0,4) != '+521' && phone.Substring(0,2) != '52' ){
                phone = '+52' + phone;
            }else{
                phone = '+52';
            }
        }else{
            phone = '+52';
        }
        System.debug(phone);
        return phone;
 	}
    
    /*
    * @description valida que no este vacío el elemento y si lo esta devuelve el valor del registro
    * @param String strNew, strData
    * @return String string
    */
    public static String getNewData(String strNew, String strData) {
        return String.isNotBlank(strNew) ? strNew : strData;
    }
    
    public static List<User> getUsersIdSiebel(Set<Integer> ids){
        List<User> objUsers;
        try{
            objUsers = [SELECT id, Name, Id_Lead_Profiler__c, JMC_ContadorLeads__c, JMC_FechaActividadContador__c FROM User Where Id_Lead_Profiler__c in :ids];
        } catch (Exception ex) {
            System.debug(ex);
            
        }
        return objUsers;
    }
    
}