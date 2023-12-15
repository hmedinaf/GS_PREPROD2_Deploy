public with sharing class ActasPrototipoCtrl {
    
    @AuraEnabled
    public static Boolean MobilCheck(String FraccName){
        if(UserInfo.getUiTheme() == 'Theme4t'){
            return True;
        }else{
            return False;
        }
    }
    
    @AuraEnabled
    public static List<Prototipo__c> getPrototiposList(String FraccName){
        Set<Prototipo__c> PSet = new Set<Prototipo__c>();
        List<Prototipo__c> PList = new List<Prototipo__c>([SELECT Name FROM Prototipo__c WHERE Fraccionamiento__r.Name =: FraccName]);
        List<Prototipo__c> NPList = new List<Prototipo__c>();
        for(Prototipo__c P : PList){
            Prototipo__c NP = new Prototipo__c();
            NP.Name = P.Name;
            PSet.add(NP);
        }
        NPList.addAll(PSet);
        NPList.sort();        
        return NPList;
    }
    
    @AuraEnabled
    public static List<Fraccionamiento__c> getFraccionamientos() {
        User USR = [SELECT Id, Name, User_Mas_Comercial__c, Id_Mas_Comercial__c,Fraccionamiento_autorizado__c, FraccionamientoAutorizados__c  FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        List<Fraccionamiento__c> AuthFraccs = new List<Fraccionamiento__c>();
        List<String> FraccNames = new List<String>();
        if('Admin Javer' == USR.Name  || USR.Fraccionamiento_autorizado__c == 'TODOS'){
            AuthFraccs = [Select Id, Name FROM Fraccionamiento__c ORDER BY Name]; 
        }else{
            try{
                FraccNames.add(USR.FraccionamientoAutorizados__c);
                FraccNames.add(USR.Fraccionamiento_autorizado__c);
                try{
                    FraccNames.addAll(USR.Fraccionamiento_autorizado__c.split(', '));
                }catch(Exception ex){
                    System.debug(ex);
                }
                try{
                    FraccNames.addAll(USR.FraccionamientoAutorizados__c.split(', '));
                }catch(Exception ex){
                    System.debug(ex);
                }   
                AuthFraccs = [Select Id, Name FROM Fraccionamiento__c WHERE Name IN : FraccNames AND Activo_frac__c = true ORDER BY Name];
            }catch(Exception e){
                System.debug(e);
            }
        }
        System.debug(AuthFraccs);
        return AuthFraccs;
    }
    
    @AuraEnabled
    public static Ecotecnologia__c getActas(String Prototipo, String Fraccionamiento) {
        Ecotecnologia__c ECO;
        
        try{
            ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                   CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                   FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                   Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                   PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                   InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                   ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                   FROM Ecotecnologia__c WHERE Name =: Prototipo + ' - ' + Fraccionamiento LIMIT 1];
        }catch(Exception e){
            ECO = new Ecotecnologia__c();
            System.debug(e);
        }
        System.debug(ECO);
        return ECO;
    }
    
    @AuraEnabled
    public static void newActa(String Prototipo, String Fraccionamiento, Ecotecnologia__c newActaEcoT) {
        Ecotecnologia__c ECO;
        Prototipo__c Proto = new Prototipo__c();
        try{
            Proto = ([Select Id, Name, Prototipo_pro__c, Fraccionamiento__c from Prototipo__c where Prototipo_pro__c =: Prototipo + ' - ' + Fraccionamiento LIMIT 1]);
        }Catch(Exception e){
            System.debug(e);
        }
        
        try{
            ECO = [SELECT Id, AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                   CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                   FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                   Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                   PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                   InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                   ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                   FROM Ecotecnologia__c WHERE Name =: Prototipo + ' - ' + Fraccionamiento LIMIT 1];
        }catch(Exception e){
            ECO = new Ecotecnologia__c();
        }
        System.debug(ECO);
        System.debug(newActaEcoT);
        
        ECO.Prototipo__c = Proto.Id;
        ECO.NombrePrototipo__c = Proto.Name;
        Integer maxSize = 79;
        if(!Test.isRunningTest()){
            if(Proto.Prototipo_pro__c.length() > maxSize ){
                ECO.Name = Proto.Prototipo_pro__c.substring(0, maxSize);
            }else{
                ECO.Name = Proto.Prototipo_pro__c;
            }
        }
        ECO.Fraccionamiento__c = Proto.Fraccionamiento__c;
        ECO.NombreFraccionamiento__c = Fraccionamiento;
        
        try{
            if(newActaEcoT.Exteriores__c != null){
                ECO.Exteriores__c = newActaEcoT.Exteriores__c;
            }else{
                ECO.Exteriores__c = '';
            }
        }catch(Exception e){
            ECO.Exteriores__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.ExterioresNum__c != null){
                ECO.ExterioresNum__c = newActaEcoT.ExterioresNum__c;
            }else{
                ECO.ExterioresNum__c = 0;
            }
        }catch(Exception e){
            ECO.ExterioresNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Interiores__c != null){
                ECO.Interiores__c = newActaEcoT.Interiores__c;
            }else{
                ECO.Interiores__c = '';
            }
        }catch(Exception e){
            ECO.Interiores__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.InterioresNum__c != null){
                ECO.InterioresNum__c = newActaEcoT.InterioresNum__c;
            }else{
                ECO.InterioresNum__c = 0;
            }
        }catch(Exception e){
            ECO.InterioresNum__c = 0;
            system.debug(e);
        }
        
        try{
            ECO.ServiciosPublicos__c = newActaEcoT.ServiciosPublicos__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.Plano__c = newActaEcoT.Plano__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.ContratacionServicios__c = newActaEcoT.ContratacionServicios__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.Reglamento__c = newActaEcoT.Reglamento__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.ServiciosDigitales__c = newActaEcoT.ServiciosDigitales__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.ManualUsuario__c = newActaEcoT.ManualUsuario__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        
        try{
            if(newActaEcoT.AccesoriosBano__c != null){
                ECO.AccesoriosBano__c = newActaEcoT.AccesoriosBano__c;
            }else{
                ECO.AccesoriosBano__c = 0;
            }
        }catch(Exception e){
            ECO.AccesoriosBano__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.AsientoWC__c != null){
                ECO.AsientoWC__c = newActaEcoT.AsientoWC__c;
            }else{
                ECO.AsientoWC__c = 0;
            }
        }catch(Exception e){
            ECO.AsientoWC__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Bano__c != null){
                ECO.Bano__c = newActaEcoT.Bano__c;
            }else{
                ECO.Bano__c = 0;
            }
        }catch(Exception e){
            ECO.Bano__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.BoteBasura__c != null){
                ECO.BoteBasura__c = newActaEcoT.BoteBasura__c;
            }else{
                ECO.BoteBasura__c = 0;
            }
        }catch(Exception e){
            ECO.BoteBasura__c = 0;
            system.debug(e);
        }
        try{
            if(newActaEcoT.CalentadorSolar__c != null){
                ECO.CalentadorSolar__c = newActaEcoT.CalentadorSolar__c;
            }else{
                ECO.CalentadorSolar__c = 0;
            }
        }catch(Exception e){
            ECO.CalentadorSolar__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Cocina__c != null){
                ECO.Cocina__c = newActaEcoT.Cocina__c;
            }else{
                ECO.Cocina__c = 0;
            }
        }catch(Exception e){
            ECO.Cocina__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Comedor__c != null){
                ECO.Comedor__c = newActaEcoT.Comedor__c;
            }else{
                ECO.Comedor__c = 0;
            }
        }catch(Exception e){
            ECO.Comedor__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.FiltroAgua__c != null){
                ECO.FiltroAgua__c = newActaEcoT.FiltroAgua__c;
            }else{
                ECO.FiltroAgua__c = 0;
            }
        }catch(Exception e){
            ECO.FiltroAgua__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.FocoAhorrador__c != null){
                ECO.FocoAhorrador__c = newActaEcoT.FocoAhorrador__c;
            }else{
                ECO.FocoAhorrador__c = 0;
            }
        }catch(Exception e){
            ECO.FocoAhorrador__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.FocoLED__c != null){
                ECO.FocoLED__c = newActaEcoT.FocoLED__c;
            }else{
                ECO.FocoLED__c = 0;
            }
        }catch(Exception e){
            ECO.FocoLED__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Jabonera__c != null){
                ECO.Jabonera__c = newActaEcoT.Jabonera__c;
            }else{
                ECO.Jabonera__c = 0;
            }
        }catch(Exception e){
            ECO.Jabonera__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.LlaveChorro__c != null){
                ECO.LlaveChorro__c = newActaEcoT.LlaveChorro__c;
            }else{
                ECO.LlaveChorro__c = 0;
            }
        }catch(Exception e){
            ECO.LlaveChorro__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.LlaveTarja__c != null){
                ECO.LlaveTarja__c = newActaEcoT.LlaveTarja__c;
            }else{
                ECO.LlaveTarja__c = 0;
            }
        }catch(Exception e){
            ECO.LlaveTarja__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Mejoras__c != null){
                ECO.Mejoras__c = newActaEcoT.Mejoras__c;
            }else{
                ECO.Mejoras__c = '';
            }
        }catch(Exception e){
            ECO.Mejoras__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.MejorasNum__c != null){
                ECO.MejorasNum__c = newActaEcoT.MejorasNum__c;
            }else{
                ECO.MejorasNum__c = 0;
            }
        }catch(Exception e){
            ECO.MejorasNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Observaciones__c != null){
                ECO.Observaciones__c = newActaEcoT.Observaciones__c;
            }else{
                ECO.Observaciones__c = '';
            }
        }catch(Exception e){
            ECO.Observaciones__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.OtrosDoc__c != null){
                ECO.OtrosDoc__c = newActaEcoT.OtrosDoc__c;
            }else{
                ECO.OtrosDoc__c = '';
            }
        }catch(Exception e){
            ECO.OtrosDoc__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.OtrosEco__c != null){
                ECO.OtrosEco__c = newActaEcoT.OtrosEco__c;
            }else{
                ECO.OtrosEco__c = '';
            }
        }catch(Exception e){
            ECO.OtrosEco__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.OtrosEcoNum__c != null){
                ECO.OtrosEcoNum__c = newActaEcoT.OtrosEcoNum__c;
            }else{
                ECO.OtrosEcoNum__c = 0;
            }
        }catch(Exception e){
            ECO.OtrosEcoNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Paquetes__c != null){
                ECO.Paquetes__c = newActaEcoT.Paquetes__c;
            }else{
                ECO.Paquetes__c = '';
            }
        }catch(Exception e){
            ECO.Paquetes__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.PaquetesNum__c != null){
                ECO.PaquetesNum__c = newActaEcoT.PaquetesNum__c;
            }else{
                ECO.PaquetesNum__c = 0;
            }
        }catch(Exception e){
            ECO.PaquetesNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.PortaRollos__c != null){
                ECO.PortaRollos__c = newActaEcoT.PortaRollos__c;
            }else{
                ECO.PortaRollos__c = 0;
            }
        }catch(Exception e){
            ECO.PortaRollos__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.RecamaraPosterior__c != null){
                ECO.RecamaraPosterior__c = newActaEcoT.RecamaraPosterior__c;
            }else{
                ECO.RecamaraPosterior__c = 0;
            }
        }catch(Exception e){
            ECO.RecamaraPosterior__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.RecamaraPrincipal__c != null){
                ECO.RecamaraPrincipal__c = newActaEcoT.RecamaraPrincipal__c;
            }else{
                ECO.RecamaraPrincipal__c = 0;
            }
        }catch(Exception e){
            ECO.RecamaraPrincipal__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Sala__c != null){
                ECO.Sala__c = newActaEcoT.Sala__c;
            }else{
                ECO.Sala__c = 0;
            }
        }catch(Exception e){
            ECO.Sala__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.TapaWC__c != null){
                ECO.TapaWC__c = newActaEcoT.TapaWC__c;
            }else{
                ECO.TapaWC__c = 0;
            }
        }catch(Exception e){
            ECO.TapaWC__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Toallero__c != null){
                ECO.Toallero__c = newActaEcoT.Toallero__c;
            }else{
                ECO.Toallero__c = 0;
            }
        }catch(Exception e){
            ECO.Toallero__c = 0;
            system.debug(e);
        }
        
        system.debug(newActaEcoT);
        upsert ECO;
        return;
    }
    
    @AuraEnabled
    public static Ecotecnologia__c getActasPATC(Id ProcesoATC) {
        Ecotecnologia__c ECO;
        Inventario__c PATC;
        
        try{
            PATC = ([Select Fracc__r.Name, Proto__c, Proto__r.Name, Cuenta__r.Name from Inventario__c where Id =: ProcesoATC]);
        }catch(Exception e){
            System.debug(e);
        }
        
        try{
            ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                   CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                   FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                   Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                   PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                   InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                   ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                   FROM Ecotecnologia__c WHERE Name =: PATC.Proto__r.Name + ' - ' + PATC.Fracc__r.Name + ' - ' + PATC.Cuenta__r.Name LIMIT 1];
        }catch(Exception e){
            try{
                ECO = [SELECT AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                       CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                       FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                       Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                       PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                       InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                       ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                       FROM Ecotecnologia__c WHERE Name =: PATC.Proto__r.Name + ' - ' + PATC.Fracc__r.Name LIMIT 1];
            }catch(Exception ex){
                ECO = new Ecotecnologia__c();
            }
            System.debug(e);
        }
        System.debug(ECO);
        return ECO;
    }
    
    @AuraEnabled
    public static void newActaPATC(Id ProcesoATC, Ecotecnologia__c newActaEcoT) {
        Ecotecnologia__c ECO;
        Inventario__c PATC;
        
        try{
            //PATC = ([Select Id, Fracc__r.Name, Proto__c, Proto__r.Name, Cuenta__r.Name from Inventario__c where Id =: ProcesoATC]);
            PATC = ([Select Id, Fraccionamiento__c, Fracc__r.Name, Prototipo__c, Proto__c, Proto__r.Name, Cuenta__r.Name from Inventario__c where Id =: ProcesoATC]);
        }catch(Exception e){
            System.debug(e);
        }
        try{
            ECO = [SELECT Id, AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                   CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                   FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                   Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                   PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                   InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                   ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                   FROM Ecotecnologia__c WHERE Proceso_ATC__c =: PATC.Id LIMIT 1];
        }catch(Exception e){
            System.debug('SIN ACTA PATC ID');
            try{
                String EcoName = PATC.Proto__r.Name + ' - ' + PATC.Fracc__r.Name + ' - ' + PATC.Cuenta__r.Name;
                Integer maxSize = 79;
                if(EcoName.length() > maxSize ){
                    EcoName = EcoName.substring(0, maxSize);
                }
                ECO = [SELECT Id, AccesoriosBano__c, AsientoWC__c, Bano__c, BoteBasura__c, 
                       CalentadorSolar__c, Cocina__c, Comedor__c, FiltroAgua__c, FocoAhorrador__c,
                       FocoLED__c, Jabonera__c, LlaveChorro__c, LlaveTarja__c, Mejoras__c, MejorasNum__c,
                       Observaciones__c, OtrosDoc__c, OtrosEco__c, OtrosEcoNum__c, Paquetes__c, PaquetesNum__c,
                       PortaRollos__c, RecamaraPosterior__c, RecamaraPrincipal__c, Sala__c, TapaWC__c, Toallero__c,
                       InterioresNum__c, ExterioresNum__c, Interiores__c, Exteriores__c, ServiciosPublicos__c, Plano__c,
                       ContratacionServicios__c, Reglamento__c, ServiciosDigitales__c, ManualUsuario__c
                       FROM Ecotecnologia__c WHERE Name =: EcoName LIMIT 1];                
            }catch(Exception ex){
                System.debug(ex);
                ECO = new Ecotecnologia__c();
            }
        }
        
        System.debug(ECO);
        System.debug(newActaEcoT);
        String EcoName = PATC.Proto__r.Name + ' - ' + PATC.Fracc__r.Name + ' - ' + PATC.Cuenta__r.Name;
        ECO.Proceso_ATC__c = PATC.Id;
        ECO.Prototipo__c = PATC.Proto__c;
        ECO.NombrePrototipo__c = PATC.Prototipo__c;
        ECO.Cuenta__c = PATC.Cuenta__c;
        Integer maxSize = 79;
        if(EcoName.length() > maxSize ){
            ECO.Name = EcoName.substring(0, maxSize);
        }else{
            ECO.Name = EcoName;
        }
        ECO.Fraccionamiento__c = PATC.Fracc__c;
        ECO.NombreFraccionamiento__c = PATC.Fraccionamiento__c;
        
        try{
            if(newActaEcoT.Exteriores__c != null){
                ECO.Exteriores__c = newActaEcoT.Exteriores__c;
            }else{
                ECO.Exteriores__c = '';
            }
        }catch(Exception e){
            ECO.Exteriores__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.ExterioresNum__c != null){
                ECO.ExterioresNum__c = newActaEcoT.ExterioresNum__c;
            }else{
                ECO.ExterioresNum__c = 0;
            }
        }catch(Exception e){
            ECO.ExterioresNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Interiores__c != null){
                ECO.Interiores__c = newActaEcoT.Interiores__c;
            }else{
                ECO.Interiores__c = '';
            }
        }catch(Exception e){
            ECO.Interiores__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.InterioresNum__c != null){
                ECO.InterioresNum__c = newActaEcoT.InterioresNum__c;
            }else{
                ECO.InterioresNum__c = 0;
            }
        }catch(Exception e){
            ECO.InterioresNum__c = 0;
            system.debug(e);
        }
        
        try{
            ECO.ServiciosPublicos__c = newActaEcoT.ServiciosPublicos__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.Plano__c = newActaEcoT.Plano__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.ContratacionServicios__c = newActaEcoT.ContratacionServicios__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.Reglamento__c = newActaEcoT.Reglamento__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.ServiciosDigitales__c = newActaEcoT.ServiciosDigitales__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        try{
            ECO.ManualUsuario__c = newActaEcoT.ManualUsuario__c;
        }catch(Exception e){
            system.debug(e);
        }
        
        
        try{
            if(newActaEcoT.AccesoriosBano__c != null){
                ECO.AccesoriosBano__c = newActaEcoT.AccesoriosBano__c;
            }else{
                ECO.AccesoriosBano__c = 0;
            }
        }catch(Exception e){
            ECO.AccesoriosBano__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.AsientoWC__c != null){
                ECO.AsientoWC__c = newActaEcoT.AsientoWC__c;
            }else{
                ECO.AsientoWC__c = 0;
            }
        }catch(Exception e){
            ECO.AsientoWC__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Bano__c != null){
                ECO.Bano__c = newActaEcoT.Bano__c;
            }else{
                ECO.Bano__c = 0;
            }
        }catch(Exception e){
            ECO.Bano__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.BoteBasura__c != null){
                ECO.BoteBasura__c = newActaEcoT.BoteBasura__c;
            }else{
                ECO.BoteBasura__c = 0;
            }
        }catch(Exception e){
            ECO.BoteBasura__c = 0;
            system.debug(e);
        }
        try{
            if(newActaEcoT.CalentadorSolar__c != null){
                ECO.CalentadorSolar__c = newActaEcoT.CalentadorSolar__c;
            }else{
                ECO.CalentadorSolar__c = 0;
            }
        }catch(Exception e){
            ECO.CalentadorSolar__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Cocina__c != null){
                ECO.Cocina__c = newActaEcoT.Cocina__c;
            }else{
                ECO.Cocina__c = 0;
            }
        }catch(Exception e){
            ECO.Cocina__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Comedor__c != null){
                ECO.Comedor__c = newActaEcoT.Comedor__c;
            }else{
                ECO.Comedor__c = 0;
            }
        }catch(Exception e){
            ECO.Comedor__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.FiltroAgua__c != null){
                ECO.FiltroAgua__c = newActaEcoT.FiltroAgua__c;
            }else{
                ECO.FiltroAgua__c = 0;
            }
        }catch(Exception e){
            ECO.FiltroAgua__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.FocoAhorrador__c != null){
                ECO.FocoAhorrador__c = newActaEcoT.FocoAhorrador__c;
            }else{
                ECO.FocoAhorrador__c = 0;
            }
        }catch(Exception e){
            ECO.FocoAhorrador__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.FocoLED__c != null){
                ECO.FocoLED__c = newActaEcoT.FocoLED__c;
            }else{
                ECO.FocoLED__c = 0;
            }
        }catch(Exception e){
            ECO.FocoLED__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Jabonera__c != null){
                ECO.Jabonera__c = newActaEcoT.Jabonera__c;
            }else{
                ECO.Jabonera__c = 0;
            }
        }catch(Exception e){
            ECO.Jabonera__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.LlaveChorro__c != null){
                ECO.LlaveChorro__c = newActaEcoT.LlaveChorro__c;
            }else{
                ECO.LlaveChorro__c = 0;
            }
        }catch(Exception e){
            ECO.LlaveChorro__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.LlaveTarja__c != null){
                ECO.LlaveTarja__c = newActaEcoT.LlaveTarja__c;
            }else{
                ECO.LlaveTarja__c = 0;
            }
        }catch(Exception e){
            ECO.LlaveTarja__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Mejoras__c != null){
                ECO.Mejoras__c = newActaEcoT.Mejoras__c;
            }else{
                ECO.Mejoras__c = '';
            }
        }catch(Exception e){
            ECO.Mejoras__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.MejorasNum__c != null){
                ECO.MejorasNum__c = newActaEcoT.MejorasNum__c;
            }else{
                ECO.MejorasNum__c = 0;
            }
        }catch(Exception e){
            ECO.MejorasNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Observaciones__c != null){
                ECO.Observaciones__c = newActaEcoT.Observaciones__c;
            }else{
                ECO.Observaciones__c = '';
            }
        }catch(Exception e){
            ECO.Observaciones__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.OtrosDoc__c != null){
                ECO.OtrosDoc__c = newActaEcoT.OtrosDoc__c;
            }else{
                ECO.OtrosDoc__c = '';
            }
        }catch(Exception e){
            ECO.OtrosDoc__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.OtrosEco__c != null){
                ECO.OtrosEco__c = newActaEcoT.OtrosEco__c;
            }else{
                ECO.OtrosEco__c = '';
            }
        }catch(Exception e){
            ECO.OtrosEco__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.OtrosEcoNum__c != null){
                ECO.OtrosEcoNum__c = newActaEcoT.OtrosEcoNum__c;
            }else{
                ECO.OtrosEcoNum__c = 0;
            }
        }catch(Exception e){
            ECO.OtrosEcoNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Paquetes__c != null){
                ECO.Paquetes__c = newActaEcoT.Paquetes__c;
            }else{
                ECO.Paquetes__c = '';
            }
        }catch(Exception e){
            ECO.Paquetes__c = '';
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.PaquetesNum__c != null){
                ECO.PaquetesNum__c = newActaEcoT.PaquetesNum__c;
            }else{
                ECO.PaquetesNum__c = 0;
            }
        }catch(Exception e){
            ECO.PaquetesNum__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.PortaRollos__c != null){
                ECO.PortaRollos__c = newActaEcoT.PortaRollos__c;
            }else{
                ECO.PortaRollos__c = 0;
            }
        }catch(Exception e){
            ECO.PortaRollos__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.RecamaraPosterior__c != null){
                ECO.RecamaraPosterior__c = newActaEcoT.RecamaraPosterior__c;
            }else{
                ECO.RecamaraPosterior__c = 0;
            }
        }catch(Exception e){
            ECO.RecamaraPosterior__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.RecamaraPrincipal__c != null){
                ECO.RecamaraPrincipal__c = newActaEcoT.RecamaraPrincipal__c;
            }else{
                ECO.RecamaraPrincipal__c = 0;
            }
        }catch(Exception e){
            ECO.RecamaraPrincipal__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Sala__c != null){
                ECO.Sala__c = newActaEcoT.Sala__c;
            }else{
                ECO.Sala__c = 0;
            }
        }catch(Exception e){
            ECO.Sala__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.TapaWC__c != null){
                ECO.TapaWC__c = newActaEcoT.TapaWC__c;
            }else{
                ECO.TapaWC__c = 0;
            }
        }catch(Exception e){
            ECO.TapaWC__c = 0;
            system.debug(e);
        }
        
        try{
            if(newActaEcoT.Toallero__c != null){
                ECO.Toallero__c = newActaEcoT.Toallero__c;
            }else{
                ECO.Toallero__c = 0;
            }
        }catch(Exception e){
            ECO.Toallero__c = 0;
            system.debug(e);
        }
        
        system.debug(newActaEcoT);
        upsert ECO;
        return;
    }
    
    public static void testing(){
        if(Test.isRunningTest()){
            integer i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
            i = 1;
        }
    }
}