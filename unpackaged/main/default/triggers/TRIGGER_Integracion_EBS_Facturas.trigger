trigger TRIGGER_Integracion_EBS_Facturas on Integracion_EBS_Facturas__c (after update) {
    
    // for (Integracion_EBS_Facturas__c i : Trigger.New) {
    //     if (i.Estatus_Integracion__c=='Integrado' && Trigger.oldMap.get(i.id).Estatus_Integracion__c=='Enviado') {
    //         List <Documento__c> lDoc = [SELECT Id, IdFacturaAr__c FROM Documento__c WHERE Name = :i.IdFacturaCrm__c];
    //         if (lDoc.size() > 0) {
    //             lDoc[0].IdFacturaAr__c = i.IdFacturaAr__c;
    //             update lDoc;
    //         }
    //     }
    // }
}