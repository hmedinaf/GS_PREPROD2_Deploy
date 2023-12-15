/*Create Producto upon insert of Vivienda*/
trigger ViviendaTrigger on Vivienda__c (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ViviendaTrigger_Handler.inVivienda(trigger.new);
        }
    }
}