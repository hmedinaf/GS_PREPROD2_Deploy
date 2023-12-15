public class CLASS_Plan_Venta_Formalizacion {

    @InvocableMethod(label='Obtener Formalizacion Plan de Venta' description='Obtener Formalizacion Plan de Venta')
    public static List<PlanVentaDetailsWrapper> CLASS_Plan_Venta_Formalizacion(List<PlanVentaInputWrapper> inputList) {
        List<PlanVentaDetailsWrapper> outputList = new List<PlanVentaDetailsWrapper>();

        String sRespuesta = '';

        for (PlanVentaInputWrapper input : inputList) {
            PlanVentaDetailsWrapper output = new PlanVentaDetailsWrapper();

            // Retrieve PlanVenta details based on the provided PlanVenta ID
            Plan_de_Venta__c rPlanVenta = [SELECT ID, Oportunidad__c, Estatus_Plan_de_venta__c, Plan_de_Venta_Aprobado__c, Fecha_Formalizacion__c, Plan_de_Venta_Formalizado__c, Chk_Formalixacion_Informaci_n_Completa__c
                    FROM Plan_de_Venta__c WHERE Id = :input.PlanVentaId];
            Id oppId = rPlanVenta.Oportunidad__c;
            system.debug('*** Plan de Venta ID: '+input.PlanVentaId);
            system.debug('*** oppID: '+oppId);

            // Obtener dictaminacion asociado a Plan de Venta
            Id contId;
            List <Dictaminacion__c> lDict = [SELECT Id, Chk_Dictaminacion_Completa__c,  Dictaminacion__c.Tipo_Contribuyente_c__c, Estado_civil__c,
                Telefono_Casa__c,TelefonoCelular__c,Tipo_de_Credito__c, Dependientes_economicos__c,Ingresos_mensuales__c 
                FROM Dictaminacion__c WHERE Oportunidad__c = :oppId];
            system.debug('*** lDict: '+lDict);

            // List <Contract> lCont = [SELECT Id,Check_Inf_Laboral__c, Check_Inf_Cliente__c, Check_Inf_Cliente_Moral__c, Notaria__c,No_Escritura__c,
            //     Ya_Capturo_Representante_Legal__c, Ya_Capturo_Info_CoAcreditado__c, Direccion_Empresa__c,Ya_Capturo_Referencia_Familiar__c,
            //     CHK_Alta_SHCP__c, CHK_Cedula_Fiscal__c, CHK_Comprobante_de_Domicilio__c, CHK_CURP__c, 
            //     CHK_Escritura__c, CHK_Facultades_Servidor_Publico__c, CHK_Identificacion_Oficial__c,
            //     CHK_INE_Representante_Legal__c, CHK_Recibos_de_Nomina__c, Tipo_Contribuyente_c__c, Chk_Dictaminacion_Completa__c
            //     FROM Contract WHERE Oportunidad__c = :oppId];
            if (lDict.size()>0) {
                contId = lDict[0].Id;
                // Refrescar info dictaminación:
                checkDictaminacionController.getCheckInfo (contId);
            }

            system.debug ('*** rCont Id: '+contId);

            // Leer PROCESO DE VENTA
            List <Opportunity> lOpp = [SELECT Id, AccountId, Estatus_Formula__c, StageName, Etapa_de_Venta__c, Fecha_Formalizacion__c, ValidationBypassDateTime__c FROM Opportunity WHERE Id = :oppId LIMIT 1];

            if (lOpp.size()==0) {
                sRespuesta += 'Problema interno, no se localizó el Proceso de Venta.<br/>';
                output.PlanVentaResult = sRespuesta;
                outputList.add(output);
                return outputList;           
            }

            // Leer Cuenta
            Id accId = lOpp[0].AccountId;
            List <Account> lAcc = [SELECT ID, Estatus_Lista_Negra_QEQ__c, RecordType.Name, ValidationBypassDateTime__c FROM Account WHERE ID = :accId LIMIT 1];

            // Proceso de Venta en Estatus Reservado
            sRespuesta += lOpp[0].Estatus_Formula__c!='Reservado' ? '- Proceso de Venta no esta con estatus Reservado<br/>' : '';

            // Plan de Venta Aprobado
            sRespuesta += rPlanVenta.Estatus_Plan_de_venta__c!='Aprobado' ? '- El Plan de Venta no ha sido Aprobado<br/>' : '';

            // Estatus LN = Validado
            if (lAcc.size()>0) {
                sRespuesta += lAcc[0].Estatus_Lista_Negra_QEQ__c!='VALIDADO' ? '- Estatus Lista Negra no Validado<br/>' : '';
            }

            // Campos obligatorios

            // Resultado Dictaminación
            if (lDict.size()>0) {
                if (!lDict[0].Chk_Dictaminacion_Completa__c) {
                    sRespuesta += '- Información faltante en Dictaminación<br/>';
                }
                /*
                if (lCont[0].Tipo_Contribuyente_c__c == 'PERSONA FISICA') {
                    if (!(lCont[0].Check_Inf_Laboral__c &&
                        lCont[0].Check_Inf_Cliente__c &&
                        lCont[0].Check_Inf_Cliente_Moral__c &&
                        lCont[0].Ya_Capturo_Representante_Legal__c &&
                        lCont[0].Ya_Capturo_Info_CoAcreditado__c &&
                        lCont[0].Direccion_Empresa__c != null &&
                        lCont[0].Ya_Capturo_Referencia_Familiar__c &&
                        lCont[0].CHK_Alta_SHCP__c && lCont[0].CHK_Comprobante_de_Domicilio__c && lCont[0].CHK_CURP__c && lCont[0].CHK_Recibos_de_Nomina__c  && lCont[0].CHK_Identificacion_Oficial__c
                        )) {
                    
                        sRespuesta += '- Información faltante en Dictaminación<br/>';
                    }
                } else { // Persona Moral
                    if (!(lCont[0].Check_Inf_Laboral__c &&
                        lCont[0].Check_Inf_Cliente__c &&
                        lCont[0].Check_Inf_Cliente_Moral__c &&
                        lCont[0].Ya_Capturo_Representante_Legal__c &&
                        lCont[0].Ya_Capturo_Info_CoAcreditado__c &&
                        (lCont[0].Direccion_Empresa__c != null) &&
                        lCont[0].Ya_Capturo_Referencia_Familiar__c &&
                        lCont[0].CHK_Comprobante_de_Domicilio__c && lCont[0].CHK_Identificacion_Oficial__c && lCont[0].CHK_Cedula_Fiscal__c &&
                        lCont[0].CHK_Escritura__c && lCont[0].CHK_INE_Representante_Legal__c  && lCont[0].CHK_Facultades_Servidor_Publico__c)) {
                    
                        sRespuesta += '- Información faltante en Dictaminación<br/>';
                    }
                }
                */
            }
            /* 
            if (lCont[0].Tipo_Contribuyente_c__c == 'PERSONA FISICA') {
                ci.chk_Checklist = lCont[0].CHK_Alta_SHCP__c && lCont[0].CHK_Comprobante_de_Domicilio__c && lCont[0].CHK_CURP__c && lCont[0].CHK_Recibos_de_Nomina__c  && lCont[0].CHK_Identificacion_Oficial__c;
            } else {
                ci.chk_Checklist = lCont[0].CHK_Comprobante_de_Domicilio__c && lCont[0].CHK_Identificacion_Oficial__c && lCont[0].CHK_Cedula_Fiscal__c  
                    && lCont[0].CHK_Escritura__c  && lCont[0].CHK_INE_Representante_Legal__c  && lCont[0].CHK_Facultades_Servidor_Publico__c;}
            */

            // Que no esté activada ninguna ruta de aprobación (pendiente, agregarán un checkbox)


            // Regla de Fondo de Garantía en caso de ser de este tipo
            // if (rPlanVenta.Exepcion_Fondo_de_Garantia_Aprobado__c == false) {
            //     sRespuesta += '- No tiene Excepción de Fondo de Garantía Aprobado<br/>';
            // }

            /*
            Id userId = UserInfo.getUserId();
            User currentUser = [SELECT Alias FROM User WHERE Id = :userId LIMIT 1];
            String userAlias = currentUser.Alias;
            if (userAlias=='HMEDI') {
                sRespuesta='';
            }
            */

            // Si respuesta vacía significa no hay faltantes, poner mensaje de Plan de Venta Formalizado y marcar registro como Formalizado
            if (sRespuesta == '') {
                system.debug('*** Entró a Información completa');
                Id tipoRegistroClientePersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Fisica').getRecordTypeId();
                Id tipoRegistroClientePersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cliente_Persona_Moral').getRecordTypeId();

                sRespuesta = '<strong>Información Completa</strong><br/><br/>Plan de Venta Formalizado<br/>';
                // rOpp.Fecha_Formalizacion__c = System.Today();
                rPlanVenta.Plan_de_Venta_Formalizado__c  = TRUE;
                rPlanVenta.Chk_Formalixacion_Informaci_n_Completa__c = True;
                try {
                    system.debug ('*** Updating rPlanVenta');
                    rPlanVenta.FlowOverride__c = datetime.now();
                    update rPlanVenta;
                } catch (DMLException e) {
                    system.debug('*** Error Plan Venta Formalizacion Plan de Venta: '+e);
                }

                // Proceso de Venta Formalizado
                // Actualizar: Estatus=Formalizado, Etapa de Venta=Escrituración y Fecha Formalización = today
                lOpp[0].StageName='Formalizado';
                lOpp[0].Etapa_de_Venta__c='Escrituración';
                lOpp[0].Fecha_Formalizacion__c=Date.today();
                try {
                    system.debug ('*** Updating lOpp');
                    lOpp[0].ValidationBypassDateTime__c = datetime.now();
                    update lOpp;
                } catch (DMLException e) {
                    system.debug('*** Error Plan Venta Formalizacion Plan de Venta Opp: '+e);
                }

                // Actualizar Cuenta
                lAcc[0].ValidationBypassDateTime__c=datetime.now();
                if ( lAcc[0].RecordType.Name.contains('FISICA') ) {
                    lAcc[0].RecordTypeId = tipoRegistroClientePersonaFisica;
                } else {
                    lAcc[0].RecordTypeId = tipoRegistroClientePersonaMoral;
                }
                try {
                    system.debug ('*** Updating lAcc');
                    lAcc[0].ValidationBypassDateTime__c = datetime.now();
                    update lAcc;
                } catch (DMLException e) {
                    system.debug('*** Error Plan Venta Formalizacion Plan de Venta Update Account: '+e);
                }

                // Llamar a EBS
                try {
                    system.debug ('*** Llamando a Integracion EBS: '+input.PlanVentaId);
                    Integracion_EBS.Inserta_Integracion_EBS ('5', input.PlanVentaId);
                } catch (Exception e) {
                    system.debug('**** Error en llamado Integracion EBS: '+input.PlanVentaId);
                }    
            } else {
                sRespuesta = '<strong>Información Faltante:</strong><br/>' + sRespuesta;
                // rPlanVenta.Plan_de_Venta_Formalizado__c  = FALSE;
            }

            // Set the PlanVenta details in the output wrapper
            output.PlanVentaResult = sRespuesta;
            
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