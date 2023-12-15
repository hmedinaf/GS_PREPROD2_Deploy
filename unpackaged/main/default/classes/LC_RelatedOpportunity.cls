public class LC_RelatedOpportunity {
	@AuraEnabled
    public static Object getOpportunities(String accId){
        return [SELECT Id,Name,Amount,CloseDate,StageName FROM Opportunity WHERE AccountId =: accId];
    }
}