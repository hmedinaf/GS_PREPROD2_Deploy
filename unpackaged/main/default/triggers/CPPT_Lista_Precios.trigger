trigger CPPT_Lista_Precios on Pricebook2 (before insert, before update, after insert, after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            map <Integer, String> mapMes = new map <Integer, String> {
                1=>'ENERO',
                2=>'FEBRERO',
                3=>'MARZO',
                4=>'ABRIL',
                5=>'MAYO',
                6=>'JUNIO',
                7=>'JULIO',
                8=>'AGOSTO',
                9=>'SEPTIEMBRE',
                10=>'OCTUBRE',
                11=>'NOVIEMBRE',
                12=>'DICIEMBRE'};

            Id devRecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosByName().get('Vivienda').getRecordTypeId();
            String currentUserId = UserInfo.getUserId();
            //User usr = [SELECT Profile.Name FROM User WHERE Id = :currentUserId];
            String usrProfileName = ''; //usr.Profile.Name;

            id recTypeId;
            Set <Id> fraccs = new Set <Id>();
            for (Pricebook2 p : Trigger.New) {
                fraccs.add(p.Fraccionamiento__c);
                recTypeId = p.RecordTypeId;
            }

            Map <String, Pricebook2> mapFechas = new Map <String, Pricebook2>();
            //Se genara mapa con llave Fraccionamiento|Protitipo prototipo__c, fraccionamiento__c, Vigente_desde__c, Vigente_Hasta__c, isactive
            for (Pricebook2 p : [SELECT Id, Name, Estatus__c,RecordTypeId, Prototipo__c, Fraccionamiento__c, Vigente_desde__c, Vigente_Hasta__c, isactive 
                    FROM Pricebook2 WHERE Fraccionamiento__c in :fraccs AND RecordTypeId = :recTypeId]) {
                mapFechas.put(p.Id, p); //p.RecordTypeId+'|'+p.Fraccionamiento__c+'|'+p.Prototipo__c, p);
            }
            for(Pricebook2 pb : Trigger.New){
                String recordtypename = Schema.SObjectType.Pricebook2.getRecordTypeInfosById().get(pb.RecordTypeId).getname();
                if(recordtypename != 'Producto Genérico'){
                    if ( pb.Vigente_desde__c==null || pb.Vigente_hasta__c==null ) {
                        pb.addError('Campos Vigente Desde y Vigente Hasta deben contener un rango de fechas válido, y deben ser capturados.');
                    }
                    else {
                        Datetime dFechaIni = DateTime.newInstance(pb.Vigente_Desde__c.year(), pb.Vigente_Desde__c.month(), pb.Vigente_Desde__c.day());
                        Datetime dFechaFin = DateTime.newInstance(pb.Vigente_Hasta__c.year(), pb.Vigente_Hasta__c.month(), pb.Vigente_Hasta__c.day());
                        String sFechaIni = dfechaIni.format('yyyy-MM-dd');
                        String sFechaFin = dfechaFin.format('yyyy-MM-dd');
					    pb.Periodo_Inicio__c = mapMes.get(pb.Vigente_Desde__c.month()) +' ' + string.ValueOf(pb.Vigente_Desde__c.year());
                        pb.Periodo_Fin__c = mapMes.get(pb.Vigente_Hasta__c.month()) +' ' + string.ValueOf(pb.Vigente_Hasta__c.year());

                        String fracc = [SELECT Name FROM Fraccionamiento__c WHERE Id =: pb.Fraccionamiento__c LIMIT 1].Name;
                        String proto = [SELECT Name FROM Prototipo__c WHERE Id =: pb.Prototipo__c LIMIT 1].Name;
                        String periodoIni = String.valueOf(pb.Periodo_Inicio__c); //pb.Periodo_Inicio__c.formatGMT('MM/dd/YYYY');
                        String periodoFin = String.valueOf(pb.Periodo_Fin__c); //pb.Periodo_Fin__c.formatGMT('MM/dd/YYYY');

                        // Validar que no hay fechas en el mismo periodo (overlap)
                        // Nueva versión. No soporta bulk
                        Boolean dateOverlap = FALSE;
                        List<Pricebook2> plist = new List<Pricebook2>();
                        RecordType rt = [SELECT ID, Name, developername FROM RecordType where Id =: pb.RecordTypeId];
                        String query = 'SELECT ID, Vigente_Desde__c, Vigente_Hasta__c FROM Pricebook2 WHERE RecordTypeId = \'' +pb.RecordTypeId + '\' AND Fraccionamiento__c = \'' +pb.Fraccionamiento__c + '\' AND Prototipo__c = \'' +pb.Prototipo__c+ '\'';
                        if(rt.developername == 'Financiamiento'){
                            query += ' AND Tipo_de_Financiamiento__c =\''+ pb.Tipo_de_Financiamiento__c+'\'';
                                }
                        system.debug(query);
                        plist = Database.query(query);
                        system.debug('plist'+plist);
                        for (Pricebook2 lprecios : plist) {
                            Date fecha1 = lprecios.Vigente_Desde__c;
                            Date fecha2 = lprecios.Vigente_Hasta__c;
                            system.debug ('*** fecha 1 '+fecha1);
                            system.debug ('*** fecha 2 '+fecha2);
                            system.debug ('*** Dfecha 1 '+dFechaIni);
                            system.debug ('*** Dfecha 2 '+dFechaFin);

                            // if (DateRangeUtils.checkDateRangesOverlap(fecha1, fecha2, dFechaIni.date(), dFechaFin.date())) {
                            //     system.debug('*** overlap: '+fecha1+' '+fecha2);
                            // }
                            dateOverlap = dateOverlap || DateRangeUtils.checkDateRangesOverlap(fecha1, fecha2, dFechaIni.date(), dFechaFin.date());
                        }
                        if (dateOverlap) {
                            pb.addError('Ya existe una Lista de Precios para ese rango de fechas');
                        }



                        if(recordtypename == 'Vivienda'){
                            // pb.Name = 'VIV' + ' ' + fracc + ' ' + proto + ' ' + periodoIni + ' ' + periodoFin;
                            // pb.Nombre_Lista_Validacion__c = 'VIV' + ' ' + fracc + ' ' + proto + ' ' + periodoIni + ' ' + periodoFin;
                            pb.Name = 'VIV' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                            pb.Nombre_Lista_Validacion__c = 'VIV' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                        }else if(recordtypename == 'Financiamiento'){
                            pb.Name = 'FIN' + ' ' + pb.Tipo_de_Financiamiento__c + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                            pb.Nombre_Lista_Validacion__c = 'FIN' + ' ' + pb.Tipo_de_Financiamiento__c + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                        }else if(recordtypename == 'Bonificación'){
                            pb.Name = 'BON' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                            pb.Nombre_Lista_Validacion__c = 'BON' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                        }else if(recordtypename == 'Paquete'){
                            pb.Name = 'PAQ' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                            pb.Nombre_Lista_Validacion__c = 'PAQ' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                        }else if(recordtypename == 'Promoción Venta'){
                            pb.Name = 'PROMVTA' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                            pb.Nombre_Lista_Validacion__c = 'PROMVTA' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                        }else if(recordtypename == 'Regalo MKT'){
                            pb.Name = 'REGMKT' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                            pb.Nombre_Lista_Validacion__c = 'REGMKT' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                        }else if(recordtypename == 'Promoción Precio'){
                            pb.Name = 'PROM $' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                            pb.Nombre_Lista_Validacion__c = 'PROM$' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                        }
                        
                        if(pb.Solicitar_Aprobaci_n__c == true){
                            pb.addError('Antes de solicitar aprobación, favor de guardar la lista de precios');
                        }
                        
                        Date firstDayOfMonth = dFechaIni.date(); //Date.valueOf(pb.Periodo_Inicio__c);
                        Date lastDayOfMonth = dFechaFin.date(); //Date.valueOf(pb.Periodo_Fin__c);
                        System.debug('Mes periodo inicio: ' + firstDayOfMonth.month());
                        System.debug('Año periodo inicio: ' + firstDayOfMonth.year());
                        
                        System.debug('Mes periodo fin: ' + lastDayOfMonth.month());
                        System.debug('Año periodo fin: ' + lastDayOfMonth.year());
                        
                        System.debug('Date.Today().Month(): ' + Date.Today().Month());
                        System.debug('Date.Today().year(): ' + Date.Today().year());
                        System.debug('recordtypename: ' + recordtypename);
                        if(recordtypename == 'Paquete' || recordtypename == 'Promoción Precio' || recordtypename == 'Promoción Venta' || recordtypename == 'Regalo MKT' || recordtypename == 'Bonificación' || recordtypename == 'Vivienda'){
                            if(firstDayOfMonth.month() < Date.Today().Month() && firstDayOfMonth.year() <= Date.Today().year() ) //&& usrProfileName!='AEC' && usrProfileName!='APC')
                            {
                                pb.addError('No se puede seleccionar un periodo inicio anterior a la fecha actual');
                            }else{
                                if(pb.Vigente_Desde__c == null){
                                    pb.Vigente_Desde__c = firstDayOfMonth;
                                }else if(pb.Vigente_Desde__c.month() < Date.Today().Month() && pb.Vigente_Desde__c.year() <= Date.Today().year()) { //&& usrProfileName!='AEC' && usrProfileName!='APC'){
                                    pb.addError('No se puede seleccionar una vigencia inicial anterior a la fecha actual');
                                }
                            }
                            if(lastDayOfMonth.month() < firstDayOfMonth.Month() && lastDayOfMonth.year() <= firstDayOfMonth.year()){ // && usrProfileName!='AEC' && usrProfileName!='APC'){
                                pb.addError('No se puede seleccionar un periodo fin anterior al periodo inicial');
                            }else{
                                if(pb.Vigente_Hasta__c == null){
                                    pb.Vigente_Hasta__c = lastDayOfMonth;
                                }else if(pb.Vigente_Hasta__c.month() < Date.Today().Month() && pb.Vigente_Hasta__c.year() <= Date.Today().year() ){ //&& usrProfileName!='AEC' && usrProfileName!='APC'
                                    pb.addError('No se puede seleccionar una vigencia final anterior a la fecha actual');
                                }
                            }
                            
                            if(pb.Vigente_Hasta__c > lastDayOfMonth){
                                pb.addError('No se puede seleccionar una vigencia final posterior al límite del periodo');
                            }
                        }
                    }
                }
                if(recordtypename == 'Producto Genérico'){
                    pb.Nombre_Lista_Validacion__c = pb.Name;
                    Date hoy = system.today();
                    System.debug('hoy.month(): ' + hoy.month());
                    System.debug('hoy.year(): ' + hoy.year());
                    System.debug('hoy.day(): ' + hoy.day());
                    if(pb.Vigente_Desde__c != null){
                        if(pb.Vigente_Desde__c.month() < hoy.month() && pb.Vigente_Desde__c.year() < hoy.year() && pb.Vigente_Desde__c.day() < hoy.day()){
                            pb.addError('No se puede seleccionar un periodo anterior al día de hoy.');
                        }   
                    }
                }
                
            }
        }if(Trigger.isUpdate){
            id recTypeId;
            Set <Id> fraccs = new Set <Id>();
            for (Pricebook2 p : Trigger.New) {
                fraccs.add(p.Fraccionamiento__c);
                recTypeId = p.RecordTypeId;
            }

            Map <String, Pricebook2> mapFechas = new Map <String, Pricebook2>();
            //Se genera mapa con llave Fraccionamiento|Protitipo prototipo__c, fraccionamiento__c, Vigente_desde__c, Vigente_Hasta__c, isactive
            for (Pricebook2 p : [SELECT Id, Name, Estatus__c,RecordTypeId, Prototipo__c, Fraccionamiento__c, Vigente_desde__c, Vigente_Hasta__c, isactive 
                    FROM Pricebook2 WHERE Fraccionamiento__c in :fraccs AND RecordTypeId = :recTypeId]) {
                mapFechas.put(p.Id, p); //p.RecordTypeId+'|'+p.Fraccionamiento__c+'|'+p.Prototipo__c, p);
            }
            system.debug('*** mapFechas: '+mapFechas);

            map <Integer, String> mapMes = new map <Integer, String> {
                1=>'ENERO',
                2=>'FEBRERO',
                3=>'MARZO',
                4=>'ABRIL',
                5=>'MAYO',
                6=>'JUNIO',
                7=>'JULIO',
                8=>'AGOSTO',
                9=>'SEPTIEMBRE',
                10=>'OCTUBRE',
                11=>'NOVIEMBRE',
                12=>'DICIEMBRE'};


            Id currentUserProfileId = UserInfo.getProfileId();

            //String profileName = [SELECT Name FROM Profile WHERE Id =: currentUserProfileId].Name;
            //System.debug('profileName: + ' + profileName);

            // No soporta bulk
            for(Pricebook2 pb : Trigger.New){
                String recordtypename = Schema.SObjectType.Pricebook2.getRecordTypeInfosById().get(pb.RecordTypeId).getname();
                if(recordtypename != 'Producto Genérico'){
                    Datetime dFechaIni = DateTime.newInstance(pb.Vigente_Desde__c.year(), pb.Vigente_Desde__c.month(), pb.Vigente_Desde__c.day());
                    Datetime dFechaFin = DateTime.newInstance(pb.Vigente_Hasta__c.year(), pb.Vigente_Hasta__c.month(), pb.Vigente_Hasta__c.day());
                    String sFechaIni = dfechaIni.format('yyyy-MM-dd');
                    String sFechaFin = dfechaFin.format('yyyy-MM-dd');

                    pb.Periodo_Inicio__c = mapMes.get(pb.Vigente_Desde__c.month()) +' ' + string.ValueOf(pb.Vigente_Desde__c.year());
                    pb.Periodo_Fin__c = mapMes.get(pb.Vigente_Hasta__c.month()) +' ' + string.ValueOf(pb.Vigente_Hasta__c.year());

                    String fracc = [SELECT Name FROM Fraccionamiento__c WHERE Id =: pb.Fraccionamiento__c LIMIT 1].Name;
                    String proto = [SELECT Name FROM Prototipo__c WHERE Id =: pb.Prototipo__c LIMIT 1].Name;
                    String periodoIni = sFechaIni; //String.valueOf(pb.Periodo_Inicio__c); //pb.Periodo_Inicio__c.formatGMT('MM/dd/YYYY');
                    String periodoFin = sFechaFin; //String.valueOf(pb.Periodo_Fin__c); //pb.Periodo_Fin__c.formatGMT('MM/dd/YYYY');

                    // Validar que no hay fechas en el mismo periodo (overlap)
                    // Nueva versión. No soporta bulk
                    Boolean dateOverlap = FALSE;
                    List<Pricebook2> plist = new List<Pricebook2>();
                    RecordType rt = [SELECT ID, Name, developername FROM RecordType where Id =: pb.RecordTypeId];
                    String query = 'SELECT ID, Vigente_Desde__c, Vigente_Hasta__c FROM Pricebook2 WHERE RecordTypeId = \'' +pb.RecordTypeId + '\' AND Fraccionamiento__c = \'' +pb.Fraccionamiento__c + '\' AND Prototipo__c = \'' +pb.Prototipo__c+ '\'';
                    query += ' AND ID <> \'' + pb.ID + '\'';
                    if(rt.developername == 'Financiamiento'){
                        query += ' AND Tipo_de_Financiamiento__c =\''+ pb.Tipo_de_Financiamiento__c+'\'';
                            }
                    system.debug(query);
                    plist = Database.query(query);
                    system.debug('plist'+plist);
                    for (Pricebook2 lprecios : plist) {
                        Date fecha1 = lprecios.Vigente_Desde__c;
                        Date fecha2 = lprecios.Vigente_Hasta__c;
                        system.debug ('*** fecha 1 '+fecha1);
                        system.debug ('*** fecha 2 '+fecha2);
                        system.debug ('*** Dfecha 1 '+dFechaIni);
                        system.debug ('*** Dfecha 2 '+dFechaFin);

                        dateOverlap = dateOverlap || DateRangeUtils.checkDateRangesOverlap(fecha1, fecha2, dFechaIni.date(), dFechaFin.date());
                    }
                    if (dateOverlap) {
                        pb.addError('Ya existe una Lista de Precios para ese rango de fechas');
                    }

                    if(recordtypename == 'Vivienda'){
                        pb.Name = 'VIV' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                    }else if(recordtypename == 'Financiamiento'){
                        pb.Name = 'FIN' + ' ' + pb.Tipo_de_Financiamiento__c + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                    }else if(recordtypename == 'Bonificación'){
                        pb.Name = 'BON' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                    }else if(recordtypename == 'Paquete'){
                        pb.Name = 'PAQ' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                    }else if(recordtypename == 'Promoción Venta'){
                        pb.Name = 'PROMVTA' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                    }else if(recordtypename == 'Regalo MKT'){
                        pb.Name = 'REGMKT' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                    }else if(recordtypename == 'Promoción Precio'){
                        pb.Name = 'PROM $' + ' ' + fracc + ' ' + proto + ' ' + sFechaIni + ' ' + sFechaFin;
                    }
                    
                    Date firstDayOfMonth = dFechaIni.date(); //Date.valueOf(pb.Periodo_Inicio__c);
                    Date lastDayOfMonth = dFechaFin.date(); //Date.valueOf(pb.Periodo_Fin__c);
                    
                    /* HMF 05/30/23 Esto ya no se va a necesitar: 
                    if(pb.Vigente_Desde__c == null){
                        pb.Vigente_Desde__c = firstDayOfMonth;
                    }
                    
                    if(pb.Vigente_Hasta__c == null){
                        pb.Vigente_Hasta__c = lastDayOfMonth;
                    }
                    
                    if( trigger.oldMap.get(pb.Id).Periodo_Inicio__c != pb.Periodo_Inicio__c){
                         pb.Vigente_Desde__c = firstDayOfMonth;
                    }
                    
                    if( trigger.oldMap.get(pb.Id).Periodo_Fin__c != pb.Periodo_Fin__c){
                         pb.Vigente_Hasta__c = lastDayOfMonth;
                    }
                    
                    if(pb.Vigente_Hasta__c > lastDayOfMonth){
                        pb.addError('No se puede seleccionar una vigencia final posterior al límite del periodo');
                    }
                    HMF fin */
                }
                If(pb.Solicitar_Aprobaci_n__c == true && (trigger.oldMap.get(pb.Id).Estatus__c == 'Aprobado' || 
                                                          trigger.oldMap.get(pb.Id).Estatus__c == 'Por Aprobar')){
                                                              pb.addError('No se puede solicitar aprobación de un registro con el estatus actual');
                                                          }
                //if( profileName != 'APC'){
                If(trigger.oldMap.get(pb.Id).Description != pb.Description || 
                   trigger.oldMap.get(pb.Id).Periodo_Fin__c != pb.Periodo_Fin__c || 
                   trigger.oldMap.get(pb.Id).Periodo_Inicio__c != pb.Periodo_Inicio__c || 
                   trigger.oldMap.get(pb.Id).Vigente_Desde__c != pb.Vigente_Desde__c || 
                   trigger.oldMap.get(pb.Id).Vigente_Hasta__c != pb.Vigente_Hasta__c ||  
                   trigger.oldMap.get(pb.Id).Cantidad__c != pb.Cantidad__c || 
                   trigger.oldMap.get(pb.Id).Ilimitado__c != pb.Ilimitado__c || 
                   trigger.oldMap.get(pb.Id).Fraccionamiento__c != pb.Fraccionamiento__c || 
                   trigger.oldMap.get(pb.Id).Prototipo__c != pb.Prototipo__c || 
                   trigger.oldMap.get(pb.Id).Estatus_Proceso_de_Venta__c != pb.Estatus_Proceso_de_Venta__c || 
                   trigger.oldMap.get(pb.Id).Precio_Min_Solicitado__c != pb.Precio_Min_Solicitado__c ||
                   trigger.oldMap.get(pb.Id).Precio_Min_Autorizado__c != pb.Precio_Min_Autorizado__c){
                       pb.Estatus__c = 'En Progreso';
                       if(recordtypename == 'Promoción Precio'){
                           pb.Estatus_Promocion__c = 'En Progreso';
                       }
                   }
                //}
                /*If((pb.Estatus__c == 'Aprobado' || pb.Estatus__c == 'Rechazado')){
pb.Solicitar_Aprobaci_n__c = false;
}*/
                If(pb.Solicitar_Aprobaci_n__c == true){
                    pb.Estatus__c = 'Por Aprobar';
                    pb.Solicitar_Aprobaci_n__c = false;
                }
                /*If(pb.Solicitar_Aprobaci_n__c == true && pb.Estatus__c == 'Rechazado'){
pb.Estatus__c = 'Por Aprobar';
pb.Solicitar_Aprobaci_n__c = false;
}*/
                if(recordtypename != 'Producto Genérico'){
                    // Date firstDayOfMonth = Date.valueOf(pb.Periodo_Inicio__c);
                    // Date lastDayOfMonth = Date.valueOf(pb.Periodo_Fin__c);
                    // Date firstDayOfMonth = dFechaIni.date(); //Date.valueOf(pb.Periodo_Inicio__c);
                    // Date lastDayOfMonth = dFechaFin.date(); //Date.valueOf(pb.Periodo_Fin__c);

                    // System.debug('Mes periodo inicio: ' + firstDayOfMonth.month());
                    // System.debug('Año periodo inicio: ' + firstDayOfMonth.year());
                    
                    // System.debug('Mes periodo fin: ' + lastDayOfMonth.month());
                    // System.debug('Año periodo fin: ' + lastDayOfMonth.year());
                    
                    // System.debug('Date.Today().Month(): ' + Date.Today().Month());
                    // System.debug('Date.Today().year(): ' + Date.Today().year());
                    // System.debug('recordtypename: ' + recordtypename);
                    /* HMF 05/30 Estas validaciones ya no tienen sentido 
                    if(recordtypename == 'Paquete' || recordtypename == 'Promoción Precio' || recordtypename == 'Promoción Venta' || recordtypename == 'Regalo MKT'){
                        if(firstDayOfMonth.month() < Date.Today().Month() && firstDayOfMonth.year() <= Date.Today().year()){
                            pb.addError('No se puede seleccionar un periodo inicio anterior a la fecha actual');
                        }else{
                            if(pb.Vigente_Desde__c == null){
                                pb.Vigente_Desde__c = firstDayOfMonth;
                            }else if(pb.Vigente_Desde__c.month() < Date.Today().Month() && pb.Vigente_Desde__c.year() <= Date.Today().year() ){
                                pb.addError('No se puede seleccionar una vigencia inicial anterior a la fecha actual');
                            }
                        }
                        if(lastDayOfMonth.month() < firstDayOfMonth.Month() && lastDayOfMonth.year() <= firstDayOfMonth.year()){
                            pb.addError('No se puede seleccionar un periodo fin anterior al periodo inicial');
                        }else{
                            if(pb.Vigente_Hasta__c == null){
                                pb.Vigente_Hasta__c = lastDayOfMonth;
                            }else if(pb.Vigente_Hasta__c.month() < Date.Today().Month() && pb.Vigente_Hasta__c.year() <= Date.Today().year() ){
                                pb.addError('No se puede seleccionar una vigencia final anterior a la fecha actual');
                            }
                        }
                    }
                    HMF Fin commented code */
                }
                // if(recordtypename != 'Producto Genérico'){
                //     if(pb.Vigente_Hasta__c.month() <= pb.Vigente_Desde__c.month() && pb.Vigente_Hasta__c.year() <= pb.Vigente_Desde__c.year() && pb.Vigente_Hasta__c.day() < pb.Vigente_Desde__c.day()){
                //         pb.addError('No se puede seleccionar una vigencia final anterior a la vigencia inicial');
                //     }
                // }
                
                if(recordtypename == 'Producto Genérico'){
                    Date hoy = system.today();
                    System.debug('hoy.month(): ' + hoy.month());
                    System.debug('hoy.year(): ' + hoy.year());
                    System.debug('hoy.day(): ' + hoy.day());
                    System.debug('pb.Vigente_Desde__c.month(): ' + pb.Vigente_Desde__c.month());
                    System.debug('pb.Vigente_Desde__c.year(): ' + pb.Vigente_Desde__c.year());
                    System.debug('pb.Vigente_Desde__c.day(): ' + pb.Vigente_Desde__c.day());
                    // if(pb.Vigente_Desde__c != null){
                    //     if(pb.Vigente_Desde__c < hoy){
                    //         pb.addError('No se puede seleccionar un periodo anterior al día de hoy.');
                    //     }   
                    // }
                }
                
                // if(trigger.oldMap.get(pb.Id).Cantidad__c != pb.Cantidad__c && pb.Cantidad__c != null){
                //     pb.Ilimitado__c = false;
                // }else if(trigger.oldMap.get(pb.Id).Ilimitado__c != pb.Ilimitado__c && pb.Cantidad__c != null){
                //     pb.Cantidad__c = null;
                // }
                
            }
        }
    }if(Trigger.isAfter){
        if(Trigger.isInsert){
            for(Pricebook2 pb : Trigger.New){
                Aprobacion_Lista_de_Precios__c alp = New Aprobacion_Lista_de_Precios__c();
                system.debug('*** pb.Estatus: '+pb.Estatus__c);
                system.debug('*** pb.Id: '+pb.Id);
                alp.Estatus_Aprobaci_n__c = pb.Estatus__c;
                alp.Lista_de_Precios__c = pb.Id;
                
                insert alp;
            }           
        }else if(Trigger.isUpdate){
            set <id> setPricebooks = new Set<Id>();
            for(Pricebook2 pb : Trigger.New){
                setPricebooks.add(pb.Id);
                list <Aprobacion_Lista_de_Precios__c> listAlp = [SELECT Id, Estatus_Aprobaci_n__c, Name FROM Aprobacion_Lista_de_Precios__c WHERE Lista_de_Precios__C =: pb.Id LIMIT 1];
                if (listAlp.size()>0) {
                    Aprobacion_Lista_de_Precios__c alp = listAlp[0];
                    alp.Estatus_Aprobaci_n__c = pb.Estatus__c;
                    update alp;
                }
            }
            /* flow & validation rule bypass pending
            List <Plan_de_Venta__c> lstPlanVenta = [SELECT Id, Name, Oportunidad__c, Subsidio__c, Anticipo__c, Enganche_a_Pagar__c, Plazo__c, Diferencia_a_Pagar__c, 
                    Porcentaje_a_Financiar__c, Valor_de_Operacion__c, Importe_del_Pago__c, Descuento__c, Monto_Descuento__c, Descuento_Empleado_Javer__c, 
                    Precio_Esquina__c, Precio_Frente_Parque__c, Paquetes_Promociones_de_Venta_Duplicadas__c, Condiciones_Pago_Venta_Anticipada__c, Venta_Especial__c, 
                    En_aprovacion__c, En_aprobacion__c, Cantidad_de_reubicaciones__c, Porcentaje_Descuento_Pre_autorizado__c, Descuento_Pre_autorizado_Empleado_Javer__c,
                    Casilla_Descuento_Empleado_Javer__c, Excepcion_Descuento_Empleado_JAVER__c, Financiamiento_Plan_de_Venta__c, VO_menor_a_P_M_nimo_de_Venta__c, 
                    Producto_Bonificacion_menor_a_P_M_nim__c, Fondo_de_Garantia__c, Venta_Anticipada__c, Check_Contrato_Firmado__c, Monto_de_Descuadre_VO__c, 
                    Lista_de_Precios_Vivienda_Reciente__c, Lista_de_Precios_Paquetes_Reciente__c, Reubicacion_Aux__c, Vivienda__c, Manzana__c, Esquina__c, 
                    Sobre_Avenida__c, Frente_Parque__c, Lado_Sol__c, Lado_Sombra__c, Instalaciones__c, Precio_Instalaciones__c, Precio_Sobre_Avenida__c, 
                    Precio_Lado_Sol__c, Precio_Lado_Sombra__c, Direccion_Regional__c, Modificacion_Automatica__c, Reubicacion__c, Estatus__c, Lote__c, 
                    Unidad_Privativa__c, Precio__c, M2_Excedentes__c, Lista_de_Precios_Vivienda__c, Lista_de_Precios_PromocionesV_Reciente__c, 
                    Lista_de_Precios_RegalosMKT_Reciente__c, Lista_de_Precios_Bonificacion_Reciente__c, Lista_de_Precios_Complementos_Reciente__c, 
                    Lista_de_Precios_Otros_Gastos_Reciente__c, Lista_de_Precios_Casa_Muestra_Reciente__c, Ubicacion_Compania__c, Precio_por_m2_exc__c, 
                    Importe_Condiciones_Especiales__c, Terreno_Excedente__c, Precio_Seleccionado__c, Paquetes__c, Regalos_MKT__c, Promociones__c, Complementos__c, 
                    Casa_Muestra__c, Otros_Gastos__c, Lista_de_Precios_Promo_Precio_Reciente__c, Lista_de_Precios_Financiamien_Reciente__c, Precio_Venta_Normal__c, 
                    Precio_Venta_Anticipada__c, Monto_Fin_Autorizado__c, Porcentaje_Fin_Autorizado__c, Representante_Legal__c, Nombre_Compania__c, 
                    Monto_Descuento_Pre_autorizado__c, Clase_de_Bonificacion__c, Bonificacion_Excepcion_de_Plan_de_Venta__c, Bonficacion__c, 
                    Bonificacion_Excepci_n_de_Plan_de_Venta__c, Debug__c, Estatus_Reembolso__c, Nombre_del_Cliente__c, Tipo_de_Cliente__c, Fraccionamiento__c, 
                    Prototipo__c, Plan_de_Venta__c, Tipo_de_Credito_Formula__c, Tipo_de_Financiamiento__c, Precio_Unitario__c, Promocion_de_Precio__c, 
                    Vigencia_desde__c, Vigencia_hasta__c, Precio_minimo_solicitado__c, Fondo_de_Garantia_No_Cubierto__c, Exepcion_Fondo_de_Garantia_Aprobado__c, 
                    Regalos_Mkt2__c, X1_Regalos_MKT2__c, Cantidad_de_Promociones_y_Paquetes__c, Plan_de_Venta_Aprobado__c, Plan_de_Venta_Formalizado__c, 
                    Fecha_Reserva_Real__c, Suma_Total_de_Pagares__c, Fecha_de_creacion__c, Estatus_Promocion_de_Precio_Formula__c, Estatis_Promo_Precio_en_Lista__c, 
                    Tipo__c, Plan_de_Venta_Original__c, Fecha_Reestructura__c, Fecha_Vencimiento_Final_Pagares__c, Plan_de_Venta_TXT__c, 
                    Identificador_de_la_Cuenta__c, Comentarios_Reubicaci_n__c, Estatus_LN__c, Numero_Interno__c, Precio_Area_Municipal__c, 
                    Precio_Superficie_Excedente__c, Area_Municipal__c, Contador_Promo__c, Obra_Fisico__c, Codigo_Estatus_Vivienda__c, Fecha_DTI__c, 
                    Fecha_DTU__c, Fecha_Avaluo__c, Importe_Avaluo__c, Cobranza_Comercial_Reestructura__c, Plan_de_Venta_Hyperlink__c, UEN_APROBACIONES__c, 
                    FlowOverride__c, Cobranza_Comercial__c, Condiciones_Pago_Venta_Anticipada_FLAG__c, Check_Aprobado_Rechazado__c, Producto_Financiero__c, 
                    FormulaEvaluaPlanFinanciera__c, Importe_Descuento__c, trCalc_Monto_Desc_Preautorizado__c, trCalc_Monto_Fin_Autorizado__c, 
                    trCalc_Porcentaje_Fin_Autorizado__c, trCalc_Precio_Area_Municipal__c, trCalc_Precio_Esquina__c, trCalc_Precio_Frente_Parque__c, 
                    trCalc_Precio_Instalaciones__c, trCalc_Precio_Lado_Sol__c, trCalc_Precio_Lado_Sombra__c, trCalc_Precio_Sobre_Avenida__c, 
                    trCalc_Precio_Superficie_Excedente__c, trCalc_Precio_Unitario__c, trCalc_Precio_Venta_Normal__c, trCalc_Precio__c, 
                    trCalc_Precio_minimo_solicitado__c, trCalc_Precio_por_m2_exc__c, Precio_Lista_con_Descuento__c, Precio_Total_Vivenda__c, 
                    Precio_por_m2_exc_PlainField__c, Valor_Operacion_vs_Credito_Neto__c, Importe_Descuento_Empleado_Javer__c, Promocion_de_Precio_monto__c, 
                    Precio_Base_Vivienda__c, Valor_Operacion_Formula__c, Precio_Venta_Anticipada_Monto__c, Requiere_Pagare_Enganche__c, Creditos_mas_Enganche__c, 
                    Compara_VO_Source_Formula__c, Compara_Cred_Eng_Source_Formula__c, Compara_VO_Source_PlainField__c, Compara_Cred_Eng_Source_PlainField__c, 
                    Fraccionamiento_Id_Formula__c, Prototipo_Id_Formula__c, Suma_Total_Pagares_Preventa__c, Diferencia_Engance_vs_Pagares__c, 
                    Cuadra_Enganche_vs_Pagares_Preventa__c, Monto_Total_Casa_Muestra__c, Vivienda_Es_Casa_Muestra__c, Direcci_n_Principal__c
                    FROM Plan_de_Venta__c
                    WHERE Lista_de_Precios_Vivienda_Reciente__c IN :setPricebooks
                    OR Lista_de_Precios_Bonificacion_Reciente__c IN :setPricebooks
                    OR Lista_de_Precios_Financiamien_Reciente__c IN :setPricebooks
                    OR Lista_de_Precios_Vivienda__c IN :setPricebooks];
            system.debug('** count de lista de listas de precios: '+lstPlanVenta.size());
            CLASS_Plan_Venta.CLASS_Calc_Precios (lstPlanVenta);
            */
        }
    }
}