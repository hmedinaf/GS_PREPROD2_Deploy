trigger CPPT_Cancelacion on CPPT_Cancelacion__c (before insert, before update, after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate){
            for(CPPT_Cancelacion__c c : trigger.New){
                if (c.CPPTS_Estatus_Cancelacion__c=='Aprobado' && trigger.oldMap.get(c.Id).CPPTS_Estatus_Cancelacion__c!='Aprobado') {
                    system.debug('*** Proceso Cancelación Aprobado');
                    Integracion_EBS.Inserta_Integracion_EBS ('-1', c.Plan_de_Venta__c);
                }
            }
        }
    }
    /*if(Trigger.isBefore){
        if(Trigger.isUpdate){
            for(CPPT_Cancelacion__c forData : trigger.New){
                if(forData.CPPTS_Proceso_con_Resolicitud__c == true){
                    Opportunity opp = [SELECT id, StageName, Name FROM Opportunity WHERE Id =: forData.CPPTS_Oportunidad__c];
                    opp.StageName = 'Cancelado';
                    update opp;
                }
                if(forData.CPPTS_Estatus_Cancelacion__c == 'Aprobado'){
                    forData.CPPTS_Fecha_Cancelacion__c = System.today();
                    Opportunity opp = [SELECT id, StageName, Etapa_de_Venta__c, Name FROM Opportunity WHERE Id =: forData.CPPTS_Oportunidad__c];
                    opp.StageName = 'Cancelado';
                    opp.Etapa_de_Venta__c = 'Rechazo';
                    update opp;
                }
                
                if(forData.CPPTS_Saldo_a_Cuenta__c != null && forDAta.CPPTS_Gastos_Operativos__c != null && forData.CPPTS_Reembolso_Aprobado__c == null){
                    forData.CPPTS_Reembolso_Pendiente__c = forData.CPPTS_Saldo_a_Cuenta__c - forDAta.CPPTS_Gastos_Operativos__c;
                }
                
                if(forData.CPPTS_Reembolso_Aprobado__c != trigger.oldMap.get(forData.Id).CPPTS_Reembolso_Aprobado__c){
                    forData.CPPTS_Reembolso_Pendiente__c = 0.00;
                }
                
                if(forData.CPPTS_Estatus_Aprobacion_Reembolso__c == 'No iniciado' && forData.CPPTS_Estatus_Proceso_de_Venta__c == 'Cancelado' && forData.CPPTS_Reembolso_Pendiente__c > 0){
                    // Creando petición para el proceso de aprobación
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setComments('Enviando proceso de aprobación para reproceso de reembolso.');
                    req1.setObjectId(forData.id);
                    
                    // Se define el usuario que solicita la aprobación, será el usuario que manipula el registro
                    String user1 = UserInfo.getUserId();
                    req1.setSubmitterId(user1); 
                    
                    // Se manda el registro al proceso correspondiente y se omiten los criterios
                    req1.setProcessDefinitionNameOrId('Reembolso_por_Cancelacion');
                    req1.setSkipEntryCriteria(true);
                    
                    
                    //Se envía la petición del proceso de aprobación
                    Approval.ProcessResult result = Approval.process(req1);
                    
                    //Se verifica el resultado
                    System.assert(result.isSuccess());
                    
                    System.assertEquals(
                        'Pending', result.getInstanceStatus(), 
                        'Instance Status'+result.getInstanceStatus());
                    
                    System.debug('Se realiza la reprocesaReembolso');   
                }
            }
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            for(CPPT_Cancelacion__c forData : trigger.New){
                if(forData.CPPTS_Proceso_con_Resolicitud__c == true){
                    //Se obtiene la oportunidad relacionada a la cancelación
                    Opportunity opp = [SELECT id,isdeleted,accountid,name,description,stagename,amount,probability,closedate,type,nextstep,leadsource,isclosed,iswon,forecastcategory,
                                       forecastcategoryname,campaignid,hasopportunitylineitem,pricebook2id,ownerid,createddate,createdbyid,lastmodifieddate,lastmodifiedbyid,systemmodstamp,
                                       lastactivitydate,pushcount,laststagechangedate,fiscalquarter,fiscalyear,fiscal,contactid,lastvieweddate,lastreferenceddate,hasopenactivity,hasoverduetask,
                                       lastamountchangedhistoryid,lastclosedatechangedhistoryid,numero_proceso_de_venta__c,financiera__c,etapa_de_venta__c,prospectador__c,lead_profiler__c,
                                       fecha_formalizacion__c,telefono_casa_eliminado__c,telefonocelular_eliminado__c,otro_telefono_eliminado__c,fraccionamiento__c,prototipo__c,colaborador_javer__c,
                                       tipo_de_credito__c,producto_financiero__c,producto_de_la_financiera__c,tiene_vivienda__c,vivienda__c,revision_apc__c,revision_rol_de_venta__c,resolicitud__c,
                                       canal_y_subcanal_de_venta_aprobado__c,tipo_de_tramite__c,r_gimen_patrimonial_matrimonio__c,cr_dito_en__c,segundo_credito__c,plazo_del_credito__c,inconsistencia__c,
                                       pendiente_escriturar__c,estatus_ln__c,apellido_materrno__c,asesor__c,fecha_asignacion_asesor__c,nss__c,canal_de_venta__c,sub_canal_de_venta__c,correo_electronico__c,
                                       telefonocasa__c,telefonocelular__c,otrotelefono__c,cantidad_cobranzas_comerciales__c,subestatus__c,plan_de_venta__c,origen__c,motivo_cambio_asesor__c,
                                       motivo_cambio_prospectador__c,motivo_cambio_lead_profiler__c,motivo_cambio_colaborador_javer__c,motivo_cambio_canal_de_venta__c,fecha_cancelacion__c,
                                       estado_de_aprobacion__c,valores_previos__c,proceso_de_aprobaci_n__c,canal_de_venta_anterior__c,sub_canal_anterior__c 
                                       FROM Opportunity WHERE Id =: forData.CPPTS_Oportunidad__c];
                    
                    //Se obtiene el plan de venta relacionado a la oportunidad
                    Plan_de_Venta__c planVta = [SELECT id,ownerid,isdeleted,name,createddate,createdbyid,lastmodifieddate,lastmodifiedbyid,systemmodstamp,lastactivitydate,estatus_plan_de_venta__c,
                                                oportunidad__c,fecha_de_actualizacion_plan__c,fecha_de_reubicacion__c,motivo_reubicaci_n__c,comentarios__c,atribuible_a_javer__c,estatus_proceso_de_venta__c,
                                                fecha_reserva__c,fecha_formalizacion__c,fecha_proyeccion_escritura__c,subsidio__c,anticipo__c,enganche_a_pagar__c,plazo__c,frecuencia__c,diferencia_a_pagar__c,
                                                porcentaje_a_financiar__c,fecha_de_inicio_de_cobranza__c,valor_de_operacion__c,importe_del_pago__c,monto_de_credito_1__c,subcuenta_vivienda_1__c,fecha_de_vencimiento__c,
                                                aval__c,descuento__c,monto_descuento__c,descuento_empleado_javer__c,ahorro_voluntario_1__c,avaluo_1__c,gastos_de_escritura_1__c,impuestos_derechos_1__c,gastos_orig_credito_1__c,
                                                monto_de_credito_2__c,subcuenta_vivienda_2__c,monto_de_credito_3__c,subcuenta_vivienda_3__c,gastos_orig_credito_3__c,impuestos_derechos_3__c,gastos_de_escritura_3__c,
                                                gastos_orig_credito_2__c,avaluo_3__c,impuestos_derechos_2__c,ahorro_voluntario_3__c,gastos_de_escritura_2__c,total_de_gastos_3__c,avaluo_2__c,ahorro_voluntario_2__c,
                                                precio_esquina__c,precio_frente_parque__c,credito_neto_final_3__c,total_de_gastos_1__c,credito_neto_final_1__c,total_de_gastos_2__c,credito_neto_final_2__c,
                                                paquetes_promociones_de_venta_duplicadas__c,condiciones_pago_venta_anticipada__c,venta_especial__c,en_aprovacion__c,en_aprobacion__c,cantidad_de_reubicaciones__c,
                                                fecha_de_creaci_n_del_proceso_de_venta__c,bonficacion__c,porcentaje_descuento_pre_autorizado__c,monto_descuento_pre_autorizado__c,descuento_pre_autorizado_empleado_javer__c,
                                                casilla_descuento_empleado_javer__c,bonificacion_excepci_n_de_plan_de_venta__c,excepcion_descuento_empleado_javer__c,x1_regalos_mkt__c,financiamiento_plan_de_venta__c,
                                                vo_menor_a_p_m_nimo_de_venta__c,producto_bonificacion_menor_a_p_m_nim__c,fecha_reserva_aux__c,fondo_de_garantia__c,venta_anticipada__c,check_contrato_firmado__c,
                                                revision_apc__c,version__c,domicilio_aval__c,telefono_celular_aval__c,telefono_casa_aval__c,telefono_otro_aval__c,monto_de_descuadre_vo__c,
                                                lista_de_precios_vivienda_reciente__c,lista_de_precios_paquetes_reciente__c,reubicacion_aux__c,vivienda__c,manzana__c,num_interior__c,esquina__c,
                                                sobre_avenida__c,frente_parque__c,lado_sol__c,lado_sombra__c,instalaciones__c,precio_instalaciones__c,precio_sobre_avenida__c,precio_lado_sol__c,precio_lado_sombra__c,
                                                direccion_regional__c,modificacion_automatica__c,reubicacion__c,estatus__c,numero_interno__c,lote__c,unidad_privativa__c,direccion_oficial__c,precio__c,m2_excedentes__c,
                                                primer_pagare_preventa_manual__c,lista_de_precios_vivienda__c,lista_de_precios_promocionesv_reciente__c,lista_de_precios_regalosmkt_reciente__c,
                                                lista_de_precios_complementos_reciente__c,lista_de_precios_otros_gastos_reciente__c,lista_de_precios_casa_muestra_reciente__c,ubicacion_compania__c,
                                                precio_por_m2_exc__c,importe_condiciones_especiales__c,terreno_excedente__c,paquetes__c,regalos_mkt__c,promociones__c,complementos__c,casa_muestra__c,otros_gastos__c 
                                                FROM Plan_de_Venta__c WHERE Oportunidad__c =: opp.Id];
                    
                    //Se crea la nueva oportunidad (proceso de ventas)
                    Opportunity newOpp = new Opportunity();
                    newOpp.accountid = opp.accountid;
                    newOpp.name = opp.name;
                    newOpp.description = opp.description;
                    newOpp.stagename = 'Validación';
                    newOpp.amount = opp.amount;
                    newOpp.probability = opp.probability;
                    newOpp.closedate = opp.closedate;
                    newOpp.type = opp.type;
                    newOpp.nextstep = opp.nextstep;
                    newOpp.leadsource = opp.leadsource;
                    newOpp.forecastcategoryname = opp.forecastcategoryname;
                    newOpp.campaignid = opp.campaignid;
                    newOpp.pricebook2id = opp.pricebook2id;
                    newOpp.ownerid = opp.ownerid;
                    newOpp.contactid = opp.contactid;
                    newOpp.financiera__c = opp.financiera__c;
                    newOpp.etapa_de_venta__c = opp.etapa_de_venta__c;
                    newOpp.prospectador__c = opp.prospectador__c;
                    newOpp.lead_profiler__c = opp.lead_profiler__c;
                    newOpp.fecha_formalizacion__c = opp.fecha_formalizacion__c;
                    newOpp.telefono_casa_eliminado__c = opp.telefono_casa_eliminado__c;
                    newOpp.telefonocelular_eliminado__c = opp.telefonocelular_eliminado__c;
                    newOpp.otro_telefono_eliminado__c = opp.otro_telefono_eliminado__c;
                    newOpp.fraccionamiento__c = opp.fraccionamiento__c;
                    newOpp.prototipo__c = opp.prototipo__c;
                    newOpp.colaborador_javer__c = opp.colaborador_javer__c;
                    newOpp.tipo_de_credito__c = opp.tipo_de_credito__c;
                    newOpp.producto_financiero__c = opp.producto_financiero__c;
                    newOpp.producto_de_la_financiera__c = opp.producto_de_la_financiera__c;
                    newOpp.vivienda__c = opp.vivienda__c;
                    newOpp.revision_apc__c = opp.revision_apc__c;
                    newOpp.revision_rol_de_venta__c = opp.revision_rol_de_venta__c;
                    newOpp.resolicitud__c = true;
                    newOpp.canal_y_subcanal_de_venta_aprobado__c = opp.canal_y_subcanal_de_venta_aprobado__c;
                    newOpp.tipo_de_tramite__c = opp.tipo_de_tramite__c;
                    newOpp.r_gimen_patrimonial_matrimonio__c = opp.r_gimen_patrimonial_matrimonio__c;
                    newOpp.cr_dito_en__c = opp.cr_dito_en__c;
                    newOpp.segundo_credito__c = opp.segundo_credito__c;
                    newOpp.plazo_del_credito__c = opp.plazo_del_credito__c;
                    newOpp.inconsistencia__c = opp.inconsistencia__c;
                    newOpp.pendiente_escriturar__c = opp.pendiente_escriturar__c;
                    newOpp.asesor__c = opp.asesor__c;
                    newOpp.fecha_asignacion_asesor__c = opp.fecha_asignacion_asesor__c;
                    newOpp.canal_de_venta__c = opp.canal_de_venta__c;
                    newOpp.sub_canal_de_venta__c = opp.sub_canal_de_venta__c;
                    newOpp.motivo_cambio_colaborador_javer__c = opp.motivo_cambio_colaborador_javer__c;
                    newOpp.motivo_cambio_canal_de_venta__c = opp.motivo_cambio_canal_de_venta__c;
                    newOpp.estado_de_aprobacion__c = opp.estado_de_aprobacion__c;
                    newOpp.valores_previos__c = opp.valores_previos__c;
                    newOpp.proceso_de_aprobaci_n__c = opp.proceso_de_aprobaci_n__c;
                    newOpp.canal_de_venta_anterior__c = opp.canal_de_venta_anterior__c;
                    newOpp.sub_canal_anterior__c = opp.sub_canal_anterior__c;
                    
                    insert newOpp;
                    
                    //Se crea el nuevo plan de venta
                    /*Plan_de_Venta__c newPlanVta = new Plan_de_Venta__c();
                    newPlanVta.oportunidad__c = newOpp.Id;
                    newPlanVta.ownerid = planVta.ownerid;
                    newPlanVta.fecha_proyeccion_escritura__c = planVta.fecha_proyeccion_escritura__c;
                    newPlanVta.subsidio__c = planVta.subsidio__c;
                    newPlanVta.anticipo__c = planVta.anticipo__c;
                    newPlanVta.fecha_de_inicio_de_cobranza__c = planVta.fecha_de_inicio_de_cobranza__c;
                    newPlanVta.monto_de_credito_1__c = planVta.monto_de_credito_1__c;
                    newPlanVta.subcuenta_vivienda_1__c = planVta.subcuenta_vivienda_1__c;
                    newPlanVta.descuento__c = planVta.descuento__c;
                    newPlanVta.ahorro_voluntario_1__c = planVta.ahorro_voluntario_1__c;
                    newPlanVta.avaluo_1__c = planVta.avaluo_1__c;
                    newPlanVta.gastos_de_escritura_1__c = planVta.gastos_de_escritura_1__c;
                    newPlanVta.impuestos_derechos_1__c = planVta.impuestos_derechos_1__c;
                    newPlanVta.gastos_orig_credito_1__c = planVta.gastos_orig_credito_1__c;
                    newPlanVta.monto_de_credito_2__c = planVta.monto_de_credito_2__c;
                    newPlanVta.subcuenta_vivienda_2__c = planVta.subcuenta_vivienda_2__c;
                    newPlanVta.monto_de_credito_3__c = planVta.monto_de_credito_3__c;
                    newPlanVta.subcuenta_vivienda_3__c = planVta.subcuenta_vivienda_3__c;
                    newPlanVta.gastos_orig_credito_3__c = planVta.gastos_orig_credito_3__c;
                    newPlanVta.impuestos_derechos_3__c = planVta.impuestos_derechos_3__c;
                    newPlanVta.gastos_de_escritura_3__c = planVta.gastos_de_escritura_3__c;
                    newPlanVta.gastos_orig_credito_2__c = planVta.gastos_orig_credito_2__c;
                    newPlanVta.avaluo_3__c = planVta.avaluo_3__c;
                    newPlanVta.impuestos_derechos_2__c = planVta.impuestos_derechos_2__c;
                    newPlanVta.ahorro_voluntario_3__c = planVta.ahorro_voluntario_3__c;
                    newPlanVta.gastos_de_escritura_2__c = planVta.gastos_de_escritura_2__c;
                    newPlanVta.avaluo_2__c = planVta.avaluo_2__c;
                    newPlanVta.ahorro_voluntario_2__c = planVta.ahorro_voluntario_2__c;
                    newPlanVta.monto_descuento_pre_autorizado__c = planVta.monto_descuento_pre_autorizado__c;
                    newPlanVta.descuento_pre_autorizado_empleado_javer__c = planVta.descuento_pre_autorizado_empleado_javer__c;
                    newPlanVta.casilla_descuento_empleado_javer__c = planVta.casilla_descuento_empleado_javer__c;
                    newPlanVta.bonificacion_excepci_n_de_plan_de_venta__c = planVta.bonificacion_excepci_n_de_plan_de_venta__c;
                    newPlanVta.excepcion_descuento_empleado_javer__c = planVta.excepcion_descuento_empleado_javer__c;
                    newPlanVta.financiamiento_plan_de_venta__c = planVta.financiamiento_plan_de_venta__c;
                    newPlanVta.producto_bonificacion_menor_a_p_m_nim__c = planVta.producto_bonificacion_menor_a_p_m_nim__c;
                    newPlanVta.fecha_reserva_aux__c = planVta.fecha_reserva_aux__c;
                    newPlanVta.fondo_de_garantia__c = planVta.fondo_de_garantia__c;
                    newPlanVta.venta_anticipada__c = planVta.venta_anticipada__c;
                    newPlanVta.check_contrato_firmado__c = planVta.check_contrato_firmado__c;
                    newPlanVta.revision_apc__c = planVta.revision_apc__c;
                    newPlanVta.version__c = planVta.version__c;
                    newPlanVta.domicilio_aval__c = planVta.domicilio_aval__c;
                    newPlanVta.telefono_celular_aval__c = planVta.telefono_celular_aval__c;
                    newPlanVta.telefono_casa_aval__c = planVta.telefono_casa_aval__c;
                    newPlanVta.telefono_otro_aval__c = planVta.telefono_otro_aval__c;
                    newPlanVta.monto_de_descuadre_vo__c = planVta.monto_de_descuadre_vo__c;
                    newPlanVta.lista_de_precios_vivienda_reciente__c = planVta.lista_de_precios_vivienda_reciente__c;
                    newPlanVta.lista_de_precios_paquetes_reciente__c = planVta.lista_de_precios_paquetes_reciente__c;
                    newPlanVta.reubicacion_aux__c = planVta.reubicacion_aux__c;
                    newPlanVta.vivienda__c = planVta.vivienda__c;
                    newPlanVta.lista_de_precios_complementos_reciente__c = planVta.lista_de_precios_complementos_reciente__c;
                    newPlanVta.lista_de_precios_otros_gastos_reciente__c = planVta.lista_de_precios_otros_gastos_reciente__c;
                    newPlanVta.lista_de_precios_casa_muestra_reciente__c = planVta.lista_de_precios_casa_muestra_reciente__c;
                    newPlanVta.ubicacion_compania__c = planVta.ubicacion_compania__c;
                    
                    insert newPlanVta;*/
                /*}
            }
        }
    }*/
}