public with sharing class Aprobaciones_Controller {

    @AuraEnabled(cacheable=true)
    public static List<Pricebook2> getPricebooks() {
        return [SELECT Id, Name, Tipo_Lista__c, IsActive, Estatus__c FROM Pricebook2 WHERE IsActive=TRUE];
    }
}