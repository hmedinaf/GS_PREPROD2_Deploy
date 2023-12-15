public class IntegracionEBS_AplicacionQueueable implements System.Queueable {
    public List<Integracion_EBS_Aplicaciones__c> RecordsToProcess;

    public IntegracionEBS_AplicacionQueueable(List<Integracion_EBS_Aplicaciones__c> records) {
        this.RecordsToProcess = records;
    }

    public void execute(QueueableContext context) {
        // Process records and handle errors here
        Integer maxRetries = 3; // Set a maximum number of retries
        Integer retryCount = 0;
        Boolean recordsFailed = False;
        
        set <String> setFacturasAR = new set<string>();
        map <String, Documento__c> mapFacturasAR = new map <String, Documento__c>();
        List <Documento__c> factsToUpdate = new List <Documento__c>();

        // Obtener set de Facturas a actualizar
        for (Integracion_EBS_Aplicaciones__c newRec : RecordsToProcess) {
            // Obtener en base a Factura Ar el Documento Correspondiente
            setFacturasAR.add(newRec.idFacturaAr__c);
        }    

        // Crear Mapa de Facturas
        List <Documento__c> lFac = [SELECT Id, idFacturaAr__c, Estatus__c, Estatus_AR__c, Pagado__c, Fecha_de_Pago__c, Importe_Aplicado__c
            FROM Documento__c WHERE idFacturaAr__c in :setFacturasAR];
        for (Documento__c fac : lFac) {
            mapFacturasAR.put(fac.idFacturaAr__c, fac);
        }

        List <Aplicacion_Pago__c> lstAplPago = new List <Aplicacion_Pago__c>();

        for (Integracion_EBS_Aplicaciones__c iea : RecordsToProcess) {
            if (iea.Respuesta_API__c=='5') {
                List <Pago__c> pagos = [SELECT Id,Estatus_del_Pago__c, Integracion_EBS_Aplicaciones__c FROM Pago__c WHERE No_Pago_AR__c = :iea.IdReciboAr__c];

                Aplicacion_Pago__c newAP = new Aplicacion_Pago__c ();
                newAP.Id_Integracion_EBS__c = iea.Id;
                newAP.Documento__c = mapFacturasAR.get(iea.idFacturaAR__c).Id;

                // Si pago ya existe, agregarlo a Aplicación Pago y marcarlo como Cerrado
                // if (!pagos.IsEmpty()) {
                //     newAP.Estatus_Aplicacion__c = 'Cerrado';
                //     newAP.Pago__c = pagos[0].Id;
                // } else {
                //     newAP.Estatus_Aplicacion__c = 'En Tránsito';
                // }
                newAP.Estatus_Aplicacion__c = 'Cerrado'; // HMF 11/09 todas las Aplicaciones se marcan cerradas (sum roll-up)

                newAP.CONFLICT_ID__c = iea.ConflictId__c;
                newAP.FECHA_APLICACION__c = iea.FechaAplicacion__c;
                newAP.FECHA_CONTABLE__c = iea.FechaContable__c;

                newAP.ID_APLICACION_AR__c = iea.IdAplicacionAr__c; //Nueva llave

                newAP.ID_CLIENTE_AR__c = iea.IdClienteAr__c;
                newAP.ID_FACTURA_AR__c = iea.IdFacturaAr__c;
                newAP.ID_INTERFACE__c = iea.IdInterface__c;
                newAP.ID_INTERFACE_CRM__c = iea.IdInterfaceCrm__c;
                newAP.ID_NOTA_CRED_AR__c = iea.IdNotaCredAr__c;
                newAP.ID_PROCESO_AR__c = iea.IdProcesoAr__c;
                newAP.ID_RECIBO_AR__c = iea.IdReciboAr__c;
                newAP.IMPORTE_A_CUENTA__c = iea.ImporteACuenta__c;
                newAP.IMPORTE_ANTICIPO__c = iea.ImporteAnticipo__c;
                newAP.IMPORTE_APLICADO__c = iea.ImporteAplicado__c;
                newAP.IMPORTE_FUNCIONAL__c = iea.ImporteFuncional__c;
                newAP.IMPORTE_NO_APLICADO__c = iea.ImporteNoAplicado__c;
                newAP.IMPORTE_NO_IDENTIFICADO__c = iea.ImporteNoIdentificado__c;
                newAP.IMPORTE_ORIGINAL__c = iea.ImporteOriginal__c;
                newAP.IMPORTE_RECLAMO__c = iea.ImporteReclamo__c;
                newAP.IMPORTE_RESTO__c = iea.ImporteResto__c;
                newAP.MENSAJE_API__c = iea.Mensaje_API__c;
                newAP.MODIFICATION_NUM__c = iea.ModificationNum__c;
                newAP.NUM_PROCESO__c = iea.NumProceso__c;
                newAP.REQUISICION_CRM__c = iea.RequisicionCrm__c;
                newAP.RESPUESTA_API__c = iea.Respuesta_API__c;
                newAP.RETRY_COUNT__c = string.valueOf(iea.RetryCount__c);
                newAP.ROW_ID__c = iea.RowId__c;
                newAP.TIPO_APLICATION__c = iea.TipoAplication__c;
                
                lstAplPago.add(newAP);
            }
        }
        if (lstAplPago.size()>0) {
            // insert lstAplPago;
            system.debug('**** Lista upsert: '+lstAplPago);
            Schema.SObjectField key = Aplicacion_Pago__c.Fields.ID_APLICACION_AR__c;
            Database.UpsertResult[] saveResults = Database.upsert(lstAplPago, key, false);

            List <Integracion_EBS_Aplicaciones__c> lEbsApl = new List <Integracion_EBS_Aplicaciones__c>();
            set <Id> setFailedRecs = new Set <Id>();
            for (Integer i = 0; i < saveResults.size(); i++) {
                if (!saveResults.get(i).isSuccess()) {
                    // Estoy guardando nuevos "Aplicacion_Pago"
                    // SI no "pudiera" escribir, tendría que marcarlo como fallido el EBS_Aplicacion para reintentar
                    Integracion_EBS_Aplicaciones__c failedRecord = RecordsToProcess[i];
                    system.debug('*** Entró a registro fallido: '+failedRecord);
                    // Add the failed record to a reprocessing list
                    Integracion_EBS_Aplicaciones__c fRecord = new Integracion_EBS_Aplicaciones__c();
                    fRecord.id = RecordsToProcess[i].Id;
                    fRecord.Estatus_Integracion__c = 'Reintentar';
                    fRecord.RetryCount__c = RecordsToProcess[i].RetryCount__c+1;
                    // Obtener y guardar todos los errores en Mensaje_Error
                    fRecord.Mensaje_Error__c = '';
                    for (Database.Error err : saveResults.get(i).getErrors()) {
                        System.debug('*** Error en Integracion EBS Aplicacion: '); 
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        fRecord.Mensaje_Error__c += err.getStatusCode() + ': '+err.getMessage()+' ';
                    }

                    setFailedRecs.add(RecordsToProcess[i].Id); // Id's de Registros a reprocesar
                    lEbsApl.add(fRecord);
                } else {
                    Integracion_EBS_Aplicaciones__c fRecord = new Integracion_EBS_Aplicaciones__c(
                        Id = RecordsToProcess[i].Id,
                        Mensaje_Error__c = '',
                        Estatus_Integracion__c = 'Integrado',
                        Aplicacion_de_pago__c = saveResults[i].Id
                    );
                    lEbsApl.add(fRecord);
                    // EXITO
                    // Marcar como pagado el PAGO
                    /* HMF 11-09-23 El pago ahora se marca cerrado con otro proceso, no con Aplicacion de Pago
                    try {
                        List <Pago__c> pagos = [SELECT Id,Estatus_del_Pago__c, Integracion_EBS_Aplicaciones__c FROM Pago__c WHERE No_Pago_AR__c = :RecordsToProcess[i].IdReciboAr__c];
                        if (!pagos.isEmpty()) {
                            system.debug('**** Encontró Pago: '+pagos);
                            pagos[0].Integracion_EBS_Aplicaciones__c = RecordsToProcess[i].Id;
                            pagos[0].Aplicacion_de_Pago__c = saveResults.get(i).Id;
                            pagos[0].Estatus_del_Pago__c = 'Cerrado';
                            update pagos;
                        } else {
                            system.debug ('*** NO encontró pagos');
                        }
                    } catch (Exception e) {
                        system.debug ('*** Error en actualizacion de PAGOS');
                    } */
                }
            }

            // encolar reintento:
            if (lEbsApl.size()>0){
                system.debug('*** Lista Registros EBS Aplicacion de este lote: '+lEbsApl);
                update lEbsApl;

                List <Integracion_EBS_Aplicaciones__c> listRetry = [SELECT Id, OwnerId, Name, ConflictId__c, RowId__c, IdInterface__c, IdInterfaceCrm__c, NumProceso__c, TipoAplication__c, RequisicionCrm__c, FechaAplicacion__c, FechaContable__c, IdAplicacionAr__c, IdClienteAr__c, IdFacturaAr__c, IdNotaCredAr__c, IdProcesoAr__c, IdReciboAr__c, ImporteACuenta__c, ImporteAnticipo__c, ImporteAplicado__c, ImporteFuncional__c, ImporteNoAplicado__c, ImporteNoIdentificado__c, ImporteOriginal__c, ImporteReclamo__c, ImporteResto__c, ModificationNum__c, Mensaje_API__c, Respuesta_API__c, RetryCount__c, Request_EBS_hacia_CRM__c, Response_EBS_hacia_CRM__c, Estatus_Integracion__c, Mensaje_Error__c
                    FROM Integracion_EBS_Aplicaciones__c 
                    WHERE Id in :setFailedRecs
                    AND Estatus_Integracion__c = 'Reintentar'
                    AND RetryCount__c <= 3];
                // Reprocesar fallidos
                // List de los fallidos en base a set Y que no excedan el número de retries (5)
                if (listRetry.Size() > 0) {
                    // System.enqueueJob(new IntegracionEBS_AplicacionQueueable(listRetry),1); // Ejecutar con 1 minuto de retraso
                    System.enqueueJob(new IntegracionEBS_AplicacionQueueable(listRetry));
                }
            }
        }
    }
}