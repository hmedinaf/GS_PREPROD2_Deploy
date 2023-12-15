trigger TRIGGER_Aplicacion_Pago on Aplicacion_Pago__c (after insert, after update) {
    List <Pago_Aplicado__c> lPagApl = new List <Pago_Aplicado__c>();

    for (Aplicacion_Pago__c apl : trigger.new){
        // Obtener el Pago relacionado a ese Recibo_AR
        List <Pago__c> lPago = [SELECT Id FROM Pago__c WHERE IdReciboAR__c = :apl.ID_RECIBO_AR__c]; 
        if (lPago.size()>0) {
            // Crear un nuevo Pago_Aplicado cada vez que se inserta un Aplicacion_Pago
            Pago_Aplicado__c newPA = new Pago_Aplicado__c();

            newPA.Pago__c = lPago[0].Id; //Pago es mandatorio por master-detail
        
            newPA.Aplicacion_de_pago__c = apl.Id;
            newPA.Documento__c = apl.Documento__c;
            newPA.IdAplicacionAR__c = apl.ID_APLICACION_AR__c;
            newPA.IdClienteAR__c = apl.ID_CLIENTE_AR__c;
            newPA.IdFacturaAr__c = apl.ID_FACTURA_AR__c;
            newPA.IdNotaCredAR__c = apl.ID_NOTA_CRED_AR__c;
            newPA.IdProcesoAR__c = apl.ID_PROCESO_AR__c;
            newPA.IdReciboAR__c = apl.ID_RECIBO_AR__c;
            newPA.Importe_a_Cuenta__c = apl.IMPORTE_A_CUENTA__c;
            newPA.Importe_Anticipo__c = apl.IMPORTE_ANTICIPO__c;
            newPA.Importe_Aplicado__c = apl.IMPORTE_APLICADO__c;
            newPA.Importe_Funcional__c = apl.IMPORTE_FUNCIONAL__c;
            newPA.Importe_No_Aplicado__c = apl.IMPORTE_NO_APLICADO__c;
            newPA.Importe_No_Identificado__c = apl.IMPORTE_NO_IDENTIFICADO__c;
            newPA.Importe_Original__c = apl.IMPORTE_ORIGINAL__c;
            newPA.Importe_Reclamo__c = apl.IMPORTE_RECLAMO__c;
            newPA.Name = apl.Name;

            system.debug('*** newPA: ' + newPA);
            lPagApl.add(newPA);
        }
    }
    // upsert lPagApl;
    if (lPagApl.size()>0) {
        Schema.SObjectField key = Pago_Aplicado__c.Fields.Name;
        Database.UpsertResult[] saveResults = Database.upsert(lPagApl, key, false);
        system.debug('*** lPagApl saveResults: '+saveResults);
    }
}