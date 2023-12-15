public without sharing class Homepageclass {
    @AuraEnabled 
    public static wrap fetchUser(Boolean recent){
        User u = [select id,Name,Profile.Name,Fraccionamientos__c from User where id =: userInfo.getUserId()];
        List<Account>accl = new List<Account>();
        String query = 'select Id, FirstName,Lastname,PersonMobilePhone,Name,Apellidomaterno_cta__c,recordtype.Name,Fraccionamiento_cta__r.Name,Nombre__c,Prospectador__c,Asesor__c,LastModifiedDate,LastViewedDate from Account where CreatedDate !=null';
        if(u.Profile.Name == 'Asesor'){
            query += ' AND Asesor__c = \''+ u.Id+'\'';
        }
        if(u.Profile.Name == 'Prospectador'){
            query += ' AND Prospectador__c = \''+ u.Id+'\'';
        }
        if(recent){
            query += ' Order by LastModifiedDate DESC NULLS LAST LIMIT 5';
        }
        else {
            query += ' Order by LastModifiedDate DESC NULLS LAST';
        }
        accl = Database.query(query);
        wrap wr = new wrap();
        wr.userName = u.Name;
        if(accl != null && accl.size()>0){
            wr.AccountList = accl;
        }
        return wr;
    }
     @AuraEnabled 
    public static void logoutFromSite(){
      JaverClass.logout();
    }
    public class wrap{
        @AuraEnabled public List<Account> AccountList ;	
        @AuraEnabled public String  userName;
    }  
}