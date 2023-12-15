public class CLASS_ProveedoresRelacion {
    @AuraEnabled
    public static list<Proveedor__c> getRelatedList(Id recordId)
    {
        List<Proveedor__c> listaProveedores = [Select Id, Codigo_de_Proveedor__c, Name, Nombre_Comercial__c, Rfc__c, Contacto__c, Correo__c, Plaza__c from Proveedor__c where Producto__c=: recordId ];
        return listaProveedores;
    }
    
     @AuraEnabled
    public static Proveedor__c creaProveedor(Proveedor__c ac, String prod){
        ac.Producto__c = prod;
        insert ac;
        return ac;
    }
}