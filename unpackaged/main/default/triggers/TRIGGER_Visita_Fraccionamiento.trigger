trigger TRIGGER_Visita_Fraccionamiento on Visita_Fraccionamiento__c (before insert) {

    CLASS_Visita_Fraccionamiento classVisitaFraccionamiento = new CLASS_Visita_Fraccionamiento();

    classVisitaFraccionamiento.asignaValoresAutomaticos(Trigger.new);

}