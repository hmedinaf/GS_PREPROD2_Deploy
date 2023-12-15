public class Integracion_Pagos_EBS {

    public static void Inserta_Pagos_EBS(String ClaveRequisicion, Id recordId) {

        // Map de Documento.Tipo__c a claves EBS (EC-VIM PAG PV)
        Map <String, String> mapTipoDoc = new Map <String, String>
        {
            'NC_BONIFICACION' => 'EC-VIM NC BF',
            'NC_DEVOLUCION_NO_APLICA' => '',
            'NC_GASTOS_NOTARIALES' => 'EC-VIM NC GN',
            'NC_GASTOS_OPERATIVOS' => 'EC-VIM NC GADM',
            'PAGARE_AHORRO_VOLUNTARIO' => 'EC-VIM PAG AHV',
            'PAGARE_DEVOLUCION_NO_APLICA' => 'EC-VIM NC CAN PAG GN',
            'PAGARE_ENGANCHE' => 'EC-VIM PAG EN',
            'PAGARE_FINANCIERA' => 'EC-VIM PAG IF',
            //'PAGARE FINANCIERA' => 'VIM PAGARE IF',
            'PAGARE_GASTOS_NOTARIALES' => 'EC-VIM PAG GN',
            'PAGARE_GASTOS_OPERATIVOS' => 'EC-VIM PAG GADM',
            'PAGARE_POSTVENTA' => 'EC-VIM PAG PV',
            'PAGARE_SUBSIDIO' => 'EC-VIM PAG SB'
        };

        if (recordId!=null) {
            // Obtener info de Plan de Venta
            List <Plan_de_Venta__c> lPDV = [SELECT Id, Oportunidad__c, Vivienda__c, Fecha_Reestructura__c
                FROM Plan_de_Venta__c 
                WHERE Estatus_Plan_de_venta__c in ('En Progreso','Aprobado','Por Aprobar')
                AND Oportunidad__c = :recordId];

            // Obtener Información sobre Proceso de Venta relacionado:
            List <Opportunity> lOpp = [SELECT ID, Name, AccountId, Dictaminacion__c, Fraccionamiento__r.UEN__c, Fecha_Escrituracion__c,
                        Prototipo__r.Name, Fraccionamiento__r.Name, Id_Proceso_AR__c,Prototipo__r.Id_Prototipo__c, Fraccionamiento__r.Id_Fraccionamiento__c,
                        Financiera__c, StageName
                    FROM Opportunity WHERE Id=:recordId];

            // Obtener Información de Account
            List <Account> lAcc = [SELECT Id, ID_CLIENTE_AR__c, Numero_de_Cliente_AutoNum__c
                    FROM Account WHERE Id = :lOpp[0].AccountId];

            system.debug('*** lAcc: '+lacc);
            // Obtener codigos AR (si existen)
            // String IdClienteAR='';
            // String IdProcesoAR='';
            // List <Control_AR__c> ctrlAR = [SELECT Id, Id_Cliente_AR__c, Id_Proceso_AR__c FROM Control_AR__c WHERE Account__c = :lOpp[0].AccountId];
            // if (ctrlAR.size()>0) {
            //     idClienteAR = ctrlAR[0].ID_Cliente_AR__c;
            //     idProcesoAR = ctrlAR[0].Id_Proceso_AR__c;
            // }
            // system.debug('*** Id Cliente AR: '+idClienteAR);

            // Obtener datos de la vivienda
            List <Vivienda__c> lVivienda = [SELECT Id, Num_Interior__c, Lote__c, Manzana__c, Excendente_M2__c FROM Vivienda__c WHERE ID = :lPDV[0].Vivienda__c];

            List <Cobranza_Comercial__c> lCbCm = [SELECT Id, Monto_Financiamiento__c, Numero_de_Credito__c, Plazo__c, Valor_Operacion__c
                FROM Cobranza_Comercial__c WHERE Proceso_Venta__c = :recordId];

            // SI no hay vivienda, salir
            if (lPDV.isEmpty() || lAcc.isEmpty() || lVivienda.isEmpty() || lCbCm.isEmpty()) {
                system.debug('*** Datos mandatorios faltantes en EBS Pagos, no procesa envío a EBS');
                return;
            }

            List <Pago__c> lPago = [SELECT Id, Cancelaci_n__c, Clasificacion__c, Cliente__c, Cobranza_Comercial__c, Estatus_del_Pago__c, 
                        Fecha_de_Cancelacion__c, Fecha_de_Pago__c, Folio_de_Cancelacion__c, Importe__c, Metodo_Pago__c, Motivo_de_Cancelacion__c, 
                        Name, No_Pago_AR__c, Nombre_del_Pago__c, Numero_de_Pago__c, Saldo__c, Tipo_de_Pago__c, Titulacion__c, Usuario_que_Cancela__c
                    FROM Pago__c
                    WHERE Cobranza_Comercial__c = :lCbCm[0].Id ];

            // Set field values
            // system.debug('Requisicion: '+ClaveRequisicion);
            // system.debug('Id Cliente AR: '+lAcc[0].ID_CLIENTE_AR__c);
            // system.debug('Id Proceso AR: '+lOpp[0].Id_Proceso_AR__c);
            // if (ClaveRequisicion == '2' && lAcc[0].ID_CLIENTE_AR__c!=null && lOpp[0].Id_Proceso_AR__c==null) {
            //     ClaveRequisicion = '4';
            // }

            List <Integracion_EBS_Pagos__c> lstIntEBSPago = new List <Integracion_EBS_Pagos__c>();

            for (Pago__c pago : lPago) {

                Integracion_EBS_Pagos__c  newRec = new Integracion_EBS_Pagos__c ();

                // newRec.RequisicionCrm__c = ClaveRequisicion;
                system.debug('*** EBS Fact ClaveRequisicion: '+ClaveRequisicion);

                newRec.ConflictId__c = '0';

                newRec.Created__c = null;
                // newRec.DbLastUpd__c = Datetime.Now();
                newRec.DescTipoDocto__c = pago.Clasificacion__c;
                newRec.Estatus_Integracion__c = 'Nuevo';
                newRec.FechaContable__c = date.today();
                newRec.FechaDeposito__c = pago.Fecha_de_Pago__c;
                newRec.FechaRecibo__c = pago.Fecha_de_Pago__c;
                newRec.IdClienteAr__c = lAcc[0].ID_CLIENTE_AR__c;
                newRec.IdCobranzaMultiple__c = null; //?
                newRec.IdEstadoVenta__c = null; //pago.Estatus_del_Pago__c; //?
                newRec.IdInterfaceCrm__c = ''; 
                newRec.IdMoneda__c = 'MXP';
                newRec.IdProcesoAr__c = lOpp[0].Id_Proceso_AR__c;
                newRec.IdReciboAr__c = null;
                newRec.IdReciboCrm__c = '';
                newRec.IdReestructura__c = null;
                newRec.IdSector__c = null;
                newRec.IdTipoDocto__c = 0; //mapTipoDoc.get(doc.Tipo__c); //'EC-VIM PAG PV'; //doc.Tipo__c;
                newRec.ImporteRecibo__c = pago.Importe__c;
                newRec.IndAnticipo__c =  null;
                newRec.IndReversa__c =  null;
                newRec.Metodo__c = pago.Metodo_Pago__c;
                newRec.ModifecationNum__c = null;
                newRec.NumRecibo__c = pago.Numero_de_Pago__c;
                newRec.Referencia__c = pago.Name;
                newRec.RowId__c = null;
                newRec.SesionCajaId__c = null;
                newRec.TipoPago__c = pago.Tipo_de_Pago__c; //map?

                newRec.Mensaje_API__c = null;

                // newRec.Request_CRM_hacia_EBS__c = 
                // newRec.Request_EBS_hacia_CRM__c = 
                // newRec.Response_CRM_hacia_EBS__c = 
                // newRec.Response_EBS_hacia_CRM__c = 
                // newRec.Respuesta_API__c = 
                // newRec.RetryCount__c = 
                

                lstIntEBSPago.add(newRec);
            }

            insert lstIntEBSPago;
        }
    }
}