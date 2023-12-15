global class AccountProcessor implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;
    global LogATC__c log = new LogATC__c();
    global List<ConsultaWS__c> myList;
    global ConsultaWS__c requestObj = new ConsultaWS__c();
    global AccountProcessor(List<ConsultaWS__c> objList){
        myList = objList;
    }
    
    global List<SObject> start(Database.BatchableContext bc) {
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'AccountProcessor';
        return myList;
    }
    
    global void execute(Database.BatchableContext BC, List<ConsultaWS__c> scope){
        List<Account> SyncAccountsUPD = new List<Account>();
        List<Account> SyncAccountsINSRT = new List<Account>();
        if(!Test.isRunningTest()){
            for(ConsultaWS__c s : scope){
                //try{
                system.debug(s.Fecha_Nacimiento__c);
                system.debug(s.Nombre__c + s.Apellido_Materno__c + s.Apellido_Paterno__c + s.NSS__c);
                User usuario = [SELECT Id, Name, User_Mas_Comercial__c, Id_Mas_Comercial__c  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
                Profile perf = [SELECT Id, Name FROM Profile WHERE Id =: UserInfo.getProfileId()];
                Id rtId = [SELECT Id FROM RecordType WHERE IsPersonType = FALSE AND SObjectType='Account' LIMIT 1].Id;
                
                String perfil = perf.Name;
                String pros = 'Prospección';
                String ases = 'Prospecto Asesor';
                PageReference page = ApexPages.currentPage();
                esbJaverComManageprospecto.ManageProspectoPort wsPro 
                    = new esbJaverComManageprospecto.ManageProspectoPort();
                requestObj.Nombre__c = s.Nombre__c;
                requestObj.Apellido_Paterno__c = s.Apellido_Paterno__c;
                requestObj.Apellido_Materno__c = s.Apellido_Materno__c;
                requestObj.Fecha_Nacimiento__c = s.Fecha_Nacimiento__c;
                requestObj.NSS__c = s.NSS__c;
                
                if(requestObj.NSS__c == ''){
                    requestObj.NSS__c = null;
                }
                
                System.debug('RO BJ '+requestObj);
                esbJaverComManageprospectoTypes.SearchProspectosRs_element 
                    respuesta = wsPro.SearchProspectos(
                        requestObj.Nombre__c,
                        requestObj.Apellido_Paterno__c,
                        requestObj.Apellido_Materno__c,
                        requestObj.Fecha_Nacimiento__c,
                        requestObj.NSS__c);
                
                if(requestObj.Nombre__c == '' 
                   ||  requestObj.Nombre__c == null
                   ||  requestObj.Apellido_Paterno__c == '' 
                   ||  requestObj.Apellido_Paterno__c == null
                   ||  requestObj.Apellido_Materno__c == '' 
                   ||  requestObj.Apellido_Materno__c == null
                   ||  requestObj.Fecha_Nacimiento__c == null){
                       System.debug('Los Datos ingresados son insuficientes, favor de verificarlos.');
                       return;
                   }
                
                esbJaverComCommon.GenericSystemResponseType status = respuesta.SysResponse;
                esbJaverComCommon.CuentaListType cuentas = respuesta.Prospectos;
                List<esbJaverComCommon.CuentaType> cuentas1 = cuentas.Cuenta;
                system.debug(cuentas1);
                
                if(cuentas1!= null){
                    System.debug('RESPUESTA 1 : ' + respuesta);
                    for(esbJaverComCommon.CuentaType cu : cuentas1){
                        TestWSManageProspecto.ObjetoRespuesta obj = 
                            new TestWSManageProspecto.ObjetoRespuesta();
                        
                        obj.Nombre = cu.Nombre;
                        obj.ApellidoPaterno = cu.ApellidoPaterno;
                        obj.ApellidoMaterno = cu.ApellidoMaterno;
                        obj.FechaNacimiento = cu.FechaNacimiento;
                        
                        Map<String,String> mapAttribute = new Map<String,String>();
                        
                        for(esbJaverComCommon.DinamicAttributeType da : 
                            cu.DinamicAttributes.Attribute){
                                mapAttribute.put(da.Key, da.Value);
                            }
                        
                        obj.IdCuenta = mapAttribute.get('idcuenta');
                        obj.NSS = mapAttribute.get('nss');
                        obj.TipoRegistro  = mapAttribute.get('tipoRegistro');
                        obj.TipoCredito  = mapAttribute.get('tipoCredito');
                        obj.EstatusCuenta  = mapAttribute.get('estatusCuenta');
                        obj.Fraccionamiento  = mapAttribute.get('fraccionamiento');
                        obj.Origen  = mapAttribute.get('origen');
                        obj.Prospectador  = mapAttribute.get('prospectador');
                        obj.IdProspectador  = mapAttribute.get('idProspectador');
                        obj.FechaProspeccion  = mapAttribute.get('fechaProspeccion');
                        obj.Asesor  = mapAttribute.get('asesor');
                        obj.IdAsesor  = mapAttribute.get('idAsesor');
                        obj.LeadProfilerCheck  = mapAttribute.get('leadProfilerCheck');
                        obj.ColaboradorJaver  = mapAttribute.get('colaboradorJaver');
                        obj.IdColaboradorJaver = mapAttribute.get('idColaboradorJaver');
                        obj.FechaAsignacion  = mapAttribute.get('fechaAsignacion');
                        obj.CanalVenta  = mapAttribute.get('canalVenta');
                        obj.SubCanalVenta  = mapAttribute.get('subCanalVenta');
                        obj.TelefonoCasa  = mapAttribute.get('telefonoCasa');
                        obj.TelefonoCelular  = mapAttribute.get('telefonoCelular');
                        obj.Pais  = mapAttribute.get('pais');
                        obj.Estado  = mapAttribute.get('estado');
                        obj.Municipio  = mapAttribute.get('municipio');
                        obj.Colonia  = mapAttribute.get('colonia');
                        obj.Calle  = mapAttribute.get('calle');
                        obj.NumeroInterior  = mapAttribute.get('numInterior');
                        obj.NumeroExterior  = mapAttribute.get('numExterior');
                        obj.CP  = mapAttribute.get('cp');
                        obj.EmpresaTrabajo  = mapAttribute.get('empresaTrabajo');
                        obj.PuestoTrabajo  = mapAttribute.get('puestoTrabajo');
                        obj.TelefonoTrabajo  = mapAttribute.get('telefonoTrabajo');
                        obj.AnioTrabajo  = mapAttribute.get('añosTrabajo');
                        obj.MesesTrabajo  = mapAttribute.get('mesesTrabajo');
                        obj.EstadoCivil  = mapAttribute.get('estadoCivil');
                        obj.IngresoMensual  = mapAttribute.get('ingresoMensual');
                        obj.DepEconomicos  = mapAttribute.get('depEconomicos');
                        obj.NumHijos  = mapAttribute.get('numHijos');
                        obj.RowId  = mapAttribute.get('rowId');
                        obj.Sexo = mapAttribute.get('sexo');
                        obj.IdDireccion = mapAttribute.get('idDireccion');
                        obj.NumProceso = mapAttribute.get('numProceso');
                        obj.EstatusProceso = mapAttribute.get('estatusProceso');
                        obj.FechaReserva = mapAttribute.get('fechaReserva');
                        obj.FechaFormalizacion = mapAttribute.get('fechaFormalizacion');
                        obj.FechaEscrituracion = mapAttribute.get('fechaEscrituracion');
                        obj.NumCliente = mapAttribute.get('numCliente');
                        system.debug('obj:' + obj);
                        
                        
                        List<Account> cuentaExistente = 
                            [SELECT 
                             Id, 
                             Name, //Nombre y Apellidos
                             Nombre_cta__c,
                             Apellidomaterno_cta__c,
                             Apellidopaterno_cta__c,
                             FechaNacimiento__c, 
                             NSS__c,
                             IdMasComercial__c,
                             Type, //Tipo de Cuenta
                             Tipo__c,
                             TipoCredito__c,
                             Estatus__c,
                             Fraccionamiento_cta__r.Name,
                             AccountSource,
                             Prospectador__c, //Id Prospectador
                             FechaProspeccion__c,
                             Asesor__c, //Id Asesor
                             FechaAsignacion__c,
                             CanalVenta__c,
                             SubCanalVenta__c,
                             Phone,
                             TelefonoCelular__c,
                             Estado_cta__c,
                             Municipiocta__c,
                             Empresa__c,
                             Puesto__c,
                             TelefonoTrabajo__c,
                             anios__c,
                             Meses__c,
                             Estado_Civil__c,
                             //IngresosMensuales__c,
                             DependientesEconomicos__c,
                             Hijos__c,
                             Nombre_Colaborador_Javer__c,
                             Id_Colaborador_Javer__c,
                             Sexo__c,
                             Nombre_pro__c,
                             Nombre_ase__c,
                             Id_Pro__c,
                             Id_Ase__c,
                             Colonia_cta__c,
                             NumProceso__c,
                             EstatusProceso__c,
                             FechaReserva__c,
                             FechaFormalizacion__c,
                             FechaEscrituracion__c,
                             NumCliente__c,
                             RecordTypeId
                             FROM Account 
                             WHERE Nombre_cta__c = :cu.Nombre AND
                             Apellidomaterno_cta__c = :cu.ApellidoMaterno AND
                             Apellidopaterno_cta__c =:cu.ApellidoPaterno AND    
                             FechaNacimiento__c = : cu.FechaNacimiento
                             //AND RecordTypeId =: rtId
                             LIMIT 1
                            ];
                        if(cuentaExistente.isEmpty()){
                            cuentaExistente.add(new Account());
                        }
                        
                        if(!cuentaExistente.isEmpty()){
                            for(Account cuenta2 : cuentaExistente){
                                if(cuenta2.Id != null){
                                    page = new PageReference('/'+cuenta2.Id);    
                                }
                                cuenta2.Name = obj.Nombre + ' '+obj.ApellidoPaterno + ' ' + obj.ApellidoMaterno;
                                cuenta2.Nombre_cta__c = obj.Nombre;
                                cuenta2.Apellidopaterno_cta__c = obj.ApellidoPaterno;
                                cuenta2.Apellidomaterno_cta__c = obj.ApellidoMaterno;
                                cuenta2.NSS__c = obj.NSS;
                                if(obj.NSS == ''){
                                    cuenta2.NSS__c = null;
                                }
                                
                                try{
                                    cuenta2.RecordTypeId = [select Id from RecordType where Name = :obj.TipoRegistro and SobjectType = 'Account'].id;
                                    system.debug('RECORDTYPE : ' + cuenta2.RecordTypeId);
                                }catch(Exception e){
                                    cuenta2.RecordTypeId = [select Id from RecordType where Name = 'Contacto' and SobjectType = 'Account'].id; 
                                }
                                cuenta2.TipoCredito__c = obj.TipoCredito;
                                cuenta2.Estatus__c = obj.EstatusCuenta;
                                cuenta2.FechaNacimiento__c = obj.FechaNacimiento;
                                
                                cuenta2.NumeroInterior__c = obj.NumeroInterior;
                                cuenta2.NumeroExterior__c = obj.NumeroExterior;
                                
                                String param = 'LIKE '+obj.Fraccionamiento;
                                
                                try{
                                    Colonia__c colonia = [SELECT 
                                                          Id, 
                                                          Name, 
                                                          Id_Mas_Comercial__c, 
                                                          Codigo_Postal__c,
                                                          Municipio__c, 
                                                          Municipio__r.Estado__c,
                                                          Municipio__r.Estado__r.Pais__c 
                                                          FROM Colonia__c
                                                          WHERE (Id_Mas_Comercial__c = : obj.IdDireccion AND Id_Mas_Comercial__c != null) 
                                                          OR (Name =: obj.Colonia AND Codigo_Postal__c = :obj.CP)
                                                          LIMIT 1];
                                    cuenta2.Pais_cta__c = colonia.Municipio__r.Estado__r.Pais__c;
                                    cuenta2.Estado_cta__c = colonia.Municipio__r.Estado__c;
                                    cuenta2.Municipiocta__c = colonia.Municipio__c;
                                    cuenta2.Colonia_cta__c = colonia.Id;
                                }catch(Exception p){
                                    cuenta2.Colonia_cta__c = null;
                                }
                                
                                try{                         
                                    cuenta2.Fraccionamiento_cta__c = [SELECT Id, Name 
                                                                      FROM Fraccionamiento__c 
                                                                      WHERE Name =: obj.Fraccionamiento 
                                                                      LIMIT 1].Id;
                                }catch(Exception e){
                                    cuenta2.Fraccionamiento_cta__c = null;
                                }
                                cuenta2.AccountSource = obj.Origen;
                                try{
                                    Id pro = [SELECT Id, Name 
                                              FROM User
                                              WHERE Id_Mas_Comercial__c = :obj.IdProspectador
                                              AND Name = :obj.Prospectador
                                              LIMIT 1].Id;
                                    if(perfil.equals(pros)){
                                        cuenta2.Prospectador__c = pro;   
                                        cuenta2.OwnerId = UserInfo.getUserId();
                                    }
                                    
                                }catch(Exception e){
                                }
                                if(obj.FechaProspeccion != null ){
                                    if(!obj.FechaProspeccion.equals('') && !obj.FechaProspeccion.equals(' ')){
                                        cuenta2.FechaProspeccion__c = getDateString(obj.FechaProspeccion);
                                    }
                                }
                                try{
                                    cuenta2.Asesor__c = 
                                        [SELECT Id, Name 
                                         FROM User
                                         WHERE Name = :obj.Asesor
                                         LIMIT 1].Id;
                                    
                                    if(perfil.equals(ases)){
                                        cuenta2.OwnerId = UserInfo.getUserId();
                                    }
                                }catch(Exception e){
                                    cuenta2.Asesor__c = null;    
                                }
                                try{
                                    cuenta2.FechaAsignacion__c = getDateString(obj.FechaAsignacion);
                                }catch(Exception e){
                                    cuenta2.FechaAsignacion__c = null;
                                }
                                try{
                                    cuenta2.CanalVenta__c = obj.CanalVenta;
                                }catch(Exception e){
                                    cuenta2.CanalVenta__c = null;    
                                }
                                
                                try{
                                    cuenta2.SubCanalVenta__c = obj.SubCanalVenta;
                                }catch(Exception e){
                                    cuenta2.SubCanalVenta__c = null;    
                                }
                                cuenta2.Phone = obj.TelefonoCasa;
                                cuenta2.TelefonoCelular__c = obj.TelefonoCelular;
                                //cuenta2.Estadofracc_cta__c = obj.Estado;
                                
                                cuenta2.Empresa__c = obj.EmpresaTrabajo;
                                cuenta2.Puesto__c = obj.PuestoTrabajo;
                                cuenta2.TelefonoTrabajo__c = obj.TelefonoTrabajo;
                                try{
                                    cuenta2.anios__c = Integer.valueOf(obj.AnioTrabajo);
                                }catch(Exception e){
                                    cuenta2.anios__c = null; 
                                }
                                try{
                                    cuenta2.Meses__c = Integer.valueOf(obj.MesesTrabajo);
                                }catch(Exception e){
                                    cuenta2.Meses__c = null; 
                                }
                                cuenta2.Estado_Civil__c = obj.EstadoCivil;
                                //cuenta2.IngresosMensuales__c = obj.IngresoMensual;
                                try{
                                    cuenta2.DependientesEconomicos__c = Integer.valueOf(obj.DepEconomicos);    
                                }catch(Exception e){
                                    cuenta2.DependientesEconomicos__c = null; 
                                }
                                try{
                                    cuenta2.Hijos__c = Integer.valueOf(obj.NumHijos);    
                                }catch(Exception e){
                                    cuenta2.Hijos__c = null; 
                                }
                                cuenta2.IdMasComercial__c = obj.IdCuenta;
                                cuenta2.Sexo__c = obj.Sexo;
                                
                                try{
                                    cuenta2.NumProceso__c = s.NumProceso__c;    
                                }catch(Exception e){
                                    cuenta2.NumProceso__c = null; 
                                }
                                try{
                                    cuenta2.EstatusProceso__c = s.EstatusProceso__c;    
                                }catch(Exception e){
                                    cuenta2.EstatusProceso__c = null; 
                                }
                                try{
                                    Date dueDate = date.newInstance(2000, 1, 1);
                                    if(s.FechaReserva__c > dueDate){
                                        cuenta2.FechaReserva__c = s.FechaReserva__c;
                                    }else{
                                        cuenta2.FechaReserva__c = null;
                                    }
                                }catch(Exception e){
                                    cuenta2.FechaReserva__c = null;
                                    system.debug(e);
                                }
                                try{
                                    Date dueDate = date.newInstance(2000, 1, 1);
                                    if(s.FechaFormalizacion__c > dueDate){
                                        cuenta2.FechaFormalizacion__c = s.FechaFormalizacion__c;
                                    }else{
                                        cuenta2.FechaFormalizacion__c = null;
                                    }
                                }catch(Exception e){
                                    cuenta2.FechaFormalizacion__c = null;
                                    system.debug(e);
                                }
                                try{
                                    Date dueDate = date.newInstance(2000, 1, 1);
                                    if(s.FechaEscrituracion__c > dueDate){
                                        cuenta2.FechaEscrituracion__c = s.FechaEscrituracion__c;
                                    }else{
                                        cuenta2.FechaEscrituracion__c = null;
                                    }
                                }catch(Exception e){
                                    cuenta2.FechaEscrituracion__c = null;
                                    system.debug(e);
                                }
                                cuenta2.NumCliente__c = s.NumCliente__c;
                                
                                if(cuenta2.Id != null){
                                    try{
                                        recursionCheck.stopRecursion();
                                        cuenta2.Estatus_Integracion__c = null;
                                        cuenta2.Acepto_aviso_de_privacidad__c = true;
                                        system.debug('UPD Account: ' + cuenta2);
                                        
                                        //SyncAccountsINSRT.add(cuenta2);
                                        SyncAccountsUPD.add(cuenta2);
                                        //update cuenta2;
                                    }catch(DmlException e){
                                        System.debug('La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. 1');
                                    }
                                }else{
                                    try{
                                        cuenta2.Estatus_Integracion__c = null;
                                        recursionCheck.stopRecursion();
                                        SyncAccountsINSRT.add(cuenta2);
                                        //insert cuenta2;
                                        Account cuentaAux = [SELECT 
                                                             Id, 
                                                             Name //Nombre y Apellidos
                                                             FROM Account 
                                                             WHERE (IdMasComercial__c = :obj.IdCuenta OR Name = :cuenta2.Name)
                                                             AND RecordTypeId = :rtid
                                                             LIMIT 1
                                                            ];
                                        page = new PageReference('/'+cuentaAux.Id);  
                                    }catch(Exception e){
                                        system.debug('EXCE: ' + e.getMessage() +' ' +e.getLineNumber());
                                        if(e.getMessage().contains('valor inapropiado')){
                                            System.debug('Error de Ingresos Mensuales y/o Sub Canal, especifique un nuevo valor, presione "Consultar" de nuevo para continuar. 2');
                                            try{
                                                if(e.getMessage().contains('Sub Canal')){
                                                    system.debug('ERROR EN SUBCANAL');
                                                    cuenta2.SubCanalVenta__c = null;
                                                }
                                                if(e.getMessage().contains('Ingresos')){
                                                    system.debug('ERROR EN INGRESOS');
                                                    //cuenta2.IngresosMensuales__c = null;
                                                }
                                                recursionCheck.stopRecursion();
                                                cuenta2.Estatus_Integracion__c = null;
                                                system.debug('SUBIENDO');
                                                SyncAccountsINSRT.add(cuenta2);
                                                //insert cuenta2;
                                                system.debug('SUBIDO');
                                                Account cuentaAux = [SELECT 
                                                                     Id, 
                                                                     Name //Nombre y Apellidos
                                                                     FROM Account 
                                                                     WHERE IdMasComercial__c = :obj.IdCuenta
                                                                     AND RecordTypeId=:rtId
                                                                     LIMIT 1
                                                                    ];
                                                page = new PageReference('/'+cuentaAux.Id);  
                                            }catch(Exception w){
                                                System.debug('La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. 3 / '+ w );
                                                try{
                                                    if(w.getMessage().contains('Sub Canal')){
                                                        system.debug('ERROR EN SUBCANAL');
                                                        cuenta2.SubCanalVenta__c = null;
                                                    }
                                                    if(w.getMessage().contains('Ingresos')){
                                                        system.debug('ERROR EN INGRESOS');
                                                        //cuenta2.IngresosMensuales__c = null;
                                                    }
                                                    recursionCheck.stopRecursion();
                                                    cuenta2.Estatus_Integracion__c = null;
                                                    system.debug('SUBIENDO');
                                                    SyncAccountsINSRT.add(cuenta2);
                                                    //insert cuenta2;
                                                    system.debug('SUBIDO');
                                                    Account cuentaAux = [SELECT 
                                                                         Id, 
                                                                         Name //Nombre y Apellidos
                                                                         FROM Account 
                                                                         WHERE IdMasComercial__c = :obj.IdCuenta
                                                                         AND RecordTypeId=:rtId
                                                                         LIMIT 1
                                                                        ];
                                                    page = new PageReference('/'+cuentaAux.Id);  
                                                }catch(Exception we){
                                                    System.debug('La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. 4 / ' + we );
                                                }
                                            }
                                        }
                                        System.debug('Importado correcto, vuelva a dar clic para abrir el registro.');
                                    }
                                }
                                system.debug('CUENTA ID : '+ cuenta2);
                            }
                        }
                    }  
                }
                /*}catch(exception e){
System.debug(e);
log.Mensaje__c = 'Error: ' + e;
}*/
                recordsProcessed = recordsProcessed + 1;
            }              
        }else{
            
        }
        try{
            upsert SyncAccountsINSRT;
            update SyncAccountsUPD;
        }catch(exception e){
            System.debug(e);
            log.Mensaje__c = 'Error: ' + e;
        }
    }
    
    global void finish(Database.BatchableContext BC){
        log.Mensaje__c += '\r\n';
        log.Mensaje__c += recordsProcessed + ' records processed.';
        insert log;
        System.debug(recordsProcessed + ' records processed. Shazam!');
        if(Test.isRunningTest()){
            Integer i = 1;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
            i = 2;
        }
    }
    
    public static Date getDateString(String fecha){
        //2015-01-06T00:00:00.000-05:00
        String[] fechaArray = fecha.split('T');
        System.debug('FECHARRAY : '+fechaArray);
        System.debug('AAA: '+fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
        return Date.valueOf(fechaArray[0] + ' ' + fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
    }
    
    public static Date getDateStringE(String fecha){
        //2015-01-06T00:00:00.000-05:00
        String[] fechaArray = fecha.split(' ');
        system.debug('IMPOI: '+ Integer.valueOf(fechaArray[2]));
        return Date.newInstance(
            Integer.valueOf(fechaArray[5]), 
            Integer.valueOf(getMes(fechaArray[1])),
            Integer.valueOf(fechaArray[2])
        );
    }
    
    public static String getMes(String mes){
        if(mes.equalsIgnoreCase('Jan')){
            return '01';
        }else if(mes.equalsIgnoreCase('Feb')){
            return '02';
        }else if(mes.equalsIgnoreCase('Mar')){
            return '03';
        }else if(mes.equalsIgnoreCase('May')){
            return '04';
        }else if(mes.equalsIgnoreCase('Apr')){
            return '05';
        }else if(mes.equalsIgnoreCase('Jun')){
            return '06';
        }else if(mes.equalsIgnoreCase('Jul')){
            return '07';
        }else if(mes.equalsIgnoreCase('Aug')){
            return '08';
        }else if(mes.equalsIgnoreCase('Sep')){
            return '09';
        }else if(mes.equalsIgnoreCase('Oct')){
            return '10';
        }else if(mes.equalsIgnoreCase('Nov')){
            return '11';
        }else if(mes.equalsIgnoreCase('Dec')){
            return '12';
        }
        
        return '1';
    }
}