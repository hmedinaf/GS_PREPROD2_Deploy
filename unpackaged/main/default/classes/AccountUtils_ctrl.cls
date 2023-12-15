/*
----------------------------------------------------------
* Nombre: AccountUtils_ctrl
* Autor Saúl González
* Proyecto: MC - FreewayConsulting
* Descripción : Clase que verifica las reglas de negocio para un lead

* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           09/03/2021     Saúl González		   	Creación
* --------------------------------------------------------------------------------
*/
public class AccountUtils_ctrl {

    
    public static List<Account> getObjActId(Set<Id> ids){
        String strQuery = AccountUtils_ctrl.generateQueryId(ids);
        Account[] lstAccts = Database.query(strQuery);
        System.debug(lstAccts);
        return lstAccts;
    }
    
    
    public static String generateQueryId(set<Id> ids){
        List<String> lstFields = LeadsUtils_ctrl.getAllLabels('Account');
        String query = 'select ' + string.join(lstFields, ',') + ', Owner.Name, Fraccionamiento_cta__r.Name from Account WHERE Id in : ids';
        return query;
    }
    
    
    public static List<Account> getObjAccount(String mail){
        String strQuery = AccountUtils_ctrl.generateQuery(mail);
        Account[] lstAccts = Database.query(strQuery);
        System.debug(lstAccts);
        return lstAccts;
    }
    
    
    public static String generateQuery(String mail){
        List<String> lstFields = LeadsUtils_ctrl.getAllLabels('Account');
        String query = 'select ' + string.join(lstFields, ',') + ', Owner.Name, Fraccionamiento_cta__r.Name from Account WHERE  CorreoElectronico__c=: mail';
        return query;
    }
}