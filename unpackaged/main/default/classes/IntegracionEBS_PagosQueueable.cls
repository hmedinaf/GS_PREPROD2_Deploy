public with sharing class IntegracionEBS_PagosQueueable implements System.Queueable {
    public List<Integracion_EBS_Pagos__c> RecordsToProcess;

    public IntegracionEBS_PagosQueueable(List<Integracion_EBS_Pagos__c> records) {
        this.RecordsToProcess = records;
    }

    public void execute(QueueableContext context) {
       
        set <string> setClientesAR = new set<string>();
        for (Integracion_EBS_Pagos__c i : RecordsToProcess){
            setClientesAR.add(i.IdClienteAr__c);
        }
        map <String, String> mapCuentasAR = new map <String,String>();
        for (Account a : [SELECT Id, ID_CLIENTE_AR__c FROM Account WHERE ID_CLIENTE_AR__c IN :setClientesAR]) {
            mapCuentasAR.put(a.ID_Cliente_AR__c, a.Id);
        }
        set <String> setAplPago = new Set <String>();

        List <Pago__c> lstPago = new List <Pago__c>();

        for (Integracion_EBS_Pagos__c iep : RecordsToProcess) {
            if (iep.Respuesta_API__c=='5' || true) {
                Pago__c newPago = new Pago__c ();

                newPago.Cancelaci_n__c = null;
                newPago.Clasificacion__c = null;
                newPago.Cliente__c = mapCuentasAR.get(iep.IdClienteAr__c);
                // Account acc = new Account (ID_CLIENTE_AR__c = iep.IdClienteAR__c);
                // newPago.Cliente__c = acc;
                // system.debug('*** Cliente__c calculado new way: '+acc);
                try {
                    List <Opportunity> PdV = [SELECT Cobranza_Comercial__c, Titulacion__c FROM Opportunity WHERE Id_Proceso_AR__c = :iep.IdProcesoAr__c LIMIT 1];
                    if (!PdV.isEmpty()) {
                        newPago.Cobranza_Comercial__c = PdV[0].Cobranza_Comercial__c; // Obtener Cobranza Comercial de Proceso AR
                        newPago.Titulacion__c = PdV[0].Titulacion__c;
                    }
                } catch (Exception e) {
                    system.debug ('*** Error: '+e.getMessage());
                }
                newPago.Desc_Tipo_Docto__c = iep.DescTipoDocto__c;
                newPago.Fecha_Contable__c = iep.FechaContable__c;
                newPago.Fecha_de_Cancelacion__c = null;
                newPago.Fecha_de_Pago__c = iep.FechaRecibo__c; // ?
                newPago.Fecha_Deposito__c = iep.FechaDeposito__c;
                newPago.Fecha_Recibo__c = iep.FechaRecibo__c;
                newPago.Folio_de_Cancelacion__c = null;
                newPago.IdClienteAr__c = iep.IdClienteAr__c;
                newPago.IdCobranzaMultiple__c = iep.IdCobranzaMultiple__c;
                newPago.IdEstadoVenta__c = iep.IdEstadoVenta__c;
                newPago.IdInterface__c = iep.IdInterface__c;
                newPago.IdInterfaceCrm__c = iep.IdInterfaceCrm__c;
                newPago.IdMoneda__c = iep.IdMoneda__c;
                newPago.IdProcesoAr__c = iep.IdProcesoAr__c;
                newPago.IdReciboAr__c = string.valueOf(iep.IdReciboAr__c);
                newPago.IdReciboCrm__c = iep.IdReciboCrm__c;
                newPago.IdReestructura__c = iep.IdReestructura__c;
                newPago.IdSector__c = iep.IdSector__c;
                newPago.IdTipoDocto__c = iep.IdTipoDocto__c;
                newPago.Importe__c = iep.ImporteRecibo__c;
                newPago.Ind_Anticipo__c = iep.IndAnticipo__c;
                newPago.Ind_Reversa__c = iep.IndReversa__c;
                
                newPago.Integracion_EBS_Pagos__c = iep.Id;

                newPago.Tipo_de_Pago__c = iep.TipoPago__c!=null ? iep.TipoPago__c : null; //'Payment';
                newPago.Metodo_Pago__c = iep.Metodo__c;
                
                newPago.Motivo_de_Cancelacion__c = null; //?
                String IdReciboAR = string.valueOf(iep.IdReciboAr__c);
                newPago.Nombre_del_Pago__c = iep.TipoPago__c=='NOTA CREDITO'? 'Nota de Crédito' : 'Recibo'; // Puede ser "Recibo" o "Nota de Crédito"
                newPago.No_Pago_AR__c = IdReciboAR; //string.valueOf(iep.IdReciboAr__c);
                newPago.Referencia__c = iep.Referencia__c;
                newPago.Saldo__c = iep.ImporteRecibo__c;
                newPago.SesionCajaId__c = iep.SesionCajaId__c;
                
                newPago.Usuario_que_Cancela__c = null;

                // Si Aplicacion Pago ya existe, ligarlo al pago
                /* Pendiente en Rearquitectura, que hacemos con pagos parciales? ***
                List <Aplicacion_Pago__c> ieapl = [SELECT ID FROM Aplicacion_Pago__c WHERE ID_RECIBO_AR__c = :IdReciboAR];
                if (!ieapl.IsEmpty()) {
                    newPago.Estatus_del_Pago__c = 'Cerrado';
                    newPago.Aplicacion_de_pago__c = ieapl[0].Id;
                    setAplPago.add(ieapl[0].Id);
                    // newPago.Aplicacion_de_pago__c = 
                } else {
                    newPago.Estatus_del_Pago__c = 'Abierto';
                } */
                                
                lstPago.add(newPago);
            }
        }
        if (lstPago.size()>0) {
            Schema.SObjectField key = Pago__c.Fields.No_Pago_AR__c;
            Database.UpsertResult[] saveResults = Database.upsert(lstPago, key, false);
            // insert lstPago;

            List <Integracion_EBS_Pagos__c> lEbsPagos = new List <Integracion_EBS_Pagos__c>();
            set <Id> setFailedRecs = new Set <Id>();
            for (Integer i = 0; i < saveResults.size(); i++) {
                if (!saveResults.get(i).isSuccess()) {
                    // Add the failed record to a reprocessing list
                    Integracion_EBS_Pagos__c fRecord = new Integracion_EBS_Pagos__c();
                    fRecord.id = RecordsToProcess[i].Id;
                    fRecord.Estatus_Integracion__c = 'Reintentar';
                    fRecord.RetryCount__c = RecordsToProcess[i].RetryCount__c+1;
                    // Obtener y guardar todos los errores en Mensaje_Error
                    fRecord.Mensaje_Error__c = '';
                    for (Database.Error err : saveResults.get(i).getErrors()) {
                        System.debug('*** Error en Integracion EBS Pagos: '); 
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        fRecord.Mensaje_Error__c += err.getStatusCode() + ': '+err.getMessage()+' ';
                    }

                    setFailedRecs.add(RecordsToProcess[i].Id); // Id's de Registros a reprocesar
                    lEbsPagos.add(fRecord);
                } else {
                    Integracion_EBS_Pagos__c fRecord = new Integracion_EBS_Pagos__c(
                        Id = RecordsToProcess[i].Id,
                        Mensaje_Error__c = '',
                        Estatus_Integracion__c = 'Integrado',
                        Pago_ID__c = saveResults[i].Id
                    );
                    lEbsPagos.add(fRecord);

                    if (setAplPago.size()>0) {
                        // 11.10 Revisar esta logica con nuevo ER
                        List <Aplicacion_Pago__c> aplPagos = [SELECT ID FROM Aplicacion_Pago__c WHERE Id in :setAplPago];
                        if (!aplPagos.isEmpty()) {
                            aplPagos[0].Estatus_Aplicacion__c = 'Cerrado';
                            // aplPagos[0].Pago__c = saveResults[i].Id;
                            update aplPagos;
                        }
                    }
                }
            }
            if (lEbsPagos.size()>0){
                // Hacer update a los registros de IntegracionEBS_Pagos, si hay fallidos encadenar reproceso
                system.debug('*** Lista Registros EBS Pagos: '+lEbsPagos);
                update lEbsPagos;

                List <Integracion_EBS_Pagos__c> listRetry = [SELECT Id, Name, DbLastUpd__c, IdClienteAr__c, FechaDeposito__c, ConflictId__c, RowId__c, FechaContable__c, Created__c, FechaRecibo__c, IdCobranzaMultiple__c, ModifecationNum__c, IndAnticipo__c, RetryCount__c, IdInterface__c, IdReciboAr__c, IdSector__c, IdReestructura__c, ImporteRecibo__c, IndReversa__c, IdEstadoVenta__c, IdTipoDocto__c, IdProcesoAr__c, Referencia__c, IdMoneda__c, NumRecibo__c, IdReciboCrm__c, SesionCajaId__c, Requisicion__c, Metodo__c, IdInterfaceCrm__c, DescTipoDocto__c, TipoPago__c, Id_Interface_AutoNo__c, Respuesta_API__c, Response_CRM_hacia_EBS__c, Request_CRM_hacia_EBS__c, Estatus_Integracion__c, Mensaje_API__c, Request_EBS_hacia_CRM__c, Response_EBS_hacia_CRM__c, Mensaje_Error__c
                    FROM Integracion_EBS_Pagos__c
                    WHERE Id in :setFailedRecs
                    AND Estatus_Integracion__c = 'Reintentar'
                    AND RetryCount__c <= 3];
                // Reprocesar fallidos
                // List de los fallidos en base a set Y que no excedan el número de retries (5)
                if (listRetry.Size() > 0) {
                    // System.enqueueJob(new IntegracionEBS_AplicacionQueueable(listRetry),1); // Ejecutar con 1 minuto de retraso
                    System.enqueueJob(new IntegracionEBS_PagosQueueable(listRetry));
                }
            }           
        }
    }

}