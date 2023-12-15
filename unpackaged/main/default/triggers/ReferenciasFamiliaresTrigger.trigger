trigger ReferenciasFamiliaresTrigger on Referencia_familiar__c (before insert) {
    new ReferenciasFamiliaresTriggerHandler().run();
}