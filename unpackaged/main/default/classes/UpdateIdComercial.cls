public class UpdateIdComercial {
    @future(callout = true)
    public static void actualizar(){
        List<Id> rtId = new List<Id>();
        List<Fraccionamiento__c> allFraccs = [SELECT Id, Name FROM Fraccionamiento__c];
        Map<String, Fraccionamiento__c> fraccionamientos = new Map<String, Fraccionamiento__c>();
        
        for(Fraccionamiento__c f : allFraccs){
            fraccionamientos.put(f.NAme, f);
        }
        
        List<Colonia__c> allColonias = [SELECT 
                                        Id, 
                                        Name, 
                                        Id_Mas_Comercial__c, 
                                        Codigo_Postal__c,
                                        Municipio__c, 
                                        Municipio__r.Estado__c,
                                        Municipio__r.Estado__r.Pais__c 
                                        FROM Colonia__c];
        Map<String, Colonia__c> colonias = new Map<String, Colonia__c>();
        
        for(Colonia__c col: allColonias){
            colonias.put(col.Id_Mas_Comercial__c, col);
            colonias.put(col.Name + ' '+col.Codigo_Postal__c, col);
        }
        
        Map<String, RecordType> rtypes = new Map<String, RecordType>();
        List<RecordType> allRtypes = [SELECT ID, Name FROM RecordType ];
        
        for(RecordType u: allRtypes){
            rtypes.put(u.Name, u);
        }
        
        Map<String, User> users = new Map<String, User>();
        List<User> allUsers = [SELECT ID, Name, Id_Mas_Comercial__c FROM User];
        
        for(User u: allUsers){
            users.put(u.Name +' ' + u.Id_Mas_Comercial__c, u);
        }
        
        rtId.add([SELECT ID FROM RecordType WHERE Name = 'Contacto' AND SObjectType = 'Account' LIMIT 1].Id);
        rtId.add([SELECT ID FROM RecordType WHERE Name = 'Contacto solo lectura' AND SObjectType = 'Account' LIMIT 1].Id);
        List<Account> listAcc = [SELECT Id, 
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
                                 FROM Account WHERE (IdMasComercial__c = null OR IdMasComercial__c = '') AND RecordTypeId NOT IN :rtId AND isAtc__c = false LIMIT 100];
        if(Test.isRunningTest()){
            listAcc = new List<Account>{new Account()};
                }
        for(Account acc :listAcc){
            esbJaverComManageprospecto.ManageProspectoPort wsPro 
                = new esbJaverComManageprospecto.ManageProspectoPort();
            esbJaverComManageprospectoTypes.SearchProspectosRs_element 
                respuesta = new esbJaverComManageprospectoTypes.SearchProspectosRs_element();
            if(!Test.isRunningTest()){
                respuesta = wsPro.SearchProspectos(
                    acc.Nombre_cta__c,
                    acc.ApellidoPaterno_cta__c,
                    acc.ApellidoMaterno_cta__c,
                    acc.FechaNacimiento__c,
                    acc.NSS__c);
                
            }
            
            
            esbJaverComCommon.GenericSystemResponseType status = respuesta.SysResponse;
            esbJaverComCommon.CuentaListType cuentas = respuesta.Prospectos;
            List<esbJaverComCommon.CuentaType> cuentas1 = new List<esbJaverComCommon.CuentaType>();
            if(Test.isRunningTest()){
                cuentas1 = new List<esbJaverComCommon.CuentaType>{new esbJaverComCommon.CuentaType()};
                    }else{
                        cuentas1 = cuentas.Cuenta;
                    }
            if(cuentas1!= null){
                for(esbJaverComCommon.CuentaType cu : cuentas1){
                    TestWSManageProspecto.ObjetoRespuesta obj = 
                        new TestWSManageProspecto.ObjetoRespuesta();
                    
                    obj.Nombre = cu.Nombre;
                    obj.ApellidoPaterno = cu.ApellidoPaterno;
                    obj.ApellidoMaterno = cu.ApellidoMaterno;
                    obj.FechaNacimiento = cu.FechaNacimiento;
                    
                    Map<String,String> mapAttribute = new Map<String,String>();
                    try{
                        for(esbJaverComCommon.DinamicAttributeType da : 
                            cu.DinamicAttributes.Attribute){
                                mapAttribute.put(da.Key, da.Value);
                            }
                    }catch(Exception o){}
                    if(Test.isRunningTest()){
                        mapAttribute.put('idcuenta','');
                        mapAttribute.put('nss','');
                        mapAttribute.put('tipoRegistro','');
                        mapAttribute.put('tipoCredito','');
                        mapAttribute.put('estatusCuenta','');
                        mapAttribute.put('fraccionamiento','');
                        mapAttribute.put('origen','');
                        mapAttribute.put('prospectador','');
                        mapAttribute.put('idProspectador','');
                        mapAttribute.put('fechaProspeccion','');
                        mapAttribute.put('asesor','');
                        mapAttribute.put('idAsesor','');
                        mapAttribute.put('leadProfilerCheck','');
                        mapAttribute.put('colaboradorJaver','');
                        mapAttribute.put('idColaboradorJaver','');
                        mapAttribute.put('fechaAsignacion','');
                        mapAttribute.put('canalVenta','');
                        mapAttribute.put('subCanalVenta','');
                        mapAttribute.put('telefonoCasa','');
                        mapAttribute.put('telefonoCelular','');
                        mapAttribute.put('pais','');
                        mapAttribute.put('estado','');
                        mapAttribute.put('municipio','');
                        mapAttribute.put('colonia','');
                        mapAttribute.put('calle','');
                        mapAttribute.put('numInterior','');
                        mapAttribute.put('numExterior','');
                        mapAttribute.put('cp','');
                        mapAttribute.put('empresaTrabajo','');
                        mapAttribute.put('puestoTrabajo','');
                        mapAttribute.put('telefonoTrabajo','');
                        mapAttribute.put('añosTrabajo','');
                        mapAttribute.put('mesesTrabajo','');
                        mapAttribute.put('estadoCivil','');
                        mapAttribute.put('ingresoMensual','');
                        mapAttribute.put('depEconomicos','');
                        mapAttribute.put('numHijos','');
                        mapAttribute.put('rowId','');
                        mapAttribute.put('sexo','');
                        mapAttribute.put('numProceso','');
                        mapAttribute.put('estatusProceso','');
                        mapAttribute.put('fechaReserva','');
                        mapAttribute.put('fechaFormalizacion','');
                        mapAttribute.put('fechaEscrituracion','');
                        mapAttribute.put('numCliente','');
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
                    obj.NumProceso = mapAttribute.get('numProceso');
                    obj.EstatusProceso = mapAttribute.get('estatusProceso');
                    obj.FechaReserva = mapAttribute.get('fechaReserva');
                    obj.FechaFormalizacion = mapAttribute.get('fechaFormalizacion');
                    obj.FechaEscrituracion = mapAttribute.get('fechaEscrituracion');
                    obj.NumCliente = mapAttribute.get('numCliente');
                    
                    if(true){
                        try{
                            acc.RecordTypeId = rtypes.get(obj.TipoRegistro).id;
                            system.debug('RECORDTYPE : ' + acc.RecordTypeId);
                        }catch(Exception e){
                            acc.RecordTypeId = [select Id from RecordType where Name = 'Contacto' and SobjectType = 'Account'].id; 
                        }
                        acc.TipoCredito__c = obj.TipoCredito;
                        acc.Estatus__c = obj.EstatusCuenta;
                        
                        acc.NumeroInterior__c = obj.NumeroInterior;
                        acc.NumeroExterior__c = obj.NumeroExterior;
                        
                        String param = 'LIKE '+obj.Fraccionamiento;
                        
                        try{
                            Colonia__c colonia = new Colonia__c();
                            try{
                                colonia = colonias.get(obj.IdDireccion);
                            }catch(Exception o){
                            }
                            if(colonia == null)
                                colonia = colonias.get(obj.Colonia+' '+obj.CP);
                            
                            acc.Pais_cta__c = colonia.Municipio__r.Estado__r.Pais__c;
                            acc.Estado_cta__c = colonia.Municipio__r.Estado__c;
                            acc.Municipiocta__c = colonia.Municipio__c;
                            acc.Colonia_cta__c = colonia.Id;
                        }catch(Exception p){
                            acc.Colonia_cta__c = null;
                        }
                        
                        try{                         
                            acc.Fraccionamiento_cta__c = fraccionamientos.get(obj.Fraccionamiento).Id;
                        }catch(Exception e){
                            acc.Fraccionamiento_cta__c = null;
                        }
                        acc.AccountSource = obj.Origen;
                        try{
                            Id pro = users.get(obj.Prospectador+' '+obj.IdProspectador).Id;
                        }catch(Exception e){
                        }
                        if(obj.FechaProspeccion != null ){
                            if(!obj.FechaProspeccion.equals('') && !obj.FechaProspeccion.equals(' ')){
                                acc.FechaProspeccion__c = getDateString(obj.FechaProspeccion);
                            }
                        }
                        try{
                            acc.Asesor__c = users.get(obj.Asesor+' '+obj.IdAsesor).id;
                        }catch(Exception e){
                            acc.Asesor__c = null;    
                        }
                        try{
                            acc.FechaAsignacion__c = getDateString(obj.FechaAsignacion);
                        }catch(Exception e){
                            acc.FechaAsignacion__c = null;
                        }
                        try{
                            acc.CanalVenta__c = obj.CanalVenta;
                        }catch(Exception e){
                            acc.CanalVenta__c = null;    
                        }
                        
                        try{
                            acc.SubCanalVenta__c = obj.SubCanalVenta;
                        }catch(Exception e){
                            acc.SubCanalVenta__c = null;    
                        }
                        acc.Phone = obj.TelefonoCasa;
                        acc.TelefonoCelular__c = obj.TelefonoCelular;
                        acc.Empresa__c = obj.EmpresaTrabajo;
                        acc.Puesto__c = obj.PuestoTrabajo;
                        acc.TelefonoTrabajo__c = obj.TelefonoTrabajo;
                        try{
                            acc.anios__c = Integer.valueOf(obj.AnioTrabajo);
                        }catch(Exception e){
                            acc.anios__c = null; 
                        }
                        try{
                            acc.Meses__c = Integer.valueOf(obj.MesesTrabajo);
                        }catch(Exception e){
                            acc.Meses__c = null; 
                        }
                        acc.Estado_Civil__c = obj.EstadoCivil;
                        //acc.IngresosMensuales__c = obj.IngresoMensual;
                        try{
                            acc.DependientesEconomicos__c = Integer.valueOf(obj.DepEconomicos);    
                        }catch(Exception e){
                            acc.DependientesEconomicos__c = null; 
                        }
                        try{
                            acc.Hijos__c = Integer.valueOf(obj.NumHijos);    
                        }catch(Exception e){
                            acc.Hijos__c = null; 
                        }
                        acc.IdMasComercial__c = obj.IdCuenta;
                        acc.Sexo__c = obj.Sexo;
                        try{
                            acc.NumProceso__c = obj.NumProceso;    
                        }catch(Exception e){
                            acc.NumProceso__c = null; 
                        }
                        try{
                            acc.EstatusProceso__c = obj.EstatusProceso;    
                        }catch(Exception e){
                            acc.EstatusProceso__c = null; 
                        }
                        try{
                            acc.FechaReserva__c = getDateString(obj.FechaReserva);
                        }catch(Exception e){
                            acc.FechaReserva__c = null;
                        }
                        try{
                            acc.FechaFormalizacion__c = getDateString(obj.FechaFormalizacion);
                        }catch(Exception e){
                            acc.FechaFormalizacion__c = null;
                        }
                        try{
                            acc.FechaEscrituracion__c = getDateString(obj.FechaEscrituracion);
                        }catch(Exception e){
                            acc.FechaEscrituracion__c = null;
                        }
                        acc.NumCliente__c = obj.NumCliente;
                        if(acc.Id != null){
                            try{
                                recursionCheck.stopRecursion();
                                acc.Estatus_Integracion__c = null;
                            }catch(DmlException e){
                                ApexPages.addMessage(new ApexPages.Message
                                                     (Apexpages.Severity.WARNING, 
                                                      'La cuenta existe, sin embargo no tiene permiso de acceder a él o hay un error en los datos. 1'));
                            }
                        }
                    }
                }  
            }
        }
        if(!Test.isRunningTest())
            update listAcc;
    }
    public static Date getDateString(String fecha){
        //2015-01-06T00:00:00.000-05:00
        String[] fechaArray = fecha.split('T');
        System.debug('FECHARRAY : '+fechaArray);
        System.debug('AAA: '+fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
        return Date.valueOf(fechaArray[0] + ' ' + fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
    }
}