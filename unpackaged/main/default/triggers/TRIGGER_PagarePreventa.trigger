trigger TRIGGER_PagarePreventa on Pagare_Preventa__c (before insert, before update, before delete) {

    CLASS_PagarePreventa classPagarePreventa = new CLASS_PagarePreventa();

    if(Trigger.isBefore && Trigger.isInsert){
        classPagarePreventa.asignaTipoDocumento(Trigger.new);
        classPagarePreventa.validaCreacionManual(Trigger.new);
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        classPagarePreventa.validaModificacionManual(Trigger.new, Trigger.oldMap);
    }
    else if(Trigger.isBefore && Trigger.isDelete){
        classPagarePreventa.validaEliminacionManual(Trigger.old);
    }
}