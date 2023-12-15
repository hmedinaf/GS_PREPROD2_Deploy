trigger GuardarMasComercial on Account (before insert, before update, before delete, after insert, after update, after delete) {

    // if(trigger.isBefore && trigger.isInsert && trigger.isUpdate){
    //     for(Account cuenta : trigger.new){
    //     cuenta.Name = cuenta.Nombre_cta__c + ' ' + cuenta.Apellidopaterno_cta__c + ' ' + cuenta.Apellidomaterno_cta__c;
    // }


    //El campo fecha duplicada no se utiliza para clientes ATC
    /*
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        for(Account cuenta : trigger.new){
            if(cuenta.FechaNacimiento__c != null){
                String fech = cuenta.FechaNacimiento__c.day() + ''+cuenta.FechaNacimiento__c.month()+''+cuenta.FechaNacimiento__c.year();
                cuenta.FechaDuplicada__c = Integer.valueOf(fech);
            }
        }
    }
    */
    
    //El campo isATC__c se marca como TRUE para todas las cuentas que llegan de Mas Comercial
    //Por ende esta logica nunca se ejecuta
    /*if(trigger.isBefore && trigger.isInsert){        
        for(Account cuenta : trigger.new){
            if(cuenta.isATC__c){
                continue;
            }
            Id idre = [SELECT Id FROM RecordType WHERE Name = 'Contacto' LIMIT 1].Id;
            Id idre2 = [SELECT Id FROM RecordType WHERE Name = 'Contacto solo lectura' LIMIT 1].Id;
            Id idre3 = [SELECT Id FROM RecordType WHERE Name = 'Clientes ATC' LIMIT 1].Id;
            
            User usuario = [SELECT Id, Name, User_Mas_Comercial__c, Id_Mas_Comercial__c  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
            
            Profile perf = [SELECT Id, Name FROM Profile WHERE Id =: UserInfo.getProfileId()];
            
            String perfil = perf.Name;
            String pro = 'Prospección';
            String ase = 'Prospecto Asesor';
            
            if(cuenta.FechaNacimiento__c != null){
                String fech = cuenta.FechaNacimiento__c.day() + ''+cuenta.FechaNacimiento__c.month()+''+cuenta.FechaNacimiento__c.year();
                cuenta.FechaDuplicada__c = Integer.valueOf(fech);
            }
            if(cuenta.RecordType != null){
                if(cuenta.RecordType.Id == idre || cuenta.RecordType.Id == idre2 || cuenta.RecordType.Id == idre3){
                    cuenta.Estatus_Integracion__c = null;
                }
            }
            if(perfil == pro && (cuenta.IdMasComercial__c == '' || cuenta.IdMasComercial__c== null)){
                cuenta.Prospectador__c = usuario.Id;
                cuenta.FechaProspeccion__c = Date.today();
            }else if(perfil == ase && (cuenta.IdMasComercial__c == ''  || cuenta.IdMasComercial__c== null)){
                cuenta.Asesor__c = usuario.Id;
                cuenta.FechaAsignacion__c = Date.today();
            }
            if(cuenta.AccountSource == null || cuenta.AccountSource == ''){
                if(perfil == pro){
                    cuenta.AccountSource = 'Prospección';      
                }else if(perfil == ase){
                    cuenta.AccountSource = 'Prospecto Asesor';
                }
            }
        }
    }*/
    
    if(trigger.isAfter && !trigger.isDelete && (trigger.isInsert||trigger.isUpdate) && recursionCheck.canIRun() && !System.isBatch() && !System.isFuture()){
        // system.debug('*** Entrando a Trigger ActualizaMasComercial!');

        Map<String,String> mapCanalVenta  = new Map<String,String>();
        Map<String,String> mapSubCanalVenta  = new Map<String,String>();

        mapCanalVenta.put('DIGITAL ASESOR','Digital Asesor');
        mapCanalVenta.put('EVENTO','Evento');
        mapCanalVenta.put('LLAMADA CALL CENTER','Llamada Call Center');
        mapCanalVenta.put('MACROVENTA','');
        mapCanalVenta.put('MEDIO PUBLICITARIO','Medio Publicitario');
        mapCanalVenta.put('MEDIOS DIGITALES','Medios Digitales');
        mapCanalVenta.put('PROGRAMAS INSTITUCIONALES','Programas Institucionales');
        mapCanalVenta.put('PROMOTOR EXTERNO','Promotor Externo');
        mapCanalVenta.put('PROSPECCION','Prospección');
        mapCanalVenta.put('PROSPECTO ASESOR','');
        mapCanalVenta.put('REFERIDOS','Referidos');

        mapSubCanalVenta.put('ACTIVACION/EVENTO','Activación/Evento');
        mapSubCanalVenta.put('ACTIVACION/EVENTO/PERIFERIA','Activación/Evento/Periferia');
        mapSubCanalVenta.put('AGS FERIA CANADEVI','AGS Feria CANADEVI');
        mapSubCanalVenta.put('AGS MOCTEZUMA','AGS Moctezuma');
        mapSubCanalVenta.put('AGS SAN DIEGO','AGS San Diego');
        mapSubCanalVenta.put('AGS VILLA ASUNCION','Ags Villa Asunción');
        mapSubCanalVenta.put('APP INVITADO','APP INVITADO');
        mapSubCanalVenta.put('BLOGGER/TANIA RENDON','');
        mapSubCanalVenta.put('BUEN FIN','Buen Fin');
        mapSubCanalVenta.put('CALL CENTER/TELEMARKETING','Call Center / Telemarketing');
        mapSubCanalVenta.put('CAMBACEO','Cambaceo');
        mapSubCanalVenta.put('CARTELERA MOVIL','Cartelera Móvil');
        mapSubCanalVenta.put('CARTELERA PV','Cartelera PV');
        mapSubCanalVenta.put('CARTERA DE CLIENTES','Cartera de Clientes');
        mapSubCanalVenta.put('CARTERA PROPIA','Cartera Propia');
        mapSubCanalVenta.put('CITA ASESOR','Cita Asesor');
        mapSubCanalVenta.put('COLABORADOR JAVER','Colaborador Javer');
        mapSubCanalVenta.put('COMPAÑERO DE TRABAJO','Compañero de Trabajo');
        mapSubCanalVenta.put('CONVENIO PABELLON M','Convenio Pabellon M');
        mapSubCanalVenta.put('CORREO','Correo');
        mapSubCanalVenta.put('CORREO DIRECTO/CARTA','Correo Directo/Carta');
        mapSubCanalVenta.put('EDO MEX SAMARA','Edo Mex Samara');
        mapSubCanalVenta.put('EN EMPRESA (VENTA EMPRESARIAL)','En Empresa (Venta Empresarial)');
        mapSubCanalVenta.put('ESPECTACULAR/CARTELERA','Espectacular/Cartelera');
        mapSubCanalVenta.put('EVENTO (MACROVENTA, SUPERVTA)','Eventos (Macroventa, Súpervta)');
        mapSubCanalVenta.put('EXPO/FERIA','Expo/Feria');
        mapSubCanalVenta.put('FACEBOOK','Facebook');
        mapSubCanalVenta.put('FACEBOOK INBOX','Facebook Inbox');
        mapSubCanalVenta.put('FAMILIAR','Familiar');
        mapSubCanalVenta.put('FB ASESOR ORGANICO','FB Asesor Orgánico');
        mapSubCanalVenta.put('FB ASESOR PAGADO POR ASESOR','FB Asesor Pagado por Asesor');
        mapSubCanalVenta.put('FB ASESOR PAGADO POR JAVER','FB Asesor Pagado por Javer');
        mapSubCanalVenta.put('FERIA REVOLUCION CDMX','Feria Revolución CDMX');
        mapSubCanalVenta.put('FERIA ZOCALO DF','Feria Zocalo D.F.');
        mapSubCanalVenta.put('FLYER/VOLANTE','Flyer/Volante');
        mapSubCanalVenta.put('GOOGLE','Google');
        mapSubCanalVenta.put('IMAGEN EN PV','Imagen en PV');
        mapSubCanalVenta.put('INBOUND','Inbound');
        mapSubCanalVenta.put('INSTAGRAM','Instagram');
        mapSubCanalVenta.put('INTERNET','Internet');
        mapSubCanalVenta.put('INTERNET/PAGINA WEB','Internet / Página Web');
        mapSubCanalVenta.put('INVITACION DEL ASESOR','Invitación del Asesor');
        mapSubCanalVenta.put('ISLA PASEO QUERETARO','Isla Paseo Queretaro');
        mapSubCanalVenta.put('JAVERMOVIL','Javermóvil');
        mapSubCanalVenta.put('LINKEDIN','LinkedIn');
        mapSubCanalVenta.put('LLAMADA CALLCENTER','Llamada callcenter');
        mapSubCanalVenta.put('LONEROS','Loneros');
        mapSubCanalVenta.put('MACROVENTA ONLINE','');
        mapSubCanalVenta.put('MAILING','Mailing');
        mapSubCanalVenta.put('MARCACION CORTA','Marcacion Corta');
        mapSubCanalVenta.put('MICROSITIO ASESOR','Micrositio Asesor');
        mapSubCanalVenta.put('MICROSITIOS','Micrositios');
        mapSubCanalVenta.put('MODULO EN PUNTO ESTRATEGICO','Modulo en Punto Estratégico');
        mapSubCanalVenta.put('MODULO PAGADO EN PUNTO ESTRATE','Módulo pagado en Punto Estratégico');
        mapSubCanalVenta.put('MUNDO JAVER','');
        mapSubCanalVenta.put('OTROS CREDITOS','Otros Creditos');
        mapSubCanalVenta.put('P. INMOBLIARIOS-INMUEBLES 24','');
        mapSubCanalVenta.put('PAGINA DE INTERNET','Página de Internet');
        mapSubCanalVenta.put('PAGINA WEB JAVER','Pagina web Javer');
        mapSubCanalVenta.put('PASABA POR AQUI','Pasaba por aquí');
        mapSubCanalVenta.put('PERIFERIA','Periferia');
        mapSubCanalVenta.put('PERIODICO','Periódico');
        mapSubCanalVenta.put('P INMOBILIARIOS INMUEBLES 24','');
        mapSubCanalVenta.put('PODCAST','Podcast');
        mapSubCanalVenta.put('PORT. INMOBILIARIO/TRATO DIREC','Port. Inmobiliario/Trato Direc');
        mapSubCanalVenta.put('PORTAL CASA PERFECTA','');
        mapSubCanalVenta.put('PORTALES INMOBILIARIOS','Portales Inmobiliarios');
        mapSubCanalVenta.put('PORTAL INMOBILIARIO','Portal Inmobiliario');
        mapSubCanalVenta.put('PORT INMOBILIARIO/TRATO DIREC','Port. Inmobiliario/Trato Direc');
        mapSubCanalVenta.put('POSTER','Póster');
        mapSubCanalVenta.put('PRENSA','Prensa');
        mapSubCanalVenta.put('PRENSA/REVISTA','Prensa/Revista');
        mapSubCanalVenta.put('PROSPECCION','Prospección');
        mapSubCanalVenta.put('PROSPECTO ASESOR','');
        mapSubCanalVenta.put('PUBLICIDAD EN AUTOBUSES','Publicidad en Autobuses');
        mapSubCanalVenta.put('QIR TIANGUIS','QIR Tianguis');
        mapSubCanalVenta.put('RADIO','Radio');
        mapSubCanalVenta.put('RECOMIENDA Y GANA','Recomienda y Gana');
        mapSubCanalVenta.put('REFERIDO','Referido');
        mapSubCanalVenta.put('REFERIDO/RECOMENDACION','Referido/Recomendación');
        mapSubCanalVenta.put('SEÑALIZACION','Señalizacion');
        mapSubCanalVenta.put('SEÑALIZACION HUMANA','Señalizacion Humana');
        mapSubCanalVenta.put('TELEMARKETING','Telemarketing');
        mapSubCanalVenta.put('TELEVISION','Televisión');
        mapSubCanalVenta.put('TWITTER','Twitter');
        mapSubCanalVenta.put('VECINO','Vecino');
        mapSubCanalVenta.put('VOLANTE','Volante');
        mapSubCanalVenta.put('WAZE','');
        mapSubCanalVenta.put('WHATSAPP','Whatsapp');
        mapSubCanalVenta.put('YOUTUBE','Youtube');

        Map <String, String> mapEstadoCivil = new Map <String,String>();
        mapEstadoCivil.put('CASADO','Casado');
        mapEstadoCivil.put('DIVORCIADO','Divorciado');
        mapEstadoCivil.put('SOLTERO','Soltero');
        mapEstadoCivil.put('UNION LIBRE','Unión Libre');
        mapEstadoCivil.put('VIUDO','Viudo');

        Map <String, String> mapIngresosMens = new Map <String,String>();
        mapIngresosMens.put('0 - 3,999','0 - 3,999');
        mapIngresosMens.put('4,000 - 7,999','4,000 – 7,999');
        mapIngresosMens.put('8,000 - 12,999','8,000 – 12,999');
        mapIngresosMens.put('13,000 - 15,999','13,000 – 15,999');
        mapIngresosMens.put('16,000 - 19,999','16,000 – 19,999');
        mapIngresosMens.put('20,000 - 24,999','20,000 – 24,999');
        mapIngresosMens.put('25,000 - 34,999','25,000 - 34,999');
        mapIngresosMens.put('35,000 - 44,999','35,000 – 44,999');
        mapIngresosMens.put('45,000 - 54,999','45,000 – 54,999');
        mapIngresosMens.put('55,000 - 64,999','55,000 - 64,999');
        mapIngresosMens.put('65,000 - 74,999','65,000 - 74,999');
        mapIngresosMens.put('75,000 - MAS','75,000 – Más');

        Map <String, String> mapSexo = new Map <String,String>();
        mapSexo.put('MASCULINO','Masculino');
        mapSexo.put('FEMENINO','Femenino');
        mapSexo.put('INDISTINTO','Indistinto');

        Map <String, String> mapRecType = new Map <String,String>();
        mapRecType.put('PROSPECTO PERSONA FISICA', 'Prospecto');
        mapRecType.put('AFLUENTE PERSONA FISICA', 'Afluente');
        mapRecType.put('CLIENTE PERSONA FISICA', 'Cliente');

        boolean execAsync = true;

        for(Account cuenta : trigger.new){
            if (trigger.isUpdate) {
                if (cuenta.Trigger_Override__c != trigger.oldMap.get(cuenta.id).Trigger_Override__c) {
                    execAsync = false;
                }
            }
            if (execAsync) {
                system.debug ('****** Entró una vez al trigger para llamar GuardarMasComercial Async');
                
                Id idre = [SELECT Id FROM RecordType WHERE Name = 'Contacto' LIMIT 1].Id;
                Id idre2 = [SELECT Id FROM RecordType WHERE Name = 'Contacto solo lectura' LIMIT 1].Id;
                Id idre3 = [SELECT Id FROM RecordType WHERE Name = 'Clientes ATC' LIMIT 1].Id;
                system.debug('CUENTA ' + cuenta);
                //Solo se utilizan cuentas ATC, por ende esta logica nunca se ejecuta
                if(cuenta.RecordTypeId != idre && cuenta.RecordTypeId != idre2 && cuenta.RecordTypeId != idre3){
                    
                    RecordType rt = [SELECT 
                                    Id,
                                    SobjectType,
                                    Name
                                    FROM RecordType 
                                    WHERE Id = : cuenta.RecordTypeId
                                    LIMIT 1];
                    
                    User usuario = new User();
                    User asesor = new User();
                    Colonia__c colonia = new Colonia__c();
                    Municipio__c municipio = new Municipio__c();
                    Date fechaA = Date.today();
                    // String mes = ''+fechaA.month();
                    // String dia = ''+fechaA.day();
                    // system.debug('*** Trigger Mas comercial: Actualizando campos!');
                    // if(mes.length() < 2 ){
                    //     mes = '0' + mes;
                    // }
                    // if(dia.length() < 2 ){
                    //     dia = '0' + dia;
                    // }
                    // Formato fecha solicitado mm/dd/aaaa
                    //Datetime.newInstance(fechaA.year(), fechaA.month(), fechaA.day()).format('mm-dd-yyyy');
                    String fechaS = Datetime.newInstance(fechaA.year(), fechaA.month(), fechaA.day()).format('dd/MM/yyyy');
                    //fechaA.format('mm-dd-yyyy');
                    
                    // String fechaS = '' + mes + '/'+dia + '/' + fechaA.year();                
                    Fraccionamiento__c fracc = new Fraccionamiento__c();
                    
                    try{
                        asesor = [SELECT Id, User_Mas_Comercial__c, Id_Mas_Comercial__c, Name, FederationIdentifier FROM User WHERE Id=: cuenta.Asesor__c LIMIT 1];
                    }catch(Exception e){
                        
                    }
                    
                    try{
                        fracc = [SELECT Id, Name FROM Fraccionamiento__c WHERE Id =: cuenta.Fraccionamiento_cta__c LIMIT 1];
                    }catch(Exception e){
                        
                    }
                    
                    try{
                        usuario = [SELECT Id,Name, User_Mas_Comercial__c, Id_Mas_Comercial__c FROM User WHERE Id=: cuenta.Prospectador__c LIMIT 1];
                        
                    }catch(Exception w){
                        
                    }
                    
                    try{
                        colonia = [SELECT Id,Name, Id_Mas_Comercial__c, Codigo_Postal__c, 
                                Municipio__r.Name, 
                                Municipio__r.Estado__r.Name,
                                Municipio__r.Estado__r.Pais__r.Name 
                                FROM Colonia__c WHERE Id =: cuenta.Colonia_cta__c LIMIT 1];
                        
                    }catch(Exception w){
                        
                    }
                    System.debug('RECORDTYPE: '+cuenta.RecordTypeId);
                    if(cuenta.RecordTypeId != null){
                        System.debug('RECORDTYPE: '+cuenta.RecordTypeId);
                        if(cuenta.RecordTypeId != idre && cuenta.RecordTypeId != idre2 && cuenta.RecordTypeId!= idre3){
                            system.debug('LAA CUENTA 2: '+cuenta);
                            List<String> mcOb = new List<String>();
                            esbJaverComCommon.CuentaType1 prospecto = new esbJaverComCommon.CuentaType1();
                            prospecto.Nombre = cuenta.FirstName;
                            // prospecto.Name = cuenta.Nombre_cta__c;
                            prospecto.ApellidoPaterno = cuenta.LastName;
                            prospecto.ApellidoMaterno = cuenta.Apellidomaterno_cta__c;
                            if (cuenta.FechaNacimiento__c!=null) {
                                prospecto.FechaNacimiento = Datetime.newInstance(cuenta.FechaNacimiento__c.year(), cuenta.FechaNacimiento__c.month(), cuenta.FechaNacimiento__c.day()).format('dd/MM/yyyy');
                            }
                            
                            prospecto.DinamicAttributes = new esbJaverComCommon.DinamicAttributeListType();
                            prospecto.DinamicAttributes.Attribute = new List<esbJaverComCommon.DinamicAttributeType>(38);
                            
                            List<esbJaverComCommon.DinamicAttributeType> attr = new List<esbJaverComCommon.DinamicAttributeType>(38);
                            for(Integer i = 0; i < 38; i++){
                                attr[i] = new esbJaverComCommon.DinamicAttributeType();
                            }
                            
                            attr[0].Key = 'idcuenta';
                            try{
                                if(cuenta.IdMasComercial__c != null){
                                    attr[0].Value = ''+cuenta.IdMasComercial__c;
                                }else{
                                    attr[0].Value = '';
                                }
                            }catch(Exception w){
                                attr[0].Value = '';
                                system.debug(w);
                            }
                            attr[1].Key = 'nss';
                            try{
                                attr[1].Value = ''+cuenta.NSS__c;
                            }catch(Exception w){
                                attr[1].Value = '';
                                system.debug(w);
                            }
                            attr[2].Key = 'tipoRegistro';
                            try{
                                attr[2].Value = ''+mapRecType.get(rt.Name);
                                System.debug('RT NAME: '+mapRecType.get(rt.Name));
                            }catch(Exception w){
                                attr[2].Value = '';
                                system.debug(w);
                            }
                            attr[3].Key = 'tipoCredito';
                            try{
                                attr[3].Value = ''+cuenta.Tipo_Credito__c.toUpperCase();
                            }catch(Exception w){
                                attr[3].Value = '';
                                system.debug(w);
                            }
                            attr[4].Key = 'estatusCuenta';
                            try{
                                attr[4].Value = ''+cuenta.Estatus__c;
                            }catch(Exception w){
                                attr[4].Value = '';
                                system.debug(w);
                            }
                            attr[5].Key = 'fraccionamiento';
                            try{
                                attr[5].Value = ''+fracc.Name.toUpperCase();
                            }catch(Exception w){
                                attr[5].Value = '';
                                system.debug(w);
                            }
                            attr[6].Key = 'origen';
                            try{
                                attr[6].Value = 'Prospección'; //''+cuenta.AccountSource;
                            }catch(Exception w){
                                attr[6].Value = '';
                                system.debug(w);
                            }
                            attr[7].Key = 'prospectador';
                            try{
                                if(usuario.Name.toUpperCase() == null || usuario.Name.toUpperCase() == ''){
                                    attr[7].Value = cuenta.Nombre_pro__c;
                                }else{
                                    attr[7].Value = ''+usuario.Name.toUpperCase();
                                }
                            }catch(Exception w){
                                try{
                                    attr[7].Value = ''+cuenta.Nombre_pro__c;
                                }catch(Exception te){
                                    attr[7].Value = '';
                                }
                                system.debug(w);
                            }
                            attr[8].Key = 'idProspectador';
                            // try{
                            //     if(usuario.Id_Mas_Comercial__c == null || usuario.Id_Mas_Comercial__c == ''){
                            //         attr[8].Value = cuenta.Id_Pro__c;
                            //     }else{
                            //         attr[8].Value = ''+usuario.Id_Mas_Comercial__c;
                            //     }
                            // }catch(Exception w){
                            //     try{
                            //         attr[8].Value = ''+cuenta.Id_pro__c;
                            //     }catch(Exception te){
                            //         attr[8].Value = ''+cuenta.Nombre_Pro__c;
                            //     }
                            //     system.debug(w);
                            // }
                            attr[9].Key = 'fechaProspeccion';
                            try{
                                attr[9].Value = ''+ Datetime.newInstance(cuenta.FechaProspeccion__c.year(), cuenta.FechaProspeccion__c.month(), cuenta.FechaProspeccion__c.day()).format('dd/MM/yyyy');
                            }catch(Exception w){
                                attr[9].Value = '';
                                system.debug(w);
                            }
                            attr[10].Key = 'asesor';
                            try{
                                if(asesor.Name.toUpperCase() == null || asesor.Name.toUpperCase() == '' ){
                                    attr[10].Value = cuenta.Nombre_Ase__c;
                                }else{
                                    // String fedId = asesor.FederationIdentifier.substring(0, asesor.FederationIdentifier.indexOf('@'));
                                    // attr[10].Value = ''+asesor.Name.toUpperCase();
                                    attr[10].Value = ''+ asesor.Name;
                                }
                            }catch(Exception w){
                                try{
                                    attr[10].Value = ''+cuenta.Nombre_Ase__c;
                                }catch(Exception te){
                                    attr[10].Value = '';
                                }
                                system.debug(w);
                            }
                            attr[11].Key = 'idAsesor';
                            attr[11].Value = '';
                            // try{
                            //     if(asesor.Id_Mas_Comercial__c == null || asesor.Id_Mas_Comercial__c == ''){
                            //         attr[11].Value = cuenta.Id_Ase__c;
                            //     }else{
                            //         attr[11].Value = ''+asesor.Id_Mas_Comercial__c;
                            //     }
                            // }catch(Exception w){
                            //     try{
                            //         attr[11].Value = ''+cuenta.Id_Ase__c;
                            //     }catch(Exception te){
                            //         attr[11].Value = '';
                            //     }
                            //     system.debug(w);
                            // }
                            attr[12].Key = 'leadProfilerCheck';
                            // attr[12].Value = 'false';
                            attr[12].Value = '';
                            attr[13].Key = 'colaboradorJaver';
                            try{
                                attr[13].Value = ''+cuenta.Nombre_Colaborador_Javer__c.toUpperCase();
                            }catch(Exception w){
                                attr[13].Value = '';
                                system.debug(w);
                            }
                            attr[14].Key = 'idColaboradorJaver'; 
                            try{
                                attr[14].Value = ''+cuenta.Id_Colaborador_Javer__c;
                            }catch(Exception w){
                                attr[14].Value = '';
                                system.debug(w);
                            }
                            attr[15].Key = 'fechaAsignacion';
                            try{
                                attr[15].Value = ''+Datetime.newInstance(cuenta.FechaAsignacion__c.year(), cuenta.FechaAsignacion__c.month(), cuenta.FechaAsignacion__c.day()).format('dd/MM/yyyy');
                            }catch(Exception w){
                                attr[15].Value = '';
                                system.debug(w);
                            }
                            
                            if(attr[15].Value == ''){
                                attr[15].Value = fechaS;
                            }
                            
                            attr[16].Key = 'canalVenta';
                            try{
                                attr[16].Value = mapCanalVenta.get(cuenta.Canal_de_Venta__c);
                            }catch(Exception w){
                                attr[16].Value = '';
                                system.debug(w);
                            }
                            attr[17].Key = 'subCanalVenta';
                            try{
                                //attr[17].Value = ''+subcanal.Name;
                                attr[17].Value = mapSubCanalVenta.get(cuenta.Sub_canal_de_venta__c);
                            }catch(Exception w){
                                attr[17].Value = '';
                                system.debug(w);
                            }
                            attr[18].Key = 'telefonoCasa';
                            try{
                                attr[18].Value = ''+cuenta.Phone;
                            }catch(Exception w){
                                try{
                                    attr[18].Value = '' + cuenta.Phone;
                                }catch(Exception e){
                                    
                                }
                                attr[18].Value = '';
                                system.debug(w);
                            }
                            attr[19].Key = 'telefonoCelular';
                            try{
                                attr[19].Value = ''+cuenta.TelefonoCelular__c;
                            }catch(Exception w){
                                try{
                                    attr[19].Value = ''+cuenta.TelefonoCelular__c;
                                }catch(Exception e){}
                                attr[19].Value = '';
                                system.debug(w);
                            }
                            attr[20].Key = 'pais';
                            // try{
                            //     attr[20].Value = ''+colonia.Municipio__r.Estado__r.Pais__r.Name;
                                
                            // }catch(Exception w){
                            //     attr[20].Value = '';
                            //     system.debug(w);
                            // }
                            attr[21].Key = 'estado';
                            // try{
                            //     attr[21].Value = ''+colonia.Municipio__r.Estado__r.Name;
                                
                            // }catch(Exception w){
                            //     attr[21].Value = '';
                            //     system.debug(w);
                            // }
                            attr[22].Key = 'municipio';
                            // try{
                            //     attr[22].Value = ''+colonia.Municipio__r.Name;
                                
                            // }catch(Exception w){
                            //     attr[22].Value = '';
                            //     system.debug(w);
                            // }
                            attr[23].Key = 'colonia';
                            // try{
                            //     attr[23].Value = ''+colonia.Name;
                                
                            // }catch(Exception w){
                            //     attr[23].Value = '';
                            //     system.debug(w);
                            // }
                            attr[24].Key = 'calle';
                            // try{
                            //     attr[24].Value = ''+cuenta.Calle__c;
                                
                            // }catch(Exception w){
                            //     attr[24].Value = '';
                            //     system.debug(w);
                            // }
                            attr[25].Key = 'numInterior';
                            // try{
                            //     attr[25].Value = ''+cuenta.NumeroInterior__c;
                            // }catch(Exception w){
                            //     attr[25].Value = '';
                            //     system.debug(w);
                            // }
                            attr[26].Key = 'numExterior';
                            // try{
                            //     attr[26].Value = ''+cuenta.NumeroExterior__c;
                            // }catch(Exception w){
                            //     attr[26].Value = '';
                            //     system.debug(w);
                            // }
                            ///attr[27].Key = 'cp';
                            // try{
                            //     attr[27].Value = ''+colonia.Codigo_Postal__c;
                            // }catch(Exception w){
                            //     attr[27].Value = '';
                            //     system.debug(w);
                            // }
                            attr[27].Key = 'CorreoElectronico';
                            try{
                                attr[27].Value = ''+cuenta.CorreoElectronico__c;
                            }catch(Exception w){
                                attr[27].Value = '';
                                system.debug(w);
                            }

                            attr[28].Key = 'empresaTrabajo';
                            try{
                                attr[28].Value = ''+cuenta.Empresa__c.toUpperCase();
                            }catch(Exception w){
                                attr[28].Value = '';
                                system.debug(w);
                            }
                            attr[29].Key = 'puestoTrabajo';
                            try{
                                attr[29].Value = ''+cuenta.Puesto__c.toUpperCase();
                            }catch(Exception w){
                                attr[29].Value = '';
                                system.debug(w);
                            }
                            attr[30].Key = 'telefonoTrabajo';
                            try{
                                attr[30].Value = ''+cuenta.TelefonoTrabajo__c;
                            }catch(Exception w){
                                try{
                                    attr[30].Value = ''+cuenta.TelefonoTrabajo__c;
                                }catch(Exception e){}
                                attr[30].Value = '';
                                system.debug(w);
                            }
                            attr[31].Key = 'añosTrabajo';
                            try{
                                attr[31].Value = ''+cuenta.anios__c;
                            }catch(Exception w){
                                attr[31].Value = '';
                                system.debug(w);
                            }
                            attr[32].Key = 'mesesTrabajo';
                            try{
                                attr[32].Value = ''+cuenta.Meses__c;
                            }catch(Exception w){
                                attr[32].Value = '';
                                system.debug(w);
                            }
                            attr[33].Key = 'estadoCivil';
                            try{
                                attr[33].Value = ''+mapEstadoCivil.get(cuenta.Estado_Civil__c);
                            }catch(Exception w){
                                attr[33].Value = '';
                                system.debug(w);
                            }
                            attr[34].Key = 'ingresoMensual';
                            try{
                                attr[34].Value = ''+mapIngresosMens.get(cuenta.Ingresos_Mensuales__c);
                            }catch(Exception w){
                                attr[34].Value = '';
                                system.debug(w);
                            }
                            
                            if(attr[34].Value == ''){
                                attr[34].Value = '0 - 3,999';
                            }
                            
                            attr[35].Key = 'depEconomicos';
                            try{
                                attr[35].Value = ''+cuenta.DependientesEconomicos__c;
                            }catch(Exception w){
                                attr[35].Value = '';
                                system.debug(w);
                            }
                            attr[36].Key = 'numHijos';
                            try{
                                attr[36].Value = ''+cuenta.Hijos__c;
                            }catch(Exception w){
                                attr[36].Value = '';
                                system.debug(w);
                            }
                            attr[37].Key = 'sexo';
                            try{
                                attr[37].Value = ''+mapSexo.get(cuenta.Sexo__c);
                            }catch(Exception w){
                                attr[37].Value = '';
                                system.debug(w);
                            }
                            
                            prospecto.DinamicAttributes.Attribute = attr;
                            
                            if(cuenta.Asesor__c != null){
                                
                            }
                            
                            if(cuenta.Prospectador__c != null){
                                
                            }
                            system.debug('***/* Nombre: ' +  prospecto.Nombre);
                            system.debug('***/* ApellidoPaterno: ' +  prospecto.ApellidoPaterno);
                            system.debug('***/* ApellidoMaterno: ' +  prospecto.ApellidoMaterno);
                            system.debug('***/* FechaNacimiento: ' +  prospecto.FechaNacimiento);
                            for(integer y = 0; y < 38; y++){
                                system.debug('KEY: '+ attr[y].Key +' VALOR:' + attr[y].Value);
                                if(attr[y].Value == 'null' || attr[y].Value == null){
                                    attr[y].Value = '';
                                }
                            }
                            mcOb.add(JSON.serialize(prospecto));
                            // if(!prospecto.Nombre.equalsIgnoreCase('CLASETEST')){
                                if(usuario.User_Mas_Comercial__c != null ){
                                    GuardarMasComercialAsync.guardar(mcOb, usuario.User_Mas_Comercial__c);
                                }else{
                                    GuardarMasComercialAsync.guardar(mcOb, asesor.User_Mas_Comercial__c);
                                }
                            // }else{
                            //     GuardarMasComercialAsync.guardar(new List<String>(), 'CLASETEST');
                            // }
                        }
                    }
                }else 
                if(cuenta.RecordTypeId != idre && cuenta.RecordTypeId != idre2 && cuenta.RecordTypeId == idre3){
                    System.debug('RECORDTYPE: '+cuenta.RecordTypeId);
                    if(cuenta.RecordTypeId != null){
                        System.debug('RECORDTYPE: '+cuenta.RecordTypeId);
                        if(cuenta.RecordTypeId != idre && cuenta.RecordTypeId != idre2 && cuenta.RecordTypeId == idre3){
                            system.debug('LAA CUENTA 2: '+cuenta);
                            try{    
                                Entrega__c entrega = [Select Id, Numero_Proceso__c From Entrega__c Where cuenta__c in :Trigger.newMap.keySet()];
                                String NumeroProceso = entrega.Numero_Proceso__c;
                                String FechaHabitibilidad = null; //porque null?
                                String Estatus = null;
                                String FechaEntrega = null;
                                Long TelefonoCasa = null;
                                
                                try{
                                    TelefonoCasa = Long.valueOf(cuenta.Phone);
                                }catch(Exception e){
                                    system.debug(e);
                                }
                                Long TelefonoCelular = null;
                                try{
                                    TelefonoCelular = Long.valueOf(cuenta.TelefonoCelular__c);
                                }catch(Exception p){
                                    system.debug(p);
                                }
                                
                                Long TelefonoOtro = null;
                                
                                try{
                                    TelefonoOtro = Long.valueOf(cuenta.TelefonoOtro__c);
                                }catch(Exception o){
                                    system.debug(o);
                                }
                                
                                Decimal TelefonoRecado = null;
                
                                if(cuenta.TelefonoRecados__c != null){
                                try{
                                    TelefonoRecado = cuenta.TelefonoRecados__c;
                                }catch(Exception e){
                                    system.debug(e);
                                }
                                }else{
                                    TelefonoRecado = null;
                                }
                                
                                String Correo = cuenta.CorreoElectronico__c;
                                Long NumeroCliente = null;
                                
                                System.debug('NumeroProceso : ' + NumeroProceso);
                                System.debug('FechaHabitibilidad : ' + FechaHabitibilidad);
                                System.debug('Estatus : ' + Estatus);
                                System.debug('FechaEntrega : ' + FechaEntrega);
                                System.debug('TelefonoCasa : ' + TelefonoCasa);
                                System.debug('TelefonoCelular : ' + TelefonoCelular);
                                System.debug('TelefonoOtro : ' + TelefonoOtro);
                                System.debug('TelefonoRecado : ' + TelefonoRecado);
                                System.debug('Correo : ' + Correo);
                                if(!Test.isRunningTest()){
                                    UpdateAccountEntrega.guardar(
                                        NumeroProceso,
                                        FechaHabitibilidad,
                                        Estatus,
                                        FechaEntrega,
                                        TelefonoCasa,
                                        TelefonoCelular,
                                        TelefonoOtro,
                                        TelefonoRecado,
                                        Correo,
                                        NumeroCliente);
                                }
                            }catch(Exception e){
                                System.debug(e);
                            }
                        }
                    }
                }
            }
        }
    }
}