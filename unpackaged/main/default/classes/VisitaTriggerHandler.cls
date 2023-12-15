/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Handler de VisitaTrigger
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      15/04/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class VisitaTriggerHandler extends TriggerHandler {
    
    private Map<Id, Visita__c> newMap;
    private Map<Id, Visita__c> oldMap;
    private List<Visita__c> newList;
    private List<Visita__c> oldList;
    
    public VisitaTriggerHandler() {
        this.newMap = (Map<Id, Visita__c>) trigger.newMap;
        this.oldMap = (Map<Id, Visita__c>) trigger.oldMap;
        this.newList = (List<Visita__c>) trigger.new;
        this.oldList = (List<Visita__c>) trigger.old;
    }
    
    public override void beforeInsert() {
    }

    public override void afterUpdate() {
        cancelationActions();
    }
    

    public void cancelationActions(){
        Map<Id, Visita__c> visitasCanceladas = new Map<Id, Visita__c>();
        for(Visita__c newVisita : newList){
            Visita__c oldVisita = oldMap.get(newVisita.Id);
            System.debug(newVisita);
            if(newVisita.Estatus__c != oldVisita.Estatus__c && newVisita.Estatus__c == 'Cancelada'){
                visitasCanceladas.put(newVisita.Id, newVisita);
            }
        }

        if(!visitasCanceladas.isEmpty()){
            List<Conjunto_Visitas__c> conjuntos = [SELECT Id, Caso_ATC__c FROM Conjunto_Visitas__c WHERE Cita_Visita__c IN: visitasCanceladas.keySet()];
            
            Map<Id, Conjunto_Visitas__c> conjuntosMap = new Map<Id, Conjunto_Visitas__c>();
            for(Conjunto_Visitas__c conjunto : conjuntos){
                conjuntosMap.put(conjunto.Caso_ATC__c, conjunto);
            }

            List<Casos_Residente__c> casos = [SELECT Id, Fecha_Programada_de_Visita__c FROM Casos_Residente__c WHERE Id IN: conjuntosMap.keySet()];
            if(!casos.isEmpty()){
                for(Casos_Residente__c caso : casos){
                    caso.Fecha_Programada_de_Visita__c = null;
                }
            }
            update casos;
        }
    }
}