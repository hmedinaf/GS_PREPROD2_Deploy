@RestResource(urlMapping='/EnlaceDataSync')
global class EnlaceDataSync {

    @HttpPut
    global static Map<String, String> updateAccount() {
        // Definicion mapas
        Map<String,String> mapEstadoCivil  = new Map<String,String>();
        Map<String,String> mapIngresosMensuales  = new Map<String,String>();
        Map<String,String> mapTelefono  = new Map<String,String>();
        Map<String,String> mapOrigen  = new Map<String,String>();
        Map<String,String> mapCanalVenta  = new Map<String,String>();
        Map<String,String> mapSubCanalVenta  = new Map<String,String>();
    
        mapEstadoCivil.put('Casado','CASADO');
        mapEstadoCivil.put('Divorciado','DIVORCIADO');
        mapEstadoCivil.put('Soltero','SOLTERO');
        mapEstadoCivil.put('Unión Libre','UNION LIBRE');
        mapEstadoCivil.put('Viudo','VIUDO');

        mapIngresosMensuales.put('0 - 3,999','0 - 3,999');
        mapIngresosMensuales.put('4,000 - 7,999','4,000 - 7,999');
        mapIngresosMensuales.put('8,000 - 12,999','8,000 - 12,999');
        mapIngresosMensuales.put('13,000 - 15,999','13,000 - 15,999');
        mapIngresosMensuales.put('16,000 - 19,999','16,000 - 19,999');
        mapIngresosMensuales.put('20,000 - 24,999','20,000 - 24,999');
        mapIngresosMensuales.put('25,000 - 34,999','25,000 - 34,999');
        mapIngresosMensuales.put('35,000 - 44,999','35,000 - 44,999');
        mapIngresosMensuales.put('45,000 - 54,999','45,000 - 54,999');
        mapIngresosMensuales.put('55,000 - 64,999','55,000 - 64,999');
        mapIngresosMensuales.put('65,000 - 74,999','65,000 - 74,999');
        mapIngresosMensuales.put('75,000 - Más','75,000 - MAS');

        mapOrigen.put('Prospecto Asesor','PROSPECTO ASESOR');
        mapOrigen.put('Mercadotecnia','MERCADOTECNIA');
        mapOrigen.put('Afluencia','AFLUENCIA');
        mapOrigen.put('Colaborador JAVER','COLABORADOR JAVER');
        mapOrigen.put('Contacto Telefónico','CONTACTO TELEFONICO');
        mapOrigen.put('Prospección','PROSPECCION');
        mapOrigen.put('SMS','SMS');

        mapCanalVenta.put('Digital Asesor','DIGITAL ASESOR');
        mapCanalVenta.put('Evento','EVENTO');
        mapCanalVenta.put('Llamada Call Center','LLAMADA CALL CENTER');
        mapCanalVenta.put('Medio Publicitario','MEDIO PUBLICITARIO');
        mapCanalVenta.put('Medios Digitales','MEDIOS DIGITALES');
        mapCanalVenta.put('Programas Institucionales','PROGRAMAS INSTITUCIONALES');
        mapCanalVenta.put('Promotor Externo','PROMOTOR EXTERNO');
        mapCanalVenta.put('Prospección','PROSPECCION');
        mapCanalVenta.put('Referidos','REFERIDOS');
        mapCanalVenta.put('Venta Empresarial','VENTA EMPRESARIAL');
        mapCanalVenta.put('Macroventa 2015','MACROVENTA 2015');

        mapSubCanalVenta.put('Activación/Evento','ACTIVACION/EVENTO');
        mapSubCanalVenta.put('Activación/Evento/Periferia','ACTIVACION/EVENTO/PERIFERIA');
        mapSubCanalVenta.put('AGS Feria CANADEVI','AGS FERIA CANADEVI');
        mapSubCanalVenta.put('AGS Moctezuma','AGS MOCTEZUMA');
        mapSubCanalVenta.put('AGS San Diego','AGS SAN DIEGO');
        mapSubCanalVenta.put('Ags Villa Asunción','AGS VILLA ASUNCION');
        mapSubCanalVenta.put('APP INVITADO','APP INVITADO');
        mapSubCanalVenta.put('Buen Fin','BUEN FIN');
        mapSubCanalVenta.put('Call Center / Telemarketing','CALL CENTER/TELEMARKETING');
        mapSubCanalVenta.put('Cambaceo','CAMBACEO');
        mapSubCanalVenta.put('Cartelera Móvil','CARTELERA MOVIL');
        mapSubCanalVenta.put('Cartelera PV','CARTELERA PV');
        mapSubCanalVenta.put('Cartera de Clientes','CARTERA DE CLIENTES');
        mapSubCanalVenta.put('Cartera Propia','CARTERA PROPIA');
        mapSubCanalVenta.put('Cita Asesor','CITA ASESOR');
        mapSubCanalVenta.put('Colaborador Javer','COLABORADOR JAVER');
        mapSubCanalVenta.put('Compañero de Trabajo','COMPAÑERO DE TRABAJO');
        mapSubCanalVenta.put('Convenio Pabellon M','CONVENIO PABELLON M');
        mapSubCanalVenta.put('Correo','CORREO');
        mapSubCanalVenta.put('Correo Directo/Carta','CORREO DIRECTO/CARTA');
        mapSubCanalVenta.put('Edo Mex Samara','EDO MEX SAMARA');
        mapSubCanalVenta.put('En Empresa (Venta Empresarial)','EN EMPRESA (VENTA EMPRESARIAL)');
        mapSubCanalVenta.put('Espectacular/Cartelera','ESPECTACULAR/CARTELERA');
        mapSubCanalVenta.put('Eventos (Macroventa, Súpervta)','EVENTO (MACROVENTA, SUPERVTA)');
        mapSubCanalVenta.put('Expo/Feria','EXPO/FERIA');
        mapSubCanalVenta.put('Facebook','FACEBOOK');
        mapSubCanalVenta.put('Facebook Inbox','FACEBOOK INBOX');
        mapSubCanalVenta.put('Familiar','FAMILIAR');
        mapSubCanalVenta.put('FB Asesor Orgánico','FB ASESOR ORGANICO');
        mapSubCanalVenta.put('FB Asesor Pagado por Asesor','FB ASESOR PAGADO POR ASESOR');
        mapSubCanalVenta.put('FB Asesor Pagado por Javer','FB ASESOR PAGADO POR JAVER');
        mapSubCanalVenta.put('Feria Revolución CDMX','FERIA REVOLUCION CDMX');
        mapSubCanalVenta.put('Feria Zocalo D.F.','FERIA ZOCALO DF');
        mapSubCanalVenta.put('Flyer/Volante','FLYER/VOLANTE');
        mapSubCanalVenta.put('Google','GOOGLE');
        mapSubCanalVenta.put('Imagen en PV','IMAGEN EN PV');
        mapSubCanalVenta.put('Inbound','INBOUND');
        mapSubCanalVenta.put('Instagram','INSTAGRAM');
        mapSubCanalVenta.put('Internet','INTERNET');
        mapSubCanalVenta.put('Internet / Página Web','INTERNET/PAGINA WEB');
        mapSubCanalVenta.put('Invitación del Asesor','INVITACION DEL ASESOR');
        mapSubCanalVenta.put('Isla Paseo Queretaro','ISLA PASEO QUERETARO');
        mapSubCanalVenta.put('Javermóvil','JAVERMOVIL');
        mapSubCanalVenta.put('LinkedIn','LINKEDIN');
        mapSubCanalVenta.put('Llamada callcenter','LLAMADA CALLCENTER');
        mapSubCanalVenta.put('Loneros','LONEROS');
        mapSubCanalVenta.put('Mailing','MAILING');
        mapSubCanalVenta.put('Marcacion Corta','MARCACION CORTA');
        mapSubCanalVenta.put('Micrositio Asesor','MICROSITIO ASESOR');
        mapSubCanalVenta.put('Micrositios','MICROSITIOS');
        mapSubCanalVenta.put('Modulo en Punto Estratégico','MODULO EN PUNTO ESTRATEGICO');
        mapSubCanalVenta.put('Módulo pagado en Punto Estratégico','MODULO PAGADO EN PUNTO ESTRATE');
        mapSubCanalVenta.put('Otros Creditos','OTROS CREDITOS');
        mapSubCanalVenta.put('Página de Internet','PAGINA DE INTERNET');
        mapSubCanalVenta.put('Pagina web Javer','PAGINA WEB JAVER');
        mapSubCanalVenta.put('Pasaba por aquí','PASABA POR AQUI');
        mapSubCanalVenta.put('Periferia','PERIFERIA');
        mapSubCanalVenta.put('Periódico','PERIODICO');
        mapSubCanalVenta.put('Podcast','PODCAST');
        mapSubCanalVenta.put('Port. Inmobiliario/Trato Direc','PORT. INMOBILIARIO/TRATO DIREC');
        mapSubCanalVenta.put('Portales Inmobiliarios','PORTALES INMOBILIARIOS');
        mapSubCanalVenta.put('Portal Inmobiliario','PORTAL INMOBILIARIO');
        mapSubCanalVenta.put('Port. Inmobiliario/Trato Direc','PORT INMOBILIARIO/TRATO DIREC');
        mapSubCanalVenta.put('Póster','POSTER');
        mapSubCanalVenta.put('Prensa','PRENSA');
        mapSubCanalVenta.put('Prensa/Revista','PRENSA/REVISTA');
        mapSubCanalVenta.put('Prospección','PROSPECCION');
        mapSubCanalVenta.put('Publicidad en Autobuses','PUBLICIDAD EN AUTOBUSES');
        mapSubCanalVenta.put('QIR Tianguis','QIR TIANGUIS');
        mapSubCanalVenta.put('Radio','RADIO');
        mapSubCanalVenta.put('Recomienda y Gana','RECOMIENDA Y GANA');
        mapSubCanalVenta.put('Referido','REFERIDO');
        mapSubCanalVenta.put('Referido/Recomendación','REFERIDO/RECOMENDACION');
        mapSubCanalVenta.put('Señalizacion','SEÑALIZACION');
        mapSubCanalVenta.put('Señalizacion Humana','SEÑALIZACION HUMANA');
        mapSubCanalVenta.put('Telemarketing','TELEMARKETING');
        mapSubCanalVenta.put('Televisión','TELEVISION');
        mapSubCanalVenta.put('Twitter','TWITTER');
        mapSubCanalVenta.put('Vecino','VECINO');
        mapSubCanalVenta.put('Volante','VOLANTE');
        mapSubCanalVenta.put('Whatsapp','WHATSAPP');
        mapSubCanalVenta.put('Youtube','YOUTUBE');
        mapSubCanalVenta.put('1-2GUPNA8','1-2GUPNA8');
        mapSubCanalVenta.put('Prensa / Revista','PRENSA / REVISTA');
        mapSubCanalVenta.put('Promotor Ext Dig/A.JLUNA','PROMOTOR EXT DIG/A.JLUNA');
        mapSubCanalVenta.put('Promotor Ext Dig/A.MAYO','PROMOTOR EXT DIG/A.MAYO');
        mapSubCanalVenta.put('Promotor Ext Dig/P.ICJASA','PROMOTOR EXT DIG/P.ICJASA');
        mapSubCanalVenta.put('Prospeccion Digital','PROSPECCION DIGITAL');
        mapSubCanalVenta.put('Señalización','SEÑALIZACION');
        mapSubCanalVenta.put('Tiktok','TIKTOK');
        mapSubCanalVenta.put('Twitter','TWITTER');
        mapSubCanalVenta.put('Venta Empresarial','VENTA EMPRESARIAL');
        mapSubCanalVenta.put('Y01','Y01');

        // Mapas de OwnerIDs y Fraccionamientos
        Map <String, Id> mapUsers = new Map <String, Id>();
        Map <String, String> mapFracc = new Map <String, String>();
        // Map <String, String> mapRecType = new Map <String, String>();

        for (User u : [SELECT Id, FirstName, LastName FROM User WHERE IsActive=TRUE]) {
            mapUsers.put(u.FirstName+' '+u.LastName, u.Id);
        }
        for (Fraccionamiento__c f : [SELECT Id, Name FROM Fraccionamiento__c]) {
            mapFracc.put(f.Name, f.Id);
        }

        // *HMF* Para UATs o PROD cambiar esto a obtener el alias como la parte izquierda de la arroba del user o email
        Map <String, String> mapAsesor = new Map <String, String>();
        for (User u : [SELECT Id, Alias FROM USER WHERE IsActive = TRUE]) {
            mapAsesor.put(u.Alias, u.Id);
        }

        Map <String, String> mapColaborador = new Map <String, String>();
        for (Colaborador_Javer__c c : [SELECT Id, Name, Usuario_Colaborador_Javer__c FROM Colaborador_Javer__c]) {
            if (c.Usuario_Colaborador_Javer__c != null) {
                String alias = c.Usuario_Colaborador_Javer__c.substringBefore('@');
                mapColaborador.put(alias, c.Id);
            }
        }
        system.debug('*** mapColaborador: '+mapColaborador);
        // for (RecordType r : [SELECT Id,Name FROM RecordType WHERE SobjectType = 'Account' AND IsActive=TRUE]){
        //     mapRecType.put(r.Name, r.Id);
        // }

        RestRequest req = RestContext.request;
        String requestBody = req.requestBody.toString();
        
        WrapperClass jData = (WrapperClass)JSON.deserialize(requestBody, WrapperClass.class);
        system.debug(jData);

        system.debug('Nombre: ' + jData.Nombre);
        system.debug('*** Materno: '+jData.ApellidoMaterno);
        String idCuenta = jData.idCuenta;
        String Nombre =  jData.Nombre+'%';
        String Paterno = jData.ApellidoPaterno+'%';
        String Materno = jData.ApellidoMaterno+'%';
        Date FechaNac = date.parse(jData.FechaNacimiento);

        try {
            // Find the account to update
            system.debug('*** buscando cuenta');
            List <Account> lAccUpd = [SELECT Id, OwnerId,Nombre__c,Apellidopaterno_cta__c,Apellidomaterno_cta__c,FechaNacimiento__c,AccountNumber,NSS__c,
                RecordTypeName__c,Tipo_Credito__c,JMC_Estatus_Cuenta__c,Fraccionamiento_cta__c,Origen__c,Prospectador__c,FechaProspeccion__c,Asesor__c,
                Lead_Profiler__c,Nombre_Colaborador_Javer__c,FechaAsignacion__c,CanalVenta__c,SubCanalVenta__c,Telefono_Principal__c,TelefonoCelular__c,
                Tipo_de_Direccion__c,Pais_cta__c,Estado_cta__c,Municipiocta__c,Colonia_cta__c,Calle__c,NumeroInterior__c,NumeroExterior__c,BillingPostalCode,
                Empresa__c,Puesto__c,TelefonoTrabajo__c,Estado_Civil__c,Ingresos_Mensuales__c,DependientesEconomicos__c,Hijos__c,Sexo__c,Correlect_cta__c,
                Fecha_Notificacion_Vencimiento_Asesor__c
            FROM Account
            WHERE // ID = :idCuenta // for testing purposes (remove)
                Nombre__c LIKE :Nombre
            AND Apellidopaterno_cta__c LIKE :Paterno
            AND Apellidomaterno_cta__c LIKE :Materno
            AND FechaNacimiento__c = :FechaNac
            LIMIT 1
            ];

            if (lAccUpd.size()==0) {
                 Map<String, String> jsonResp = new Map<String, String> {
                	'code' => '1001',
                	'message' => 'Cuenta no encontrada'
            	};
            	return jsonResp;
            }
                
            Account accUpd = lAccUpd[0];
            
            // Update the fields
            // accUpd.OwnerId = mapUsers.get(jData.User);
            // accUpd.FechaNacimiento__c = date.parse(jData.FechaNacimiento);
            accUpd.AccountNumber = jData.idcuenta;
            accUpd.NSS__c = jData.nss;
            //accUpd.RecordTypeName__c = mapRecType.get(jData.tipoRegistro);
            accUpd.Tipo_Credito__c = jData.tipoCredito.toUpperCase(); // ok
            accUpd.JMC_Estatus_Cuenta__c = jData.estatusCuenta;
            if (mapFracc.get(jData.fraccionamiento)!= null) {
                accUpd.Fraccionamiento_cta__c = mapFracc.get(jData.fraccionamiento);
            }
            if (mapOrigen.get(jData.origen)!=null) accUpd.Origen__c = mapOrigen.get(jData.origen);
            if (accUpd.Prospectador__c != mapUsers.get(jData.prospectador)) {
                accUpd.Prospectador__c = mapUsers.get(jData.prospectador);
                system.debug('Prospectador: '+accUpd.Prospectador__c);
            } else {
                system.debug('*** SIN CAMBIO EN PROSPECTADOR ***');
            }
            if (accUpd.Asesor__c != mapUsers.get(jData.asesor)) {
                accUpd.Asesor__c = mapUsers.get(jData.asesor); // Map OK
            }
            //accUpd.Prospectador__c = jData.idProspectador;
            // accUpd.Asesor__c = jData.idAsesor;
            // accUpd.Lead_Profiler__c = jData.leadProfilerCheck=='' ? null : mapUsers.get(jData.leadProfilerCheck); // 05.03.23 no se requiere

            accUpd.Nombre_Colaborador_Javer__c = jData.colaboradorJaver;
            if (mapColaborador.get(jData.colaboradorJaver)!=null) {
                accUpd.Colaborador_Javer__c = mapColaborador.get(jData.colaboradorJaver);
            }
            accUpd.FechaAsignacion__c = date.parse(jData.fechaAsignacion);
            if (mapCanalVenta.get(jData.canalVenta) != null) {
                accUpd.Canal_de_Venta__c = mapCanalVenta.get(jData.canalVenta);
                system.debug('*** MapCanalVenta: '+accUpd.Canal_de_Venta__c);
            }
            if (mapSubCanalVenta.get(jData.subCanalVenta) != null) {
                accUpd.Sub_canal_de_venta__c = mapSubCanalVenta.get(jData.subCanalVenta);
            }
            accUpd.Telefono_Principal__c = 'TELEFONO CASA';
            accUpd.Phone = jData.telefonoCasa;
            accUpd.TelefonoCelular__c = jData.telefonoCelular;
            accUpd.Tipo_de_Direccion__c = jData.tipoDireccion;
            accUpd.BillingCountry = jData.pais=='' ? null : jData.pais;
            accUpd.BillingState = jData.estado;
            // accUpd.Municipiocta__c = jData.municipio;
            // accUpd.Colonia_cta__c = jData.colonia;
            accUpd.BillingStreet = jData.calle+' '+jData.numExterior+' - '+jData.numInterior;
            // accUpd.NumeroInterior__c = jData.numInterior;
            // accUpd.NumeroExterior__c = jData.numExterior;
            accUpd.BillingPostalCode = jData.cp;
            accUpd.Empresa__c = jData.empresaTrabajo; // ok
            accUpd.Puesto__c = jData.puestoTrabajo; // ok
            accUpd.TelefonoTrabajo__c = jData.telefonoTrabajo; // ok
            accUpd.Estado_Civil__c = jData.estadoCivil.toUpperCase();
            accUpd.Ingresos_Mensuales__c = jData.ingresoMensual; // ok
            accUpd.DependientesEconomicos__c = Decimal.valueOf(jData.depEconomicos); // ok
            accUpd.Hijos__c = Decimal.valueOf(jData.numHijos);
            accUpd.Sexo__c = jData.sexo.toUppercase();
            accUpd.Correlect_cta__c = jData.CorreoElectronico;

            //accUpd.Fecha_Notificacion_Vencimiento_Asesor__c = date.parse(jData.FechaVencimiento);
            
            // Update the account
            update accUpd;

            //return 'Account updated successfully';
            Map<String, String> jsonResp = new Map<String, String> {
                'code' => '200',
                'message' => 'Cuenta Actualizada Correctamente'
            };
            return jsonResp;
            
        } catch(Exception e) {
            // Return an error message if an exception is caught
            Map<String, String> jsonResp = new Map<String, String>()    ;

            if (e.getMessage() == 'Error: List has no rows for assignment to SObject') {
                jsonResp.put('code', '1001');
                jsonResp.put('message', 'Cuenta no encontrada.');
            } 
            else {
                jsonResp.put('code', '1002');
                jsonResp.put('message', 'Error: ' + e.getMessage());
            }
            return jsonResp;
        }
    }

    private Class WrapperClass{
        String User;
        String Nombre;
        String ApellidoPaterno;
        String ApellidoMaterno;
        String FechaNacimiento;
        String idcuenta;
        String nss;
        String tipoRegistro;
        String tipoCredito;
        String estatusCuenta;
        String fraccionamiento;
        String origen;
        String prospectador;
        String idProspectador;
        String fechaProspeccion;
        String asesor;
        String idAsesor;
        String leadProfilerCheck;
        String colaboradorJaver;
        // String idColaboradorJaver;
        String fechaAsignacion;
        String canalVenta;
        String subCanalVenta;
        String telefonoCasa;
        String telefonoCelular;
        String tipoDireccion;
        String pais;
        String estado;
        String municipio;
        String colonia;
        String calle;
        String numInterior;
        String numExterior;
        String cp;
        String empresaTrabajo;
        String puestoTrabajo;
        String telefonoTrabajo;
        String aniosTrabajo;
        String mesesTrabajo;
        String estadoCivil;
        String ingresoMensual;
        String depEconomicos;
        String numHijos;
        String sexo;
        String Perfil;
        String EjecutivoVenta;
        String CorreoElectronico;
        String FechaVencimiento;
        String DiasVencimiento;
        String asignacion_Tipo;
        String asignacion_Nombre;
        String asignacion_Login;
        String asignacion_Fraccionamiento;
        String asignacion_FechaVigencia;
        String procesoVenta_Venta; //quitarlo
        String procesoVenta_EstadoVenta; //quitarlo
        String comment_AccountId;
        String comment_commentId;
        String comment_NombreCreadoPor;
        String comment_FechaCreacion;
        String comment_HoraCreacion;
        String comment_TipoNota;
        String comment_Nota;
        String comment_Tipo;
        String comment_Area;
        String comment_SubArea;
        String comment_Privado;
    }
}