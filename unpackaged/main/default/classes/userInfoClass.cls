public without sharing class userInfoClass{
    @AuraEnabled
    public static User userInfoMethod(){
        String userId =  UserInfo.getUserId();
        User  userList=[Select Id,Name,Phone,Username,SenderEmail,Email,state,IsActive, Profile.Name,Fraccionamientos__c from User where Id=:userId];
        return userList;
    }
    @AuraEnabled
    public static String updateMethod(string pId ,String frac){
        String msg = ''; String fId;
        try{
            list<Fraccionamiento__c> f = [Select Id,Name From Fraccionamiento__c where Name =:frac LIMIT 1];
            
            if(f != null && f.size()>0){
                fId = f[0].Id;
            }
            id userId =  UserInfo.getUserId();
            User  u =[Select Id,Name,Phone,SenderEmail,Email,state, Profile.Name,Fraccionamientos__c from User where Id=:userId];
            List<Account>Acc=[Select Id,Asesor__c,Prospectador__c from Account where Id=:pId LIMIT 1];
            if(Acc != null && Acc.size()>0){
                if(u.Profile.Name == 'Asesor'){
                    Acc[0].Asesor__c = userId;
                }
                else if(u.Profile.Name == 'Prospectador'){
                    Acc[0].Prospectador__c = userId;
                }
                Acc[0].Fraccionamiento_cta__c = fId;
                update Acc[0];
                msg = 'Usuario actual asignado';
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
    @AuraEnabled
    public static listTypeWrapper NeighMethod(){
        list<String> fracValuesList = new list<String>();
        list<String> typeValuesList = new list<String>();
        list <Account> aclist = new list<Account>();
        listTypeWrapper wr = new listTypeWrapper();
        Id userId =  UserInfo.getUserId();
        User  u =[Select Id,Name,Phone,SenderEmail,Email,state, Profile.Name,Fraccionamientos__c from User where Id=:userId];
        List<String> fracList  = new List<String>();
        if(u.Fraccionamientos__c != null && u.Fraccionamientos__c != ''){
            fracList = u.Fraccionamientos__c.split(';');
        }
        fracList.sort();
        Schema.DescribeFieldResult fieldResult1 = Account.Tipo__c.getDescribe();
        List<Schema.PicklistEntry>ple1= fieldResult1.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple1){  
            typeValuesList.add(pickListVal.getLabel());
        }
        String query = 'select Id, FirstName,Lastname,PersonMobilePhone,Name,Fecha_Asignacion_Asesor__c,Fecha_Prospeccion__c,Apellidomaterno_cta__c,recordtype.Name,Fraccionamiento_cta__r.Name,Nombre__c,Prospectador__c,Asesor__c,FechaAsignacion__c,LastmodifiedDate,LastViewedDate from Account where CreatedDate !=null';
        
        if(u.Profile.Name == 'Asesor'){
            query += ' AND Asesor__c = \''+ u.Id+'\'';
        }
        else if(u.Profile.Name == 'Prospectador'){
            query += ' AND Prospectador__c = \''+ u.Id+'\'';
        }
        //  query += ' Order by FechaAsignacion__c asc';
        
        if(u.Profile.Name == 'Prospectador'){
            query += ' ORDER BY Fecha_Prospeccion__c ASC';           
        }
        else if(u.Profile.Name == 'Asesor'){
            query += ' ORDER BY Fecha_Asignacion_Asesor__c ASC';
        }
        
        system.debug(query);
        aclist = Database.query(query);
        wr.acclist = aclist;
        wr.fracList = fracList;	
        wr.accTypeList = typeValuesList;
        wr.UserId = UserInfo.getUserId();
        wr.profile = u.Profile.Name;
        wr.recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        return wr;
    }
    @AuraEnabled
    public static List<string> searchDivision(String searchValue){
        List<string> result = new list<string>();    List<String> fracList = new List<String>();
        User u =[Select Id,Name,Phone,Email,state,Profile.Name,Fraccionamientos__c from User where Id=:userInfo.getUserId()];
        if(u.Fraccionamientos__c != null ){
            fracList = u.Fraccionamientos__c.split(';');
        }
        for(String frac : fracList){
            if(frac.contains(searchValue.toUppercase())){
                result.add(frac);
                
            }
        }
        return  result;
    }
    
    @AuraEnabled
    public static list<Account> filterAccounts(String div , string selectedtype, Date fromdate, Date enddate, String dateRange,Boolean toggleAssign){
        id userId =  UserInfo.getUserId();
        list<Account> acclist = new list <Account>();  List<String> fracList = new List<String>();
        User u = [select id,Name,Profile.Name,Fraccionamientos__c from User where id =: userInfo.getUserId()];
        if(u.Fraccionamientos__c != null && u.Fraccionamientos__c != ''){
            fracList = u.Fraccionamientos__c.split(';');
        }
        String query =  'Select Id,Tipo__c,PersonMobilePhone,Nombre__c,Asesor__c,FirstName,Name,Prospectador__c,Apellidomaterno_cta__c,Fecha_Prospeccion__c,Fecha_Asignacion_Asesor__c,RecordTypeName__c,Tipo_de_Direccion__c,BillingColony__c,Fraccionamiento_cta__r.Name ,JMC_Estatus_Proceso__c,Estatus_Cliente__c from Account where CreatedDate != null';
        if(u.Profile.Name == 'Asesor'){
            query += ' AND Asesor__c = \''+ u.Id+'\'';
        }
        if(u.Profile.Name == 'Prospectador'){
            query += ' AND Prospectador__c = \''+ u.Id+'\'';
        }
        if(div == null && div == '' && div == 'Todos' ){
            query += ' AND Fraccionamiento_cta__r.Name IN :' +fracList;
        }
        if(div != null && div != '' && div != 'Todos' ){
            query += ' AND Fraccionamiento_cta__r.Name = \''+ div+'\''; 
        }
        if(selectedtype != null && selectedtype != '' && selectedtype != 'Todos'){
            selectedtype = selectedtype.toUpperCase();
            query += ' AND Tipo__c LIKE \'%'+ selectedtype+'%\'';
        }
        if(fromdate != null  && enddate != null){
            String fdate = String.valueOf(fromdate).split(' ')[0]; String edate =String.valueOf(enddate).split(' ')[0];
            if(u.Profile.Name == 'Prospectador'){
                query += ' AND Fecha_Prospeccion__c >=' + fdate +' AND Fecha_Prospeccion__c <='+  edate ;
            }
            else if(u.Profile.Name == 'Asesor'){
                query += ' AND Fecha_Asignacion_Asesor__c >=' + fdate +' AND Fecha_Asignacion_Asesor__c <='+  edate ;
            }
        }
        if(dateRange != null && dateRange != '' && dateRange != 'None'){
            if(u.Profile.Name == 'Prospectador'){
                if(dateRange == 'This Week'){
                    query += ' AND Fecha_Prospeccion__c = THIS_WEEK';
                }
                else if(dateRange == 'Last Week'){
                    query += ' AND Fecha_Prospeccion__c = LAST_WEEK' ;
                }
                else if(dateRange == 'This Month'){
                    query += ' AND Fecha_Prospeccion__c = THIS_MONTH' ;
                }
                else if(dateRange == 'Last Month'){
                    query += ' AND Fecha_Prospeccion__c = LAST_MONTH' ;
                }
                else if(dateRange == 'Older'){
                    query += ' AND Fecha_Prospeccion__c = LAST_90_DAYS';
                }
            }
            else if(u.Profile.Name == 'Asesor'){
                if(dateRange == 'This Week'){
                    query += ' AND Fecha_Asignacion_Asesor__c = THIS_WEEK';
                }
                else if(dateRange == 'Last Week'){
                    query += ' AND Fecha_Asignacion_Asesor__c = LAST_WEEK' ;
                }
                else if(dateRange == 'This Month'){
                    query += ' AND Fecha_Asignacion_Asesor__c = THIS_MONTH' ;
                }
                else if(dateRange == 'Last Month'){
                    query += ' AND Fecha_Asignacion_Asesor__c = LAST_MONTH' ;
                }
                else if(dateRange == 'Older'){
                    query += ' AND Fecha_Asignacion_Asesor__c = LAST_90_DAYS';
                } 
            }
        }
        if(u.Profile.Name == 'Prospectador'){
            if(toggleAssign){
                query += ' ORDER BY Fecha_Prospeccion__c ASC';
            }
            else{
                query += ' ORDER BY Fecha_Prospeccion__c desc';
            }
        }
        else if(u.Profile.Name == 'Asesor'){
            if(toggleAssign){
                query += ' ORDER BY Fecha_Asignacion_Asesor__c ASC';
            }
            else{
                query += ' ORDER BY Fecha_Asignacion_Asesor__c desc';
            }
        }
        acclist = Database.query(query);
        return acclist;
    }
    @AuraEnabled
    public static String updateOwner(string pId){
        String msg = '';
        try{
            List<Account> acc = [Select Id,Asesor__c,Prospectador__c from Account where Id=:pId LIMIT 1];
            if(acc != null && acc.size()>0){
                acc[0].OwnerId = UserInfo.getUserId();
                update acc[0];
                msg = 'Dueño actualizado';
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
    @AuraEnabled
    public static String updateFA(string pId, String frac){
        String msg = JaverClass.updateFraccAsessor(pId, frac);
        return msg;
    } 
    @AuraEnabled 
    public static void logoutFromSite(){
        JaverClass.logout();
    }
    
    public class wrap{
        @AuraEnabled public List<Account> accntslist;
        @AuraEnabled public Boolean available;
    }
    public class listTypeWrapper{
        @AuraEnabled public List<String> fracList ;	
        @AuraEnabled public List<String> accTypeList ;
        @AuraEnabled public List<Account> acclist;
        @AuraEnabled public String UserId;
        @AuraEnabled public String recordTypeId;
        @AuraEnabled public String profile;
    }
}