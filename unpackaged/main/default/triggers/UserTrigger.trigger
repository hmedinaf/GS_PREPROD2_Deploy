trigger UserTrigger on User (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            // HMF 9/4/23 Apagado hasta corregir problema de overload de Fraccionamientos
            // UserTrigger_Handler.updFraccionamientos(trigger.new);
        }
    }
}