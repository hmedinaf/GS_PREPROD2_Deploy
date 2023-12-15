/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* LeadRedirection Aura Component Controller
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      21/03/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class LeadRedirectionCtrl {

    @AuraEnabled
    public static String getLead(String accountId){
        try{
            String convertedLead = [SELECT Id FROM Lead WHERE  ConvertedAccountId =: accountId LIMIT 1].Id;
            return convertedLead != null ? convertedLead : null;
        }catch(Exception e){
            return null;
        }
    }

}