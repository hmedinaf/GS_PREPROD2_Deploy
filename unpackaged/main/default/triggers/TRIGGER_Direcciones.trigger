trigger TRIGGER_Direcciones on Direcciones__c (before insert, after insert, before update, after update) {
    new DireccionesTriggerHandler().run();
}