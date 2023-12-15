public class CLASS_PopulateNewRecords {

    @AuraEnabled(cacheable=true)
    public static String populaCamposDictaminacion(String oppId) {
        Dictaminacion__c dict = new Dictaminacion__c();
        
        if(oppId != null && oppId != ''){
            
            // Id recordTypeIdFisica = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Persona_Fisica').getRecordTypeId();
            // Id recordTypeIdMoral = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Persona_Moral').getRecordTypeId();
            
            Opportunity opp = [SELECT Id, AccountId, Account.RecordType.DeveloperName FROM Opportunity WHERE Id =: oppId]; 
            
            dict.Account__c = opp.AccountId;
            dict.Oportunidad__c = oppId;
        }else{
            dict.Account__c = '';
            // cont.RecordTypeId = '';
        }
        
        return JSON.serialize(dict);
    }
    
    @AuraEnabled(cacheable=true)
    public static String populaCamposContrato(String oppId) {
        Contract cont = new Contract();
        
        if(oppId != null && oppId != ''){
            
            Id recordTypeIdFisica = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Persona_Fisica').getRecordTypeId();
            // Id recordTypeIdMoral = Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Persona_Moral').getRecordTypeId();
            
            Opportunity opp = [SELECT Id, AccountId, Account.RecordType.DeveloperName FROM Opportunity WHERE Id =: oppId]; 
            
            cont.AccountId = opp.AccountId;
            cont.Oportunidad__c = oppId;
            
            // if(opp.Account.RecordType.DeveloperName == 'Prospecto_Persona_Fisica' || opp.Account.RecordType.DeveloperName == 'Afluente_Persona_Fisica' || opp.Account.RecordType.DeveloperName == 'Cliente_Persona_Fisica' ){
                cont.RecordTypeId = recordTypeIdFisica;   
            //}else{
                // cont.RecordTypeId = recordTypeIdMoral;
            //    cont.RecordTypeId = recordTypeIdFisica;
            // }
            
        }else{
            cont.AccountId = '';
            cont.RecordTypeId = '';
        }
        
        return JSON.serialize(cont);
    }
    
    @AuraEnabled(cacheable=true)
    public static String populaCamposInformacionRep(String idCesion){
        
        Informacion_representante_legal__c infoRep = new Informacion_representante_legal__c();
        Cesion_a_Otra_Persona_Fisica_o_Moral__c cesiOtra = new Cesion_a_Otra_Persona_Fisica_o_Moral__c();
        
        if(idCesion != null && idCesion != ''){
            cesiOtra = [SELECT Id, Contrato__c FROM Cesion_a_Otra_Persona_Fisica_o_Moral__c WHERE Id =: idCesion ];	    
            infoRep.Contrato__c = cesiOtra.Contrato__c;
            infoRep.Cesion_a_Otra_Persona_Fisica_o_Moral__c = cesiOtra.Id;
        }else{
            infoRep.Contrato__c = '';
            infoRep.Cesion_a_Otra_Persona_Fisica_o_Moral__c = '';
        }
        
        return JSON.serialize(infoRep);
    } 
}