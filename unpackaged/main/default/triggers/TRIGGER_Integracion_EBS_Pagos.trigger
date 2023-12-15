trigger TRIGGER_Integracion_EBS_Pagos on Integracion_EBS_Pagos__c (after insert) {
    System.enqueueJob(new IntegracionEBS_PagosQueueable(Trigger.New));
}