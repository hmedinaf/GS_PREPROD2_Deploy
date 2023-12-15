trigger CrearVisita on Event (before insert, after insert, before update, after update, before delete, after delete) {
    if(trigger.isBefore && trigger.isDelete){
        for(Event evento : trigger.old){
            try{
                List<Casos_Residente__c> caso = [SELECT Id FROM Casos_Residente__c WHERE Id = :evento.WhatId];
                List<Visita__c> visita = [SELECT Id, Name FROM Visita__c WHERE CasoResidente__c = :caso[0].Id AND CasoResidente__c !=null];
                delete visita;
            }catch(Exception u){
                List<Visita__c> visita = [SELECT Id, Name FROM Visita__c WHERE CasoResidente__c = :evento.WhatId AND CasoResidente__c !=null];
                try{
                delete visita;
                }catch(Exception o){
                    
                }
            }
        }
    }
}