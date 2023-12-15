trigger TRIGGER_Integracion_EBS_Aplicaciones on Integracion_EBS_Aplicaciones__c (after insert) {

    System.enqueueJob(new IntegracionEBS_AplicacionQueueable(Trigger.New), 1);
}