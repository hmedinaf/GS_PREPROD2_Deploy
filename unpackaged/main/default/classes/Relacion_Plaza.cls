public class Relacion_Plaza {
    @AuraEnabled
    public static String saveRecord(String plazaId, string prodId){
        string message = '';
        try {
            List<Plaza__c> plazalist = [Select Id, Name from Plaza__c where Id =: plazaId];
            String plazaName  ;
            if(plazalist != null && plazalist.size()>0){
                plazaName = plazalist[0].Name;
            }
            list<Relacion_Producto_Plaza__c> plalist= [select id, Name , Producto__c from Relacion_Producto_Plaza__c Where Name =: plazaName AND Producto__c = :prodId];
            if(plalist != null && plalist.size()>0){
                message = 'Error al duplicar!'; 
            }
            else{
                Relacion_Producto_Plaza__c plaza = new Relacion_Producto_Plaza__c();
                plaza.Producto__c = prodId;
                plaza.Plaza__c = plazaId;
                insert plaza;
                message = 'success!';
            }
            return message;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            message =  e.getDmlMessage(0);
            return message;
        }
    }
}