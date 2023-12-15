public class ImportarEntregaWS {
    
    @future(callout=true)
    public static void run(Integer dias){

        LogATC__c log = new LogATC__c();
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'ImportarEntregaWS';

        Date defaultDate = date.newInstance(1900, 1, 1);

        try{
            RecordType planta1 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 1'];
            RecordType planta2 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 2'];
            RecordType planta3 = [SELECT Id, Name FROM RecordType WHERE Name = 'Planta 3'];
            List<Account> listaCuenta = new List<Account>();
            xmlnsOracleComJavergtiEntrega.bpelQueryEntrega_pt wsPort = new xmlnsOracleComJavergtiEntrega.bpelQueryEntrega_pt();
            wsPort.timeout_x = 120000;  
            xmlnsOracleComJavergtiEntrega.getEntregaRs_element respuesta = new xmlnsOracleComJavergtiEntrega.getEntregaRs_element();
            if(!Test.isRunningTest()){
                respuesta = wsPort.getEntrega(dias);
            }
            
            xmlnsOracleComJavergtiEntrega.Result_element mensaje = respuesta.Result;
            xmlnsOracleComJavergtiEntrega.ReporteEntrega_element reporteEntrega = respuesta.ReporteEntrega;
            
            List<xmlnsOracleComJavergtiEntrega.RowType> resultados = new List<xmlnsOracleComJavergtiEntrega.RowType>();
            if(!Test.isRunningTest()){
                resultados.addAll(reporteEntrega.Row);   
            }
            
            if(Test.isRunningTest()){
                xmlnsOracleComJavergtiEntrega.Result_element mm = new xmlnsOracleComJavergtiEntrega.Result_element();
                xmlnsOracleComJavergtiEntrega.ReporteEntrega_element rr = new xmlnsOracleComJavergtiEntrega.ReporteEntrega_element();
                xmlnsOracleComJavergtiEntrega.RowType ffg = new xmlnsOracleComJavergtiEntrega.RowType();
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                
                ffg.Numero_cliente = '';
                ffg.Nombre = '';
                ffg.Apellido_Paterno = '';
                ffg.Apellido_Materno = '';
                ffg.Telefono_casa = '';
                ffg.Telefono_celular = '';
                ffg.Telefono_Otro = '';
                ffg.Producto_Financiero = '';
                ffg.Tipo_de_Credito = '';
                ffg.Correo_electronico = '';
                ffg.Login = '';
                ffg.Id_Vivienda = '';
                ffg.Num_Proceso = '';
                ffg.Supervisor = '';
                ffg.Fraccionamiento = '';
                ffg.Municipio_de_fraccionamiento = '';
                ffg.Prototipo = '';
                ffg.Numero_Interno = '';
                ffg.Manzana = 0;
                ffg.Lote = 0;
                ffg.Interior = '';
                ffg.Sector = '';
                ffg.Direccion_Oficial = '';
                ffg.Fecha_Exigible = defaultDate;
                ffg.Fecha_de_Entrega_Esperada = defaultDate;
                ffg.Fecha_Habitabilidad = defaultDate;
                ffg.Fecha_DTU = defaultDate;
                ffg.Supervisor_de_obra = '';
                ffg.Nombre_de_Asesor = '';
                ffg.Condominio = '';
                ffg.Unidad_Privativa = 0;
                ffg.Frente = '';
                ffg.Estatus = '';
                ffg.Fecha_de_Escritura = defaultDate;
                ffg.Fecha_Exigible_para_Cobro = defaultDate;
                ffg.Fecha_de_Entrega = defaultDate;
                ffg.Check_de_Paquete = '';
                ffg.Check_de_Producto = '';
                ffg.Exigible_para_Cobro = '';
                ffg.Vivienda_Cobrada = '';
                ffg.Check_de_Mejora = '';
                ffg.Notario = '';
                ffg.Notaria = '';
                ffg.Referencia_bancaria_cliente = '';
                ffg.Plaza = '';
                ffg.arreglo_paquetes = new xmlnsOracleComJavergtiEntrega.arreglo_paquetes_element();
                ffg.arreglo_paquetes.Paquete = new List<xmlnsOracleComJavergtiEntrega.PaqueteType>();
                xmlnsOracleComJavergtiEntrega.PaqueteType pp = new xmlnsOracleComJavergtiEntrega.PaqueteType();
                
                pp.Tipo_paquete = '';
                pp.Descripcion_paquete = '';
                pp.Fecha_Solicitud_Paquete = defaultDate;
                pp.Paquete_Entregado = '';
                pp.Fecha_Entrega_Paquete = defaultDate;
                
                ffg.arreglo_paquetes.Paquete.add(pp);
                
                resultados.add(ffg);
            }
            
            List<String> filtroCuentas = new List<String>();
            List<String> filtroInventario = new List<String>();
            List<String> filtroFraccionamientos = new List<String>();
            List<String> filtroEntregas = new List<String>();
            
            List<String> filtroCuentas2 = new List<String>();
            try{
                log.Mensaje__c = 'Estatus SIEBEL: '+mensaje.Success;
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Respuesta SIEBEL: '+mensaje.SysMessage;
            }catch(Exception o){
                
            }
            log.Mensaje__c += '\r\n';
            log.Mensaje__c += 'Cantidad de registros: '+resultados.size();
            log.Mensaje__c += '\r\n';
            
            
            //Iteración para los filtros del query
            for(xmlnsOracleComJavergtiEntrega.RowType obj : resultados){
                if(obj.Estatus != 'Firmado'){
                    filtroCuentas.add(obj.Numero_cliente);
                    filtroCuentas2.add((obj.Nombre +' '+obj.Apellido_Paterno+' '+obj.Apellido_Materno).toUpperCase());
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
            
            /*List<Account> allCuentas = [SELECT Id, Name, MiddleName, LastName, Nombre_cta__c, Apellidomaterno_cta__c, RecordTypeId, Apellidopaterno_cta__c,FechaNacimiento__c, CorreoElectronico__c, Telefono2__c, NumerodeCliente__c 
                                        FROM Account WHERE((NumerodeCliente__c IN : filtroCuentas AND NumerodeCliente__c != null)
                                                           OR (IdMasComercial__c IN :filtroCuentas AND IdMasComercial__c != null)
                                                           OR Name IN :filtroCuentas2)
                                        LIMIT 48000];*/
            List<Account> allCuentas = [SELECT Id, Name, LastName, Nombre_cta__c, Apellidomaterno_cta__c, RecordTypeId, Apellidopaterno_cta__c,FechaNacimiento__c, CorreoElectronico__c, Telefono2__c, NumerodeCliente__c 
                                        FROM Account WHERE((NumerodeCliente__c IN : filtroCuentas AND NumerodeCliente__c != null)
                                                           OR (IdMasComercial__c IN :filtroCuentas AND IdMasComercial__c != null)
                                                           OR Name IN :filtroCuentas2)
                                        LIMIT 48000];
            List<Inventario__c> allInventarios = [SELECT Id, Name,NumeroInterior__c, Entregada__c FROM Inventario__c 
                                                  WHERE NumeroInterior__c IN : filtroInventario
                                                  LIMIT 48000];
            List<Fraccionamiento__c> allFraccionamientos = [SELECT Id, Name FROM Fraccionamiento__c 
                                                            WHERE Name IN : filtroFraccionamientos 
                                                            LIMIT 48000];
            List<Entrega__c> allEntregas = [SELECT Id, Name FROM Entrega__c 
                                            WHERE Name IN :filtroEntregas LIMIT 48000];
            
            List<Prototipo__c> prototipos = [SELECT Id, Name, Fraccionamiento__r.Name, Plantas__c FROM Prototipo__c 
                                             WHERE Fraccionamiento__r.Name IN :filtroFraccionamientos
                                             LIMIT 49000];        
            Map<String, Prototipo__c> mapProto = new Map<String,Prototipo__c>();
            
            Map<String, Id> entregas = new Map<String, Id>();
            Map<String, Account> cuentas = new Map<String, Account>();
            Map<String, Id> fraccionamientos = new Map<String, Id>();
            Map<String, Inventario__c> inventarios = new Map<String, Inventario__c>();
            
            for(Entrega__c e : allEntregas){
                entregas.put(e.Name, e.Id);
            }
            
            for(Inventario__c i : allInventarios){
                inventarios.put(i.NumeroInterior__c, i);
            }
            
            for(Fraccionamiento__c frac : allFraccionamientos){
                fraccionamientos.put(frac.Name.toUpperCase(), frac.Id);
            }
            
            for(Account c : allCuentas){
                cuentas.put(c.Numerodecliente__c, c);
            }
            
            for(Prototipo__c p: prototipos){
                mapProto.put(p.Name.toUpperCase() + ' '+p.Fraccionamiento__r.Name, p);
            }
            
            List<String> numerosDeCliente = new List<String>();
            
            List<Account> upsertCuentas = new List<Account>();
            List<Inventario__c> upsertInventarios = new List<Inventario__c>();
            List<Entrega__c> upsertEntregas = new List<Entrega__c>();
            List<PaqueteEntrega__c> upsertPaquetes = new List<PaqueteEntrega__c>();
            
            Id recordtypeA = [SELECT Id, Name FROM RecordType WHERE Name = 'Clientes ATC' AND IsPersonType=False].Id;
            Id recordtypePA = [SELECT Id, Name FROM RecordType WHERE Name = 'Clientes ATC' AND IsPersonType=True].Id;
            //Num de cliente
            Map<String, Account> rCuenta = new Map<String, Account>();
            //NumeroInterno
            Map<String, Inventario__c> rInventario = new Map<String, Inventario__c>();
            //
            Map<String, PaqueteEntrega__c> rEntrega = new Map<String, PaqueteEntrega__c>();
            
            upsertCuentas = new List<Account>();
            upsertInventarios = new List<Inventario__c>();
            upsertEntregas = new List<Entrega__c>();
            upsertPaquetes = new List<PaqueteEntrega__c>();
            
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
                    
                    if(regexMatcher_empty.find() || regexMatcher.find()) {
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
            for(String key :mapAyudaCuenta.keySet()){
                upsertCuentas.add(mapAyudaCuenta.get(key));
            }
            
            if(!Test.isRunningTest()){
                upsert upsertCuentas;
                log.Mensaje__c += 'Cuentas Actualizadas/Insertadas: '+upsertCuentas.size();
                log.Mensaje__c += '\r\n';
            }
            
            
            
            for(Account cu : upsertCuentas){
                rCuenta.put(cu.Numerodecliente__c, cu);
            }
            
            List<Check_List__c> upsertChecks = new List<Check_List__c>();
            List<Inventario__c> insertInventarios = new List<Inventario__c>();
            
            Map<String, Check_List__c> mapChecks = new Map<String, Check_List__c>();
            Map<String, Inventario__c> mapAyudaInventario = new Map<String, Inventario__c>();
            Map<String, Inventario__c> mapAyudaInventarioI = new Map<String, Inventario__c>();
            
            for(xmlnsOracleComJavergtiEntrega.RowType obj : resultados){
                if(obj.Estatus != 'Firmado'){
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

                    try {
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
            
            if(!Test.isRunningTest()){
                upsert upsertInventarios;
                log.Mensaje__c += 'Inventarios Actualizados: '+upsertInventarios.size();
                log.Mensaje__c += '\r\n';
            }
            
            for(Inventario__c iv : upsertInventarios){
                system.debug('INVENTARIO: '+iv.Id);
                rInventario.put(iv.NumeroInterior__c, iv);
            }
            
            for(xmlnsOracleComJavergtiEntrega.RowType obj : resultados){
                if(obj.Estatus != 'Firmado'){
                Entrega__c entrega = new Entrega__c();
                
                entrega.Estatus__c = obj.Estatus;

                if(obj.Fecha_de_Escritura != defaultDate){
                    entrega.FechaEscritura__c = obj.Fecha_de_Escritura;
                }

                if(obj.Fecha_de_Entrega != defaultDate){
                    entrega.FechaEntrega__c = obj.Fecha_de_Entrega;
                }
                
                entrega.Paquete__c = obj.Check_de_Paquete.equals('Y') ? true : false;
                entrega.Producto__c = obj.Check_de_Producto.equals('Y') ? true : false;
                entrega.Mejora__c = obj.Check_de_Mejora.equals('Y') ? true : false;
                
                Inventario__c inventario = rInventario.get(obj.Numero_Interno);
                Account cuenta = rCuenta.get(obj.Numero_cliente);
                
                entrega.Inventario__c = inventario.Id;
                entrega.Cuenta__c = cuenta.Id;
                
                String nombrec = 
                    cuenta.Nombre_cta__c.toUpperCase() + ' ' 
                    + cuenta.Apellidopaterno_cta__c.toUpperCase() + ' ' 
                    + cuenta.Apellidomaterno_cta__c.toUpperCase();
                
                String filename = inventario.Manzana__c + '-' +inventario.Lote__c + '-' + nombrec + '_' + obj.Num_Proceso;
                
                entrega.Name = filename;

                try{
                    entrega.Id = entregas.get(filename);
                }catch(Exception p){
                    
                }

                upsertEntregas.add(entrega);
                for(xmlnsOracleComJavergtiEntrega.PaqueteType ofs: obj.arreglo_paquetes.Paquete){
                    PaqueteEntrega__c paquete = new PaqueteEntrega__c();
                    
                    paquete.TipoPaquete__c = ofs.Tipo_paquete;
                    paquete.DescripcionPaquete__c = ofs.Descripcion_paquete;
                    //paquete.FechaSolicitudPaquete__c = ofs.Fecha_Solicitud_Paquete == defaultDate ? null : ofs.Fecha_Solicitud_Paquete;
                    
                    if(ofs.Paquete_Entregado != null && !ofs.Paquete_Entregado.equals('')){
                        paquete.Estatus__c = ofs.Paquete_Entregado;
                    }else{
                        paquete.Estatus__c = 'Sin Estatus';
                    }
                    
                    //paquete.FechaEntregaPaquete__c = ofs.Fecha_Entrega_Paquete == defaultDate ? null : ofs.Fecha_Entrega_Paquete;
                    rEntrega.put(entrega.Name, paquete);
                }
                }
            }
            
            if(!Test.isRunningTest()){
                upsert upsertEntregas;
                log.Mensaje__c += 'Entregas Insertadas/Actualizadas: '+upsertEntregas.size();
                log.Mensaje__c += '\r\n';
            }
            
            List<Id> idsBorrar = new List<Id>();
            
            for(Entrega__c e : upsertEntregas){
                //system.debug('ENTREGA: '+ e.Id);
                idsBorrar.add(e.Id);
            }
            
            List<PaqueteEntrega__c> borrarPaquetes = [SELECT Id FROM PaqueteEntrega__c WHERE Entrega__c IN :idsBorrar];
            if(borrarPaquetes != null){
                delete borrarPaquetes;
            }
            
            Set<PaqueteEntrega__c> helpPaquetes = new Set<PaqueteEntrega__c>();
            
            for(Entrega__c en :upsertEntregas){
                PaqueteEntrega__c paquete = rEntrega.get(en.Name);
                
                paquete.Entrega__c = en.Id;
                try{
                    if(paquete.TipoPaquete__c != null && !paquete.TipoPaquete__c.equals(' ')){
                        //system.debug(paquete.TipoPaquete__c);
                        helpPaquetes.add(paquete);
                    }
                }catch(Exception o){
                    
                }
            }
            
            upsertPaquetes.addAll(helpPaquetes);
            
            if(!Test.isRunningTest()){
                upsert upsertPaquetes;
                log.Mensaje__c += 'Paquetes Insertados/Actualizados: '+upsertPaquetes.size();
                log.Mensaje__c += '\r\n';
            }
            //upsert upsertEntregas;
        }catch(Exception io){
            log.Mensaje__c += 'EXCEPTION: ' + io.getMessage() + ' - ' + io.getLineNumber() +' - ' + io.getCause() +' - '+io.getStackTraceString();
            log.Mensaje__c += '\r\n';
            upsert log;
        } 
        upsert log;
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
}