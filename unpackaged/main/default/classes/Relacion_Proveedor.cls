public class Relacion_Proveedor {
    @AuraEnabled
    public static String saveRecord(String provId, string prodId){
        string message = '';
        try {
            List<Proveedor__c> provlist = [Select Id, Name from Proveedor__c where Id =: provId];
            String provName  ;
            if(provlist != null && provlist.size()>0){
                provName = provlist[0].Name;
            }
            list<Relacion_Precio_Proveedor__c> plist= [select id, Name ,Name__c, Producto__c from Relacion_Precio_Proveedor__c Where Name__c =: provName AND Producto__c = :prodId];
            if(plist != null && plist.size()>0){
                message = 'Error al duplicar!'; 
            }
            else{
                Relacion_Precio_Proveedor__c pro = new Relacion_Precio_Proveedor__c();
                pro.Producto__c = prodId;
                pro.Proveedor__c = provId;
                insert pro;
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