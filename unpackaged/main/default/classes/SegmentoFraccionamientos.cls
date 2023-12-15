public class SegmentoFraccionamientos {
	@AuraEnabled
    public static Object getFracc(){
        List<SelectFracc> sfList = new List<SelectFracc>();
        for(Fraccionamiento__c f: [SELECT Id,Name,Plaza__c FROM Fraccionamiento__c WHERE Segmentacion__c = null ORDER BY Plaza__c ASC]){
            SelectFracc sf = new SelectFracc();
            sf.check = false;
            sf.frac = f;
            sfList.add(sf);
        }
        return sfList;
    }
    
    @AuraEnabled
    public static String saveFraccs(List<String> fracs, String segId){
        try{
            List<Fraccionamiento__c> fracsToUpdate = new List<Fraccionamiento__c>();
            for(String s: fracs){
                fracsToUpdate.add(new Fraccionamiento__c(Id = s,Segmentacion__c = segId));
            }
            update fracsToUpdate;
            return 'Success';
        }
        catch(Exception e){
            return 'ERROR: '+e.getMessage();
        }
    }
    
    public class SelectFracc{
        @AuraEnabled public Fraccionamiento__c frac;
        @AuraEnabled public Boolean check;
    }
}