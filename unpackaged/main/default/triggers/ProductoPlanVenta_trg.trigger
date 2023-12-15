trigger ProductoPlanVenta_trg on Producto_de_Plan_de_Venta__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            CLASS_ProductoPlanVenta.ValidaCasaMuestra(Trigger.New);
        }
    }
}