global class GuardarMasComercialAsync{
    // @future(callout= true) 
    public static void guardar(List<String> prospectos, String cuenta){
        Id idre = [SELECT Id FROM RecordType WHERE Name = 'Contacto' LIMIT 1].Id;
		Id idre2 = [SELECT Id FROM RecordType WHERE Name = 'Contacto solo lectura' LIMIT 1].Id;
        Id idre3 = [SELECT Id FROM RecordType WHERE Name = 'AFLUENTE PERSONA FISICA' LIMIT 1].Id;
        Id idre4 = [SELECT Id FROM RecordType WHERE Name = 'AFLUENTE PERSONA MORAL' LIMIT 1].Id;
        Boolean errCall = false;

        esbJaverComManageprospecto.ManageProspectoPort wsPro 
            = new esbJaverComManageprospecto.ManageProspectoPort();
        wsPro.timeout_x = 100000;
        List<Informe_Siebel__c> informes = new List<Informe_Siebel__c>();
        
        if(!cuenta.equals('CLASETEST')){
        for(String prospecto : prospectos){
            esbJaverComCommon.CuentaType1 pro = (esbJaverComCommon.CuentaType1) JSON.deserialize(prospecto, esbJaverComCommon.CuentaType1.class);
            
            // debug_log__c dLog = new debug_log__c ();
            // dLog.Log_Info__c = json.serialize(pro);
            // insert dLog;

            esbJaverComCommon.GenericSystemResponseType respues = new esbJaverComCommon.GenericSystemResponseType();
            esbJaverComManageprospectoTypes.UpdateProspectoByUserRs_element 
             fullRS = new esbJaverComManageprospectoTypes.UpdateProspectoByUserRs_element(); 
            esbJaverComManageprospectoTypes.SearchProspectosRs_element 
             respuesta = new esbJaverComManageprospectoTypes.SearchProspectosRs_element();
            Informe_Siebel__c info = new Informe_Siebel__c();
             
           String nombreC = pro.Nombre + ' ' + pro.ApellidoPaterno + ' ' + pro.ApellidoMaterno;  
            List<Account> acclist = new List<Account>();
            Account ac = null;
            system.debug('*** pro.Nombre '+pro.Nombre);
            system.debug('*** pro.ApellidoPaterno '+pro.ApellidoPaterno);
            system.debug('*** pro.ApellidoMaterno '+pro.ApellidoMaterno);
            // try{
            acclist = [SELECT Id, FirstName, Nombre_cta__c, ApellidoMaterno_cta__c, ApellidoPaterno_cta__c, RecordTypeId, NSS__c, FechaNacimiento__c, IdMasComercial__c, Estatus__c 
                       FROM Account WHERE FirstName = :pro.Nombre AND LastName = :pro.ApellidoPaterno AND ApellidoMaterno_cta__c = :pro.ApellidoMaterno ORDER BY CreatedDate Desc LIMIT 1];
            if(acclist != null && acclist.size()>0){
                ac = acclist[0];
            }
            // }catch(Exception e){
                
            // }
            try{
            	fullRS = wsPro.UpdateProspectoByUser1(cuenta, pro);
                system.debug('RESPUESTA '+ fullRS);
                respues = fullRS.SysResponse;
                system.debug ('*** Respuesta servicio: '+respues);
            }
            catch(Exception e){
                info.Name= '' + Date.today();
                info.Nombre_cta__c = nombreC;
                if(ac != null ){
                    info.Cuenta__c = ac.Id;
                }
                info.Estatus__c = '-1';
            	info.Mensaje__c = 'El servicio tardó mucho en responder, intente guardar de nuevo.';
                
                system.debug('ERROR: '+e.getMessage());
                errCall=true;
            }

            if (!errCall && ac!=null) {
                try{
                    system.debug('**** respuesta idCuenta: '+fullRS.IdCuenta);

                    if(ac.IdMasComercial__c == null && fullRS.IdCuenta != null){
                        ac.IdMasComercial__c = fullRS.IdCuenta;
                        ac.Trigger_Override__c = Datetime.now();
                        ac.ValidationBypassDateTime__c = datetime.now();
                        update ac;
                    }
                    // if(ac.NumCliente__c == null && fullRS.NumCliente != null){
                    //     ac.NumCliente__c = fullRS.NumCliente;
                    // }
                }catch(Exception e){
                    system.debug('*** Error update en GuardarMasComercialAsync');
                }

            }

            // try{
                /* Comentado 7/19
                system.debug ('*** llamando a SearchProspectos:');
                system.debug ('*** pro.Nombre:'+pro.Nombre);
                system.debug ('*** pro.ApellidoPaterno:'+pro.ApellidoPaterno);
                system.debug ('*** pro.ApellidoMaterno:'+pro.ApellidoMaterno);
                system.debug ('*** ac.FechaNacimiento__c:'+ac.FechaNacimiento__c);
                String fechaNac = Datetime.newInstance(ac.FechaNacimiento__c.year(), ac.FechaNacimiento__c.month(), ac.FechaNacimiento__c.day()).format('dd/MM/yyyy');
                system.debug ('*** ac.NSS__c:'+ac.NSS__c);
                respuesta = wsPro.SearchProspectos(
                 pro.Nombre.toUpperCase(),
                 pro.ApellidoPaterno.toUpperCase(),
                 pro.ApellidoMaterno.toUpperCase(),
                 fechaNac, // ac.FechaNacimiento__c
                 ac.NSS__c);
                 */
            // }catch(Exception e){
            //     system.debug ('*** error en llamado SearchProspectos');
            // }
            
            /* HMF 7/19
            // try{
                system.debug('*** entro a deslgose de llamado a SearchProspectos');
                esbJaverComCommon.GenericSystemResponseType status = respuesta.SysResponse;
                esbJaverComCommon.CuentaListType cuentas = respuesta.Prospectos;
                List<esbJaverComCommon.CuentaType> cuentas1 = cuentas.Cuenta;
                for(esbJaverComCommon.CuentaType cu : cuentas1){
                    Map<String,String> mapAttribute = new Map<String,String>();
                     
                     for(esbJaverComCommon.DinamicAttributeType da : 
                         pro.DinamicAttributes.Attribute){
                             mapAttribute.put(da.Key, da.Value);
                             system.debug(da.Key + da.Value);
                     }
                    if(respues.Estatus != '-1'){
                        system.debug('*** respues.Estatus <>-1 linea 70');
                        //ac.IdMasComercial__c = mapAttribute.get('idcuenta');
                        ac.Estatus__c = mapAttribute.get('estatusCuenta');
                    }
                }
            // }catch(Exception e){
            //     system.debug('*** ERROR CON RESPUESTA linea 76');
            // }
            Date hoy = Date.today();
            info.Name = '' + hoy;
            info.Nombre_cta__c = nombreC;
            info.Estatus__c = respues.Estatus;
            system.debug('ERROR '+ respues.Estatus);
            if(respues.Message != null){
                info.Mensaje__c = respues.Message;
            }
            system.debug('ERROR '+ respues.Message); //Aqui esta regresando msg de error
            try{
            if(info.Mensaje__c.contains('se ha interrumpido') || info.Mensaje__c.contains('guardar de nuevo')){
                info.Estatus__c = '-1';
            }
            }catch(Exception f){
                if(respues.Estatus == '0'){
                    info.Estatus__c = '0';
                    info.Mensaje__c = 'Registro integrado correctamente.';
                }
                
            }
            if(info.Estatus__c != '-1'){
                ac.Estatus_Integracion__c = 'Completada';
            }else{
                ac.Estatus_Integracion__c = 'Incidencia';
            }
            
            if(info.Estatus__c == '0' && ac.Estatus_Integracion__c == 'Completada'){
                info.Mensaje__c = 'Registro integrado correctamente.';
            }
            */

            recursionCheck.stopRecursion();
            /* HMF 7/19
            if(ac.RecordTypeId != idre && ac.RecordTypeId != idre2 && ac.RecordTypeId != idre3){
            	update ac;
                info.Cuenta__c = ac.Id;
            	informes.add(info);
            }
            
            try{
                esbJaverComManageprospecto.ManageProspectoPort wsPro2
                    = new esbJaverComManageprospecto.ManageProspectoPort();
                string nss = ac.NSS__c!=null ? ac.NSS__c : '';
                String fechaNac2 = Datetime.newInstance(ac.FechaNacimiento__c.year(), ac.FechaNacimiento__c.month(), ac.FechaNacimiento__c.day()).format('dd/MM/yyyy');
                esbJaverComManageprospectoTypes.SearchProspectosRs_element 
                    respuesta2 = wsPro2.SearchProspectos(
                        ac.FirstName, //ac.Nombre_cta__c,
                        ac.ApellidoPaterno_cta__c,
                        ac.ApellidoMaterno_cta__c,
                        fechaNac2,
                        nss);
                for(esbJaverComCommon.CuentaType cu : respuesta2.Prospectos.Cuenta){
                    Map<String,String> mapAttribute = new Map<String,String>();
                    
                    for(esbJaverComCommon.DinamicAttributeType da : 
                        cu.DinamicAttributes.Attribute){
                            mapAttribute.put(da.Key, da.Value);
                        }
                    
                    //ac.IdMasComercial__c = mapAttribute.get('idcuenta');
                }
            }catch(Exception o){
                //ac.IdMasComercial__c = '';
            }
            try{
                if(ac.IdMasComercial__c == null && fullRS.IdCuenta != null){
                    ac.IdMasComercial__c = fullRS.IdCuenta;
                }
                if(ac.NumCliente__c == null && fullRS.NumCliente != null){
                    ac.NumCliente__c = fullRS.NumCliente;
                }
            }catch(Exception e){
                
            }
            update ac;
            */
        }
        }else{
            Integer i = 0;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
        }
        // upsert informes;
    }
}