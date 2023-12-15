public with sharing class ReferenciasFamiliaresTriggerHandler extends TriggerHandler{
    private Map<Id, Referencia_familiar__c> newMap;
    private Map<Id, Referencia_familiar__c> oldMap;
    private List<Referencia_familiar__c> newList;
    private List<Referencia_familiar__c> oldList;
    
    public ReferenciasFamiliaresTriggerHandler() {
        this.newMap = (Map<Id, Referencia_familiar__c>) trigger.newMap;
        this.oldMap = (Map<Id, Referencia_familiar__c>) trigger.oldMap;
        this.newList = (List<Referencia_familiar__c>) trigger.new;
        this.oldList = (List<Referencia_familiar__c>) trigger.old;
    }

    private final String ERROR_MESSAGE = 'Solo pueden existir 3 referencias familiares relacionadas al mismo objeto'; 

    public override void beforeInsert() {
        checkDictaminacion(this.newList);
    }

    public void checkDictaminacion(List<Referencia_familiar__c> referenceList){
        Set<Id> dictIds = new Set<Id>();

        for(Referencia_familiar__c rf : referenceList){
            dictIds.add(rf.Dictaminacion__c);
        }

        List<AggregateResult> results = [
            SELECT COUNT(Id)activeReferences, Dictaminacion__c
            FROM Referencia_familiar__c 
            WHERE Dictaminacion__c IN :dictIds
            GROUP BY Dictaminacion__c];

        Id Dictaminacion;
        Integer activeReferences;
        Map<Id,Integer> activeReferencesByDictaminacion = new Map<Id,Integer>();

        for(AggregateResult ag : results){
            Dictaminacion = (Id) ag.get('dictaminacion__c');
            activeReferences = (Integer) ag.get('activeReferences');

            activeReferencesByDictaminacion.put(Dictaminacion,activeReferences);
        }

        for(Referencia_familiar__c rf : referenceList){
            activeReferences = activeReferencesByDictaminacion.get(rf.Dictaminacion__c);

            if(activeReferences >= 3){
                rf.addError(ERROR_MESSAGE);
            }
        }
    }
}