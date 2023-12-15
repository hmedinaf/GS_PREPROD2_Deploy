trigger TRIGGER_PlanDeVenta on Plan_de_Venta__c (before update, after insert, after update, after delete, after undelete) {
    new TRIGGER_PlanDeVenta_Handler().run();
}