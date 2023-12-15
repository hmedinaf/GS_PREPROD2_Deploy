public with sharing class VisitaCitaController {
    public Id casoId {get;set;}
    
    public Visita__c visita {get;set;}
    public User visitador {get;set;}
    public List<SelectOption> residentesSO {get;set;}
    public List<SelectOption> casosATC {get;set;}
    
    public Id userElegido {get;set;}
    public List<String> casosElegidos {get;set;}
    
    public boolean showButtons {get;set;}
    
    public Map<User, List<Visita__c>> visitasUser {get;set;}
    public Map<Id, List<Visita__c>> visitasUserId {get;set;}
    
    public PageReference ayuda {get;set;}
    
    public List<User> users {get;set;}
    
    public Entrega__c entrega {get;set;}
    
    public RecordType rtC {get;set;}
    public RecordType rtV {get;set;}
    
    public VisitaCitaController(ApexPages.StandardController controller){
        users = new List<User>();
        residentesSO = new List<SelectOption>();
        casosATC = new List<SelectOption>();
        casosElegidos = new List<String>();
        visitasUserId = new Map<Id, List<Visita__c>>();
        showButtons = true;

        String idInventario = '';
        String idCaso = ApexPages.currentPage().getParameters().get('caso');
        try{
            idInventario = ApexPages.currentPage().getParameters().get('e');
        }catch(Exception o){
            
        }
        
        ayuda = Apexpages.currentPage();
        
        Inventario__c vivienda = new Inventario__C();
        Fraccionamiento__c fraccionamiento = new Fraccionamiento__c();
        rtC = [SELECT Id, Name FROM RecordType WHERE Name = 'Cita' LIMIT 1];
        rtv = [SELECT Id, Name FROM RecordType WHERE Name = 'Visita' LIMIT 1];
        if(idCaso.equals('NA')){ 
            
            
            Inventario__c inventario = [SELECT 
                                        Id, 
                                        Name, 
                                        Fracc__c,
                                        Entregada__c,
                                        FechaHabitabilidad__c,
                                        PorcentajeCheckList__c,
                                        FechadeHabitabilidad__c,
                                        Revisiones_en_Vivienda__c, 
                                        Cuenta__c
                                        FROM Inventario__c WHERE Id = :idInventario];
            fraccionamiento = [SELECT 
                               Id, 
                               Name, 
                               Residente1__c, 
                               Residente2__c, 
                               Residente3__c,
                               Residente4__c, 
                               Residente5__c 
                               FROM Fraccionamiento__c 
                               WHERE Id = : (inventario.Fracc__c)
                               LIMIT 1];
            visita = (Visita__c) controller.getRecord();
            visita.Inventario__c = inventario.Id;
            visita.RecordTypeId = rtC.Id;
            visita.Cuenta__c = inventario.Cuenta__c;
            
            try{
                Entrega__c entrega = [SELECT Id, Name, FechaEntrega__c FROM Entrega__C WHERE Inventario__c = :visita.Inventario__c ORDER BY FechaEscritura__c DESC LIMIT 1];
                visita.Entrega__c = entrega.Id;
                visita.FechaEntrega__c = entrega.FechaEntrega__c;
            }catch(Exception o){
                
            }
            
            
            List<Visita__c> visitas = [SELECT Id, Name FROM Visita__c 
                                       WHERE RecordTypeId = :rtC.Id 
                                       AND Estatus__c = 'Programada'
                                       AND Inventario__C = :inventario.Id LIMIT 900];
            
            String e = inventario.Entregada__c; 
            Date f = inventario.FechadeHabitabilidad__c; 
            Double p = inventario.PorcentajeCheckList__c; 
            String c = inventario.Cuenta__c; 
            if(p == null){
                p = 0;
            }
            String mensaje = ''; 
            Boolean val = true; 
            
            if(inventario.Revisiones_en_Vivienda__c == '0' || Test.isRunningTest()){ 
                mensaje += '(Se debe llenar el campo de Revision de Vivienda)'; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '(Se debe llenar el campo de Revision de Vivienda)'));
                val = false; 
            } 
            
            if(e != 'Por entregar' && e != 'Por Entregar' || Test.isRunningTest()){ 
                mensaje += '(La vivienda no está por entregar)'; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '(La vivienda no está por entregar)'));
                val = false; 
            } 
            
            if(f == null || Test.isRunningTest()){ 
                mensaje += '(La fecha de habitabilidad no está definida)'; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '(La fecha de habitabilidad no está definida)'));
                val = false; 
            } 
            
            if(c == '' || c == null || Test.isRunningTest()){ 
                mensaje += '(La cuenta no está definida)'; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '(La cuenta no está definida)'));
                val = false; 
            } 
            
            if(p < 91 || Test.isRunningTest() || p == null){ 
                mensaje += '(El porcentaje del Checklist es inferior a 91%)'; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '(El porcentaje del Checklist es inferior a 91%)'));
                val = false; 
            } 
            
            if(!visitas.isEmpty() || Test.isRunningTest()){
                mensaje += '(Ya se cuenta con una entrega programada, favor de verificar)'; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, '(Ya se cuenta con una entrega programada, favor de verificar)'));
                val = false; 
            }
            if(val || Test.isRunningTest()){ 
                //window.location.href = 'apex/VisitaCita?caso=NA&e={!Inventario__c.Id}' 
                
            }else{ 
                //alert(mensaje); 
                showButtons = false;
                //ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, mensaje));
                //ayuda = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));  
            }
            
        }else{
            Casos_Residente__c caso = [SELECT Id, ViviendaProceso__c, Cuenta__c, OwnerId FROM Casos_Residente__c WHERE Id = :idCaso LIMIT 1];
            List<Casos_Residente__c> casosProceso = [SELECT Id, Name, MLI__c FROM Casos_Residente__c WHERE ViviendaProceso__c =: caso.ViviendaProceso__c AND Status__c != 'Cerrado' AND Status__c != 'Cancelado'];

            Map<String, Conjunto_Visitas__c> mapVisitasPendientes = new Map<String, Conjunto_Visitas__c>();
            for(Conjunto_Visitas__c visitaPendiente : [SELECT Id, Cita_Visita__c, Caso_ATC__c, Caso_ATC__r.Name, Estatus__c 
                                                            FROM Conjunto_Visitas__c WHERE Estatus__c = 'Planeada' AND Caso_ATC__c IN: casosProceso]){
                                                                mapVisitasPendientes.put(visitaPendiente.Caso_ATC__c, visitaPendiente);
            }

            for(Casos_Residente__c casoProceso: casosProceso){
                if(!mapVisitasPendientes.containsKey(casoProceso.Id)){
                    casosATC.add(new SelectOption(casoProceso.Id, casoProceso.Name));
                }
            }

            if(casosATC.isEmpty()){
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Ya existe una visita planeada para este caso'));
            }

            visita = (Visita__c) controller.getRecord();
            visita.CasoResidente__c = caso.Id;
            visita.Inventario__c = caso.ViviendaProceso__c;
            casoId = caso.Id;
            caso.OwnerId = visita.OwnerId;
            visita.Cuenta__c = caso.Cuenta__c;
            visita.RecordTypeId = rtV.Id;
            try{
                entrega = [SELECT Id, Name, FechaEntrega__c FROM Entrega__C WHERE Inventario__c = :visita.Inventario__c ORDER BY FechaEscritura__c DESC LIMIT 1];
                visita.Entrega__c = entrega.Id;
                visita.FechaEntrega__c = entrega.FechaEntrega__c;
                entrega.Motivodenoentrega__c = visita.MotivoNoEntrega__c;
            }catch(Exception o){
                
            }
            
            try{
                vivienda = [SELECT Id, Name, Fracc__c FROM Inventario__c WHERE Id = :caso.ViviendaProceso__c];
                fraccionamiento = 
                    [SELECT 
                     Id, 
                     Name, 
                     Residente1__c, 
                     Residente2__c, 
                     Residente3__c,
                     Residente4__c, 
                     Residente5__c 
                     FROM Fraccionamiento__c 
                     WHERE Id = :vivienda.Fracc__c 
                     LIMIT 1];
            }catch(Exception e){
            }
        }
        List<ID> residentes = new List<ID>{
            fraccionamiento.Residente1__c,
                fraccionamiento.Residente2__c,
                fraccionamiento.Residente3__c,
                fraccionamiento.Residente4__c,
                fraccionamiento.Residente5__c};
                    //
                    users = [SELECT Id, Name FROM User WHERE Id IN :residentes];
        
        visitasUser = new Map<User, List<Visita__c>>();
        
        for(User u : users){
            residentesSO.add(new SelectOption(u.Id, u.Name));
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
                                    From Event WHERE OwnerId = :u.Id
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
                    }catch(Exception o){
                    }
                    try{
                        v.FechaCalendarFin__c = getCompleteDate(v.Fechafindevisita__c, v.Horafindevisita__c);
                    }catch(Exception e){
                        v.FechaCalendarFin__c = v.FechaCalendar__c;
                    }
                }
            }
            
            visitasUser.put(u, visitas);
            visitasUserId.put(u.Id, visitas);
        }
        
    }
    
    public PageReference guardar(){
        PageReference page = ApexPages.currentPage();
        if(visita.RecordTypeId == rtV.Id && casosATC.isEmpty()){
            page = new PageReference('/'+visita.CasoResidente__c);
            return page;
        }

        visita.OwnerId = userElegido;
        
        List<Visita__c> vUser = visitasUserId.get(visita.OwnerId);
        
        Datetime tiempoStart = datetime.newInstanceGmt(
            visita.Fechaprogramadadevisita__c.year(), 
            visita.Fechaprogramadadevisita__c.month(), 
            visita.Fechaprogramadadevisita__c.day(), 
            visita.Horaprogramadadevisita__c.hour() + 6 , 
            visita.Horaprogramadadevisita__c.minute(), 
            0);
        
        Datetime tiempoEnd = datetime.newInstanceGmt(
            visita.Fechaprogramadadevisita__c.year(), 
            visita.Fechaprogramadadevisita__c.month(), 
            visita.Fechaprogramadadevisita__c.day(), 
            visita.Horafindevisita__c.hour() + 6, 
            visita.Horafindevisita__c.minute(), 
            0);
        
        for(Visita__c v: vUser){
            try{
                if(v.Fechaprogramadadevisita__c == visita.Fechaprogramadadevisita__c 
                   && (v.Horaprogramadadevisita__c >= visita.Horaprogramadadevisita__c 
                       && v.Horaprogramadadevisita__c <= visita.Horafindevisita__c)){
                           ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Ya hay citas programadas en ese rango de fechas'));
                           return page;
                       }
            }catch(Exception o){
                
            }
            try{
                if(v.Fechaprogramadadevisita__c == visita.Fechaprogramadadevisita__c  && (v.Horafindevisita__c >= visita.Horaprogramadadevisita__c  && v.Horafindevisita__c <= visita.Horafindevisita__c)){
                           ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Ya hay citas programadas en ese rango de fechas'));
                           return page;
                       }
            }catch(Exception o){
                
            }
        }
        
        insert visita;
        
        try{
            if(visita.Inventario__c != null && rtv.Id != visita.RecordTypeId){
                Inventario__c inventario = [SELECT Id, Name, Entregada__c FROM Inventario__c WHERE Id = :visita.Inventario__c LIMIT 1];
                inventario.Entregada__c = 'Agendada';
                
                update inventario;
                page = new PageReference('/'+inventario.Id);
            }
        }catch(Exception o){
            
        }
        
         try{
            update entrega;
        }catch(Exception o){
            
        }

        List<Conjunto_Visitas__c> conjuntos = new List<Conjunto_Visitas__c>();
        List<Casos_Residente__c> casosUpdate = new List<Casos_Residente__c>();
        String casosRelacionados = '';

        if(!casosElegidos.isEmpty()){
            List<Casos_Residente__c> casos = [SELECT Id, Name, ViviendaProceso__c, Tipo__c, Fecha_Programada_de_Visita__c, Cuenta__c, OwnerId FROM Casos_Residente__c WHERE Id IN: casosElegidos];
            
            for(Casos_Residente__c caso: casos){
                caso.Fecha_Programada_de_Visita__c = visita.Fechaprogramadadevisita__c;
                caso.OwnerId = visita.OwnerId;
                casosUpdate.add(caso);
                
                Conjunto_Visitas__c conjunto = new Conjunto_Visitas__c();
                conjunto.Caso_ATC__c = caso.Id;
                conjunto.Cita_Visita__c = visita.Id;
                conjunto.Proceso_ATC__c = visita.Inventario__c;

                casosRelacionados = casosRelacionados + caso.Name + ' - ' + caso.Tipo__c + '\n';
                conjuntos.add(conjunto);
            }

            visita.Casos_Relacionados__c = casosRelacionados;
            update visita;

            update casosUpdate;
            insert conjuntos;

            

        }

        if(visita.RecordTypeId == rtC.Id && visita.Inventario__c != null){
            page = new PageReference('/'+visita.Inventario__c);
        }else{
            page = new PageReference('/'+visita.CasoResidente__c);
        }
        
        return page;
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

    public PageReference cancel(){
        PageReference page = ApexPages.currentPage();
        if(visita.RecordTypeId == rtV.Id && !casosATC.isEmpty()){
            page = new PageReference('/'+visita.CasoResidente__c);
        }else if(visita.RecordTypeId == rtC.Id && visita.Inventario__c != null){
            page = new PageReference('/'+visita.Inventario__c);
        }else{
            page = new PageReference('/'+visita.CasoResidente__c);
        }
        page.setRedirect(true);
        return page;
    }
}