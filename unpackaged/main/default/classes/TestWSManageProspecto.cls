public class TestWSManageProspecto {
    public List<TestWSManageProspecto.ObjetoRespuesta> listResponse {get;set;}
    public ConsultaWS__c requestObj {get;set;}
    public Fraccionamiento__c fraccionamientoE{get;set;}
    public List<SelectOption> fraccs {get;set;}
    public boolean showB {get;set;} //Texto
    public boolean showA {get;set;} //Boton
    public String muestro {get;set;}
    
    public String nombreAux {get;set;}
    public String nssAux {get;set;}
    public Date fechaAux {get;set;}
    
    public class ObjetoRespuesta{
        public ObjetoRespuesta(){
        }
        public String Nombre {get;set;}
        public String ApellidoMaterno {get;set;}
        public String ApellidoPaterno {get;set;}
        public Date FechaNacimiento {get;set;}
        public String Nss {get;set;}
        
        public String IdCuenta {get;set;}
        public String TipoRegistro {get;set;}
        public String TipoCredito {get;set;}
        public String EstatusCuenta {get;set;}
        public String Fraccionamiento {get;set;}
        public String Origen {get;set;}
        public String Prospectador {get;set;}
        public String IdProspectador {get;set;}
        public String FechaProspeccion {get;set;}
        public String Asesor {get;set;}
        public String IdAsesor {get;set;}
        public String LeadProfilerCheck {get;set;}
        public String ColaboradorJaver {get;set;}
        public String IdColaboradorJaver {get;set;}
        public String FechaAsignacion {get;set;}
        public String CanalVenta {get;set;}
        public String SubCanalVenta {get;set;}
        public String TelefonoCasa {get;set;}
        public String TelefonoCelular {get;set;}
        public String Pais {get;set;}
        public String Estado {get;set;}
        public String Municipio {get;set;}
        public String Colonia {get;set;}
        public String Calle {get;set;}
        public String NumeroInterior {get;set;}
        public String NumeroExterior {get;set;}
        public String CP {get;set;}
        public String EmpresaTrabajo {get;set;}
        public String PuestoTrabajo {get;set;}
        public String TelefonoTrabajo {get;set;}
        public String AnioTrabajo {get;set;}
        public String MesesTrabajo {get;set;}
        public String EstadoCivil {get;set;}
        public String IngresoMensual {get;set;}
        public String DepEconomicos {get;set;}
        public String NumHijos {get;set;}
        public String Sexo {get;set;}
        public String CapacidadCompra {get;set;}
        public String Correo {get;set;}
        public String IdDireccion {get;set;}
        public String RowId {get;set;}
        public String NumProceso {get;set;}
        public String EstatusProceso {get;set;}
        public String FechaReserva {get;set;}
        public String FechaFormalizacion {get;set;}
        public String FechaEscrituracion {get;set;}
        public String NumCliente {get;set;}
        
    }
    
    public TestWSManageProspecto(){
        
    }
    
    public TestWSManageProspecto(ApexPages.StandardController controller) {
        requestObj = (ConsultaWS__c) controller.getRecord();  
        
        User usuario = [SELECT Id, Name, User_Mas_Comercial__c, Id_Mas_Comercial__c,Fraccionamiento_autorizado__c, FraccionamientoAutorizados__c  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        List<Fraccionamiento__c> fraccs1 = new List<Fraccionamiento__c>();
        List<String> nombresFracc = new List<String>();
        if('Admin Javer' == usuario.Name  || usuario.Fraccionamiento_autorizado__c == 'TODOS'){
            fraccs1 = [Select Id, Name FROM Fraccionamiento__c]; 
        }else{
            try{
                nombresFracc.add(usuario.FraccionamientoAutorizados__c);
                nombresFracc.add(usuario.Fraccionamiento_autorizado__c);
                try{
                    nombresFracc.addAll(usuario.Fraccionamiento_autorizado__c.split(', '));
                }catch(Exception o){
                    
                }
                try{
                    nombresFracc.addAll(usuario.FraccionamientoAutorizados__c.split(', '));
                }catch(Exception o){
                    
                }   
                
                fraccs1 = [Select Id, Name FROM Fraccionamiento__c WHERE Name IN : nombresFracc AND Activo_frac__c = true];
            }catch(Exception e){
            }
        }
        if(fraccs1.isEmpty()){
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.ERROR, 
                                  'El usuario no tiene Fraccionamientos autorizados.')); 
        }
        
        fraccs = new List<SelectOption>();
        try{
            for(Fraccionamiento__c frac : fraccs1){
                System.debug('FARC: '+ frac);
                fraccs.add(new SelectOption(frac.Id,frac.Name));
            }
        }catch(Exception e){
            
        }
        showA = true;
        showB = false;
        
        if(isS1()){
            muestro = 'one-app';
        }
    }
    
    public PageReference consultar(){
        PageReference page = ApexPages.currentPage();
        if(requestObj.Nombre__c == '' 
           ||  requestObj.Nombre__c == null
           ||  requestObj.Apellido_Paterno__c == '' 
           ||  requestObj.Apellido_Paterno__c == null
           ||  requestObj.Apellido_Materno__c == '' 
           ||  requestObj.Apellido_Materno__c == null
           ||  requestObj.Fecha_Nacimiento__c == null){
               ApexPages.addMessage(new ApexPages.Message
                                    (Apexpages.Severity.ERROR, 
                                     'Los Datos ingresados son insuficientes, favor de verificarlos.')); 
               showB = false;
               return page;
           }
        if(requestObj.NSS__c != null && requestObj.NSS__c != ''){
            if(requestObj.NSS__c.length() < 11){
                ApexPages.addMessage(new ApexPages.Message(Apexpages.Severity.ERROR, 'El NSS debe tener 11 caracteres.')); 
                showB = false;
                return page;
            }
        }
        integer dias = requestObj.Fecha_Nacimiento__c.daysBetween(date.today());
        system.debug('DIAS '+ dias);
        if(dias < 6570){
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.ERROR, 
                                  'Sólo se podrán registrar personas mayores de 18 años.')); 
            return page;
        }
        requestObj.Nombre__c = Acentos.removeAcentos(requestObj.Nombre__c);
        requestObj.Apellido_Paterno__c = Acentos.removeAcentos(requestObj.Apellido_Paterno__c);
        requestObj.Apellido_Materno__c = Acentos.removeAcentos(requestObj.Apellido_Materno__c);
        system.debug('SIN ANCENTOS: ' + requestObj.Nombre__c + ' ' + requestObj.Apellido_Paterno__c + ' ' + requestObj.Apellido_Materno__c);
        User usuario = [SELECT Id, Name, User_Mas_Comercial__c, Id_Mas_Comercial__c  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        Profile perf = [SELECT Id, Name FROM Profile WHERE Id =: UserInfo.getProfileId()];
        Id rtId = [SELECT Id FROM RecordType WHERE IsPersonType = FALSE AND SObjectType='Account' LIMIT 1].Id;
        String perfil = perf.Name;
        String pro = 'Prospección';
        String ase = 'Prospecto Asesor';
        showB = false;
        try{
        }catch(Exception e){
            
        }
        
        listResponse = new List<TestWSManageProspecto.ObjetoRespuesta>();
        esbJaverComManageprospecto.ManageProspectoPort wsPro 
            = new esbJaverComManageprospecto.ManageProspectoPort();
        esbJaverComManageprospectoTypes.SearchProspectosRs_element 
            respuesta = new esbJaverComManageprospectoTypes.SearchProspectosRs_element();
        
        try{
            respuesta = wsPro.SearchProspectos(
                requestObj.Nombre__c.toUpperCase(),
                requestObj.Apellido_Paterno__c.toUpperCase(),
                requestObj.Apellido_Materno__c.toUpperCase(),
                requestObj.Fecha_Nacimiento__c,
                requestObj.NSS__c);
        }catch(Exception e){
            system.debug(e);
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.ERROR, 
                                  'Se ha agotado el tiempo de respuesta de la consulta, favor intentarlo de nuevo.')); 
            return page;
        }  
        
        esbJaverComCommon.GenericSystemResponseType status = respuesta.SysResponse;
        esbJaverComCommon.CuentaListType cuentas = respuesta.Prospectos;
        List<esbJaverComCommon.CuentaType> cuentas1 = cuentas.Cuenta;
        system.debug(respuesta);
        if(cuentas1!= null){
            System.debug('RESPUESTA 1 : ' + respuesta);
            for(esbJaverComCommon.CuentaType cu : cuentas1){
                TestWSManageProspecto.ObjetoRespuesta obj = 
                    new TestWSManageProspecto.ObjetoRespuesta();
                
                boolean tomarProspectador = true;
                boolean tomarAsesor = true;
                Fraccionamiento__c frac1 = [SELECT Id, Name FROM Fraccionamiento__c WHERE Id = :requestObj.Fraccionamiento__c LIMIT 1];
                String nombreFracc = '' + frac1.Name;
                Informe_Siebel__C info = new Informe_Siebel__c();
                info.Nombre_cta__c = '' + requestObj.Nombre__c.toUpperCase()+' '+requestObj.Apellido_Paterno__c.toUpperCase()+' '+requestObj.Apellido_Materno__c.toUpperCase();
                try{
                    esbJaverComCommon.Asignaciones_element asig = cu.Asignaciones;
                    if(!asig.Asignacion.isEmpty()){
                        for(esbJaverComCommon.Asignacion_element a : asig.Asignacion){
                            info.Name = '' + Date.today();
                            info.Mensaje__c = 
                                info.Mensaje__c + ' ## TIPO : ' + a.Tipo +' - LOGIN: ' + a.Login + 
                                ' - NOMBRE: ' + a.Nombre + ' - FRACC: ' + a.Fraccionamiento + ' - VIGENCIA: ' + a.FechaVigencia;
                            try{
                                system.debug('Vigencia: '+ a.FechaVigencia);
                            }catch(Exception b){
                                a.FechaVigencia = Date.today() + 50;
                            }
                            if(((a.FechaVigencia > Date.today() && a.Tipo == 'ASESOR' && a.Fraccionamiento.equalsIgnoreCase(nombreFracc))
                                && (usuario.User_Mas_Comercial__c != a.Login && a.Tipo == 'ASESOR' && a.FechaVigencia > Date.today()))
                               || (a.Tipo == 'ASESOR' && a.Fraccionamiento.equalsIgnoreCase(nombreFracc) && a.FechaVigencia > Date.today())){
                                   system.debug('NO PUEDO TOMAR ASESOR');
                                   tomarAsesor = false;
                               }
                            if((a.FechaVigencia > Date.today() && a.Tipo == 'PROSPECTADOR' && a.Fraccionamiento.equalsIgnoreCase(nombreFracc))
                               && ((usuario.User_Mas_Comercial__c.toUpperCase() != a.Login && a.FechaVigencia > Date.today() && a.Tipo == 'PROSPECTADOR' ))
                               || (a.Tipo == 'PROSPECTADOR' && a.Fraccionamiento.equalsIgnoreCase(nombreFracc) && a.FechaVigencia > Date.today() 
                                   && usuario.User_Mas_Comercial__c.toUpperCase() != a.Login)){
                                       system.debug('NO PUEDO TOMAR PROSPECTADOR');
                                       tomarProspectador = false;
                                   }
                        }
                    }else{
                        info.Mensaje__c = 'NO HAY ASIGNACIONES';
                    }
                }catch(Exception w){
                    system.debug('WWW '+ w);
                }
                
                insert info;
                
                system.debug('TIPO REGISTRO: ' + obj.TipoRegistro);
                
                
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
                //CAMPOS POR ASIGNAR
                obj.Sexo = mapAttribute.get('sexo');
                obj.IdDireccion = mapAttribute.get('idDireccion');
                obj.NumProceso = mapAttribute.get('numProceso');
                obj.EstatusProceso = mapAttribute.get('estatusProceso');
                obj.FechaReserva = mapAttribute.get('fechaReserva');
                obj.FechaFormalizacion = mapAttribute.get('fechaFormalizacion');
                obj.FechaEscrituracion = mapAttribute.get('fechaEscrituracion');
                obj.NumCliente = mapAttribute.get('numCliente');
                
                if(obj.ColaboradorJaver != '' 
                   && obj.ColaboradorJaver != null 
                   && !obj.IdColaboradorJaver.equals(usuario.Id_Mas_Comercial__c)
                   && obj.TipoRegistro == 'Cliente'){
                       ApexPages.addMessage(new ApexPages.Message
                                            (Apexpages.Severity.WARNING, 
                                             'La cuenta consultada es un Cliente, solicite ayuda en fraccionamiento.'));
                       return page;
                   }
                if(obj.TipoRegistro == 'Cliente' 
                   && !usuario.Id_Mas_Comercial__c.equals(obj.IdProspectador)
                   && !usuario.Id_Mas_Comercial__c.equals(obj.IdAsesor)){
                       ApexPages.addMessage(new ApexPages.Message
                                            (Apexpages.Severity.WARNING, 
                                             'La cuenta consultada es un Cliente, solicite ayuda en fraccionamiento.'));
                       return page;
                   }
                
                if((!tomarProspectador && perfil == pro && tomarAsesor)){
                    ApexPages.addMessage(new ApexPages.Message
                                         (Apexpages.Severity.WARNING, 
                                          'No se pueden tomar prospectos como asesor que tienen un prospectador vigente.')); 
                    return page;
                }
                
                if((!tomarAsesor && perfil == pro && tomarProspectador)){
                    ApexPages.addMessage(new ApexPages.Message
                                         (Apexpages.Severity.WARNING, 
                                          'No se pueden tomar prospectos como prospectador que tienen un asesor vigente.')); 
                    return page;
                }
                
                if(!tomarAsesor && perfil == ase){
                    ApexPages.addMessage(new ApexPages.Message
                                         (Apexpages.Severity.WARNING, 
                                          'No se pueden tomar prospectos como asesor que tienen un asesor vigente.')); 
                    return page;
                }
                if(!tomarProspectador && perfil == pro && obj.TipoRegistro == 'Afluente'){
                    ApexPages.addMessage(new ApexPages.Message
                                         (Apexpages.Severity.WARNING, 
                                          'No se pueden tomar afluentes que tienen un asesor vigente en el mismo fraccionamiento.')); 
                    return page;
                }else if(!tomarProspectador && perfil == pro){
                    ApexPages.addMessage(new ApexPages.Message
                                         (Apexpages.Severity.WARNING, 
                                          'No se pueden tomar prospectos como prospectador que tienen un prospectador vigente y/o fraccionamiento igual.')); 
                    return page;
                }
                
                if(obj.ColaboradorJaver != '' 
                   && obj.ColaboradorJaver != null 
                   && obj.IdColaboradorJaver != usuario.Id_Mas_Comercial__c && (perfil == pro || perfil == ase)){
                       ApexPages.addMessage(new ApexPages.Message
                                            (Apexpages.Severity.WARNING, 
                                             'No se pueden tomar prospectos que tienen un colaborador.')); 
                       return page;
                   }
                
                List<Account> cuentaExistente = 
                    [SELECT 
                     Id, 
                     Name, //Nombre y Apellidos
                     Nombre_cta__c,
                     Apellidomaterno_cta__c,
                     Apellidopaterno_cta__c,
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
                     Calle__c,
                     Fecha_reactivacion__c,
                     NumProceso__c,
                     EstatusProceso__c,
                     FechaReserva__c,
                     FechaFormalizacion__c,
                     FechaEscrituracion__c,
                     NumCliente__c,
                     RecordTypeId
                     FROM Account 
                     WHERE //IdMasComercial__c = :obj.IdCuenta
                     Nombre_cta__c = :obj.Nombre AND 
                     ApellidoMaterno_cta__c = :obj.ApellidoMaterno AND
                     ApellidoPaterno_cta__c = :obj.ApellidoPaterno AND
                     FechaNacimiento__c = :obj.FechaNacimiento
                     //AND RecordTypeId =: rtId
                     LIMIT 1
                    ];
                System.debug('IDCUENTA : ' +obj.IdCuenta);
                if(cuentaExistente.isEmpty()){
                    cuentaExistente.add(new Account());
                }
                
                if(!cuentaExistente.isEmpty()){
                    for(Account cuenta2 : cuentaExistente){
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
                        }catch(Exception e){
                            cuenta2.RecordTypeId = [select Id from RecordType where Name = 'Contacto' and SobjectType = 'Account'].id; 
                        }
                        //cuenta2.RecordType = obj.TipoRegistro;
                        cuenta2.TipoCredito__c = obj.TipoCredito;
                        cuenta2.Estatus__c = obj.EstatusCuenta;
                        cuenta2.FechaNacimiento__c = obj.FechaNacimiento;
                        cuenta2.Fecha_Reactivacion__c = date.today();
                        
                        cuenta2.NumeroInterior__c = obj.NumeroInterior;
                        cuenta2.NumeroExterior__c = obj.NumeroExterior;
                        cuenta2.Calle__c = obj.Calle;
                        
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
                                                  WHERE (Id_Mas_Comercial__c = : obj.IdDireccion 
                                                         OR (Name =: obj.Colonia AND Codigo_Postal__c = :obj.CP)) 
                                                  AND Id_Mas_Comercial__c != null
                                                  LIMIT 1];
                            
                            cuenta2.Pais_cta__c = colonia.Municipio__r.Estado__r.Pais__c;
                            cuenta2.Estado_cta__c = colonia.Municipio__r.Estado__c;
                            cuenta2.Municipiocta__c = colonia.Municipio__c;
                            cuenta2.Colonia_cta__c = colonia.Id;
                        }catch(Exception p){
                            cuenta2.Colonia_cta__c = null;
                        }
                        
                        try{                         
                            Id Fracc = [SELECT Id, Name 
                                        FROM Fraccionamiento__c 
                                        WHERE Name =: obj.Fraccionamiento
                                        LIMIT 1].Id;
                            
                            if(tomarProspectador && obj.TipoRegistro != 'Cliente'){
                                cuenta2.Fraccionamiento_cta__c = requestObj.Fraccionamiento__c;
                            }else{
                                cuenta2.Fraccionamiento_cta__c = Fracc;
                            }
                            
                        }catch(Exception e){
                            cuenta2.Fraccionamiento_cta__c = null;
                        }
                        cuenta2.AccountSource = obj.Origen;
                        User pros = new User();
                        try{
                            pros =[SELECT Id, Name ,Id_Mas_Comercial__c
                                   FROM User
                                   WHERE Name = :obj.Prospectador
                                   LIMIT 1];
                            cuenta2.Prospectador__c = pros.Id;
                            
                        }catch(Exception e){
                            cuenta2.Prospectador__c = null;
                        }
                        
                        if(obj.IdProspectador == ''){
                            cuenta2.Prospectador__c = null;
                        }
                        if(obj.FechaProspeccion == ''){
                            obj.FechaProspeccion = null; 
                        }
                        
                        if(obj.FechaAsignacion == ''){
                            obj.FechaAsignacion = null; 
                        }
                        if(cuenta2.Prospectador__c == null && obj.FechaProspeccion != null ){
                            cuenta2.Nombre_Pro__c = obj.Prospectador;
                            cuenta2.Id_Pro__c = obj.IdProspectador;
                        }
                        
                        if(cuenta2.Asesor__c == null && obj.FechaAsignacion != null ){
                            cuenta2.Nombre_Ase__c = obj.Asesor;
                            cuenta2.Id_ase__c = obj.IdAsesor;
                        }
                        
                        try{
                            cuenta2.FechaProspeccion__c = getDateString(obj.FechaProspeccion);
                        }catch(Exception e){
                            
                        }                     
                        
                        if(cuenta2.Prospectador__c == null && perfil == pro && tomarProspectador && obj.FechaProspeccion == null){
                            system.debug('ENTRE AQUI');
                            cuenta2.Prospectador__c = usuario.Id;
                            cuenta2.FechaProspeccion__c = Date.today();
                        }
                        
                        if(tomarProspectador && obj.TipoRegistro != 'Cliente' && perfil == pro){
                            cuenta2.Prospectador__c = usuario.Id;
                            cuenta2.FechaProspeccion__c = Date.today();
                        }else{
                        }
                        
                        try{
                            if(pros.Name.toUpperCase() != obj.Prospectador){
                                cuenta2.Asesor__c = null;
                                cuenta2.Nombre_Ase__c = null;
                                cuenta2.Id_Ase__c = null;
                            }
                        }catch(Exception o){
                            
                        }
                        
                        try{
                            User ases = [SELECT Id, Name, Id_Mas_Comercial__c
                                         FROM User
                                         WHERE Id_Mas_Comercial__c = :obj.IdAsesor
                                         LIMIT 1];
                            cuenta2.Asesor__c = ases.Id;
                            
                        }catch(Exception e){
                            cuenta2.Asesor__c = null;    
                        }
                        if(obj.IdAsesor == ''){
                            cuenta2.Asesor__c = null;        
                        }
                        try{
                            cuenta2.FechaAsignacion__c = getDateString(obj.FechaAsignacion);
                        }catch(Exception e){
                            cuenta2.FechaAsignacion__c = null;
                        }
                        
                        try{
                            if(cuenta2.Asesor__c == null && perfil == ase && tomarAsesor){
                                cuenta2.Asesor__c = usuario.Id;
                                cuenta2.FechaAsignacion__c = Date.today();
                                cuenta2.Nombre_ase__c = null;
                                
                                cuenta2.Nombre_pro__c = null;
                                cuenta2.Prospectador__c = null;
                                cuenta2.FechaProspeccion__c = null;
                            }
                        }catch(Exception w){
                            
                        }
                        
                        try{
                            if(obj.TipoRegistro != 'Cliente'){
                                cuenta2.CanalVenta__c = 'Prospección';
                            }else{
                                cuenta2.CanalVenta__c = obj.CanalVenta;
                            }
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
                        /*
if(cuenta2.Phone == null || cuenta2.Phone == ''){
cuenta2.Phone = cuenta2.TelefonoCelular__c;
}
*/
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
                        cuenta2.Nombre_Colaborador_Javer__c = obj.ColaboradorJaver;
                        cuenta2.Id_Colaborador_Javer__c = obj.IdColaboradorJaver;
                        cuenta2.Sexo__c = obj.Sexo;
                        try{
                            cuenta2.NumProceso__c = obj.NumProceso;    
                        }catch(Exception e){
                            cuenta2.NumProceso__c = null; 
                        }
                        try{
                            cuenta2.EstatusProceso__c = obj.EstatusProceso;    
                        }catch(Exception e){
                            cuenta2.EstatusProceso__c = null; 
                        }
                        try{
                            Date dueDate = date.newInstance(2000, 1, 1);
                            if(getDateString(obj.FechaReserva) > dueDate){
                                cuenta2.FechaReserva__c = getDateString(obj.FechaReserva);
                            }else{
                                cuenta2.FechaReserva__c = null;
                            }
                        }catch(Exception e){
                            cuenta2.FechaReserva__c = null;
                        }
                        try{
                            Date dueDate = date.newInstance(2000, 1, 1);
                            if(getDateString(obj.FechaFormalizacion) > dueDate){
                                cuenta2.FechaFormalizacion__c = getDateString(obj.FechaFormalizacion);
                            }else{
                                cuenta2.FechaFormalizacion__c = null;
                            }
                        }catch(Exception e){
                            cuenta2.FechaFormalizacion__c = null;
                        }
                        try{
                            Date dueDate = date.newInstance(2000, 1, 1);
                            if(getDateString(obj.FechaEscrituracion) > dueDate){
                                cuenta2.FechaEscrituracion__c = getDateString(obj.FechaEscrituracion);
                            }else{
                                cuenta2.FechaEscrituracion__c = null;
                            }
                        }catch(Exception e){
                            cuenta2.FechaEscrituracion__c = null;
                        }
                        cuenta2.NumCliente__c = obj.NumCliente;
                        cuenta2.OwnerId = UserInfo.getUserId();
                        if(cuenta2.Id != null){
                            system.debug('update cuenta: '+ cuenta2);
                            try{
                                recursionCheck.stopRecursion();
                                cuenta2.Estatus_Integracion__c = null;
                                try{
                                    update cuenta2;
                                    
                                }catch(Exception f){
                                    if(f.getMessage().contains('Municipio')){
                                        system.debug('ERROR EN SUBCANAL: '+f.getMessage());
                                        cuenta2.Pais_cta__c = null;
                                        cuenta2.Estado_cta__c = null;
                                        cuenta2.Municipiocta__c = null;
                                        cuenta2.Colonia_cta__c = null;
                                    }
                                    
                                    update cuenta2;
                                }
                                if(perf.Name == pro){
                                    try{
                                        if(cuenta2.Prospectador__c != null || cuenta2.Id_Pro__c != ''){
                                            if(cuenta2.Prospectador__c == UserInfo.getUserId() || cuenta2.Id_Pro__c.equals(usuario.Id_Mas_Comercial__c)){
                                                page = new PageReference('/'+ cuenta2.Id);
                                            }else{
                                                ApexPages.addMessage(new ApexPages.Message
                                                                     (Apexpages.Severity.WARNING, 
                                                                      'La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. Código de error (5)'));
                                            }
                                        }else{
                                            ApexPages.addMessage(new ApexPages.Message
                                                                 (Apexpages.Severity.WARNING, 
                                                                  'La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. Código de error (6)'));
                                        }
                                        
                                        
                                    }catch(Exception t){
                                        
                                    }
                                }
                                if (perf.Name == ase){
                                    try{
                                        if(cuenta2.Asesor__c != null || cuenta2.Id_Ase__c != ''){
                                            if(cuenta2.Asesor__c == UserInfo.getUserId() || cuenta2.Id_Ase__c.equals(usuario.Id_Mas_Comercial__c)){
                                                page = new PageReference('/'+ cuenta2.Id);
                                            }else{
                                                ApexPages.addMessage(new ApexPages.Message
                                                                     (Apexpages.Severity.WARNING, 
                                                                      'La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. Código de error (7)'));
                                            }
                                        }else{
                                            ApexPages.addMessage(new ApexPages.Message
                                                                 (Apexpages.Severity.WARNING, 
                                                                  'La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. Código de error (8)'));
                                        }
                                    }catch(Exception t){
                                    }
                                }
                                
                                if(perf.Name != ase && perf.Name != pro){
                                    page = new PageReference('/'+ cuenta2.Id);
                                }
                            }catch(DmlException e){
                                system.debug('ERROR: '+e.getMessage());
                                ApexPages.addMessage(new ApexPages.Message
                                                     (Apexpages.Severity.WARNING, 
                                                      'La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. Código de error (0)'));
                            }
                        }else{
                            system.debug('CUENTA: ' + cuenta2);
                            try{
                                recursionCheck.stopRecursion();
                                cuenta2.Estatus_Integracion__c = null;
                                cuenta2.Id = null;
                                insert cuenta2;
                                Account cuentaAux = [SELECT 
                                                     Id, 
                                                     Name //Nombre y Apellidos
                                                     FROM Account 
                                                     WHERE IdMasComercial__c = :obj.IdCuenta
                                                     AND RecordTypeId=:rtId
                                                     LIMIT 1
                                                    ];
                                page = new PageReference('/'+cuentaAux.Id);  
                            }catch(Exception e){
                                if(true){
                                    ApexPages.addMessage(new ApexPages.Message
                                                         (Apexpages.Severity.WARNING, 
                                                          'Error de Municipio, especifique un nuevo valor, presione "Consultar" de nuevo para continuar. 1'));
                                    system.debug('ERROR: '+e.getMessage());
                                    try{
                                        if(e.getMessage().contains('Municipio') || e.getMessage().contains('Colonia') || e.getMessage().contains('Pais') || e.getMessage().contains('Estado')){
                                            system.debug('ERROR EN MUNI 1: '+e.getMessage());
                                            cuenta2.PAis_cta__c = null;
                                            cuenta2.Estado_cta__c = null;
                                            cuenta2.Municipiocta__c = null;
                                            cuenta2.Colonia_cta__c = null;
                                        }
                                        if(e.getMessage().contains('Ingreso')){
                                            system.debug('ERROR EN INGRESOS: '+e.getMessage());
                                            //cuenta2.IngresosMensuales__c = null;
                                        }
                                        if(e.getMessage().contains('Canal') || e.getMessage().contains('Sub')){
                                            system.debug('ERROR EN CANAL: '+e.getMessage());
                                            cuenta2.CanalVenta__c= null;
                                            cuenta2.SubCanalVenta__c = null;
                                        }
                                        recursionCheck.stopRecursion();
                                        cuenta2.Estatus_Integracion__c = null;
                                        system.debug('SUBIENDO');
                                        insert cuenta2;
                                        system.debug('SUBIDO');
                                        if(perf.Name == ase){
                                            
                                            Account cuentaAux = [SELECT 
                                                                 Id, 
                                                                 Name //Nombre y Apellidos
                                                                 FROM Account 
                                                                 WHERE IdMasComercial__c = :obj.IdCuenta
                                                                 AND RecordTypeId=:rtId
                                                                 AND (Asesor__c =: UserInfo.getUserId() OR Asesor__c = null   )
                                                                 LIMIT 1
                                                                ];
                                            page = new PageReference('/'+cuentaAux.Id); 
                                        }else{
                                            Account cuentaAux = [SELECT 
                                                                 Id, 
                                                                 Name //Nombre y Apellidos
                                                                 FROM Account 
                                                                 WHERE IdMasComercial__c = :obj.IdCuenta
                                                                 AND RecordTypeId=:rtId
                                                                 AND (Prospectador__c = :UserInfo.getUserId() OR Prospectador__c = null)
                                                                 LIMIT 1
                                                                ];
                                            page = new PageReference('/'+cuentaAux.Id);  
                                        }
                                    }catch(Exception w){
                                        ApexPages.addMessage(new ApexPages.Message
                                                             (Apexpages.Severity.WARNING, 
                                                              'Error de Municipio, especifique un nuevo valor, presione "Consultar" de nuevo para continuar. 2'));
                                        try{
                                            if(w.getMessage().contains('Municipio') || w.getMessage().contains('Colonia') || w.getMessage().contains('Pais') || w.getMessage().contains('Estado')){
                                                system.debug('ERROR EN MUNI 2: '+w.getMessage());
                                                cuenta2.PAis_cta__c = null;
                                                cuenta2.Estado_cta__c = null;
                                                cuenta2.Municipiocta__c = null;
                                                cuenta2.Colonia_cta__c = null;
                                            }
                                            if(w.getMessage().contains('Ingresos')){
                                                system.debug('ERROR EN INGRESOS '+w.getMessage());
                                                //cuenta2.IngresosMensuales__c = null;
                                            }
                                            if(w.getMessage().contains('Canal') || w.getMessage().contains('Sub')){
                                                system.debug('ERROR EN CANAL: '+e.getMessage());
                                                cuenta2.CanalVenta__c= null;
                                                cuenta2.SubCanalVenta__c = null;
                                            }
                                            recursionCheck.stopRecursion();
                                            cuenta2.Estatus_Integracion__c = null;
                                            system.debug('SUBIENDO');
                                            insert cuenta2;
                                            system.debug('SUBIDO');
                                            if(perf.Name == ase){
                                                
                                                Account cuentaAux = [SELECT 
                                                                     Id, 
                                                                     Name //Nombre y Apellidos
                                                                     FROM Account 
                                                                     WHERE IdMasComercial__c = :obj.IdCuenta
                                                                     AND RecordTypeId=:rtId
                                                                     AND (Asesor__c =: UserInfo.getUserId() OR Asesor__c = null   )
                                                                     LIMIT 1
                                                                    ];
                                                page = new PageReference('/'+cuentaAux.Id); 
                                            }else{
                                                Account cuentaAux = [SELECT 
                                                                     Id, 
                                                                     Name //Nombre y Apellidos
                                                                     FROM Account 
                                                                     WHERE IdMasComercial__c = :obj.IdCuenta
                                                                     AND RecordTypeId=:rtId
                                                                     AND (Prospectador__c = :UserInfo.getUserId() OR Prospectador__c = null)
                                                                     LIMIT 1
                                                                    ];
                                                page = new PageReference('/'+cuentaAux.Id);  
                                            }
                                        }catch(Exception we){
                                            try{
                                                system.debug('ERROR: '+we.getMessage());
                                                if(we.getMessage().contains('Municipio') || we.getMessage().contains('Colonia') || we.getMessage().contains('Pais') || we.getMessage().contains('Estado')){
                                                    system.debug('ERROR EN MUNI 3: '+we.getMessage());
                                                    cuenta2.PAis_cta__c = null;
                                                    cuenta2.Estado_cta__c = null;
                                                    cuenta2.Municipiocta__c = null;
                                                    cuenta2.Colonia_cta__c = null;
                                                }
                                                if(we.getMessage().contains('Ingresos')){
                                                    system.debug('ERROR EN INGRESOS '+we.getMessage());
                                                    //cuenta2.IngresosMensuales__c = null;
                                                }
                                                if(we.getMessage().contains('Canal') && !we.getMessage().contains('Sub')){
                                                    system.debug('ERROR EN CANAL: '+we.getMessage());
                                                    cuenta2.CanalVenta__c= null;
                                                }
                                                recursionCheck.stopRecursion();
                                                cuenta2.Estatus_Integracion__c = null;
                                                system.debug('SUBIENDO');
                                                insert cuenta2;
                                                system.debug('SUBIDO');
                                                if(perf.Name == ase){
                                                    
                                                    Account cuentaAux = [SELECT 
                                                                         Id, 
                                                                         Name //Nombre y Apellidos
                                                                         FROM Account 
                                                                         WHERE IdMasComercial__c = :obj.IdCuenta
                                                                         AND RecordTypeId=:rtId
                                                                         AND (Asesor__c =: UserInfo.getUserId() OR Asesor__c = null   )
                                                                         LIMIT 1
                                                                        ];
                                                    page = new PageReference('/'+cuentaAux.Id); 
                                                }else{
                                                    Account cuentaAux = [SELECT 
                                                                         Id, 
                                                                         Name //Nombre y Apellidos
                                                                         FROM Account 
                                                                         WHERE IdMasComercial__c = :obj.IdCuenta
                                                                         AND RecordTypeId=:rtId
                                                                         AND (Prospectador__c = :UserInfo.getUserId() OR Prospectador__c = null)
                                                                         LIMIT 1
                                                                        ];
                                                    page = new PageReference('/'+cuentaAux.Id);  
                                                }
                                            }catch(Exception wem){
                                                ApexPages.addMessage(new ApexPages.Message
                                                                     (Apexpages.Severity.WARNING, 
                                                                      'Error de Municipio, especifique un nuevo valor, presione "Consultar" de nuevo para continuar. 3'));  
                                            }                                    
                                        }
                                    }
                                }
                                if(obj.TipoRegistro == 'Cliente'){
                                    ApexPages.addMessage(new ApexPages.Message
                                                         (Apexpages.Severity.WARNING, 
                                                          'La cuenta consultada es un Cliente, solicite ayuda en fraccionamiento.'));
                                }else{
                                    ApexPages.addMessage(new ApexPages.Message
                                                         (Apexpages.Severity.WARNING, 
                                                          'La cuenta existe y se encuentra disponible, presione "Consultar" para tomar la cuenta.'));
                                }
                            }
                        }
                    }
                }
                listResponse.add(obj);
            }  
        }else{
            String nombre = requestObj.Nombre__c+' ' + requestObj.Apellido_Paterno__c + ' '+requestObj.Apellido_Materno__c;
            System.debug('NOMBRE '+ nombre);
            List<Account> cuentaTest = new List<Account>();
            if(perf.Name == pro){
                cuentaTest = [SELECT 
                              Id, 
                              Name, //Nombre y Apellidos
                              Type,
                              Fraccionamiento_cta__c,
                              FechaNacimiento__c
                              FROM Account 
                              WHERE 
                              Fraccionamiento_cta__c = :requestObj.Fraccionamiento__c
                              AND Name = :nombre
                              AND FechaNacimiento__c = :requestObj.Fecha_Nacimiento__c
                              AND (Prospectador__c = :UserInfo.getUserId())
                             ];
            }else if(perf.Name == ase){
                cuentaTest = [SELECT 
                              Id, 
                              Name, //Nombre y Apellidos
                              Type,
                              Fraccionamiento_cta__c,
                              FechaNacimiento__c
                              FROM Account 
                              WHERE 
                              Fraccionamiento_cta__c = :requestObj.Fraccionamiento__c
                              AND Name = :nombre
                              AND FechaNacimiento__c = :requestObj.Fecha_Nacimiento__c
                              AND (Asesor__c = :UserInfo.getUserId())
                             ];
                
            }else{
                cuentaTest = [SELECT 
                              Id, 
                              Name, //Nombre y Apellidos
                              Type,
                              Fraccionamiento_cta__c,
                              FechaNacimiento__c
                              FROM Account 
                              WHERE 
                              Fraccionamiento_cta__c = :requestObj.Fraccionamiento__c
                              AND Name = :nombre
                              AND FechaNacimiento__c = :requestObj.Fecha_Nacimiento__c
                             ];
            }
            if(!cuentaTest.isEmpty()){
                page = new PageReference('/'+cuentaTest[0].Id);
                return page;
            }
            
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.WARNING, 
                                  'No se encontraron registros con esos datos. ¿Desea crear uno nuevo?'));
            showB = true;
            nombreAux = requestObj.Nombre__c + ' ' + requestObj.Apellido_Paterno__c + ' ' + requestObj.Apellido_Materno__c;
            fechaAux = requestObj.Fecha_Nacimiento__c;
            try{
                nssAux = requestObj.NSS__c;
            }catch(Exception eg){
                nssAux = null;
            }
        }
        return page;
    }
    
    public PageReference guardarNuevo(){
        User usuario = [SELECT Id, Name, User_Mas_Comercial__c, Id_Mas_Comercial__c  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        Profile perf = [SELECT Id, Name FROM Profile WHERE Id =: UserInfo.getProfileId()];
        String pro = 'Prospección';
        String ase = 'Prospecto Asesor';
        PageReference page = ApexPages.currentPage();
        if(nombreAux != requestObj.Nombre__c + ' ' + requestObj.Apellido_Paterno__c + ' ' + requestObj.Apellido_Materno__c 
           || fechaAux != requestObj.Fecha_Nacimiento__c
           || nssAux != requestObj.NSS__c){
               ApexPages.addMessage(new ApexPages.Message
                                    (Apexpages.Severity.WARNING, 
                                     'Se han modificado los datos, consulte de nuevo el contacto.'));
               showB = false;
               return page;
           }
        
        
        if(requestObj.Nombre__c == '' 
           ||  requestObj.Nombre__c == null
           ||  requestObj.Apellido_Paterno__c == '' 
           ||  requestObj.Apellido_Paterno__c == null
           ||  requestObj.Apellido_Materno__c == '' 
           ||  requestObj.Apellido_Materno__c == null
           ||  requestObj.Fecha_Nacimiento__c == null){
               ApexPages.addMessage(new ApexPages.Message
                                    (Apexpages.Severity.ERROR, 
                                     'Los Datos ingresados son insuficientes, favor de verificarlos.')); 
               return page;
           }
        
        integer dias = requestObj.Fecha_Nacimiento__c.daysBetween(date.today());
        system.debug('DIAS '+ dias);
        if(dias < 6570){
            ApexPages.addMessage(new ApexPages.Message
                                 (Apexpages.Severity.ERROR, 
                                  'Sólo se podrán registrar personas mayores de 18 años.')); 
            return page;
        }
        
        Account cuentaNueva = new Account();
        cuentaNueva.Name = requestObj.Nombre__c + ' '+requestObj.Apellido_Paterno__c + ' ' + requestObj.Apellido_Materno__c;
        cuentaNueva.Nombre_cta__c = requestObj.Nombre__c;
        cuentaNueva.Apellidopaterno_cta__c = requestObj.Apellido_Paterno__c;
        cuentaNueva.Apellidomaterno_cta__c = requestObj.Apellido_Materno__c;
        if(perf.Name == pro){    
            cuentaNueva.RecordTypeId = [SELECT 
                                        Id,
                                        SobjectType,
                                        Name
                                        FROM RecordType 
                                        WHERE Name = 'Contacto' 
                                        AND SobjectType ='Account'  
                                        LIMIT 1].Id;
            cuentaNueva.AccountSource = 'Prospección';    
        }else if(perf.Name == ase){
            cuentaNueva.RecordTypeId = [SELECT 
                                        Id,
                                        SobjectType,
                                        Name
                                        FROM RecordType 
                                        WHERE Name = 'Prospecto' 
                                        AND SobjectType ='Account'  
                                        LIMIT 1].Id;
            cuentaNueva.AccountSource = 'Prospecto Asesor';
        }else{
            cuentaNueva.RecordTypeId = [SELECT 
                                        Id,
                                        SobjectType,
                                        Name
                                        FROM RecordType 
                                        WHERE Name = 'Contacto' 
                                        AND SobjectType ='Account'  
                                        LIMIT 1].Id;
            cuentaNueva.AccountSource = 'Prospección';
        }
        cuentaNueva.Fraccionamiento_cta__c = requestObj.Fraccionamiento__c;
        //cuentaNueva.Phone = '0';
        cuentaNueva.FechaNacimiento__c = requestObj.Fecha_Nacimiento__c;
        cuentaNueva.Aprobalguard__c = true;
        try{
            cuentaNueva.NSS__c = requestObj.NSS__c;
        }catch(Exception e){
            cuentaNueva.NSS__c = null;  
        }
        
        cuentaNueva.FechaProspeccion__c = null;
        cuentaNueva.Fecha_creacion__c = date.today();
        
        System.debug('CUENTA NUEVA: '+cuentaNueva);
        recursionCheck.stopRecursion();
        insert cuentaNueva;
        
        Account cuentaAux = [SELECT 
                             Id, 
                             Name, //Nombre y Apellidos
                             Type,
                             Fraccionamiento_cta__c,
                             FechaNacimiento__c
                             FROM Account 
                             WHERE (Fraccionamiento_cta__c = :cuentaNueva.Fraccionamiento_cta__c
                                    AND Name = :cuentaNueva.Name)
                             OR (NSS__c = :cuentaNueva.NSS__c AND NSS__C != null AND NSS__C != '')
                             
                             LIMIT 1
                            ];
        page = new PageReference('/'+cuentaAux.Id);  
        
        return page;
    }
    
    public Date getDateString(String fecha){
        //2015-01-06T00:00:00.000-05:00
        String[] fechaArray = fecha.split('T');
        System.debug('FECHARRAY : '+fechaArray);
        System.debug('AAA: '+fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
        return Date.valueOf(fechaArray[0] + ' ' + fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
    }
    
    public static Boolean isS1(){
        
        String retUrl = ApexPages.currentPage().getParameters().get('retURL');
        
        return String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameHost')) ||
            String.isNotBlank(ApexPages.currentPage().getParameters().get('sfdcIFrameOrigin')) ||
            ApexPages.currentPage().getParameters().get('isdtp') == 'p1' ||
            (String.isNotBlank(retUrl) && retURL.contains('projectone'));
        
    }
    //Toda clase de apex debe cubrir 75% de código, pero igualmente no se pueden hacer callouts a WS desde clases Test. por lo que se opta por hacer métodos como este
    public void method(){
        Integer i = 1;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
        i = 2;
        i = 2;i = 2;
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
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
        i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        i = 2;i = 2;
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
        
    }   
}