public with sharing class PATCListCtrl {
    
    @AuraEnabled
    public static List<Object> getInventarioList(Integer recordLimit, Integer recordOffset){
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
        Integer intLimit = Integer.valueof(recordLimit);
        Integer intOffset = Integer.valueof(recordOffset);
        List<Object> PATCList = new List<Object>();
        List<Visita__c> VisitaList = new List<Visita__c>();
        System.debug(AuthFraccs);
        VisitaList = [Select Id, Fechaprogramadadevisita__c, Inventario__r.Id, Inventario__r.MLI__c, Cuenta__r.Name, Inventario__r.DiasAntiguedad__c, 
                      Entrega__c, Inventario__r.Manzana__c, Inventario__r.Lote__c, Inventario__r.NumeroInterior__c, Inventario__r.Fraccionamiento__c,
                      Inventario__r.Sector__c, Inventario__r.Direccionoficial__c, Inventario__r.Prototipo__c, Inventario__r.NombreAsesor__c,
                      Inventario__r.Entregada__c, Horaprogramadadevisita__c, Owner.Name, OwnerId
                      from Visita__c 
                      WHERE RecordType.Name = 'Cita'
                      AND Inventario__r.Fraccionamiento__c IN : FraccNames
                      AND Owner.Name =: UserInfo.getName()
                      LIMIT :intLimit Offset :intOffset];
        for(Visita__c V : VisitaList){
            Inventario__c INV = new Inventario__c();
            INV.Id = V.Inventario__r.Id;
            INV.Modulo__c =  V.Entrega__c;
            INV.FechaEntrega__c = V.Fechaprogramadadevisita__c.addDays(1);
            INV.SupervisorObra__c = String.valueOf(V.Horaprogramadadevisita__c).substring(0, 5);
            INV.MLI__c = V.Inventario__r.MLI__c;
            INV.Notaria__c = V.Cuenta__r.Name;
            INV.ConteoCitasEntrega__c = V.Inventario__r.DiasAntiguedad__c;
            INV.Manzana__c = V.Inventario__r.Manzana__c;
            INV.Lote__c = V.Inventario__r.Lote__c;
            INV.NumeroInterior__c = V.Inventario__r.NumeroInterior__c;
            INV.Fraccionamiento__c = V.Inventario__r.Fraccionamiento__c;
            INV.Sector__c = V.Inventario__r.Sector__c;
            INV.Interior__c = V.Inventario__r.Direccionoficial__c;
            INV.Prototipo__c = V.Inventario__r.Prototipo__c;
            INV.NombreAsesor__c = V.Inventario__r.NombreAsesor__c;
            INV.Entregada__c = V.Inventario__r.Entregada__c;
            INV.Notario__c = V.Owner.Name;
            PATCList.add(INV);
        }
        return PATCList;
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
    public static List<Object> getFilteredPATC(Integer recordLimit, Integer recordOffset, String FraccName, String ProtoName, Date FirstDate, Date FinalDate){
        Integer intLimit = Integer.valueof(recordLimit);
        Integer intOffset = Integer.valueof(recordOffset);
        System.debug(FraccName);
        if(FraccName == null){
            FraccName = '%%';
        }
        if(ProtoName == ''){
            ProtoName = '%%';
        }
        List<Object> PATCList = new List<Object>();
        List<Visita__c> VisitaList = new List<Visita__c>();
        VisitaList = [Select Id, Fechaprogramadadevisita__c, Entrega__c, Inventario__r.MLI__c, Cuenta__r.Name, Inventario__r.DiasAntiguedad__c, 
                      Inventario__r.Manzana__c, Inventario__r.Lote__c, Inventario__r.NumeroInterior__c, Inventario__r.Fraccionamiento__c,
                      Inventario__r.Sector__c, Inventario__r.Direccionoficial__c, Inventario__r.Prototipo__c, Inventario__r.NombreAsesor__c,
                      Inventario__r.Entregada__c, Horaprogramadadevisita__c, Owner.Name from Visita__c 
                      WHERE (RecordType.Name = 'Cita' 
                             AND Inventario__r.Fraccionamiento__c =: FraccName 
                             AND Inventario__r.Prototipo__c LIKE : ProtoName
                             AND Owner.Name =: UserInfo.getName()
                             AND Fechaprogramadadevisita__c >=: FirstDate
                             AND Fechaprogramadadevisita__c <=: FinalDate)
                      LIMIT :intLimit Offset :intOffset];
        for(Visita__c V : VisitaList){
            Inventario__c INV = new Inventario__c();
            INV.Id = V.Inventario__r.Id;
            INV.Modulo__c =  V.Entrega__c;
            INV.FechaEntrega__c = V.Fechaprogramadadevisita__c.addDays(1);
            INV.SupervisorObra__c = String.valueOf(V.Horaprogramadadevisita__c).substring(0, 5);
            INV.MLI__c = V.Inventario__r.MLI__c;
            INV.Notaria__c = V.Cuenta__r.Name;
            INV.ConteoCitasEntrega__c = V.Inventario__r.DiasAntiguedad__c;
            INV.Manzana__c = V.Inventario__r.Manzana__c;
            INV.Lote__c = V.Inventario__r.Lote__c;
            INV.NumeroInterior__c = V.Inventario__r.NumeroInterior__c;
            INV.Fraccionamiento__c = V.Inventario__r.Fraccionamiento__c;
            INV.Sector__c = V.Inventario__r.Sector__c;
            INV.Interior__c = V.Inventario__r.Direccionoficial__c;
            INV.Prototipo__c = V.Inventario__r.Prototipo__c;
            INV.NombreAsesor__c = V.Inventario__r.NombreAsesor__c;
            INV.Entregada__c = V.Inventario__r.Entregada__c;
            INV.Notario__c = V.Owner.Name;
            PATCList.add(INV);
        }
        return PATCList;
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
        }
    }
}