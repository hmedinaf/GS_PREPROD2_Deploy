public class FraccPickList {
	@AuraEnabled
    public static List <String> getPicklistValues() {
         Id userId =  UserInfo.getUserId();
        User  u =[Select Id,Name,Phone,SenderEmail,Email,state, Profile.Name,Fraccionamientos__c from User where Id=:userId];
        List<String> fracList  = new List<String>();
        if(u.Fraccionamientos__c != null && u.Fraccionamientos__c != ''){
            fracList = u.Fraccionamientos__c.split(';');
        }
       fracList.sort();
        return fracList;
    }
    @AuraEnabled
    public static string SaveFracc(List <String> FraccList, string accountId){
        list <Fraccionamiento_Asociado__c> FracAsoList = new list <Fraccionamiento_Asociado__c>();
        if(FraccList.size()>0 && FraccList != null){
        for(Fraccionamiento__c Fr : [select id from Fraccionamiento__c where Name IN: FraccList]){
            Fraccionamiento_Asociado__c Frac = new Fraccionamiento_Asociado__c();
            Frac.Company__c = accountId;
            Frac.Fraccionamiento__c= Fr.Id;
            FracAsoList.add(Frac);
        }
        insert FracAsoList;
            return 'success';
        }
        else{
            return '';
        }
    }
}