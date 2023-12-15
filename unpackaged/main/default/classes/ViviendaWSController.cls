public class ViviendaWSController {
    
    @future(callout=true)
    public static void run(String dias){        
        if(dias == null){
            dias = '1';
        }
        LogATC__c log = new LogATC__c();
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'ViviendaWS';
        
        RecordType planta1 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 1'];
        RecordType planta2 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 2'];
        RecordType planta3 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 3'];
        
        
        esbJaverComMxAtencionclientesInvviv.InvViviendaBindingQSPort wsPort = new esbJaverComMxAtencionclientesInvviv.InvViviendaBindingQSPort();
        
        wsPort.timeout_x = 20000;
        
        esbJaverComMxAtencionclientesInvviv.GetInvViviendaRs_element respuesta = new esbJaverComMxAtencionclientesInvviv.GetInvViviendaRs_element();
        esbJaverComMxAtencionclientesInvviv.ReporteInvVivienda_element env = new esbJaverComMxAtencionclientesInvviv.ReporteInvVivienda_element();
        List<esbJaverComMxAtencionclientesInvviv.Row_element> listObj = new List<esbJaverComMxAtencionclientesInvviv.Row_element>();
        if(!Test.isRunningTest()){
            try{
                respuesta = wsPort.GetInvVivienda(dias);
                
                log.Mensaje__c += 'Estatus SIEBEL: '+respuesta.Result.Success;
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Respuesta SIEBEL: '+respuesta.Result.SysMessage;
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Cantidad de registros: '+listObj.size();
                log.Mensaje__c += '\r\n';
            }catch(Exception o){
                log.Mensaje__c += 'ERROR: '+o.getMessage() +' - '+o.getStackTraceString();
                log.Mensaje__c += '\r\n';
                upsert log;
            }
        }else{
            esbJaverComMxAtencionclientesInvviv n = new esbJaverComMxAtencionclientesInvviv();
            n.method();
            esbJaverComMxAtencionclientesInvviv.GetInvViviendaRq_element ff = new esbJaverComMxAtencionclientesInvviv.GetInvViviendaRq_element();
            ff.NumDias = '1';
            respuesta.Result = new esbJaverComMxAtencionclientesInvviv.Result_element();
            respuesta.ReporteInvVivienda = new esbJaverComMxAtencionclientesInvviv.ReporteInvVivienda_element();
            respuesta.ReporteInvVivienda.Row = new List<esbJaverComMxAtencionclientesInvviv.Row_element>();
            respuesta.ReporteInvVivienda.ItemQuantity = 1;
            
            esbJaverComMxAtencionclientesInvviv.Row_element e = new esbJaverComMxAtencionclientesInvviv.Row_element();
            e.IdVivienda = '';
            e.Fraccionamiento = '';
            e.Prototipo = '';
            e.NumInterno = '';
            e.NunInterior = '';
            e.IdManzana = '';
            e.Manzana = '';
            e.IdLote = '';
            e.Lote = '';
            e.Sector = '';
            e.UnidadPrivativa = '';
            e.Condominio = '';
            e.Dtu = '';
            e.DireccionOficial = '';
            e.Frente = '';
            e.Seccion = '';
            e.Conjunto = '';
            e.Concepto = '';
            e.Concepto = '';
            respuesta.ReporteInvVivienda.Row.add(e);
        }
        
        env = respuesta.ReporteInvVivienda;
        listObj = env.Row;
        
        List<String> filtroViviendas = new List<String>();
        List<Id> filtroFraccionamientos = new List<Id>();
        
        if(listObj != null){
            if(!listObj.isEmpty()){
                for(esbJaverComMxAtencionclientesInvviv.Row_element vivienda : listObj){
                    filtroViviendas.add(vivienda.NumInterno);
                }
            }
        }
        
        Map<String, Id> mapFracc = new Map<String,Id>();
        Map<String, Prototipo__c> mapProto = new Map<String,Prototipo__c>();
        Map<String, Inventario__c> inventarios = new Map<String,Inventario__c>();
        
        
        List<Inventario__c> allInventarios = [SELECT Id, Name,Fracc__r.Id FROM Inventario__c WHERE Name IN :filtroViviendas LIMIT 13000];
        for(Inventario__c i :allInventarios){
            filtroFraccionamientos.add(i.Fracc__r.Id);
            inventarios.put(i.Name, i);
        }
        
        List<Fraccionamiento__c> fraccionamientos = [SELECT Id, Name FROM Fraccionamiento__c WHERE Id IN :filtroFraccionamientos LIMIT 13000];
        for(Fraccionamiento__c f: fraccionamientos){
            mapFracc.put(f.Name.toUpperCase(), f.Id);
        }
        
        List<Prototipo__c> prototipos = [SELECT Id, Name, Fraccionamiento__r.Name, Plantas__c FROM Prototipo__c WHERE Fraccionamiento__r.Id IN: filtroFraccionamientos LIMIT 13000];        
        for(Prototipo__c p: prototipos){
            mapProto.put(p.Name.toUpperCase() + ' '+p.Fraccionamiento__r.Name, p);
        }
        
        Set<Inventario__c> upsertInventarios = new Set<Inventario__c>();
        if(listObj != null){
            if(!listObj.isEmpty()){
                for(esbJaverComMxAtencionclientesInvviv.Row_element vivienda : listObj){
                    Inventario__c inventario = new Inventario__c();
                    
                    inventario.Name = vivienda.NumInterno;
                    
                    inventario.Fraccionamiento__c = vivienda.Fraccionamiento;
                    
                    try{
                        inventario.Fracc__c = mapFracc.get(vivienda.Fraccionamiento.toUpperCase());
                    }catch(Exception e){
                        inventario.Fracc__c = null;
                    }
                    
                    inventario.IsEntrega__c = false;
                    inventario.Prototipo__c = vivienda.Prototipo;
                    
                    try{
                        inventario.Proto__c = mapProto.get(vivienda.Prototipo.toUpperCase()+' '+vivienda.Fraccionamiento.toUpperCase()).Id;
                    }catch(Exception e){
                        inventario.Proto__c = null;
                    }
                    
                    inventario.NumeroInterior__c = vivienda.NumInterno;
                    //inventario. = vivienda.NunInterior;
                    //inventario.Manzana__c = vivienda.IdManzana;
                    inventario.Manzana__c = vivienda.Manzana;
                    //inventario. = vivienda.IdLote;
                    inventario.Lote__c = vivienda.Lote;
                    inventario.Sector__c = vivienda.Sector;
                    inventario.Unidad_privativa__c = vivienda.UnidadPrivativa;
                    inventario.Condominio__c = vivienda.Condominio;
                    
                    inventario.FechaDTU_DTI__c = vivienda.Dtu;
                    
                    try{
                        inventario.FechaDTUDTI__c = getDateString(vivienda.Dtu);
                    }catch(Exception d){
                        inventario.FechaDTUDTI__c = null;
                    }
                    
                    inventario.Direccionoficial__c = vivienda.DireccionOficial;
                    inventario.Frente__c = vivienda.Frente;
                    //inventario. = vivienda.Seccion;
                    inventario.Conjunto__c = vivienda.Conjunto;
                    //inventario. = vivienda.Concepto;
                    inventario.EnviarSibel__c = false;
                    
                    try{
                        inventario.Id = inventarios.get(inventario.Name).Id;
                    }catch(Exception o){
                        
                    }
                    
                    upsertInventarios.add(inventario);
                    
                    if(inventario.Id == null){
                        inventario.Entregada__c = 'No Entregado';
                        insert inventario;
                        
                        Check_List__c ch = new Check_List__c();
                        
                        ch.Vivienda__c = inventario.Id;
                        
                        if(inventario.Proto__c != null){
                            if(mapProto.get(vivienda.Prototipo.toUpperCase()+' '+vivienda.Fraccionamiento.toUpperCase()).Plantas__c.equals('1')){
                                ch.RecordTypeId = planta1.ID;
                            }else if(mapProto.get(vivienda.Prototipo.toUpperCase()+' '+vivienda.Fraccionamiento.toUpperCase()).Plantas__c.equals('3')){
                                ch.RecordTypeId = planta3.ID;
                            }else{
                                ch.RecordTypeId = planta2.ID;
                            }
                        }else{
                            ch.RecordTypeId = planta2.Id;
                        }
                        ch.Name =vivienda.Manzana +'-' + vivienda.Lote + '-' +vivienda.NumInterno+ ' - ' + vivienda.Fraccionamiento.toUpperCase() +' V1';
                        ch.Estatus__c = 'Abierto';
                        insert ch;
                    }else{
                        update inventario;
                    }
                }
                log.Mensaje__c += 'Inventarios Insertados/Actualizados: '+upsertInventarios.size();
                log.Mensaje__c += '\r\n';
                upsert log;
            }else{
                log.Mensaje__c += 'No hay inventarios';
                log.Mensaje__c += '\r\n';
                upsert log;
            }
        }else{
            log.Mensaje__c += 'No hay inventarios';
            log.Mensaje__c += '\r\n';
            upsert log;
        }
    }
    
    public static Date getDateString(String fecha){
        //2015-01-06T00:00:00.000-05:00
        String[] fechaArray = fecha.split('T');
        System.debug('FECHARRAY : '+fechaArray);
        System.debug('AAA: '+fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
        return Date.valueOf(fechaArray[0] + ' ' + fechaArray[1].substring(0,  fechaArray[1].lastIndexOf('.')));
    }
    
    
    public ViviendaWSController(){
    }
}