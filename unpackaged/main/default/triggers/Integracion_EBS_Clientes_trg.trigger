trigger Integracion_EBS_Clientes_trg on Integracion_EBS_Clientes__c (after update) {
    for (Integracion_EBS_Clientes__c iebs : Trigger.New) {
        if (iebs.Estatus_Integracion__c=='Integrado' && Trigger.oldMap.get(iebs.id).Estatus_Integracion__c=='Enviado') {
            system.debug('*** Cambio de Enviado a Integrado');
            List<Opportunity> opp = [SELECT Id, AccountId, Id_Proceso_AR__c, Plan_de_Venta__c, ValidationBypassDateTime__c FROM Opportunity WHERE ID = :iebs.Proceso_de_Venta__c];
            if (opp.size()>0) {
                // Actualizar Control_AR
                // List <Control_AR__c> ctrlAR = [SELECT Id, Id_Cliente_AR__c, Id_Proceso_AR__c, Account__c from Control_AR__c WHERE Account__c = :opp[0].AccountId];
                List <Control_AR__c> ctrlAR = [SELECT Id, Id_Cliente_AR__c, Id_Proceso_AR__c, Account__c from Control_AR__c WHERE Proceso_de_Venta__c = :iebs.Proceso_de_Venta__c];
                if (ctrlAR.size()>0) {
                    // Exists
                    ctrlAR[0].Id_Cliente_AR__c = iebs.Id_Cliente_AR__c;
                    ctrlAR[0].Id_Proceso_AR__c = iebs.Id_Proceso_AR__c;
                    system.debug('*** Actualizo Control AR');
                    update ctrlAR;
                } else {
                    Control_AR__c newRec = new Control_AR__c();
                    newRec.Account__c = opp[0].AccountId;
                    newRec.Proceso_de_Venta__c = opp[0].Id;
                    newRec.Proceso_de_Venta_text__c = opp[0].Id;
                    newRec.Plan_de_Venta__c = opp[0].Plan_de_Venta__c;
                    newRec.Id_Cliente_AR__c = iebs.Id_Cliente_AR__c;
                    newRec.Id_Proceso_AR__c = iebs.Id_Proceso_AR__c;
                    system.debug('*** Inserto Control AR');
                    insert newRec;
                }
                // Actualizar Cliente AR en Account
                Account updAcc = new Account(
                    Id = opp[0].AccountId,
                    ID_CLIENTE_AR__c = iebs.Id_Cliente_AR__c,
                    ValidationBypassDateTime__c = Datetime.now()
                );
                try {
                    update updAcc;
                } catch (DmlException e) {
                    system.debug ('Error actualizando Cuenta ID_CLIENTE_AR'+e.getMessage());
                }
                // Actualizar Proceso AR en Opportunity/Proceso de Venta
                opp[0].Id_Proceso_AR__c = iebs.Id_Proceso_AR__c;
                opp[0].ValidationBypassDateTime__c = Datetime.now();
                try {
                    update opp;
                } catch (DmlException e) {
                    system.debug ('Error actualizando Cuenta ID_PROCESO_AR'+e.getMessage());
                }
            }
        }
    }

}