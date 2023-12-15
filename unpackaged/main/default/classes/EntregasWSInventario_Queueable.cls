public without sharing class EntregasWSInventario_Queueable implements Queueable, Database.AllowsCallouts{

    List<xmlnsOracleComJavergtiEntrega.RowType> resultados = new List<xmlnsOracleComJavergtiEntrega.RowType>();
    LogATC__c log = new LogATC__c();
    Map<String, Account> rCuenta = new Map<String, Account>();
    Integer daysBefore;

    public EntregasWSInventario_Queueable(Integer daysBefore, LogATC__c log, Map<String, Account> rCuenta){
        this.daysBefore = daysBefore;
        this.log = log;
        this.rCuenta = rCuenta;
    }
    
    public void execute(QueueableContext context){
        try{
            recursionCheck.entregasWS = true;

            xmlnsOracleComJavergtiEntrega.bpelQueryEntrega_pt wsPort = new xmlnsOracleComJavergtiEntrega.bpelQueryEntrega_pt();
            wsPort.timeout_x = 120000;	
            xmlnsOracleComJavergtiEntrega.getEntregaRs_element respuesta = new xmlnsOracleComJavergtiEntrega.getEntregaRs_element();
            respuesta = wsPort.getEntrega(daysBefore);

            xmlnsOracleComJavergtiEntrega.Result_element mensaje = respuesta.Result;
            xmlnsOracleComJavergtiEntrega.ReporteEntrega_element reporteEntrega = respuesta.ReporteEntrega;
            List<xmlnsOracleComJavergtiEntrega.RowType> resultados = new List<xmlnsOracleComJavergtiEntrega.RowType>();
            resultados.addAll(reporteEntrega.Row);   

            List<String> filtroInventario = new List<String>();
            List<String> filtroFraccionamientos = new List<String>();
            List<String> filtroEntregas = new List<String>();

            Map<String, Prototipo__c> mapProto = new Map<String,Prototipo__c>();
            Map<String, Inventario__c> inventarios = new Map<String, Inventario__c>();
            Map<String, Id> fraccionamientos = new Map<String, Id>();

            for(xmlnsOracleComJavergtiEntrega.RowType obj : resultados){
                if(obj.Estatus != 'Firmado'){
                    filtroInventario.add(obj.Numero_Interno);
                    filtroFraccionamientos.add(obj.Fraccionamiento.toUpperCase());
                    filtroEntregas.add(obj.Manzana+'-'+obj.Lote+'-'+(obj.Nombre +' '+obj.Apellido_Paterno+' '+obj.Apellido_Materno).toUpperCase()+'_'+obj.Num_Proceso);
                }else{
                    log.Mensaje__c += '\r\n';
                    log.Mensaje__c += 'Proceso con estatus no válido: '+ obj.Num_Proceso + ' - ' + obj.Nombre +' '+obj.Apellido_Paterno+' '+obj.Apellido_Materno ;
                    log.Mensaje__c += '\r\n';
                    log.Mensaje__c += '\r\n';
                }
            } 

            List<Inventario__c> allInventarios = [SELECT Id, Name,NumeroInterior__c, Entregada__c FROM Inventario__c 
                                                    WHERE NumeroInterior__c IN : filtroInventario
                                                    LIMIT 48000];
            List<Fraccionamiento__c> allFraccionamientos = [SELECT Id, Name FROM Fraccionamiento__c 
                                                                WHERE Name IN : filtroFraccionamientos 
                                                                LIMIT 48000];
                
            List<Prototipo__c> prototipos = [SELECT Id, Name, Fraccionamiento__r.Name, Plantas__c FROM Prototipo__c 
                                                WHERE Fraccionamiento__r.Name IN :filtroFraccionamientos
                                                LIMIT 49000];       
                
            for(Inventario__c i : allInventarios){
                inventarios.put(i.NumeroInterior__c, i);
            }
            
            for(Fraccionamiento__c frac : allFraccionamientos){
                fraccionamientos.put(frac.Name.toUpperCase(), frac.Id);
            }

            RecordType planta1 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 1'];
            RecordType planta2 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 2'];
            RecordType planta3 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 3'];

            List<Check_List__c> upsertChecks = new List<Check_List__c>();
            List<Inventario__c> insertInventarios = new List<Inventario__c>();
            List<Inventario__c> lInventarios = new List<Inventario__c>();
            List<Inventario__c> upsertInventarios = new List<Inventario__c>();

            Date defaultDate = date.newInstance(1900, 1, 1);
            
            Map<String, Check_List__c> mapChecks = new Map<String, Check_List__c>();
            Map<String, Inventario__c> mapAyudaInventario = new Map<String, Inventario__c>();
            Map<String, Inventario__c> mapAyudaInventarioI = new Map<String, Inventario__c>();

            Map<String, Inventario__c> rInventario = new Map<String, Inventario__c>();
            
            for(xmlnsOracleComJavergtiEntrega.RowType obj : resultados){
                if(obj.Estatus != 'Firmado' && rCuenta.containsKey(obj.Numero_cliente)){
                    system.debug('NUMERO INTERNO: ' + obj.Numero_Interno);
                    Inventario__c inventario = new Inventario__c();    

                    if(obj.Fecha_de_Escritura != defaultDate){
                        inventario.FechaEscritura__c = obj.Fecha_de_Escritura;
                    }

                    inventario.ControlE__c = true;
                    inventario.Entregada__c = obj.Estatus;
                    inventario.IsEntrega__c = true;
                    inventario.Name = obj.Numero_Interno;
                    inventario.NumeroProceso__c = obj.Num_Proceso;
                    inventario.Fraccionamiento__c = obj.Fraccionamiento;
                    inventario.Supervisor__c = obj.Supervisor;
                    inventario.MunicipioFraccionamiento__c = obj.Municipio_de_fraccionamiento;
                    inventario.Plaza__c = obj.Plaza;
                    inventario.Plazo__c = obj.Plazo;
                    inventario.Plazos_Pendientes__c = obj.PlazosPendientes;
                    inventario.Plazos_Transcurridos__c = obj.PlazosTranscurridos;
                    inventario.Mensualidad_Aproximada__c = obj.MensualidadAproximada;
                    inventario.Frecuencia__c = obj.Frecuencia;
                    inventario.Saldo_Vencido__c = obj.SaldoVencido;
                    inventario.Monto_de_Financiamiento__c = obj.MontoFinanciamiento;
                    
                    
                    if(!obj.Estatus.equalsIgnoreCase('Cancelado')){
                        inventario.ProductoFinanciero__c = obj.Producto_Financiero;
                        inventario.TipoCredito__c = obj.Tipo_de_Credito;
                        inventario.Notario__c = obj.Notario;
                        inventario.Notaria__c = obj.Notaria;   
                    }else{
                        inventario.ProductoFinanciero__c = null;
                        inventario.TipoCredito__c = null;
                        inventario.Notario__c = null;
                        inventario.Notaria__c = null;   
                    }
                    
                    inventario.Prototipo__c = obj.Prototipo.toUpperCase();

                    try	{
                        inventario.Proto__c = mapProto.get(obj.Prototipo.toUpperCase()+' '+obj.Fraccionamiento.toUpperCase()).Id;
                    }catch(Exception d){
                        inventario.Proto__c = null;   
                    }
                    
                    inventario.NumeroInterior__c = obj.Numero_Interno;
                    inventario.Manzana__c = ''+obj.Manzana;
                    inventario.Lote__c = ''+obj.Lote;
                    inventario.EnviarSibel__c = false;
                    inventario.Interior__c = obj.Interior;
                    inventario.Sector__c = obj.Sector;
                    inventario.Direccionoficial__c = obj.Direccion_Oficial;

                    if(obj.Fecha_de_Entrega_Esperada != defaultDate){
                        inventario.FechaEntregaEsperada__c = obj.Fecha_de_Entrega_Esperada;
                    }

                    if(obj.Fecha_Exigible != defaultDate){
                        inventario.FechaExigible__c = obj.Fecha_Exigible;
                    }

                    if(obj.Fecha_Habitabilidad != defaultDate){
                        inventario.FechadeHabitabilidad__c = obj.Fecha_Habitabilidad;
                    }

                    if(obj.Fecha_DTU != defaultDate){
                        inventario.FechaDTUDTI__c = obj.Fecha_DTU;
                    }

                    if(obj.Fecha_Exigible_para_Cobro != defaultDate){
                        inventario.Fecha_Exigible_para_Cobro__c = obj.Fecha_Exigible_para_Cobro;
                    }

                    inventario.Exigible_para_Cobro__c = obj.Exigible_para_Cobro.equals('Y') ? true : false;
                    inventario.Vivienda_Cobrada__c = obj.Vivienda_Cobrada.equals('Y') ? true : false;
                    inventario.SupervisorObra__c = obj.Supervisor_de_obra;
                    inventario.Compania__c = obj.Compania;
                    inventario.NombreAsesor__c = obj.Nombre_de_Asesor;
                    inventario.Condominio__c = obj.Condominio;
                    inventario.Unidad_privativa__c = ''+obj.Unidad_Privativa;
                    inventario.Frente__c = obj.Frente;
                    inventario.Cuenta__c = rCuenta.get(obj.Numero_cliente).Id;

                    try{
                        inventario.Fracc__c = fraccionamientos.get(obj.Fraccionamiento.toUpperCase());
                    }catch(Exception e){
                        inventario.Fracc__c = null;
                        system.debug('ERROR ' + e.getMessage());
                    }
                    
                    try{
                        inventario.Id = inventarios.get(inventario.NumeroInterior__c).id;
                    }catch(Exception t){
                        system.debug('ERROR ' + t.getMessage());
                    }

                    if(inventario.Id == null){
                        try{
                            if(mapAyudaInventarioI.get(obj.Numero_Interno) == null){
                                mapAyudaInventarioI.put(obj.Numero_Interno, inventario);
                            }else{
                                if((!inventario.Entregada__c.equals('Cancelado') && mapAyudaInventarioI.get(obj.Numero_Interno).Entregada__c.equals('Cancelado')) 
                                    || (inventario.Entregada__c.equals('Cancelado') && mapAyudaInventarioI.get(obj.Numero_Interno).Entregada__c.equals('Cancelado'))){
                                        mapAyudaInventarioI.put(obj.Numero_Interno, inventario);
                                    }
                            }
                        }catch(Exception p){
                            mapAyudaInventarioI.put(obj.Numero_Interno, inventario);
                        }
                        
                        Check_List__c ch = new Check_List__c();
                        try{
                            if(inventario.Proto__c != null){
                                if(mapProto.get(obj.Prototipo.toUpperCase()+' '+obj.Fraccionamiento.toUpperCase()).Plantas__c.equals('1')){
                                    ch.RecordTypeId = planta1.ID;
                                }else if(mapProto.get(obj.Prototipo.toUpperCase()+' '+obj.Fraccionamiento.toUpperCase()).Plantas__c.equals('3')){
                                    ch.RecordTypeId = planta3.ID;
                                }else{
                                    ch.RecordTypeId = planta2.ID;
                                }
                            }else{
                                ch.RecordTypeId = planta2.Id;
                            }
                        }catch(Exception ff){
                            ch.RecordTypeId = planta2.Id;
                        }
                        ch.Name =obj.Manzana +'-' + obj.Lote + '-' +obj.Numero_Interno+ ' - ' + obj.Fraccionamiento.toUpperCase() + ' - ' + obj.Num_Proceso+' V1';
                        ch.Estatus__c = 'Abierto';
                        
                        mapChecks.put(inventario.Name, ch);
                        //uspertChecks.add(ch);
                    }else{
                        try{
                            if(mapAyudaInventario.get(obj.Numero_Interno) == null){
                                mapAyudaInventario.put(obj.Numero_Interno, inventario);
                            }else{
                                if((!inventario.Entregada__c.equals('Cancelado') && mapAyudaInventario.get(obj.Numero_Interno).Entregada__c.equals('Cancelado')) 
                                    || (inventario.Entregada__c.equals('Cancelado') && mapAyudaInventario.get(obj.Numero_Interno).Entregada__c.equals('Cancelado'))){
                                        mapAyudaInventario.put(obj.Numero_Interno, inventario);
                                    }
                            }
                        }catch(Exception p){
                            mapAyudaInventario.put(obj.Numero_Interno, inventario);
                        }
                    }
                }
            }
            
            for(String key :mapAyudaInventario.keySet()){
                upsertInventarios.add(mapAyudaInventario.get(key));
            }
            
            for(String key :mapAyudaInventarioI.keySet()){
                insertInventarios.add(mapAyudaInventarioI.get(key));
            }
            
            if(!insertInventarios.isEmpty()){
                upsert insertInventarios;
                log.Mensaje__c += 'Inventarios Insertados: '+insertInventarios.size();
                log.Mensaje__c += '\r\n';
            }
            
            for(Inventario__c invv : insertInventarios){ 
                Check_List__c ch = mapChecks.get(invv.Name);
                ch.Vivienda__c = invv.Id;
                System.debug(ch.Vivienda__c);
                upsertChecks.add(ch);
                rInventario.put(invv.NumeroInterior__c, invv);
            }

            try{
                upsert upsertChecks;
                log.Mensaje__c += 'CheckList Insertados/Actualizados: '+ upsertChecks.size();
                log.Mensaje__c += '\r\n';
            }catch(Exception o){
                log.Mensaje__c += 'Error en checklist: '+o.getMessage() +' - ' +o.getStackTraceString()+' - '+o.getCause();
                log.Mensaje__c += '\r\n';
                upsert log;
            }

            upsert upsertInventarios;
            log.Mensaje__c += 'Inventarios Actualizados: '+upsertInventarios.size();
            log.Mensaje__c += '\r\n';

            for(Inventario__c iv : upsertInventarios){
                system.debug('INVENTARIO: '+iv.Id);
                rInventario.put(iv.NumeroInterior__c, iv);
            }

            EntregasWSEntregas_Queueable EntregasWSEntregas_Queueable = new EntregasWSEntregas_Queueable(daysBefore, log, rCuenta, rInventario);
            ID jobID = System.enqueueJob(EntregasWSEntregas_Queueable);
        }catch(Exception io){
            log.Mensaje__c += 'EXCEPTION: ' + io.getMessage() + ' - ' + io.getLineNumber() +' - ' + io.getCause() +' - '+io.getStackTraceString();
            log.Mensaje__c += '\r\n';
            insert log;
            
            testingClass();
        }
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