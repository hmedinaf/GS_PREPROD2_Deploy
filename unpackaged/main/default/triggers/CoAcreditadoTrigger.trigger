trigger CoAcreditadoTrigger on Co_Acreditado__c (before insert, before update) {
    new CoAcreditadoTriggerHandler().run();
}