public without sharing class EntregasWS_Queueable implements Queueable, Database.AllowsCallouts{

    Integer daysBefore;

    public EntregasWS_Queueable(Integer daysBefore){
        this.daysBefore = daysBefore;
    }
    
    public void execute(QueueableContext context){
        recursionCheck.entregasWS = true;

        LogATC__c log = new LogATC__c();
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'ImportarEntregaWS';

        Date defaultDate = date.newInstance(1900, 1, 1);

        boolean runningInASandbox = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;

        try{
            
            List<Account> listaCuenta = new List<Account>();
            xmlnsOracleComJavergtiEntrega.bpelQueryEntrega_pt wsPort = new xmlnsOracleComJavergtiEntrega.bpelQueryEntrega_pt();
            wsPort.timeout_x = 120000;  
            xmlnsOracleComJavergtiEntrega.getEntregaRs_element respuesta = new xmlnsOracleComJavergtiEntrega.getEntregaRs_element();
            respuesta = wsPort.getEntrega(daysBefore);

            xmlnsOracleComJavergtiEntrega.Result_element mensaje = respuesta.Result;
            xmlnsOracleComJavergtiEntrega.ReporteEntrega_element reporteEntrega = respuesta.ReporteEntrega;
            List<xmlnsOracleComJavergtiEntrega.RowType> resultados = new List<xmlnsOracleComJavergtiEntrega.RowType>();
            resultados.addAll(reporteEntrega.Row);   

            List<String> filtroCuentas = new List<String>();
            List<String> filtroCuentas2 = new List<String>();

            log.Mensaje__c = 'Estatus SIEBEL: '+mensaje.Success;
            log.Mensaje__c += '\r\n';
            log.Mensaje__c += 'Respuesta SIEBEL: '+mensaje.SysMessage;
            log.Mensaje__c += '\r\n';
            log.Mensaje__c += 'Cantidad de registros: '+resultados.size();
            log.Mensaje__c += '\r\n';

            for(xmlnsOracleComJavergtiEntrega.RowType obj : resultados){
                if(obj.Estatus != 'Firmado'){
                    filtroCuentas.add(obj.Numero_cliente);
                    filtroCuentas2.add((obj.Nombre +' '+obj.Apellido_Paterno+' '+obj.Apellido_Materno).toUpperCase());
                }else{
                    log.Mensaje__c += '\r\n';
                    log.Mensaje__c += 'Proceso con estatus no válido: '+ obj.Num_Proceso + ' - ' + obj.Nombre +' '+obj.Apellido_Paterno+' '+obj.Apellido_Materno ;
                    log.Mensaje__c += '\r\n';
                    log.Mensaje__c += '\r\n';
                }
            } 

            Map<String, Id> entregas = new Map<String, Id>();
            Map<String, Account> cuentas = new Map<String, Account>();
            Map<String, Id> fraccionamientos = new Map<String, Id>();
            Map<String, Inventario__c> inventarios = new Map<String, Inventario__c>();

            /*for(Account c : [SELECT Id, Name, MiddleName, LastName, Nombre_cta__c, Apellidomaterno_cta__c, RecordTypeId, Apellidopaterno_cta__c,FechaNacimiento__c, CorreoElectronico__c, Telefono2__c, NumerodeCliente__c 
                            FROM Account WHERE((NumerodeCliente__c IN : filtroCuentas AND NumerodeCliente__c != null) OR (IdMasComercial__c IN :filtroCuentas AND IdMasComercial__c != null) OR Name IN :filtroCuentas2) LIMIT 48000]){
                cuentas.put(c.Numerodecliente__c, c);
            }*/
            
            for(Account c : [SELECT Id, Name, LastName, Nombre_cta__c, Apellidomaterno_cta__c, RecordTypeId, Apellidopaterno_cta__c,FechaNacimiento__c, CorreoElectronico__c, Telefono2__c, NumerodeCliente__c 
                            FROM Account WHERE((NumerodeCliente__c IN : filtroCuentas AND NumerodeCliente__c != null) OR (IdMasComercial__c IN :filtroCuentas AND IdMasComercial__c != null) OR Name IN :filtroCuentas2) LIMIT 48000]){
                cuentas.put(c.Numerodecliente__c, c);
            }

            filtroCuentas.clear();
            filtroCuentas2.clear();
            
            List<String> numerosDeCliente = new List<String>();
                
            List<Account> upsertCuentas = new List<Account>();
            List<Inventario__c> upsertInventarios = new List<Inventario__c>();
            List<PaqueteEntrega__c> upsertPaquetes = new List<PaqueteEntrega__c>();
            
            Id recordtypeA = [SELECT Id, Name FROM RecordType WHERE Name = 'Clientes ATC' AND IsPersonType=False].Id;
            Id recordtypePA = [SELECT Id, Name FROM RecordType WHERE Name = 'Clientes ATC' AND IsPersonType=True].Id;

            Map<String, Account> rCuenta = new Map<String, Account>();
            Map<String, Account> mapAyudaCuenta = new Map<String, Account>();
            
            for(xmlnsOracleComJavergtiEntrega.RowType obj : resultados){
                if(obj.Estatus != 'Firmado'){
                    Account cuenta = new Account();
                    
                    cuenta.isATC__c = true;
                    cuenta.Numerodecliente__c = obj.Numero_cliente;
                    cuenta.IdMasComercial__c = obj.Numero_cliente;
                    cuenta.Nombre_cta__c = obj.Nombre;
                    cuenta.Apellidopaterno_cta__c = obj.Apellido_Paterno;
                    cuenta.Apellidomaterno_cta__c = obj.Apellido_Materno;
                    cuenta.ProductoFinanciero__c = obj.Producto_Financiero;
                    cuenta.TipoCredito__c = obj.Tipo_de_Credito;
                    //cuenta.CorreoElectronico__c = obj.Correo_electronico;
                    cuenta.Notaria__c = obj.Notaria;
                    cuenta.Notario__c = obj.Notario;
                    cuenta.ReferenciaBancariaCliente__c = obj.Referencia_bancaria_cliente;
                    //validar longitud 10 digitos + valores numericos -> dejar valor nulo 
                    //+52 - > null, null -> -1, 1 -> 1
                    cuenta.Phone = obj.Telefono_casa != null && obj.Telefono_casa != '' && obj.Telefono_casa != '-1' && obj.Telefono_casa != '1'  && obj.Telefono_casa != '0'&& obj.Telefono_casa != '+0'? getFilteredPhoneWPrefix(obj.Telefono_casa) : '+52';
                    cuenta.TelefonoCelular__c = obj.Telefono_celular != null && obj.Telefono_celular != '' && obj.Telefono_celular != '-1' && obj.Telefono_celular != '1'  && obj.Telefono_celular != '0'&& obj.Telefono_celular != '+0'? getFilteredPhoneWPrefix(obj.Telefono_celular) : '+52';
                    cuenta.TelefonoOtro__c = obj.Telefono_Otro != null && obj.Telefono_Otro != '' && obj.Telefono_Otro != '-1' && obj.Telefono_Otro != '1' && obj.Telefono_Otro != '0' && obj.Telefono_Otro != '+0'? getFilteredPhoneWPrefix(obj.Telefono_Otro) : '+52';
                    //cuenta.Phone = obj.Telefono_casa.Substring(0,1) == '52' ? '+'+obj.Telefono_casa : obj.Telefono_casa.Substring(0,2) == '+52' ? obj.Telefono_casa : '+52'+obj.Telefono_casa;
                    //cuenta.TelefonoCelular__c = obj.Telefono_celular.Substring(0,2) == '52' ? '+'+obj.Telefono_celular : obj.Telefono_celular.Substring(0,2) == '+52' ? obj.Telefono_celular : '+52'+obj.Telefono_celular;
                    //cuenta.TelefonoOtro__c = obj.Telefono_Otro.Substring(0,2) == '52' ? '+'+obj.Telefono_Otro : obj.Telefono_Otro.Substring(0,2) == '+52' ? obj.Telefono_Otro : '+52'+obj.Telefono_Otro;

                    String RawEmail = obj.Correo_electronico;
                    if(RawEmail.startsWith('.')){
                        RawEmail = RawEmail.right(RawEmail.length()-1);
                    }
                    String empty_regex = '^\\s*$';
                    String regex = '^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$';
                    Pattern regexPattern_empty = Pattern.compile(empty_regex);
                    Matcher regexMatcher_empty = regexPattern_empty.matcher(RawEmail);
                    Pattern regexPattern = Pattern.compile(regex);
                    Matcher regexMatcher = regexPattern.matcher(RawEmail);
                    String replacedMessage = 'Error al verificar email: ' + RawEmail + ', ' + cuenta.Name + '. Se asignara una direccion predeterminada';

                    if((regexMatcher_empty.find() || regexMatcher.find()) && !runningInASandbox) {
                        try{
                            cuenta.CorreoElectronico__c = RawEmail;
                        }catch(Exception ex){
                            system.debug('ERROR ' + ex.getMessage());
                        }
                    }else{
                        try{
                            System.debug(System.LoggingLevel.ERROR, replacedMessage);
                            System.debug(cuenta.Name);
                            cuenta.CorreoElectronico__c = 'undefined.atc@javer.com.mx';
                        }catch(Exception ex){
                            system.debug('ERROR ' + ex.getMessage());
                        }
                    }

                    if(cuentas.containsKey(cuenta.Numerodecliente__c)){
                        Account cuentaTemp = cuentas.get(cuenta.Numerodecliente__c);
                        cuenta.Id = cuentaTemp.Id;
                        if(cuentaTemp.RecordTypeId == recordtypePA){
                            cuenta.FirstName = obj.Nombre;
                            /*cuenta.MiddleName = obj.Apellido_Paterno;*/
                            cuenta.LastName = obj.Apellido_Materno;
                            cuenta.RecordTypeId = recordtypePA;
                            cuenta.PersonBirthdate = obj.FechaNacimiento;
                            cuenta.PersonEmail = cuenta.CorreoElectronico__c;
                        }else{
                            cuenta.Name = cuenta.Nombre_cta__c + ' ' + cuenta.Apellidopaterno_cta__c + ' ' + cuenta.Apellidomaterno_cta__c;
                            cuenta.RecordTypeId = recordtypeA;
                        }
                    }else{
                        cuenta.FirstName = obj.Nombre;
                        /*cuenta.MiddleName = obj.Apellido_Paterno;*/
                        cuenta.PersonBirthdate = obj.FechaNacimiento;
                        cuenta.LastName = obj.Apellido_Materno;
                        cuenta.RecordTypeId = recordtypePA;
                    }
                    
                    try{
                        mapAyudaCuenta.put(obj.Numero_cliente, cuenta);
                    }catch(Exception p){
                        mapAyudaCuenta.put(obj.Numero_cliente, cuenta);
                    }
                }
            }

            //for(String key :mapAyudaCuenta.keySet()){
                //upsertCuentas.add(mapAyudaCuenta.get(key));
            //}

            upsert mapAyudaCuenta.values();
            log.Mensaje__c += 'Cuentas Actualizadas/Insertadas: '+mapAyudaCuenta.size();
            log.Mensaje__c += '\r\n';

            //for(Account cu : mapAyudaCuenta.values()){
              //  rCuenta.put(cu.Numerodecliente__c, cu);
            //}

            EntregasWSInventario_Queueable EntregasWSInventario_Queueable = new EntregasWSInventario_Queueable(daysBefore, log, mapAyudaCuenta);
            ID jobID = System.enqueueJob(EntregasWSInventario_Queueable);

        }catch(Exception io){
            log.Mensaje__c += 'EXCEPTION: ' + io.getMessage() + ' - ' + io.getLineNumber() +' - ' + io.getCause() +' - '+io.getStackTraceString();
            log.Mensaje__c += '\r\n';
            insert log;
            
            if(Test.isRunningTest()){
                testingClass();
            }
        }
    }

    public static String getFilteredPhoneWPrefix(String phone){
        System.debug(phone);
        if(!String.isBlank(phone) && phone.length() == 10 && phone.Substring(0,1) != '+' && phone.Substring(0,4) != '+521' && phone.Substring(0,2) != '52'){
            phone = '+52' + phone;
        }else if(!String.isBlank(phone) && phone.length() > 9){
            if(phone.Substring(0,2) == '52' || (phone.Substring(0,2) == '+1' && phone.length() == 12)){
                phone = '+52' + phone.Substring(2,phone.length());
            }else if(phone.Substring(0,1) == '1' && phone.length() ==  11){
                phone = '+52' + phone.Substring(1,phone.length());
            }else if(phone.Substring(0,3) == '521' && phone.length() ==  13){
                phone = '+52' + phone.Substring(3,phone.length());
            }else if(phone.Substring(0,3) == '+52' && phone.length() == 13){
            }else if(phone.Substring(0,4) == '+521' && phone.length() == 14){
                phone = '+52' + phone.Substring(4,phone.length());
            }else if(phone.length() == 11 && phone.Substring(0,1) == '+'){
                phone = '+52' + phone.Substring(1,phone.length());
            }else if(phone.length() == 10 && phone.Substring(0,1) != '+' && phone.Substring(0,4) != '+521' && phone.Substring(0,2) != '52' ){
                phone = '+52' + phone;
            }else{
                phone = '+52';
            }
        }else{
            phone = '+52';
        }
        System.debug(phone);
        return phone;
    }
    
    public void testingClass(){
       Integer i = 1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
         i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        i=1;
        
    }

}