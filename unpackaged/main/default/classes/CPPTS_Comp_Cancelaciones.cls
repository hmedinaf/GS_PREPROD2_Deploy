public class CPPTS_Comp_Cancelaciones {
    
    @AuraEnabled
    public static CPPT_Cancelacion__c obtenerBooleanos(String idCan) {
        CPPT_Cancelacion__c cancel = [SELECT Id, Cancela_Proceso_Check__c, Reembolso_Check__c, CPPTS_Estatus_Aprobacion_Reembolso__c, 
                                        CPPTS_Estatus_Cancelacion__c, Ya_se_Calcularon_los_Gastos__c
                                      FROM CPPT_Cancelacion__c  WHERE Id=: idCan LIMIT 1];
        return cancel;
    }
    
    @AuraEnabled
    public static void calculaGasto(String idCanCG) {
        CPPT_Cancelacion__c cancel =[SELECT Id, CPPTS_Estatus_Aprobacion_Reembolso__c, CPPTS_Estatus_Cancelacion__c, 
                                CPPTS_Fecha_Cancelacion__c, CPPTS_Gastos_Operativos__c, CPPTS_Gastos_Operativos_Propuestos__c, 
                                CPPTS_Motivo_Cierre__c, CPPTS_Numero_Reubicaciones__c, CPPTS_Proceso_con_Resolicitud__c,
                                CPPTS_Razon_Rechazo__c, CPPTS_Reembolso_Aprobado__c, CPPTS_Reembolso_Pendiente__c,
                                CPPTS_Saldo_a_Cuenta__c, CPPTS_Oportunidad__c, Cancela_Proceso_Check__c, Reembolso_Check__c,
                                Total_de_Pagos__c
                                FROM CPPT_Cancelacion__c  WHERE Id=: idCanCG LIMIT 1];
        
        System.debug('cancel.CPPTS_Oportunidad__c: ' + cancel.CPPTS_Oportunidad__c);

        Opportunity opp = [SELECT Plan_de_Venta__c FROM Opportunity WHERE Id = :cancel.CPPTS_Oportunidad__c LIMIT 1];
        
        Plan_de_Venta__c planVta = [SELECT Id, Name, Precio__c FROM Plan_de_Venta__c WHERE ID = :opp.Plan_de_Venta__c LIMIT 1]; // cancel.CPPTS_Oportunidad__c LIMIT 1];
        
        // if (cancel.CPPTS_Razon_Rechazo__c == '')

        cancel.CPPTS_Gastos_Operativos__c = 0.0;
        Decimal auxGOP = 0.00;

        system.debug('*** CompCanc PlanVta.Precio: '+planVta.Precio__c);

        if(planVta.Precio__c < 240000.00){
            auxGOP = 500.00;
        }else if(planVta.Precio__c >= 240000.01 && planVta.Precio__c <= 350000.00){
            auxGOP = 1000.00;
        }else if(planVta.Precio__c >= 350000.01 && planVta.Precio__c <= 500000.00){
            auxGOP = 3000.00;
        }else if(planVta.Precio__c >= 500000.01 && planVta.Precio__c <= 800000.00){
            auxGOP = 5000.00;
        }else if(planVta.Precio__c > 800000.01){
            auxGOP = 8000.00;
        }
        
        cancel.CPPTS_Saldo_a_Cuenta__c = cancel.Total_de_Pagos__c;
        if(cancel.CPPTS_Saldo_a_Cuenta__c < auxGOP){
            cancel.CPPTS_Gastos_Operativos_Propuestos__c = cancel.CPPTS_Saldo_a_Cuenta__c;
        }else{
            cancel.CPPTS_Gastos_Operativos_Propuestos__c = auxGOP;
        }
        
        cancel.Cancela_Proceso_Check__c = false;
        update cancel;
        System.debug('Se realiza la actualización de Gastos Operativos');
    }
    
    @AuraEnabled
    public static void cancelaProceso(String idCanCP) {
        CPPT_Cancelacion__c cancel =[SELECT Id, CPPTS_Estatus_Aprobacion_Reembolso__c, CPPTS_Estatus_Cancelacion__c, 
                                     CPPTS_Fecha_Cancelacion__c, CPPTS_Gastos_Operativos__c, CPPTS_Gastos_Operativos_Propuestos__c, 
                                     CPPTS_Motivo_Cierre__c, CPPTS_Numero_Reubicaciones__c, CPPTS_Proceso_con_Resolicitud__c,
                                     CPPTS_Razon_Rechazo__c, CPPTS_Reembolso_Aprobado__c, CPPTS_Reembolso_Pendiente__c,
                                     CPPTS_Saldo_a_Cuenta__c, CPPTS_Oportunidad__c, Cancela_Proceso_Check__c, Reembolso_Check__c
                                     FROM CPPT_Cancelacion__c  WHERE Id=: idCanCP LIMIT 1];
        
        Opportunity opp = [SELECT Id, Name, StageName, Fecha_Cancelacion__c FROM Opportunity WHERE Id =: cancel.CPPTS_Oportunidad__c LIMIT 1];
        
        if(opp.Stagename == 'Validación' || opp.StageName == 'Reservado'){
            opp.StageName = 'Cancelado';
            opp.Fecha_Cancelacion__c = date.today();
            System.debug('*Se cancela proceso de ventas*');
            update opp;

            cancel.CPPTS_Estatus_Cancelacion__c = 'Aprobado';
            cancel.CPPTS_Fecha_Cancelacion__c = date.today();
            cancel.CPPTS_Reembolso_Aprobado__c = 0;
            cancel.CPPTS_Reembolso_Pendiente__c = 0; 
            cancel.Reembolso_Check__c = false;
            cancel.Cancela_Proceso_Check__c = true;
            update cancel;
        }
 

        if(opp.Stagename == 'Reservado' || opp.Stagename == 'Formalizado' || opp.StageName == 'Escriturado' || opp.StageName == 'Entregado'){
            // Creando petición para el proceso de aprobación
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setObjectId(cancel.id);
            
            // Se define el usuario que solicita la aprobación, será el usuario que manipula el registro
            String user1 = UserInfo.getUserId();
            req1.setSubmitterId(user1); 
            
            // Se manda el registro al proceso correspondiente y se omiten los criterios
            if(opp.Stagename == 'Formalizado'){
                req1.setProcessDefinitionNameOrId('Cancelacion_Formalizacion_V2');
                if(cancel.CPPTS_Gastos_Operativos__c < cancel.CPPTS_Gastos_Operativos_Propuestos__c && cancel.CPPTS_Saldo_a_Cuenta__c >= cancel.CPPTS_Gastos_Operativos_Propuestos__c){
                    req1.setComments('Enviando proceso de aprobación formalización. "Gasto Operativo < Gasto Operativo Propuesto"');
                }else{
                    req1.setComments('Enviando proceso de aprobación formalización.');
                }
                
                req1.setSkipEntryCriteria(true);
            }else if(opp.StageName == 'Escriturado' || opp.StageName == 'Entregado'){
                req1.setProcessDefinitionNameOrId('Cancelacion_Escritura_v2');
                if(cancel.CPPTS_Gastos_Operativos__c < cancel.CPPTS_Gastos_Operativos_Propuestos__c && cancel.CPPTS_Saldo_a_Cuenta__c >= cancel.CPPTS_Gastos_Operativos_Propuestos__c){
                    req1.setComments('Enviando proceso de aprobación escritura. "Gasto Operativo < Gasto Operativo Propuesto"');
                }else{
                    req1.setComments('Enviando proceso de aprobación escritura.');
                }
                req1.setSkipEntryCriteria(true);
            }/*else if(opp.StageName == 'Validación' || opp.StageName == 'Reservado'){
                req1.setProcessDefinitionNameOrId('Cancelacion_Reserva');
                if(cancel.CPPTS_Gastos_Operativos__c < cancel.CPPTS_Gastos_Operativos_Propuestos__c && cancel.CPPTS_Saldo_a_Cuenta__c >= cancel.CPPTS_Gastos_Operativos_Propuestos__c){
                    req1.setComments('Enviando proceso de aprobación reserva. "Gasto Operativo < Gasto Operativo Propuesto"');
                }else{
                    req1.setComments('Enviando proceso de aprobación reserva.');
                }
                req1.setSkipEntryCriteria(true);
            }*/

            cancel.CPPTS_Estatus_Cancelacion__c = 'Por Aprobar';
            cancel.Reembolso_Check__c = false;
            update cancel;

            //Se envía la petición del proceso de aprobación
            Approval.ProcessResult result = Approval.process(req1);
            
            //Se verifica el resultado
            System.assert(result.isSuccess());
            System.assertEquals('Pending', result.getInstanceStatus(),'Instance Status'+result.getInstanceStatus());
            
        }
        System.debug('Se realiza la actualización de Fecha Cancelación');
    }
    
    @AuraEnabled
    public static void reprocesaReembolso(String idCanRR) {
        CPPT_Cancelacion__c cancel =[SELECT Id, CPPTS_Estatus_Aprobacion_Reembolso__c, CPPTS_Estatus_Cancelacion__c, 
                                     CPPTS_Fecha_Cancelacion__c, CPPTS_Gastos_Operativos__c, CPPTS_Gastos_Operativos_Propuestos__c, 
                                     CPPTS_Motivo_Cierre__c, CPPTS_Numero_Reubicaciones__c, CPPTS_Proceso_con_Resolicitud__c,
                                     CPPTS_Razon_Rechazo__c, CPPTS_Reembolso_Aprobado__c, CPPTS_Reembolso_Pendiente__c,
                                     CPPTS_Saldo_a_Cuenta__c, CPPTS_Oportunidad__c, Cancela_Proceso_Check__c, Reembolso_Check__c
                                     FROM CPPT_Cancelacion__c WHERE Id=: idCanRR LIMIT 1];
        
        System.debug('cancel.CPPTS_Oportunidad__c: ' + cancel.CPPTS_Oportunidad__c);
        
        Opportunity opp = [SELECT Id, Name, StageName FROM Opportunity WHERE Id =: cancel.CPPTS_Oportunidad__c LIMIT 1];
        
        if(opp.StageName != 'Cancelado' && (cancel.CPPTS_Estatus_Aprobacion_Reembolso__c == 'No inciado' || cancel.CPPTS_Estatus_Aprobacion_Reembolso__c == 'Por Aprobar') && cancel.CPPTS_Saldo_a_Cuenta__c < 0){
            System.debug('No se puede reprocesar un proceso de venta activo');
            System.debug('Validar que se cumplan las condiciones para poder solicitar un reproceso');
        }
        
        // Creando petición para el proceso de aprobación
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Enviando proceso de aprobación para reproceso de reembolso.');
        req1.setObjectId(cancel.id);
        
        // Se define el usuario que solicita la aprobación, será el usuario que manipula el registro
        String user1 = UserInfo.getUserId();
        req1.setSubmitterId(user1); 
        
        // Se manda el registro al proceso correspondiente y se omiten los criterios
        req1.setProcessDefinitionNameOrId('Reembolso_por_Cancelacion_V2');
        req1.setSkipEntryCriteria(true);
        
        
        //Se envía la petición del proceso de aprobación
        Approval.ProcessResult result = Approval.process(req1);
        
        //Se verifica el resultado
        System.assert(result.isSuccess());
        
        System.assertEquals(
            'Pending', result.getInstanceStatus(), 
            'Instance Status'+result.getInstanceStatus());
        
        System.debug('Se realiza la reprocesaReembolso');
        
        cancel.CPPTS_Estatus_Aprobacion_Reembolso__c = 'Por Aprobar';
        update cancel;
    }
}