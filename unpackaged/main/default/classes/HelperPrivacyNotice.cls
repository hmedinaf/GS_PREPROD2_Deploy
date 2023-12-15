public class HelperPrivacyNotice {
    public static void upPrivacy(list<Privacy_Notice__c>newPrivacy ,  Map<id,Privacy_Notice__c>newMapPrivacy,Map<id,Privacy_Notice__c>oldPrivacy){
        set<id>accIds = new set<id>();  
        set<id>pIdSet = new set<id>();  
        set<string>Types = new set<string>();
        List<Account> updateaccList =  new List<Account>();
        for(Privacy_Notice__c P : newPrivacy){
            if(oldPrivacy.size()== 0){ 
                if(P.Active__c == true && P.Type__c != null && P.Type__c != ''){
                    system.debug('accId:: ' + P.Account__c );
                    accIds.add(P.Account__c);
                    Types.add(P.Type__c); 
                }
            }
            else{
                if(P.Active__c == true && P.Active__c != oldPrivacy.get(P.id).Active__c ){
                    if(P.Type__c != null && P.Type__c != '' ){
                        accIds.add(P.Account__c);
                        Types.add(P.Type__c);
                    }
                }
            }
        }
        if(accIds.size()>0){
            list<Privacy_Notice__c> updatePrivList = new list <Privacy_Notice__c>(); 
            list<Privacy_Notice__c> newUpdatedPrivList = new list <Privacy_Notice__c>();
            updatePrivList = [select id,Name,Active__c, Type__c,Account__c from Privacy_Notice__c where Active__c = true /*AND Account__c IN: accIds */
                              AND Type__c IN: Types AND Id NOT IN : newMapPrivacy.keySet() ];
            system.debug('updatePrivList'+updatePrivList);
            if(updatePrivList != null && updatePrivList.size()>0){
                for(Privacy_Notice__c P : updatePrivList){
                    for(ID pId : accIds){
                        if(P.Type__c == 'Aviso de Empresa' && P.Account__c == pId && P.Account__c != null){
                            P.Active__c = false;
                            pIdSet.add(p.Id);
                            newUpdatedPrivList.add(P);
                        }
                        else if(P.Type__c == 'Aviso de Inicio'){
                            P.Active__c = false;
                            newUpdatedPrivList.add(P); 
                        }
                    }
                }
            }
            if(newUpdatedPrivList != null && newUpdatedPrivList.size()>0){
                update newUpdatedPrivList;
            }
        }
        if(pIdSet != null && pIdSet.size()>0){
            List<Account> acclist= [select Id,Aviso_de_Privadidad_Relacionado2__c, Tipo__c, MANAGEAPPROVALS__Active__c from Account Where Aviso_de_Privadidad_Relacionado2__c In : pIdSet  
                                   /* AND (Tipo__c ='Afluente' OR Tipo__c ='Prospecto')  AND  MANAGEAPPROVALS__Active__c = 'Yes' */];
            for(Privacy_Notice__c p1 : newPrivacy){
                for(Account acc : acclist){
                    acc.Aviso_de_Privadidad_Relacionado2__c = p1.Id;
                    updateaccList.add(acc);
                }
            }
            if(updateaccList != null && updateaccList.size()>0){
               update  updateaccList ;
            }
        }
    }
}