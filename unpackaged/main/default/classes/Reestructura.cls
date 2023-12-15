public class Reestructura {
    @AuraEnabled 
    public static Plan_de_Venta__c fetchPlanRecord(string ccId){
        List<Plan_de_Venta__c> planesVenta = [Select Id,Descuento__c,Descuento_Empleado_Javer__c,Porcentaje_Descuento_Pre_autorizado__c,Obra_Fisico__c,X1_Regalos_MKT__c,X1_Regalos_MKT2__c,
                                        Ahorro_Voluntario_1__c,Ahorro_voluntario_2__c,Ahorro_Voluntario_3__c,Anticipo__c,Atribuible_a_Javer__c,Aval__c,Bonficacion__c,Lista_de_Precios_Bonificacion_Reciente__c,
                                        Bonificacion_Excepcion_de_Plan_de_Venta__c,Bonificacion_Excepci_n_de_Plan_de_Venta__c,Cantidad_de_Promociones_y_Paquetes__c,Regalos_Mkt2__c,
                                        Cantidad_de_reubicaciones__c,Casa_Muestra__c,Check_Contrato_Firmado__c,Clase_de_Bonificacion__c,Cobranza_Comercial_Reestructura__c,
                                        Codigo_Estatus_Vivienda__c,Comentarios__c,Comentarios_Reubicaci_n__c,Complementos__c,Condiciones_Pago_Venta_Anticipada__c,Contador_Promo__c,
                                        Credito_Neto_Final_1__c,Credito_Neto_Final_2__c,Credito_Neto_Final_3__c,Debug__c,Casilla_Descuento_Empleado_Javer__c,Descuento_Pre_autorizado_Empleado_Javer__c,
                                        Diferencia_a_Pagar__c,Direccion_Oficial__c,Direccion_Regional__c,Domicilio_Aval__c,En_aprobacion__c,En_aprovacion__c,Enganche_a_Pagar__c,
                                        Esquina__c,Estatis_Promo_Precio_en_Lista__c,Estatus_LN__c,Estatus_Plan_de_venta__c,Estatus_Proceso_de_Venta__c,Estatus_Promocion_de_Precio_Formula__c,Estatus_Reembolso__c,
                                        Estatus__c,Excepcion_Descuento_Empleado_JAVER__c,Exepcion_Fondo_de_Garantia_Aprobado__c,Fecha_Avaluo__c,Fecha_de_actualizacion_plan__c,Fecha_de_creacion__c,
                                        Fecha_de_creaci_n_del_proceso_de_venta__c,Fecha_de_Inicio_de_Cobranza__c,Fecha_de_Reubicacion__c,Fecha_DTI__c,Fecha_DTU__c,Fecha_Formalizacion__c,Fecha_de_Vencimiento__c,
                                        Fecha_Proyeccion_escritura__c,Fecha_Reestructura__c,Fecha_Reserva__c,Fecha_Reserva_Aux__c,Fecha_Reserva_Real__c,Financiamiento_Plan_de_Venta__c,Fondo_de_Garantia__c,
                                        Fondo_de_Garantia_No_Cubierto__c,Fraccionamiento__c,Frecuencia__c,Frente_Parque__c,Avaluo_1__c,Avaluo_2__c,Avaluo_3__c,Gastos_de_Escritura_1__c,Gastos_de_Escritura_2__c,
                                        Gastos_de_Escritura_3__c,Gastos_Orig_Credito_1__c,Gastos_Orig_Credito_2__c,Gastos_Orig_Credito_3__c,Identificador_de_la_Cuenta__c,Importe_Avaluo__c,
                                        Importe_Condiciones_Especiales__c,Importe_del_Pago__c,Impuestos_Derechos_1__c,Impuestos_Derechos_2__c,Impuestos_Derechos_3__c,Instalaciones__c,Lado_Sol__c,Lado_Sombra__c,
                                        Lista_de_Precios_Casa_Muestra_Reciente__c,Lista_de_Precios_Complementos_Reciente__c,Lista_de_Precios_Financiamien_Reciente__c,Lista_de_Precios_Otros_Gastos_Reciente__c,
                                        Lista_de_Precios_Paquetes_Reciente__c,Lista_de_Precios_Promo_Precio_Reciente__c,Lista_de_Precios_PromocionesV_Reciente__c,Lista_de_Precios_RegalosMKT_Reciente__c,
                                        Lista_de_Precios_Vivienda__c,Lista_de_Precios_Vivienda_Reciente__c,Lote__c,Manzana__c,Modificacion_Automatica__c,Monto_de_Credito_1__c,Monto_de_Credito_2__c,Monto_de_Credito_3__c,
                                        Monto_de_Descuadre_VO__c,Monto_Descuento__c,Monto_Descuento_Pre_autorizado__c,Monto_Fin_Autorizado__c,Promociones__c,Regalos_MKT__c,Motivo_Reubicaci_n__c,M2_Excedentes__c,
                                        Nombre_Compania__c,Nombre_del_Cliente__c,Num_Interior__c,Numero_Interior__c,Numero_Interno__c,Otros_Gastos__c,Paquetes__c,Paquetes_Promociones_de_Venta_Duplicadas__c,
                                        Plan_de_Venta__c,Name,Plan_de_Venta_Aprobado__c,Plan_de_Venta_Formalizado__c,Plan_de_Venta_Original__c,Plazo__c,Porcentaje_a_Financiar__c,Porcentaje_Fin_Autorizado__c,
                                        Precio__c,Precio_Esquina__c,Precio_Frente_Parque__c,Precio_Instalaciones__c,Precio_Lado_Sol__c,Precio_Lado_Sombra__c,Precio_minimo_solicitado__c,Precio_por_m2_exc__c,
                                        Precio_Seleccionado__c,Precio_Sobre_Avenida__c,Precio_Superficie_Excedente__c,Precio_Unitario__c,Precio_Venta_Anticipada__c,Precio_Venta_Normal__c,Precio_Area_Municipal__c,
                                        Primer_Pagare_Preventa_Manual__c,Oportunidad__c,Producto_Bonificacion_menor_a_P_M_nim__c,Promocion_de_Precio__c,Prototipo__c,Representante_Legal__c,Reubicacion__c,
                                        Reubicacion_Aux__c,Revision_APC__c,Sobre_Avenida__c,Subcuenta_Vivienda_1__c,Subcuenta_Vivienda_2__c,Subcuenta_Vivienda_3__c,Subsidio__c,Suma_Total_de_Pagares__c,
                                        Telefono_Casa_Aval__c,Telefono_Celular_Aval__c,Telefono_Otro_Aval__c,Terreno_Excedente__c,Tipo__c,Tipo_de_Cliente__c,Tipo_de_Credito_Formula__c,Tipo_de_Financiamiento__c,
                                        Total_de_Gastos_1__c,Total_de_Gastos_2__c,Total_de_Gastos_3__c,Ubicacion_Compania__c,Unidad_Privativa__c,VO_menor_a_P_M_nimo_de_Venta__c,Valor_de_Operacion__c,
                                        Venta_Anticipada__c,Venta_Especial__c,Version__c,Vigencia_desde__c,Vigencia_hasta__c,Vivienda__c,Area_Municipal__c,CreatedDate From Plan_de_Venta__c
                                        WHERE Cobranza_Comercial_Reestructura__c =: ccId Order by CreatedDate desc LIMIT 1];
        return planesVenta[0];
    } 
    @AuraEnabled 
    public static String createRecord(object fields){
        String jsonFields = JSON.serialize(fields);
        Map<String, Object> fieldMap = (Map<String, Object>)JSON.deserializeUntyped(jsonFields);
        if (fieldMap.containsKey('Id')) {
            fieldMap.remove('Id');
        }
        String msg = '';
        try{
            Plan_de_Venta__c p = new Plan_de_Venta__c();
            for (String fieldName : fieldMap.keySet()) {
                if(p.getSObjectType().getDescribe().fields.getMap().containsKey(fieldName) && !(p.getSObjectType().getDescribe().fields.getMap().get(fieldName).getDescribe().isCalculated())){
                    Schema.SObjectField fieldToken = p.getSObjectType().getDescribe().fields.getMap().get(fieldName);
                    Schema.DisplayType fieldType = fieldToken.getDescribe().getType();
                    if(fieldMap.get(fieldName) != null && fieldMap.get(fieldName) != ''){
                        if (fieldType == Schema.DisplayType.Date) {
                            p.put(fieldName, Date.valueOf((String) fieldMap.get(fieldName)));
                        }
                        else if (fieldType == Schema.DisplayType.Currency) {
                            p.put(fieldName, Double.valueOf( fieldMap.get(fieldName)));
                        } 
                        else if (fieldType == Schema.DisplayType.Integer) {
                            p.put(fieldName, Integer.valueOf(fieldMap.get(fieldName)));
                        } 
                        else if (fieldType == Schema.DisplayType.Double) {
                            p.put(fieldName, Double.valueOf(fieldMap.get(fieldName))); 
                        }  
                        else {
                            p.put(fieldName, fieldMap.get(fieldName));
                        }
                    }
                }
            }
            system.debug('p'+p);
            p.Estatus_Plan_de_venta__c = 'Reestructurado';
            insert p;
            msg  = p.Id;
        }
        catch(DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                msg =+ e.getDmlMessage(i) +  '\n' ;
            }
            throw new AuraHandledException(msg);
        }
        return msg;
    }
}