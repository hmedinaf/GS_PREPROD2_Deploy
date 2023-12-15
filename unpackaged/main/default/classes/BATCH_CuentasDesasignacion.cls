global class BATCH_CuentasDesasignacion implements Database.Batchable<SObject>, Database.AllowsCallouts, Database.Stateful{

    public List<ErrorBatch> erroresBatch = new List<ErrorBatch>();
    public Integer contadorExitos;
    public Integer contadorErrores;

    //Metodo para obtener los registros de cuentas a desasignar algun rol de ventas (Asesor, Prospectador, Lead Profiler y Colaborador Javer)
    global Database.QueryLocator start(Database.BatchableContext BC) { 
        //String hoy = Datetime.now().format('yyyy-MM-dd');
        //Se obtienen todos los prototipos que no tengan un Precio Presupuesto de la version Oficial Firmada
        // HMF: Corregir query
        return Database.getQueryLocator([
            SELECT Id,
                Fraccionamiento_cta__c,
                Motivo_Asignacion__c,
                Asesor__c,
                Estatus_Asesor__c,
                Fecha_Asignacion_Asesor__c,
                Prospectador__c,
                Estatus_Prospectador__c,
                Fecha_Prospeccion__c,
                Lead_Profiler__c,
                Fecha_LP__c,
                Estatus_LP__c,
                Colaborador_Javer__c,
                Fecha_Colaborador_Javer__c,
                Estatus_Colaborador_Javer__c,
                Fecha_Estatus__c,
                Fecha_Vencimiento_Asesor__c,
                Fecha_Vencimiento_Prospectador__c, 
                Fecha_Vencimiento_LP__c, 
                Fecha_Vencimiento_Colaborador_Javer__c, 
                Desasignacion_Auto_Asesor__c, 
                Desasignacion_Auto_Prospectador__c, 
                Desasignacion_Auto_Lead_Profiler__c, 
                Desasignacion_Auto_Colaborador_Javer__c, 
                Contador_Auto_Desasignacion__c,
                Estatus_Cliente__c
            FROM Account 
            WHERE Numero_de_Oportunidades__c < 1
            AND CreatedDate >= 2023-07-01T00:00:00Z
            AND ((Fecha_Vencimiento_Asesor__c < TODAY AND Estatus_Asesor__c = 'ASIGNADO')
            OR (Fecha_Vencimiento_Prospectador__c < TODAY AND Estatus_Prospectador__c = 'ASIGNADO')
            OR (Fecha_Vencimiento_LP__c < TODAY AND Estatus_LP__c='ASIGNADO')
            OR (Fecha_Vencimiento_Colaborador_Javer__c < TODAY AND Estatus_Colaborador_Javer__c='ASIGNADO'))
        ]);
    }

    //Metodo donde se desasignan los roles de venta (Asesor, Prospectador, Lead Profiler y Colaborador Javer) ya vencidos de una cuenta y
    //Se actualiza su correspondiente registro de Rol de Venta
	global void execute(Database.BatchableContext BC, List<Account> cuentas) {
        system.debug ('*** Cuentas batch: '+cuentas);

        List<Account> cuentasActualizar = new List<Account>();
        Set<String> llavesRolesVenta = new Set<String>();

        for(Account cuenta : cuentas){

            //Si la cuenta tiene asignado un Asesor y dicho Asesor ya vencio (Fecha Vencimiento Asesor < hoy), se desasigna el Asesor del registro de cuenta y
            //Se crea la llave del registro de Rol de Venta de Asesor para su posterior busqueda y actualizacion
            //if(String.isBlank(String.valueOf(cuenta.Asesor__c)) == false && cuenta.Fecha_Vencimiento_Asesor__c < Date.today()){
            if(cuenta.Fecha_Vencimiento_Asesor__c < Date.today()){

                System.debug('****Cuenta: ' + cuenta.Id + ' vencida en Asesor: ' + cuenta.Asesor__c + ' fecha: ' + cuenta.Fecha_Vencimiento_Asesor__c);

                llavesRolesVenta.add(String.valueOf(cuenta.Asesor__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'AS');
                System.debug('****Llave Asesor vencido: ' + String.valueOf(cuenta.Asesor__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'AS');

                cuenta.Asesor__c = null;
                if (!(cuenta.Estatus_Cliente__c=='BAJA' || cuenta.Estatus_Cliente__c=='INCUBADORA')) {
                    cuenta.Estatus_Cliente__c = 'POR REASIGNAR';
                }
                cuenta.Estatus_Asesor__c = 'POR REASIGNAR';
                cuenta.Fecha_Estatus_Asesor__c = Datetime.Now();
                cuenta.Fecha_Estatus__c = Datetime.now();
                cuenta.Fecha_Asignacion_Asesor__c = null;
                cuenta.Motivo_Asignacion__c = null;
                cuenta.Desasignacion_Auto_Asesor__c = true;
                cuenta.Contador_Auto_Desasignacion__c = (String.isBlank(String.valueOf(cuenta.Contador_Auto_Desasignacion__c)) == true ? 1 : cuenta.Contador_Auto_Desasignacion__c + 1);
                cuenta.ValidationBypassDateTime__c = datetime.now();
                cuenta.Trigger_Override__c = datetime.now();
            }

            //Si la cuenta tiene asignado un Prospectador y dicho Prospectador ya vencio (Fecha Vencimiento Prospectador < hoy), se desasigna el Prospectador del registro de cuenta y
            //Se crea la llave del registro de Rol de Venta de Prospectador para su posterior busqueda y actualizacion
            //if(String.isBlank(String.valueOf(cuenta.Prospectador__c)) == false && cuenta.Fecha_Vencimiento_Prospectador__c < Date.today()){
            if(cuenta.Fecha_Vencimiento_Prospectador__c < Date.today()){

                System.debug('****Cuenta: ' + cuenta.Id + ' vencida en Prospectador: ' + cuenta.Prospectador__c + ' fecha: ' + cuenta.Fecha_Vencimiento_Prospectador__c);

                llavesRolesVenta.add(String.valueOf(cuenta.Prospectador__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'PR');
                System.debug('****Llave Prospectador vencido: ' + String.valueOf(cuenta.Prospectador__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'PR');
            
                cuenta.Prospectador__c = null;
                cuenta.Estatus_Prospectador__c = 'POR REASIGNAR';
                // cuenta.Estatus_Cliente__c = 'POR REASIGNAR'; // NOTA HMF 8/13 Correccion error Cliente #438 Si el prospectador vence, el status anteior permanece
                cuenta.Fecha_Estatus_Prospectador__c = Datetime.Now();
                cuenta.Fecha_Estatus__c = Datetime.now();
                cuenta.Fecha_Prospeccion__c = null;
                cuenta.Desasignacion_Auto_Prospectador__c = true;
                cuenta.Contador_Auto_Desasignacion__c = (String.isBlank(String.valueOf(cuenta.Contador_Auto_Desasignacion__c)) == true ? 1 : cuenta.Contador_Auto_Desasignacion__c + 1);
                cuenta.ValidationBypassDateTime__c = datetime.now();
            }

            //Si la cuenta tiene asignado un Lead Profiler y dicho Lead Profiler ya vencio (Fecha Vencimiento LP < hoy), se desasigna el Lead Profiler del registro de cuenta y
            //Se crea la llave del registro de Rol de Venta de Lead Profiler para su posterior busqueda y actualizacion
            //if(String.isBlank(String.valueOf(cuenta.Lead_Profiler__c)) == false && cuenta.Fecha_Vencimiento_LP__c < Date.today()){
            if(cuenta.Fecha_Vencimiento_LP__c < Date.today()){

                System.debug('****Cuenta: ' + cuenta.Id + ' vencida en Lead Profiler: ' + cuenta.Lead_Profiler__c + ' fecha: ' + cuenta.Fecha_Vencimiento_LP__c);

                llavesRolesVenta.add(String.valueOf(cuenta.Lead_Profiler__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'LP');
                System.debug('****Llave Lead Profiler vencido: ' + String.valueOf(cuenta.Lead_Profiler__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'LP');

                cuenta.Lead_Profiler__c = null;
                cuenta.Fecha_LP__c = null;
                cuenta.Estatus_LP__c = 'POR REASIGNAR';
                cuenta.Fecha_Estatus_LP__c = Datetime.Now();
                cuenta.Fecha_Estatus__c = Datetime.now();
                cuenta.Desasignacion_Auto_Lead_Profiler__c = true;
                cuenta.Contador_Auto_Desasignacion__c = (String.isBlank(String.valueOf(cuenta.Contador_Auto_Desasignacion__c)) == true ? 1 : cuenta.Contador_Auto_Desasignacion__c + 1);
                cuenta.ValidationBypassDateTime__c = datetime.now();
            }

            //Si la cuenta tiene asignado un Colaborador Javer y dicho Colaborador Javer ya vencio (Fecha Vencimiento Colaborador Javer < hoy), se desasigna el Colaborador Javer del registro de cuenta y
            //Se crea la llave del registro de Rol de Venta de Colaborador Javer para su posterior busqueda y actualizacion
            //if(String.isBlank(String.valueOf(cuenta.Colaborador_Javer__c)) == false && cuenta.Fecha_Vencimiento_Colaborador_Javer__c < Date.today()){
            if(String.isBlank(String.valueOf(cuenta.Colaborador_Javer__c)) == false && cuenta.Fecha_Vencimiento_Colaborador_Javer__c < Date.today()){

                System.debug('****Cuenta: ' + cuenta.Id + ' vencida en Colaborador Javer: ' + cuenta.Colaborador_Javer__c + ' fecha: ' + cuenta.Fecha_Vencimiento_Colaborador_Javer__c);

                llavesRolesVenta.add(String.valueOf(cuenta.Colaborador_Javer__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'CJ');
                System.debug('****Llave Colaborador Javer vencido: ' + String.valueOf(cuenta.Colaborador_Javer__c) + String.valueOf(cuenta.Id) + String.valueOf(cuenta.Fraccionamiento_cta__c) + 'CJ');

                cuenta.Colaborador_Javer__c = null;
                cuenta.Fecha_Colaborador_Javer__c = null;
                cuenta.Estatus_Colaborador_Javer__c = 'POR REASIGNAR';
                cuenta.Fecha_Estatus_Colaborador_Javer__c = Datetime.Now();
                cuenta.Fecha_Estatus__c = Datetime.now();
                cuenta.Desasignacion_Auto_Colaborador_Javer__c = true;
                cuenta.Contador_Auto_Desasignacion__c = (String.isBlank(String.valueOf(cuenta.Contador_Auto_Desasignacion__c)) == true ? 1 : cuenta.Contador_Auto_Desasignacion__c + 1);
                cuenta.ValidationBypassDateTime__c = datetime.now();
            }

            cuentasActualizar.add(cuenta);
        }

        //Si hubo cuentas con roles de venta vencidos, se actualizan dichas cuentas y
        //Se obtienen los registros de Rol de Venta de dichos roles de venta vencidos para actualizarlos
        if(cuentasActualizar.size() > 0){

            //update cuentasActualizar;
            try {
                Database.SaveResult[] resultadoActualizacionCuentas = Database.update(cuentasActualizar, false);

                for (Database.SaveResult resultado : resultadoActualizacionCuentas) {
                    if (resultado.isSuccess()) {
                        System.debug('*****Id cuenta actualizada exitosamente:' + resultado.getId());
                        contadorExitos = (contadorExitos == null ? 1 : contadorExitos + 1);
                    }
                    else {              
                        for(Database.Error error : resultado.getErrors()) {

                            ErrorBatch errorBatch = new ErrorBatch();
                            errorBatch.objeto = 'Cuenta';
                            errorBatch.idRegistro = resultado.getId();
                            errorBatch.codigo = String.valueOf(error.getStatusCode());
                            errorBatch.mensaje = error.getMessage();
                            errorBatch.campos = error.getFields();
                            errorBatch.idJob = BC.getJobId();
                            erroresBatch.add(errorBatch);
                            contadorErrores = (contadorErrores == null ? 1 : contadorErrores + 1);
                        }
                    }
                }
            } catch (dmlexception e) {
                system.debug ('*** Error en resuladoActualizarCuentas');
            }
            //Se obtienen los registros de Rol de Venta de los roles de venta vencidos y se marcan como vencidos
            /*
            List<Rol_Venta__c> rolesVentaActualizar = new List<Rol_Venta__c>();
            for(Rol_Venta__c rolVenta : [SELECT Id, Llave__c, Vencido__c FROM ROL_Venta__c WHERE Llave__c IN : llavesRolesVenta]){

                System.debug('*****rolVenta:' + rolVenta);
                rolVenta.Vencido__c = true;
                rolesVentaActualizar.add(rolVenta);
            }

            //Si hubo registros de Rol de Venta marcados como vencidos, se actualizan dichos registros
            if(rolesVentaActualizar.size() > 0){

                //update rolesVentaActualizar;
                try {
                    Database.SaveResult[] resultadoActualizacionRolesVenta = Database.update(rolesVentaActualizar, false);
                    for (Database.SaveResult resultado : resultadoActualizacionRolesVenta) {
                        if (resultado.isSuccess()) {
                            System.debug('*****Id rol de vent actualizado exitosamente:' + resultado.getId());
                        }
                        else {               
                            for(Database.Error error : resultado.getErrors()) {

                                ErrorBatch errorBatch = new ErrorBatch();
                                errorBatch.objeto = 'Rol de Venta';
                                errorBatch.idRegistro = resultado.getId();
                                errorBatch.codigo = String.valueOf(error.getStatusCode());
                                errorBatch.mensaje = error.getMessage();
                                errorBatch.campos = error.getFields();
                                errorBatch.idJob = BC.getJobId();
                                erroresBatch.add(errorBatch);
                            }
                        }
                    }
                } catch (dmlexception e) {
                    system.debug ('*** error en rolesVentaActualizar');
                }
            }
            */
        }
    }

    global void finish(Database.BatchableContext BC) {

        System.debug('*****Metodo finish BATCH_CuentasDesasignacion');
        System.debug('*****erroresBatch.size():' + erroresBatch.size());
        System.debug('*****erroresBatch:' + erroresBatch);
        System.debug('*****contadorExitos:' + (contadorExitos == null ? 0 : contadorExitos));
        System.debug('*****contadorErrores:' + (contadorErrores == null ? 0 : contadorErrores));

        if(erroresBatch.size() > 0){

            System.debug('*****Hubo errores en el procesamiento del BATCH_CuentasDesasignacion');

            String fechaHora = Datetime.now().format('dd-MM-yyy hh:mm'); Integer exitos = (contadorExitos == null ? 0 : contadorExitos); Integer errores = (contadorErrores == null ? 0 : contadorErrores); Integer totalRegistros = exitos + errores;

            String cuerpoCorreo = 'Estás recibiendo este email pues hubo error(es) en el proceso batch de desasignación de roles de venta de cuentas en Salesforce (<b>BATCH_CuentasDesasignacion</b>):'+'<br/><br/>';      
            for(ErrorBatch errorBatch : erroresBatch){

                System.debug('*****Objeto:' + errorBatch.objeto);
                System.debug('*****Id:' + errorBatch.idRegistro);
                System.debug('*****Codigo:' + errorBatch.codigo);
                System.debug('*****Mensaje::' + errorBatch.mensaje);
                System.debug('*****Campos: ' + errorBatch.campos);
                System.debug('*****idJob:' + errorBatch.idJob);

                cuerpoCorreo += '--------------------------------------'+'<br/>' + '<b>Objeto:</b> ' + errorBatch.objeto + '<br/>' + '<b>Id:</b> ' + errorBatch.idRegistro + '<br/>' + '<b>Código:</b> ' + errorBatch.codigo + '<br/>' + '<b>Mensaje:</b> ' +errorBatch.mensaje + '<br/>' + '<b>Campos:</b> ' + errorBatch.campos + '<br/>';
                cuerpoCorreo += '<b>Job:</b> ' + errorBatch.idJob + '<br/>' + '--------------------------------------'+'<br/><br/>';
            }

            // String[] correosElectronicos = new List<String>();
            // for(Persona_Notificacion__mdt personaNotificacion : [SELECT MasterLabel, Correo_Electronico__c, Proceso__c FROM Persona_Notificacion__mdt WHERE Proceso__c = 'BATCH_CuentasDesasignacion']){

            //     correosElectronicos.add(personaNotificacion.Correo_Electronico__c);
            // }

            // Messaging.SingleEmailMessage correo = new Messaging.SingleEmailMessage();
            // correo.setToAddresses(correosElectronicos);
            // correo.setSubject('Salesforce - Error Proceso Batch Desasignación Cuentas - ' + fechaHora);
            // correo.setHtmlBody(cuerpoCorreo);
            // Messaging.sendEmail(new Messaging.SingleEmailMessage[]{correo});
        }
    }

    public class ErrorBatch{

        Id idRegistro;
        String objeto;
        String codigo;
        String mensaje;
        String[] campos;
        Id idJob;
    }
}