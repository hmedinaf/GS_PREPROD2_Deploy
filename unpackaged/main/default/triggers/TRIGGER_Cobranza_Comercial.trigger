trigger TRIGGER_Cobranza_Comercial on Cobranza_Comercial__c (before insert, after insert, after update, before delete) {

    CLASS_Cobranza_Comercial classCobranzaComercial = new CLASS_Cobranza_Comercial();

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            classCobranzaComercial.validaDatos(Trigger.new);
        }
        if(Trigger.isDelete){
            classCobranzaComercial.eliminaOtraRelacionCobranzaComercial(Trigger.old);
        }
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            classCobranzaComercial.creaPagareEnganche(Trigger.new);
        }
        if(Trigger.isUpdate){
            Id tipoReg = Schema.SObjectType.Documento__c.getRecordTypeInfosByDeveloperName().get('Nota_Credito').getRecordTypeId();
            // Validar si cambio check Vivienda
            
            for(Cobranza_Comercial__c c : Trigger.New){
                if(c.Vivienda_Cobrada__c==true && Trigger.oldMap.get(c.Id).Vivienda_Cobrada__c!=true){
                    // Cuando el check vivienda = true checar por saldos a favor para devolución
                    if(c.Saldo_Devolucion__c > 0) {
                        // Si hay saldo a favor crear un documento/pagaré de lo pendiente
                        system.debug('*** CC Trigger vivienda cobrada=TRUE / Devolucion > 0');

                        Documento__c pag = new Documento__c();
                        pag.Cobranza_Comercial__c = c.Id;
                        pag.Estatus__c = 'ABIERTO';
                        pag.Estatus_AR__c = 'PENDIENTE';
                        pag.Importe__c = c.Saldo_Devolucion__c;
                        pag.Pagado__c = false;
                        pag.RecordTypeId = tipoReg;
                        pag.Tipo__c = 'NC_REEMBOLSO_POR_ESCRITURA';

                        insert pag;
                        system.debug('*** CC Trigger. Nuevo pago: '+pag);

                        // Enviar nuevo documento/pagaré a EBS
                        Integracion_Facturas_EBS.Inserta_Facturas_EBS('1', c.Plan_Venta__c, pag.Id);
                    }
                }
            }
            // Mas adelante
            // Cuando el check vivienda = true
            // checar por saldos a favor y pendientes
            // si hay saldo, ejecutar Ruta de Aprobación de Devoluciones
            // Cuando se apruebe, crear documento/pagare de lo pendiente
            // enviar a EBS

        }
    }
}