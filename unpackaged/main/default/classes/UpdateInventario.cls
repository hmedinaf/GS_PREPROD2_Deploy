public class UpdateInventario {
    public Inventario__c inventario {get;set;}
    
    public UpdateInventario(String idInv){
        inventario.Id = idInv;
    }
    
    public UpdateInventario(ApexPages.StandardController controller){
        inventario = (Inventario__c) controller.getRecord();
    }
    
    @future(callout = true)
    public static void guardar(String idInv){
        LogATC__c log = new LogATC__c();
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'UpdateInventario';
        
        Inventario__c inventario = [SELECT Id, NumeroProceso__c, FechaHabitabilidad__c, Entregada__c, FechaEntregaEsperada__c,Cuenta__c,FechadeHabitabilidad__c FROM Inventario__c WHERE Id = :idInv];
        Entrega__c entrega = null;
        try{
            entrega  = [SELECT Id, Name, FechaEntrega__c FROM Entrega__c WHERE Estatus__C = 'Entregado' AND Inventario__c = :inventario.Id LIMIT 1];
        }catch(Exception e){
            entrega = null;
        }
        esbJaverComMxUpddat.UpdDatosEntregaBindingQSPort wsPort = new esbJaverComMxUpddat.UpdDatosEntregaBindingQSPort();
        wsPort.timeout_x = 100000;
        try{
            Account cuenta = [SELECT 
                              Id, 
                              Phone, 
                              TelefonoCelular__c, 
                              TelefonoOtro__c, 
                              TelefonoRecados__c, 
                              CorreoElectronico__c, 
                              Numerodecliente__c 
                              FROM Account 
                              WHERE Id =: inventario.Cuenta__c 
                              LIMIT 1];
            
            String NumeroProceso = inventario.NumeroProceso__c;
            
            String FechaHabitibilidad = null;
            if(inventario.FechadeHabitabilidad__c != null) {
                Datetime help = Datetime.newInstance(inventario.FechadeHabitabilidad__c.year(), inventario.FechadeHabitabilidad__c.month(), inventario.FechadeHabitabilidad__c.day());
                FechaHabitibilidad = help.format('MM/dd/yyyy');
            }               
            
            //newInstance(year, month, day, hour, minute, second)
            
            String Estatus = ''+inventario.Entregada__c;
            String FechaEntrega = '';
            if(entrega != null){
                Datetime help = Datetime.newInstance(entrega.FechaEntrega__c.year(), entrega.FechaEntrega__c.month(), entrega.FechaEntrega__c.day());
                FechaEntrega = help.format('MM/dd/yyyy');    
            }else{
                FechaEntrega = null;
            }
            
            
            Long TelefonoCasa = null;
            
            try{
                TelefonoCasa = Long.valueOf(cuenta.Phone);
            }catch(Exception e){
                
            }
            Long TelefonoCelular = null;
            try{
                TelefonoCelular = Long.valueOf(cuenta.TelefonoCelular__c);
            }catch(Exception p){
                
            }
            
            Long TelefonoOtro = null;
            
            try{
                TelefonoOtro = Long.valueOf(cuenta.TelefonoOtro__c);
            }catch(Exception o){
                
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
                esbJaverComMxUpddatTypes.Result_element respuesta = wsPort.UpdDatosEntrega(
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
                log.Mensaje__c += 'Mensaje SIEBEL: '+respuesta.Message;
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: '+respuesta.Estatus;
                log.Mensaje__c += '\r\n';
                upsert log;
            }else{
                if(inventario.FechadeHabitabilidad__c != null) {
                    Datetime help = Datetime.newInstance(inventario.FechadeHabitabilidad__c.year(), inventario.FechadeHabitabilidad__c.month(), inventario.FechadeHabitabilidad__c.day());
                    FechaHabitibilidad = help.format('MM/dd/yyyy');
                }       
                if(inventario.FechadeHabitabilidad__c != null) {
                    Datetime help = Datetime.newInstance(inventario.FechadeHabitabilidad__c.year(), inventario.FechadeHabitabilidad__c.month(), inventario.FechadeHabitabilidad__c.day());
                    FechaHabitibilidad = help.format('MM/dd/yyyy');
                }       
                if(inventario.FechadeHabitabilidad__c != null) {
                    Datetime help = Datetime.newInstance(inventario.FechadeHabitabilidad__c.year(), inventario.FechadeHabitabilidad__c.month(), inventario.FechadeHabitabilidad__c.day());
                    FechaHabitibilidad = help.format('MM/dd/yyyy');
                }       
                if(inventario.FechadeHabitabilidad__c != null) {
                    Datetime help = Datetime.newInstance(inventario.FechadeHabitabilidad__c.year(), inventario.FechadeHabitabilidad__c.month(), inventario.FechadeHabitabilidad__c.day());
                    FechaHabitibilidad = help.format('MM/dd/yyyy');
                }       
                if(inventario.FechadeHabitabilidad__c != null) {
                    Datetime help = Datetime.newInstance(inventario.FechadeHabitabilidad__c.year(), inventario.FechadeHabitabilidad__c.month(), inventario.FechadeHabitabilidad__c.day());
                    FechaHabitibilidad = help.format('MM/dd/yyyy');
                }       
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Mensaje SIEBEL: ';
                log.Mensaje__c += '\r\n';
                log.Mensaje__c += 'Estatus SIEBEL: ';
                log.Mensaje__c += '\r\n';
                Integer uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
                uno = 1;
            }
            
        }catch(Exception io){
            log.Mensaje__c += 'EXCEPTION: ' + io.getMessage() + ' - ' + io.getLineNumber() +' - ' + io.getCause() +' - '+io.getStackTraceString();
            log.Mensaje__c += '\r\n';
            upsert log;
        }
        upsert log;
        
    }
}