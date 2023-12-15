public class CustomLookup {
    @AuraEnabled 
    public static user fetchUser(){
       User u = [select id,Name from User where id =: userInfo.getUserId()];
        return u;
    }
   @AuraEnabled(cacheable=true)
    public static String searchDB(String objectName, String isParentAccount, String fld_API_Text, String fld_API_Val, String fld_API_Search, String searchText){ 
        List<sObject> sobjList = new List<sObject>();
        List<ResultWrapper> lstRet = new List<ResultWrapper>();
        if(searchText != null){
            searchText='\'%' + String.escapeSingleQuotes(searchText.trim()) + '%\'';       
            String query = 'SELECT '+fld_API_Text+' ,'+fld_API_Val;
            query +=  ' FROM '+objectName+' WHERE '+fld_API_Search+' LIKE '+searchText;
            query+= ' LIMIT 5'; 
            sobjList = Database.query(query);
            for(SObject s : sobjList){
                ResultWrapper obj = new ResultWrapper();
                obj.objName = objectName;
                obj.Name = String.valueOf(s.get(fld_API_Text)) ;
                obj.Id = String.valueOf(s.get(fld_API_Val))  ;
                lstRet.add(obj);
            } 
        }
        return JSON.serialize(lstRet);
    }
    
    public class ResultWrapper{
        @AuraEnabled public String objName;
        @AuraEnabled public String Name;
        @AuraEnabled public String Id;
    }
}