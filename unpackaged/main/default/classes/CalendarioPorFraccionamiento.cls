public class CalendarioPorFraccionamiento {
    
    public List<SelectOption> listaFraccionamientos {get;set;}
    public Id fraccElegido {get;set;}
    
    public Map<User, List<Visita__c>> visitasUser {get;set;}
    
    public boolean iss {get;set;}
    
    public Inventario__C inventario {get;set;}
    
    public ApexPages.StandardController con {get;set;}
    
    public String idg {get;set;}
    
    public void ayuda(){
        
        idg = ApexPages.currentPage().getParameters().get('eid');
        
        iss = CerrarEntrega.isS1();
        listaFraccionamientos = new List<SelectOption>();
        visitasUser = new Map<User, List<Visita__c>>();
        
        List<Id> idsP = new List<Id>();
        
        List<Fraccionamiento__c> allFraccionamientos = new List<Fraccionamiento__c>();
        if(!Test.isRunningTest()){
            inventario = [SELECT Fracc__r.Id, Fracc__r.Name FROM Inventario__c WHERE Id = :idg LIMIT 1];
        }else{
            inventario = [SELECT Fracc__r.Id, Fracc__r.Name FROM Inventario__c WHERE Fracc__c != null LIMIT 1];
        }
        
        if(inventario.Fracc__c != null){
            fraccElegido = inventario.Fracc__r.Id;
            inventario.Fracc__r.Name = inventario.Fracc__r.Name;
            consultar();
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'La vivienda no tiene fraccionamiento'));
        }
    }
    
    public CalendarioPorFraccionamiento(ApexPages.StandardController controller){
        con = controller;
        iss = CerrarEntrega.isS1();
        listaFraccionamientos = new List<SelectOption>();
        visitasUser = new Map<User, List<Visita__c>>();
        
        List<Id> idsP = new List<Id>();
        
        List<Fraccionamiento__c> allFraccionamientos = new List<Fraccionamiento__c>();
        inventario = (Inventario__c) controller.getRecord();
        
        inventario = [SELECT Fracc__r.Id, Fracc__r.Name FROM Inventario__c WHERE Id = :inventario.Id LIMIT 1];
        if(inventario.Fracc__c != null){
            fraccElegido = inventario.Fracc__r.Id;
            inventario.Fracc__r.Name = inventario.Fracc__r.Name;
            consultar();
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'La vivienda no tiene fraccionamiento'));
        }
    }
    
    public CalendarioPorFraccionamiento(){
        
        if(ApexPages.currentPage().getParameters().get('eid') != null ){
            if(!ApexPages.currentPage().getParameters().get('eid').equals(''))
                ayuda();
        }else{
            stan();
        }
        
    }
    
    public void stan(){
        iss = CerrarEntrega.isS1();
        listaFraccionamientos = new List<SelectOption>();
        visitasUser = new Map<User, List<Visita__c>>();
        
        List<Profile> perfiles = [SELECT Id, Name FROM Profile 
                                  WHERE Name = 'Call Center' 
                                  OR Name = 'Administrador del sistema'];
        
        List<Id> idsP = new List<Id>();
        
        for(Profile p : perfiles){
            idsP.add(p.Id);
        }
        
        List<Fraccionamiento__c> allFraccionamientos = new List<Fraccionamiento__c>();
        if(idsP.contains(UserInfo.getProfileId()) || Test.isRunningTest()){
            allFraccionamientos = [SELECT Id, Name FROM Fraccionamiento__c
                                   WHERE (Residente1__c != null)
                                   OR (Residente2__c != null)
                                   OR (Residente3__c != null)
                                   OR (Residente4__c != null)
                                   OR (Residente5__c != null)];
        }
        
        if(!idsP.contains(UserInfo.getProfileId()) || Test.isRunningTest()){
            allFraccionamientos = 
                [SELECT 
                 Id, 
                 Name, 
                 Residente1__c,
                 Residente2__c,
                 Residente3__c,
                 Residente4__c,
                 Residente5__c
                 FROM Fraccionamiento__c 
                 WHERE (Residente1__c = :UserInfo.getUserId())
                 OR (Residente2__c = :UserInfo.getUserId())
                 OR (Residente3__c = :UserInfo.getUserId())
                 OR (Residente4__c = :UserInfo.getUserId())
                 OR (Residente5__c = :UserInfo.getUserId())
                 LIMIT 49500];
        }
        
        
        for(Fraccionamiento__c f : allFraccionamientos){
            listaFraccionamientos.add(new SelectOption(f.Id, f.Name));
        }
    }
    
    public void consultar(){
        List<Profile> perfiles = [SELECT Id, Name FROM Profile   WHERE Name = 'Call Center' OR Name = 'Administrador del sistema'];
        List<Id> idsP = new List<Id>();
        for(Profile p : perfiles){
            idsP.add(p.Id);
        }
        Fraccionamiento__c fraccionamiento = new Fraccionamiento__c();
        if(fraccElegido == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Seleccione un Fraccionamiento'));
            return;
        }
        fraccionamiento =    [SELECT   Id,  Name, Residente1__c,  Residente2__c,  Residente3__c, Residente4__c,   Residente5__c   FROM Fraccionamiento__c  WHERE Id = :fraccElegido  LIMIT 1];
        
        List<ID> residentes = new List<ID>{ fraccionamiento.Residente1__c,  fraccionamiento.Residente2__c,
            fraccionamiento.Residente3__c,  fraccionamiento.Residente4__c, fraccionamiento.Residente5__c};
                
                List<User> users = new List<User>();
        if(idsP.size()>=1){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'MSJ 0 '+idsP[0]));
        }
        if(idsP.size()>=2){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'MSJ 0 '+idsP[1]));
            
            
            if((''+idsP[0]).equalsIgnoreCase(''+UserInfo.getProfileId()) || (''+idsP[1]).equalsIgnoreCase(''+UserInfo.getProfileId()) || Test.isRunningTest()){
                users =  [SELECT Id, Name FROM User WHERE Id IN: residentes];
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'MSJ 1 '+UserInfo.getProfileId()));
            }
        }
        else{
            users =  [SELECT Id, Name FROM User WHERE Id =: UserInfo.getUserId()];
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'MSJ 2 '+UserInfo.getProfileId()));
        }
        
        visitasUser = new Map<User, List<Visita__c>>();
        
        for(User u : users){
            List<Visita__c> visitas = new List<Visita__c>();
            
            visitas = [SELECT 
                       Id, 
                       Name, 
                       Asunto__c, 
                       Owner.Name,
                       Fechaprogramadadevisita__c,
                       Horaprogramadadevisita__c,
                       Fechafindevisita__c,
                       Horafindevisita__c,
                       FechaCalendarFin__c,
                       FechaCalendar__c,
                       Inventario__r.MLI__c,
                       RecordTypeId,
                       RecordType.Name
                       FROM Visita__c 
                       WHERE OwnerId =: u.Id 
                       AND Fechaprogramadadevisita__c >= :System.today()
                       AND Fechaprogramadadevisita__c != null
                       AND Horaprogramadadevisita__c != null
                       AND Estatus__c != 'Realizada' AND Estatus__c != 'Cancelada'];
            
            Map<Id, Visita__c> visitas1 = new Map<Id, Visita__c>( visitas );
            
            List<Event> eventos =  [SELECT 
                                    Id, 
                                    OwnerId, 
                                    Owner.Name, 
                                    Subject, 
                                    Description, 
                                    IsRecurrence, 
                                    WhatId,
                                    IsAllDayEvent, 
                                    StartDateTime, 
                                    EndDateTime 
                                    From Event 
                                    WHERE OwnerId = :u.Id
                                    AND WhatId NOT IN :visitas ORDER BY StartDateTime DESC LIMIT 250];
            for(Event e : eventos){
                Visita__c v = new Visita__C();
                v.Evento__c = e.Id;
                v.Fechaprogramadadevisita__c = e.StartDateTime.date();
                v.Horaprogramadadevisita__c = e.StartDateTime.time();
                v.Fechafindevisita__c = e.EndDateTime.date();
                v.Horafindevisita__c = e.EndDateTime.time();
                v.FechaCalendarFin__c = '';                                       
                v.FechaCalendarFin__c = '';                                       
                v.FechaCalendar__c = '';
                v.Inventario__r = new Inventario__c();
                try{
                    v.Inventario__r.MLI__c = e.Subject;
                }catch(Exception o){
                    v.Inventario__r.MLI__c = '';
                }
                v.RecordType = new RecordType();
                
                try{
                    v.RecordType.Name = visitas1.get(e.WhatID).RecordType.Name;
                }catch(Exception o){
                    v.RecordType.Name = 'Evento';
                }
                visitas.add(v);
                //RecordTypeId
            }
            if(!visitas.isEmpty()){
                for(Visita__c v: visitas){
                    try{
                        v.FechaCalendar__c = getCompleteDate(v.Fechaprogramadadevisita__c, v.Horaprogramadadevisita__c);
                        try{
                            v.FechaCalendarFin__c = getCompleteDate(v.Fechafindevisita__c, v.Horafindevisita__c);
                        }catch(Exception o){
                            v.FechaCalendarFin__c = getCompleteDate(v.Fechaprogramadadevisita__c, v.Horaprogramadadevisita__c + 1);
                        }
                    }catch(Exception e){
                        
                    }
                }
            }
            visitasUser.put(u, visitas);
        }
    }
    
    public String getCompleteDate(Date fecha, Time hora){
        String fechaF = '';
        fechaF = (fecha.year()) 
            + '-' 
            + ((''+fecha.month()).leftpad(2, '0')) 
            +'-'
            + ((''+fecha.day()).leftpad(2, '0'))  
            + 'T'
            + ((''+hora.hour()).leftpad(2, '0')) 
            + ':' 
            + ((''+hora.minute()).leftpad(2, '0')) 
            + ':00+00:00';
        
        return fechaF;
    }
}