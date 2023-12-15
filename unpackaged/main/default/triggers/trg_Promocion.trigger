trigger trg_Promocion on Promocion__c (after insert, after update) {
    // Call the appropriate handler method based on the TriggerEvent
    if (Trigger.isInsert) {
        if (Trigger.isAfter ) {
            PromocionTriggerHandler.handleAfterInsert(Trigger.new);
        }
    }
    /*
    } else if (Trigger.isUpdate) {
        PromocionTriggerHandler.handleUpdate(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isDelete) {
        PromocionTriggerHandler.handleDelete(Trigger.old);
    }
    */
}