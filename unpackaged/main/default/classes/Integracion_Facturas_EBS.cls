public class Integracion_Facturas_EBS {
    public static void Inserta_Facturas_EBS(String ClaveRequisicion, Id recordId, Id documentoId) {
        // recordId = Plan de Venta
        system.debug('*** Inserta_Facturas_EBS recordId: '+recordId);

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
            'PAGARE_SUBSIDIO' => 'EC-VIM PAG SB',
            'NC_REEMBOLSO_POR_ESCRITURA' => 'EC-VIM PAG REEM ESC'
        };

        if (recordId!=null) {
            // Obtener info de Plan de Venta
            List <Plan_de_Venta__c> lPDV = [SELECT Id, Oportunidad__c, Vivienda__c, Fecha_Reestructura__c, Identificador_de_la_Cuenta__c,
                    Fraccionamiento__c, Prototipo_Id_Formula__c 
                FROM Plan_de_Venta__c 
                WHERE Estatus_Plan_de_venta__c in ('En Progreso','Aprobado','Por Aprobar')
                AND Id = :recordId];
            system.debug('*** plan de venta: '+lPDV);
            // Obtener Información sobre Proceso de Venta relacionado:
            /* 
            List <Opportunity> lOpp = [SELECT ID, Name, AccountId, Dictaminacion__c, Fraccionamiento__r.UEN__c, Fecha_Escrituracion__c,
                        Prototipo__r.Name, Fraccionamiento__r.Name, Opp_Id_Proceso_AR__c,Prototipo__r.Id_Prototipo__c, Fraccionamiento__r.Id_Fraccionamiento__c,
                        Opp_Financiera__c, StageName
                    FROM Opportunity WHERE Id=:recordId];
            */

            // Obtener Información de Account
            List <Account> lAcc = [SELECT Id, ID_CLIENTE_AR__c, Numero_de_Cliente_AutoNum__c
                    FROM Account WHERE Id = :lPDV[0].Identificador_de_la_Cuenta__c];
            system.debug('*** lAcc: '+lacc);

            // leer de Titulacion
            List <Titulacion__c> lTtl = [SELECT Opp_Id_Proceso_AR__c, Numero_de_Credito__c FROM Titulacion__c WHERE Plan_de_Venta__c = :recordId];
            system.debug('*** lTtl: '+lTtl);

            // Obtener codigos ARid
            String IdClienteAR='';
            String IdProcesoAR='';

            IdClienteAR = lAcc[0].ID_CLIENTE_AR__c;
            IdProcesoAR = lTtl[0].Opp_Id_Proceso_AR__c;

            if (IdClienteAR==null || IdProcesoAR==null){
                List <Control_AR__c> ctrlAR = [SELECT Id, Id_Cliente_AR__c, Id_Proceso_AR__c, Proceso_de_venta_text__c FROM Control_AR__c WHERE Plan_de_Venta__c = :recordId];
                if (ctrlAR.size()>0) {
                    idClienteAR = ctrlAR[0].ID_Cliente_AR__c;
                    idProcesoAR = ctrlAR[0].Id_Proceso_AR__c;
                }
            }
            system.debug('*** Id Cliente AR: '+idClienteAR);
            system.debug('*** Id Proceso AR: '+idProcesoAR);

            // Obtener datos de la vivienda
            List <Vivienda__c> lVivienda = [SELECT Id, Num_Interior__c, Lote__c, Manzana__c, Excendente_M2__c FROM Vivienda__c WHERE ID = :lPDV[0].Vivienda__c];

            Id idPrototipo = lPDV[0].Prototipo_Id_Formula__c;
            List <Prototipo__c> lProt = [SELECT Name, Id_Prototipo__c, Fraccionamiento__r.Id_Fraccionamiento__c
                FROM Prototipo__c WHERE Id = :idPrototipo];
            system.debug('*** lProt: '+lProt);

            List <Cobranza_Comercial__c> lCbCm = [SELECT Id, Monto_Financiamiento__c, Numero_de_Credito__c, Plazo__c, Valor_Operacion__c
                FROM Cobranza_Comercial__c WHERE Plan_Venta__c = :recordId];
            system.debug ('*** List Cob Com: '+lCbCm);

            // SI no hay vivienda, salir
            if (lPDV.isEmpty() || lAcc.isEmpty() || lVivienda.isEmpty() || lCbCm.isEmpty()) {
                system.debug('*** Datos mandatorios faltantes en EBS Facturas, no procesa EBS');
                return;
            }

            // List <Documento__c> lDoc = [SELECT Estatus__c, Fecha_Vencimiento__c, Tipo_Documento__c, Name, Importe__c, Tipo__c
            //     FROM Documento__c
            //     WHERE Cobranza_Comercial__c = :lCbCm[0].Id];

            String dynamicQuery = 'SELECT Estatus__c, Fecha_Vencimiento__c, Tipo_Documento__c, Name, Importe__c, Tipo__c ';
            dynamicQuery += 'FROM Documento__c WHERE Cobranza_Comercial__c = \'' + lCbCm[0].Id + '\'';
            if (documentoId!=null)
                dynamicQuery += ' AND Id = \'' + documentoID + '\'';
            system.debug('*** FacturaEBS dynamicQuery: '+dynamicQuery);

            // Execute the dynamic query and store the results in a list
            List<Documento__c> lDoc = Database.query(dynamicQuery);

            List <Integracion_EBS_Facturas__c> lstIntEBSFact = new List <Integracion_EBS_Facturas__c>();

            if (lDoc.size()>0) {
                for (Documento__c doc : lDoc) {

                    Integracion_EBS_Facturas__c  newRec = new Integracion_EBS_Facturas__c ();

                    newRec.RequisicionCrm__c = ClaveRequisicion;
                    system.debug('*** EBS Fact ClaveRequisicion: '+ClaveRequisicion);

                    newRec.CategoriaDesc__c = null;
                    newRec.ConflictId__c = '0';
                    newRec.DocumentoAplicado__c = null;
                    newRec.DocumentoClase__c = null;
                    newRec.DocumentoDesc__c = 'Factura Pagaré Post Venta';
                    newRec.DocumentoRef__c = null;
                    newRec.EntidadLegal__c = null;
                    newRec.EstatusFactura__c = '1'; //doc.Estatus__c;
                    newRec.EstatusProceso__c = 1;
                    newRec.EstatusReg__c = null;
                    newRec.Factura__c = doc.Id;
                    newRec.FechaContable__c = null;
                    newRec.FechaReestructura__c = lPDV[0].Fecha_Reestructura__c;
                    newRec.FechaVencimiento__c = doc.Fecha_Vencimiento__c;
                    newRec.FideicomisoFact__c = null;
                    newRec.FideicomosoDesc__c = null;
                    newRec.FinancieraDesc__c = null; // lOpp[0].Financiera__c;
                    newRec.FinancieraNum__c = lttl[0].Numero_de_Credito__c;
                    newRec.IdAplicarDocto__c = null;
                    newRec.IdClase__c = null;
                    newRec.IdClienteAr__c = lAcc[0].ID_CLIENTE_AR__c;
                    system.debug ('ClienteAR: '+lAcc[0].ID_CLIENTE_AR__c);
                    newRec.IdCobranzaMultiple__c = null;
                    newRec.IdDireccionRegional__c = null;
                    newRec.IdDocumentoTipo__c = 1; // Pendiente, se obtiene un secuencial;
                    newRec.IdFacturaAr__c = null; // Enviar con valor cuando se tenga
                    newRec.IdFacturaCrm__c = doc.Name;
                        //lOpp[0].Fraccionamiento__r.Id_Fraccionamiento__c!=null?decimal.valueOf(lOpp[0].Fraccionamiento__r.Id_Fraccionamiento__c):null;
                    newRec.IdFraccionamiento__c = lProt[0].Fraccionamiento__r.Id_Fraccionamiento__c!=null ? Decimal.ValueOf(lProt[0].Fraccionamiento__r.Id_Fraccionamiento__c) : null;
                    // lOpp[0].Prototipo__r.Id_Prototipo__c!=null?decimal.ValueOf(lOpp[0].Prototipo__r.Id_Prototipo__c):null;
                    newRec.IdPrototipo__c = lProt[0].Id_Prototipo__c!=null ? Decimal.ValueOf(lProt[0].Id_Prototipo__c) : null; 
                    
                    newRec.IdInterface__c = null; // Lo llena el servicio con auto-number
                    newRec.IdInterfaceCrm__c = '';
                    newRec.IdLote__c = lVivienda[0].Lote__c!=null? integer.valueOf(lVivienda[0].Lote__c):null; // se puede quitar
                    newRec.IdManzana__c = lVivienda[0].Manzana__c!=null? integer.valueOf(lVivienda[0].Manzana__c):null; // se puede quitar
                    newRec.IdMunicipio__c = null; // No se tiene municipio en VIVIENDA
                    newRec.IdPagareConta__c = null;
                    newRec.IdPagareReversa__c = null;
                    newRec.IdProcesoAr__c = IdProcesoAR;
                    newRec.IdReestructura__c = null;
                    newRec.IdTipoFactura__c = null; // puede ser null
                    newRec.ImporteFactura__c = doc.Importe__c;
                    newRec.IndAntesEscritura__c = 0;
                    newRec.IndGastoAdmin__c = '0';
                    newRec.IndIntereses__c = '0';
                    newRec.IndReembolso__c = '0';
                    newRec.IndReestructurado__c = '0';
                    newRec.ModificationNum__c = 0;
                    newRec.Moneda__c = 'MXN';
                    newRec.MontoFinanciado__c = String.valueOf(integer.valueof(lCbCm[0].Monto_Financiamiento__c));
                    newRec.NumCredito__c = lttl[0].Numero_de_Credito__c;
                    newRec.NumFactura__c = doc.Name;
                    newRec.OrigenDesc__c = null;
                    newRec.Respuesta_API__c = '0';
                    newRec.RetryCount__c = null;
                    newRec.RowId__c = null; // PEND Cobranza Comercial.Name
                    newRec.TermPago__c = string.valueOf(lCbCm[0].Plazo__c); //revisar pendiente
                    newRec.TipoFactura__c = mapTipoDoc.get(doc.Tipo__c); //'EC-VIM PAG PV'; //doc.Tipo__c;
                    newRec.ValorCobJaver__c = null;
                    newRec.ValorOperacion__c = lCbCm[0].Valor_Operacion__c;
                    newRec.Request_CRM_hacia_EBS__c = null;
                    newRec.Response_CRM_hacia_EBS__c = null;
                    newRec.Estatus_Integracion__c = 'Nuevo';
                    newRec.Mensaje_API__c = null;

                    lstIntEBSFact.add(newRec);
                }
                insert lstIntEBSFact;
            } else {
                system.debug('*** No hay facturas para enviar');
            }
        }
    }

    @InvocableMethod(label='Insert Integracion Facturas EBS')
    public static void invokeInserta_Integracion_Fact_EBS(List<InvocableParameters> params) {
        system.debug('****** invokeInserta params: '+params);
        String ClaveRequisicion = params[0].ClaveRequisicion;
        Id planId = params[0].PlanVentaId;
        Inserta_Facturas_EBS(ClaveRequisicion, planId, null);
    }

    public class InvocableParameters {
        @InvocableVariable(label='Clave Requisicion')
        public String ClaveRequisicion;
        @InvocableVariable(label='Plan de Venta ID')
        public Id PlanVentaId;
    }

}