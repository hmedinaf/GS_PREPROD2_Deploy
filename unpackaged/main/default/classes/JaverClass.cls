public class JaverClass {
 @AuraEnabled
    public static void logout(){
         List<AuthSession> sessions = [SELECT Id,UsersId FROM AuthSession WHERE UsersId = : userInfo.getUserId()];
        if (sessions != null) {
            delete sessions;
        }
    }
      @AuraEnabled
  public static String updateFraccAsessor(string pId, String frac){
        String msg = ''; String fId; String fracc;
        try{
            list<Fraccionamiento__c> f = [Select Id,Name From Fraccionamiento__c where Name =:frac LIMIT 1];
            
            if(f != null && f.size()>0){
                fId = f[0].Id;
            }
            List<Historial_Asignacion__c> Halist =[Select Id ,Asesor__c,Cuenta__c, Fraccionamiento__c, CreatedDate from Historial_Asignacion__c Where 
                                                   Cuenta__c =: pId AND Asesor__c != null /*AND Fraccionamiento__c =: fId */Order by CreatedDate desc LIMIT 1];
            if(Halist != null && Halist.size()>0){
                fracc =  Halist[0].Fraccionamiento__c  ;
            }
            if(fracc == fId){
                msg = 'El prospecto existe, pero tiene una asignación vigente.';
            }
            else{
                List<Account> acc = [Select Id,Asesor__c,Fraccionamiento_cta__r.Name, Fraccionamiento_cta__c,Prospectador__c from Account where Id=:pId LIMIT 1];
                 if(acc != null && acc.size()>0){
                    acc[0].Asesor__c = UserInfo.getUserId();
                    acc[0].Fraccionamiento_cta__c = fId;
                    update acc[0];
                    msg = 'Actualizado';
                }
            }
        }
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            throw new AuraHandledException(msg);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        return msg;
    } 
}