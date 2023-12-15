public class CLASS_Plan_Venta_Aprobacion {

    @InvocableMethod(label='Obtener Aprobacion Plan de Venta' description='Obtener Aprobacion Plan de Venta')
    public static List<PlanVentaDetailsWrapper> CLASS_Plan_Venta_Aprobacion(List<PlanVentaInputWrapper> inputList) {
        List<PlanVentaDetailsWrapper> outputList = new List<PlanVentaDetailsWrapper>();
        system.debug('*** Entró a Aprobación Plan de Venta');
        String sRespuesta = '';

        for (PlanVentaInputWrapper input : inputList) {
            PlanVentaDetailsWrapper output = new PlanVentaDetailsWrapper();

            // Retrieve PlanVenta details based on the provided PlanVenta ID
            Plan_de_Venta__c rPlanVenta = [SELECT ID, Oportunidad__c, Vivienda__c,Exepcion_Fondo_de_Garantia_Aprobado__c, Fecha_Proyeccion_escritura__c,
                    Credito_Neto_Final_1__c, Credito_Neto_Final_2__c, Credito_Neto_Final_3__c, Diferencia_a_Pagar__c, Plan_de_Venta_Aprobado__c,Estatus_Plan_de_venta__c,
                    Fondo_de_Garantia__c,Fondo_de_Garantia_No_Cubierto__c,Valor_Operacion_vs_Credito_Neto__c,
                    Requiere_Pagare_Enganche__c, Cuadra_Enganche_vs_Pagares_Preventa__c, Enviar_Rutas_a_Aprobacion__c,
                    Chk_Formalixacion_Informaci_n_Completa__c, OwnerId
                    FROM Plan_de_Venta__c WHERE Id = :input.PlanVentaId];
            Id oppId = rPlanVenta.Oportunidad__c;
            system.debug('*** oppID: '+oppId);


            Opportunity rOpp = [SELECT Id, AccountId, Tipo_de_Tramite__c,Valor_Operacion__c FROM Opportunity WHERE Id = :oppId];
            /* HMF 2023-06-07 Los valores se checan vs Dictaminación, no Account
            Id accId = rOpp.AccountId;
            Account rAcc = [SELECT ID, Estado_Civil__c, Phone, Otro_Telefono__c, TelefonoCelular__c, Tipo_Credito__c, 
                            DependientesEconomicos__c, Ingresos_Mensuales__c, Tipo_Contribuyente__c
                            FROM Account WHERE ID = :accId];

            // Validar checks o validar: edo civil, telefonos, tipo credito, dependientes eco, ingreso mensual
            if (rAcc.Tipo_Contribuyente__c == 'PERSONA FISICA') {
                sRespuesta += rAcc.Estado_Civil__c==null ? '- Falta Estado Civil<br/>' : '';
                sRespuesta += rAcc.Phone==null ? '- Falta Teléfono Casa<br/>' : '';
                sRespuesta += rAcc.TelefonoCelular__c==null ? '- Falta Teléfono Celular<br/>' : '';
                sRespuesta += rAcc.Tipo_Credito__c==null ? '- Falta Tipo de Crédito<br/>' : '';
                sRespuesta += rAcc.DependientesEconomicos__c==null ? '- Falta Dependientes Economicos<br/>' : '';
                sRespuesta += rAcc.Ingresos_Mensuales__c==null ? '- Falta Ingresos Mensuales<br/>' : '';
            }
            */

            // direccion principal y laboral. (se realiza en Dictaminación)
            // Obtener dictaminacion asociado a Plan de Venta

            Id dictId;
            List <Dictaminacion__c> lDict = [SELECT Id, Chk_Dictaminacion_Completa__c,  Dictaminacion__c.Tipo_Contribuyente_c__c, Estado_civil__c,
                Telefono_Casa__c,TelefonoCelular__c,Tipo_de_Credito__c, Dependientes_economicos__c,Ingresos_mensuales__c 
                FROM Dictaminacion__c WHERE Oportunidad__c = :oppId];
            system.debug('*** lDict: '+lDict);

            if (lDict.size()>0) {
                dictId = lDict[0].Id;
                // Refrescar info dictaminación:
                checkDictaminacionController.getCheckInfo (dictId);

                if (lDict[0].Tipo_Contribuyente_c__c == 'PERSONA FISICA') {
                    sRespuesta += lDict[0].Estado_civil__c==null ? '- Falta Estado Civil<br/>' : '';
                    if (lDict[0].Telefono_Casa__c==null && lDict[0].TelefonoCelular__c==null) {
                        sRespuesta += lDict[0].Telefono_Casa__c==null ? '- Falta Teléfono Casa<br/>' : '';
                        sRespuesta += lDict[0].TelefonoCelular__c==null ? '- Falta Teléfono Celular<br/>' : '';    
                    }
                    sRespuesta += lDict[0].Tipo_de_Credito__c==null ? '- Falta Tipo de Crédito<br/>' : '';
                    sRespuesta += lDict[0].Dependientes_economicos__c==null ? '- Falta Dependientes Economicos<br/>' : '';
                    sRespuesta += lDict[0].Ingresos_mensuales__c==null ? '- Falta Ingresos Mensuales<br/>' : '';
                }
                
                if (!lDict[0].Chk_Dictaminacion_Completa__c) {
                    sRespuesta += '- Checklist Dictaminación Incompleto<br/>';
                }
            } else {
                sRespuesta += '- Checklist Dictaminación Incompleto<br/>';
            }
            
            //Datos Coacreditado cuando el tipo es conyugal
            if (rOpp.Tipo_de_Tramite__c == 'CONYUGAL') {
                // Checar por Coacreditado ligado a Dictaminación
                List <Co_Acreditado__c> lCoAcr = [SELECT Id FROM Co_Acreditado__c WHERE Dictaminacion__c = :dictId];
                if (lCoAcr.size() == 0) {
                    sRespuesta += '- No tiene CoAcreditados<br/>';
                }
            }
            // Vivienda Reservada
            if (rPlanVenta.Vivienda__c == null) {
                sRespuesta += '- No tiene Vivienda Reservada<br/>';
            }

            // Que no esté activada ninguna ruta de aprobación (pendiente, agregarán un checkbox)

            // Cumplimiento de esta condición: Credito Neto Final 1 + Credito Neto Final 2 + Credito Neto Final 3
            // + Enganche a Pagar = Monto de Valor en Operacion (o Enganche_a_Pagar__c)
            Double sumaCreditos = rPlanVenta.Credito_Neto_Final_1__c + rPlanVenta.Credito_Neto_Final_2__c + rPlanVenta.Credito_Neto_Final_3__c + rPlanVenta.Diferencia_a_Pagar__c;
            if (sumaCreditos != rOpp.Valor_Operacion__c) {
                // sRespuesta += '- La suma de los Créditos (1, 2 y 3) no es igual al Monto del Valor de la Operación<br/>';                
            }

            // Regla de Fondo de Garantía en caso de ser de este tipo
            if (rPlanVenta.Fondo_de_Garantia__c==TRUE && 
                    rPlanVenta.Fondo_de_Garantia_No_Cubierto__c == TRUE &&
                    rPlanVenta.Exepcion_Fondo_de_Garantia_Aprobado__c == FALSE) {
                sRespuesta += '- No tiene Excepción de Fondo de Garantía Aprobado<br/>';
            }
            // Reglas de Venta Anticipada en caso de ser de este tipo (Pendiente)

            // Fecha Proyeccion Escritura (verde)
            if (rPlanVenta.Fecha_Proyeccion_escritura__c == null) {
                sRespuesta += '- No tiene Fecha de Proyección de Escritura<br/>';
            }
            // Validación de Promoción de Precio (en caso de que esté asignada al proceso de venta)

            if (rPlanVenta.Requiere_Pagare_Enganche__c) {
                if(!rPlanVenta.Cuadra_Enganche_vs_Pagares_Preventa__c) {
                    sRespuesta += '- Los Pagarés Preventa no cuadran con el Monto del Enganche<br/>';
                }
            }
            if (!rPlanVenta.Valor_Operacion_vs_Credito_Neto__c) {
                sRespuesta += '- Valor de Operación no coincide con suma de crédito neto<br/>';
            }

            if (sRespuesta == '') {
                sRespuesta = '<strong>Información Completa</strong><br/><br/>Plan de Venta Aprobado<br/>';
                // "Aprobar" plan de venta
                rPlanVenta.Plan_de_Venta_Aprobado__c = False;
                rPlanVenta.Enviar_Rutas_a_Aprobacion__c = True;
                rPlanVenta.Estatus_Plan_de_venta__c = 'Por Aprobar';
                rPlanVenta.Chk_Formalixacion_Informaci_n_Completa__c = true;
                rPlanVenta.OwnerId = UserInfo.getUserId();
                // try {
                    system.debug('*** Update a rPlanVenta desde Plan Venta Aprobación');
                    update (rPlanVenta);                    
                // } catch (DMLException e) {
                //     system.debug('CLASS Plan Venta Aprobacion error: '+e);
                // }

            } else {
                sRespuesta = '<strong>Información Faltante:</strong><br/>' + sRespuesta;
            }
            // Set the PlanVenta details in the output wrapper
            output.PlanVentaResult = sRespuesta;
            // output.PlanVentaName = opp.Name;
            // output.closeDate = opp.CloseDate;
            // output.stageName = opp.StageName;
            
            outputList.add(output);
        }
        
        return outputList;
    }
    
    // Wrapper class for input parameters
    public class PlanVentaInputWrapper {
        @InvocableVariable(required=true)
        public String PlanVentaId;
    }
    
    // Wrapper class for output results
    public class PlanVentaDetailsWrapper {
        @InvocableVariable
        public String PlanVentaResult;
    }
}