trigger InformacionRepresentanteLegal on Informacion_representante_legal__c (before insert, before update) {
    if (trigger.isBefore) {
        InfRepLegalTriggerHandler.updateRFCyCURP(Trigger.new);
    }
}