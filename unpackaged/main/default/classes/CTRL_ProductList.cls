public with sharing class CTRL_ProductList {
    @AuraEnabled(cacheable=true)
    public static List<Producto_de_Plan_de_Venta__c> getProducts(string recId) {
        return [SELECT Id, Nombre_del_Producto__c, Cantidad__c, Tipo_de_Producto__c, Precio_de_venta__c, Precio_Total__c,Precio_Unitario__c
                FROM Producto_de_Plan_de_Venta__c where Plan_de_Venta__c = :recId];
    }
}