public with sharing class OpportunityProductController {

    public String opportunityProducts { get; set; }

    public String getHasProducts() {
        return null;
    }

    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getOpportunityProducts(Id opportunityId) {
        return [SELECT Product2.Name, Quantity, UnitPrice, TotalPrice
                FROM OpportunityLineItem
                WHERE OpportunityId = :opportunityId];
    }
}