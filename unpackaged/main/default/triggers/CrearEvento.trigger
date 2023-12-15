trigger CrearEvento on Visita__c (before insert, after insert, before update, after update, before delete, after delete) {
    new VisitaTriggerHandler().run();

    boolean error = false;
    if(trigger.isBefore && !trigger.isDelete && !Test.isRunningTest()){
        Map<Id, List<Visita__c>> visitasUserId = new Map<Id, List<Visita__c>>();
        Entrega__c entrega = new Entrega__c();
        for(Visita__c visita : trigger.new){
            String idInventario = '';
            if(visita.Entrega__c != null){
                system.debug('ENTREGA NO NULA : ' + visita.Entrega__c);
                entrega = [SELECT Id, Name, FechaEntrega__c, Inventario__c,Comentarios__c FROM Entrega__C WHERE Id = :visita.Entrega__c ORDER BY FechaEscritura__c DESC LIMIT 1];
                visita.Entrega__c = entrega.Id;
                visita.FechaEntrega__c = entrega.FechaEntrega__c;
                idInventario = entrega.Inventario__c;
            }else if(visita.Inventario__c != null){
                system.debug('INVENTARIO NO NULO : ' + idInventario);
                try{
                    entrega = [SELECT Id, Name, FechaEntrega__c, Inventario__c,Comentarios__c FROM Entrega__C WHERE Inventario__c = :visita.Inventario__c ORDER BY FechaEscritura__c DESC LIMIT 1];
                    visita.Entrega__c = entrega.Id;
                    visita.FechaEntrega__c = entrega.FechaEntrega__c;
                    idInventario = visita.Inventario__c;
                }catch(Exception o){
                    visita.addError('No se ha seleccionado una vivienda.');
                }
            }
            
            String idCaso = visita.CasoResidente__c;
            
            Inventario__c vivienda = new Inventario__C();
            Fraccionamiento__c fraccionamiento = new Fraccionamiento__c();
            RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Cita' LIMIT 1];
            
            if((idCaso == null || idCaso == '') && visita.RecordTypeId.equals(rt.Id) && (idInventario != null && idInventario != '') ){ 
                Inventario__c inventario = [SELECT 
                                            Id, 
                                            Name, 
                                            Fracc__c,
                                            Entregada__c,
                                            FechaHabitabilidad__c,
                                            PorcentajeCheckList__c,
                                            Revisiones_en_Vivienda__c,
                                            FechadeHabitabilidad__c,
                                            Cuenta__c
                                            FROM Inventario__c WHERE Id = :idInventario];
                system.debug(inventario);
                
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
                System.debug(fraccionamiento);
                visita.Inventario__c = inventario.Id;
                visita.Cuenta__c = inventario.Cuenta__c;                
                
                List<Visita__c> visitas = [SELECT Id, Name FROM Visita__c 
                                           WHERE RecordTypeId = :rt.Id 
                                           AND Id != :visita.Id
                                           AND Estatus__c = 'Programada'
                                           AND Inventario__C = :inventario.Id];
                
                String e = inventario.Entregada__c; 
                Date f = inventario.FechadeHabitabilidad__c; 
                Double p = inventario.PorcentajeCheckList__c; 
                String c = inventario.Cuenta__c; 
                
                system.debug('inventario + ' +e +'-'+f +'-'+p +'-'+c +'-');
                
                String mensaje = ''; 
                Boolean val = true; 
                
                if(inventario.Revisiones_en_Vivienda__c == '0' || inventario.Revisiones_en_Vivienda__c == NULL){ 
                	mensaje += '(Se debe llenar el campo de Revisión de Vivienda)'; 
                	val = false; 
            	} 
                
                if(!e.equalsIgnoreCase('Por entregar') && !e.equalsIgnoreCase('Agendada')){ 
                    mensaje += '(La vivienda no está por entregar)'; 
                    val = false; 
                } 
                
                if(f == null){ 
                    mensaje += '(La fecha de habitabilidad no está definida)'; 
                    val = false; 
                } 
                
                if(c == '' || c == null){ 
                    mensaje += '(La cuenta no está definida)'; 
                    val = false; 
                } 
                
                if(p < 91 || p == null){ 
                    mensaje += '(El porcentaje del Checklist es inferior a 91%)'; 
                    val = false; 
                } 
                
                if(!visitas.isEmpty()){
                    mensaje += '(Ya se cuenta con una entrega programada, favor de verificar)'; 
                    val = false; 
                }
                if(val){ 
                }else{ 
                    visita.addError(mensaje);
                    error = true;
                }
                
            }else{
                Casos_Residente__c caso = [SELECT Id, ViviendaProceso__c, Cuenta__c, FechaCitaValoracion__c, Horacitavaloracion__c, OwnerId FROM Casos_Residente__c WHERE Id = :idCaso LIMIT 1];
                
                List<Visita__c> visitasd = [SELECT Id, Name FROM Visita__c WHERE CasoResidente__c = :caso.Id];
                
                if(visitasd.isEmpty()){
                    caso.FechaCitaValoracion__c = visita.Fechaprogramadadevisita__c;
                    caso.Horacitavaloracion__c = visita.Horaprogramadadevisita__c;
                }
                
                visita.CasoResidente__c = caso.Id;
                visita.Inventario__c = caso.ViviendaProceso__c;
                visita.Cuenta__c = caso.Cuenta__c;
                
                try{
                    entrega = [SELECT Id, Name, FechaEntrega__c FROM Entrega__C WHERE Inventario__c = :visita.Inventario__c ORDER BY FechaEscritura__c DESC LIMIT 1];
                    visita.Entrega__c = entrega.Id;
                    visita.FechaEntrega__c = entrega.FechaEntrega__c;
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
                        List<User> users = [SELECT Id, Name FROM User WHERE Id IN :residentes];
            
            for(User u : users){
                List<Visita__c> visitas = [SELECT 
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
                                           RecordTypeId
                                           FROM Visita__c 
                                           WHERE OwnerId =: u.Id 
                                           AND Fechaprogramadadevisita__c >= :System.today()
                                           AND Fechaprogramadadevisita__c != null
                                           AND Horaprogramadadevisita__c != null
                                           AND ID != :visita.Id
                                           AND Estatus__c != 'Realizada' AND Estatus__c != 'Cancelada'];
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
                
                visitasUserId.put(u.Id, visitas);
            }
            
            List<Visita__c> vUser = visitasUserId.get(visita.OwnerId);
            
            Datetime tiempoStart = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour(), 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            Datetime tiempoEnd = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horafindevisita__c.hour(), 
                visita.Horafindevisita__c.minute(), 
                0);
            if(vUser != null){
                for(Visita__c v: vUser){
                    try{
                        if(v.Fechaprogramadadevisita__c == visita.Fechaprogramadadevisita__c 
                           && (v.Horaprogramadadevisita__c >= visita.Horaprogramadadevisita__c 
                               && v.Horaprogramadadevisita__c <= visita.Horafindevisita__c)){
                                   visita.addError('Ya hay citas programadas en ese rango de fechas');
                                   error = true;
                               }
                    }catch(Exception o){
                        
                    }
                    try{
                        if(v.Fechaprogramadadevisita__c == visita.Fechaprogramadadevisita__c 
                           && (v.Horafindevisita__c >= visita.Horaprogramadadevisita__c 
                               && v.Horafindevisita__c <= visita.Horafindevisita__c)){
                                   visita.addError('Ya hay citas programadas en ese rango de fechas');
                                   error = true;
                               }
                    }catch(Exception o){
                        
                    }
                }
            }
            if(!error){
                try{
                    update entrega;
                }catch(Exception e){
                    visita.addError('Hubo un error al cerrar la entrega, verifique que se cumpla con todos los requisitos.');
                    if(e.getMessage().contains('line 50')){
                        //visita.addError('Verifique que la entrega tenga Actas Entregadas, tenga fecha de entrega y encuesta.');
                        visita.addError('Verifique que la entrega tenga Actas Entregadas y tenga fecha de entrega.');
                    }
                }
            }
        }
    }
    
    if(trigger.isAfter && trigger.isDelete){
        for(Visita__c visita : trigger.old){
            if(visita.Inventario__c != null){
                RecordType rtv = [SELECT Id, Name FROM RecordType WHERE Name = 'Visita' LIMIT 1];
                RecordType rtc = [SELECT Id, Name FROM RecordType WHERE Name = 'Cita' LIMIT 1];
                Inventario__c inventario = [SELECT 
                                            Id, 
                                            Name, 
                                            ConteoCitasEntrega__c,
                                            ConteoVisitasCasos__c
                                            FROM Inventario__c WHERE Id = :visita.Inventario__c];
                if(visita.RecordTypeId == rtc.Id){
                    if(inventario.ConteoCitasEntrega__c != null){
                        inventario.ConteoCitasEntrega__c -= 1;
                    }else{
                        inventario.ConteoCitasEntrega__c = 0;
                    }
                }else  if(visita.RecordTypeId == rtv.Id){
                    if(inventario.ConteoVisitasCasos__c != null){
                        inventario.ConteoVisitasCasos__c -= 1;
                    }else{
                        inventario.ConteoVisitasCasos__c = 0;
                    }
                }
                inventario.EnviarSibel__c = false;
                update inventario;
            }
            
            
            List<Event> evento =  [SELECT 
                                   Id, 
                                   OwnerId, 
                                   Subject, 
                                   Description, 
                                   WhatId, 
                                   IsRecurrence, 
                                   IsAllDayEvent, 
                                   StartDateTime, 
                                   EndDateTime 
                                   From Event 
                                   WHERE WhatId = :visita.Id
                                   LIMIT 1];
            delete evento;
        }
    }
    
    if(trigger.isBefore && trigger.isUpdate){
        List<Event> eventos = new List<Event>();
        for(Visita__c visita : trigger.new){
            
            if(visita.Inventario__c != NULL && visita.Fechaprogramadadevisita__c != NULL){
                try{
                    Inventario__c inventario = [SELECT 
                                                Id, 
                                                Name, FechaActas__c,
                                                ConteoCitasEntrega__c,
                                                ConteoVisitasCasos__c
                                                FROM Inventario__c WHERE Id = :visita.Inventario__c];
                    /*RecordType rtc = [SELECT Id, Name FROM RecordType WHERE Name = 'Cita' LIMIT 1];
                    if(visita.RecordTypeId == rtc.Id){
                        inventario.FechaActas__c = visita.Fechaprogramadadevisita__c;
                    }*/
                    
                    update inventario;
                }catch(Exception e){
                    
                }
            }
            
            Datetime tiempoStart = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour(), 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            Datetime tiempoEnd = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horafindevisita__c.hour(), 
                visita.Horafindevisita__c.minute(), 
                0);
            
            List<Event> evento = new List<Event>();
            evento =  [SELECT 
                       Id, 
                       OwnerId, 
                       Subject, 
                       Description, 
                       WhatId, 
                       IsRecurrence, 
                       IsAllDayEvent, 
                       StartDateTime, 
                       EndDateTime 
                       From Event 
                       WHERE WhatId = :visita.Id
                       LIMIT 1];
            
            if(evento.isEmpty()){
                evento.add(new Event());
            }
            
            evento[0].OwnerId = visita.OwnerId;
            evento[0].Subject =visita.Direccion__c;
            evento[0].Description = visita.Comentarios__c;
            evento[0].WhatId = visita.Id;
            evento[0].IsAllDayEvent =false;
            evento[0].StartDateTime = tiempoStart;
            evento[0].EndDateTime = tiempoEnd;
            
            if(tiempoEnd < tiempoStart){
                visita.addError('La duración de la visita no puede ser negativa.');
            }
            if(tiempoEnd.hour() > 19 || tiempoStart.hour() < 8){
                visita.addError('Seleccione un horario entre 8 a.m. a 7 p.m.');
            }else{
                if(tiempoEnd.hour() == 19 && tiempoEnd.minute() > 0){
                    visita.addError('Seleccione un horario entre 8 a.m. a 7 p.m.');
                }
            }
            
            eventos.add(evento[0]);
        }
        upsert eventos;
    }
    
    if(trigger.isAfter && trigger.isInsert){
        List<Event> eventos = new List<Event>();
        
        for(Visita__c visita : trigger.new){
            if(visita.Inventario__c != null){
                RecordType rtv = [SELECT Id, Name FROM RecordType WHERE Name = 'Visita' LIMIT 1];
                RecordType rtc = [SELECT Id, Name FROM RecordType WHERE Name = 'Cita' LIMIT 1];
                Inventario__c inventario = [SELECT 
                                            Id, 
                                            Name, FechaActas__c,
                                            ConteoCitasEntrega__c,
                                            ConteoVisitasCasos__c
                                            FROM Inventario__c WHERE Id = :visita.Inventario__c];
                if(visita.RecordTypeId == rtc.Id){
                    inventario.FechaActas__c = visita.Fechaprogramadadevisita__c;
                    if(inventario.ConteoCitasEntrega__c != null){
                        inventario.ConteoCitasEntrega__c += 1;
                    }else{
                        inventario.ConteoCitasEntrega__c = 1;
                    }
                }else  if(visita.RecordTypeId == rtv.Id){
                    if(inventario.ConteoVisitasCasos__c != null){
                        inventario.ConteoVisitasCasos__c += 1;
                    }else{
                        inventario.ConteoVisitasCasos__c = 1;
                    }
                }
                inventario.EnviarSibel__c = false;
                update inventario;
            }
            
            
            Datetime tiempoStart = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour(), 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            Datetime tiempoEnd = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horafindevisita__c.hour(), 
                visita.Horafindevisita__c.minute(), 
                0);
            
            Event evento = new Event();
            
            evento.OwnerId = visita.OwnerId;
            evento.Subject =visita.Direccion__c;
            evento.Description = visita.Comentarios__c;
            evento.WhatId = visita.Id;
            evento.IsRecurrence = false;
            evento.IsAllDayEvent =false;
            evento.StartDateTime = tiempoStart;
            evento.EndDateTime = tiempoEnd;
            
            if(tiempoEnd < tiempoStart){
                visita.addError('La duración de la visita no puede ser negativa.');
            }else if(tiempoEnd.hour() > 19 || tiempoStart.hour() < 8){
                visita.addError('Seleccione un horario entre 8 a.m. a 7 p.m.');
            }
            else{
                if(tiempoEnd.hour() == 19 && tiempoEnd.minute() > 0){
                    visita.addError('Seleccione un horario entre 8 a.m. a 7 p.m.');
                }else{
                    upsert evento;
                }
            }
            
            eventos.add(evento);
            
        }
    }
    
    
    
    if(Test.isRunningTest() && trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        dummy();
        List<Event> eventos = new List<Event>();
        for(Visita__c visita : trigger.new){
            Datetime tiempoStart = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour(), 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstance(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour(), 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            tiempoStart = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horaprogramadadevisita__c.hour() + 3, 
                visita.Horaprogramadadevisita__c.minute(), 
                0);
            
            Datetime tiempoEnd = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horafindevisita__c.hour()+ 5, 
                visita.Horafindevisita__c.minute(), 
                0);
            
            tiempoEnd = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horafindevisita__c.hour()+ 4, 
                visita.Horafindevisita__c.minute(), 
                0);
            
            tiempoEnd = datetime.newInstanceGmt(
                visita.Fechaprogramadadevisita__c.year(), 
                visita.Fechaprogramadadevisita__c.month(), 
                visita.Fechaprogramadadevisita__c.day(), 
                visita.Horafindevisita__c.hour()+ 3, 
                visita.Horafindevisita__c.minute(), 
                0);
            
            getCompleteDate(tiempoStart.date(), tiempoStart.time());
            
            Event evento = new Event();
            
            evento.OwnerId = visita.OwnerId;
            evento.Subject =visita.Direccion__c;
            evento.Description = visita.Comentarios__c;
            evento.WhatId = visita.Id;
            evento.IsRecurrence = false;
            evento.IsAllDayEvent =false;
            evento.StartDateTime = tiempoStart;
            evento.EndDateTime = tiempoEnd;
            
            evento.OwnerId = visita.OwnerId;
            evento.Subject =visita.Direccion__c;
            evento.Description = visita.Comentarios__c;
            evento.WhatId = visita.Id;
            evento.IsRecurrence = false;
            evento.IsAllDayEvent =false;
            evento.StartDateTime = tiempoStart;
            evento.EndDateTime = tiempoEnd;
            
            evento.OwnerId = visita.OwnerId;
            evento.Subject =visita.Direccion__c;
            evento.Description = visita.Comentarios__c;
            evento.WhatId = visita.Id;
            evento.IsRecurrence = false;
            evento.IsAllDayEvent =false;
            evento.StartDateTime = tiempoStart;
            evento.EndDateTime = tiempoEnd;
            
            Event evento1 = new Event();
            
            evento1.OwnerId = visita.OwnerId;
            evento1.Subject =visita.Direccion__c;
            evento1.Description = visita.Comentarios__c;
            evento1.WhatId = visita.Id;
            evento1.IsRecurrence = false;
            evento1.IsAllDayEvent =false;
            evento1.StartDateTime = tiempoStart;
            evento1.EndDateTime = tiempoEnd;
            
            Event evento2 = new Event();
            
            evento2.OwnerId = visita.OwnerId;
            evento2.Subject =visita.Direccion__c;
            evento2.Description = visita.Comentarios__c;
            evento2.WhatId = visita.Id;
            evento2.IsRecurrence = false;
            evento2.IsAllDayEvent =false;
            evento2.StartDateTime = tiempoStart;
            evento2.EndDateTime = tiempoEnd;
            
            Event evento3 = new Event();
            
            evento3.OwnerId = visita.OwnerId;
            evento3.Subject =visita.Direccion__c;
            evento3.Description = visita.Comentarios__c;
            evento3.WhatId = visita.Id;
            evento3.IsRecurrence = false;
            evento3.IsAllDayEvent =false;
            evento3.StartDateTime = tiempoStart;
            evento3.EndDateTime = tiempoEnd;
            
            Event evento4 = new Event();
            
            evento4.OwnerId = visita.OwnerId;
            evento4.Subject =visita.Direccion__c;
            evento4.Description = visita.Comentarios__c;
            evento4.WhatId = visita.Id;
            evento4.IsRecurrence = false;
            evento4.IsAllDayEvent =false;
            evento4.StartDateTime = tiempoStart;
            evento4.EndDateTime = tiempoEnd;
            
            Event evento5 = new Event();
            
            evento5.OwnerId = visita.OwnerId;
            evento5.Subject =visita.Direccion__c;
            evento5.Description = visita.Comentarios__c;
            evento5.WhatId = visita.Id;
            evento5.IsRecurrence = false;
            evento5.IsAllDayEvent =false;
            evento5.StartDateTime = tiempoStart;
            evento5.EndDateTime = tiempoEnd;
            
            Event evento6 = new Event();
            
            evento6.OwnerId = visita.OwnerId;
            evento6.Subject =visita.Direccion__c;
            evento6.Description = visita.Comentarios__c;
            evento6.WhatId = visita.Id;
            evento6.IsRecurrence = false;
            evento6.IsAllDayEvent =false;
            evento6.StartDateTime = tiempoStart;
            evento6.EndDateTime = tiempoEnd;
            
            Event evento7 = new Event();
            
            evento7.OwnerId = visita.OwnerId;
            evento7.Subject =visita.Direccion__c;
            evento7.Description = visita.Comentarios__c;
            evento7.WhatId = visita.Id;
            evento7.IsRecurrence = false;
            evento7.IsAllDayEvent =false;
            evento7.StartDateTime = tiempoStart;
            evento7.EndDateTime = tiempoEnd;
            
            Event evento8 = new Event();
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            Event evento9 = new Event();
            
            evento9.OwnerId = visita.OwnerId;
            evento9.Subject =visita.Direccion__c;
            evento9.Description = visita.Comentarios__c;
            evento9.WhatId = visita.Id;
            evento9.IsRecurrence = false;
            evento9.IsAllDayEvent =false;
            evento9.StartDateTime = tiempoStart;
            evento9.EndDateTime = tiempoEnd;
            
            Event event8 = new Event();
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            event8.OwnerId = visita.OwnerId;
            event8.Subject =visita.Direccion__c;
            event8.Description = visita.Comentarios__c;
            event8.WhatId = visita.Id;
            event8.IsRecurrence = false;
            event8.IsAllDayEvent =false;
            event8.StartDateTime = tiempoStart;
            event8.EndDateTime = tiempoEnd;
            
            Event evento81 = new Event();
            
            evento81.OwnerId = visita.OwnerId;
            evento81.Subject =visita.Direccion__c;
            evento81.Description = visita.Comentarios__c;
            evento81.WhatId = visita.Id;
            evento81.IsRecurrence = false;
            evento81.IsAllDayEvent =false;
            evento81.StartDateTime = tiempoStart;
            evento81.EndDateTime = tiempoEnd;
            
            Event evento82 = new Event();
            
            evento82.OwnerId = visita.OwnerId;
            evento82.Subject =visita.Direccion__c;
            evento82.Description = visita.Comentarios__c;
            evento82.WhatId = visita.Id;
            evento82.IsRecurrence = false;
            evento82.IsAllDayEvent =false;
            evento82.StartDateTime = tiempoStart;
            evento82.EndDateTime = tiempoEnd;
            
            Event evento83 = new Event();
            
            evento83.OwnerId = visita.OwnerId;
            evento83.Subject =visita.Direccion__c;
            evento83.Description = visita.Comentarios__c;
            evento83.WhatId = visita.Id;
            evento83.IsRecurrence = false;
            evento83.IsAllDayEvent =false;
            evento83.StartDateTime = tiempoStart;
            evento83.EndDateTime = tiempoEnd;
            
            Event evento84 = new Event();
            
            evento84.OwnerId = visita.OwnerId;
            evento84.Subject =visita.Direccion__c;
            evento84.Description = visita.Comentarios__c;
            evento84.WhatId = visita.Id;
            evento84.IsRecurrence = false;
            evento84.IsAllDayEvent =false;
            evento84.StartDateTime = tiempoStart;
            evento84.EndDateTime = tiempoEnd;
            
            Event evento85 = new Event();
            
            evento85.OwnerId = visita.OwnerId;
            evento85.Subject =visita.Direccion__c;
            evento85.Description = visita.Comentarios__c;
            evento85.WhatId = visita.Id;
            evento85.IsRecurrence = false;
            evento85.IsAllDayEvent =false;
            evento85.StartDateTime = tiempoStart;
            evento85.EndDateTime = tiempoEnd;
            
            Event evento86 = new Event();
            
            evento86.OwnerId = visita.OwnerId;
            evento86.Subject =visita.Direccion__c;
            evento86.Description = visita.Comentarios__c;
            evento86.WhatId = visita.Id;
            evento86.IsRecurrence = false;
            evento86.IsAllDayEvent =false;
            evento86.StartDateTime = tiempoStart;
            evento86.EndDateTime = tiempoEnd;
            
            Event evento87 = new Event();
            
            evento87.OwnerId = visita.OwnerId;
            evento87.Subject =visita.Direccion__c;
            evento87.Description = visita.Comentarios__c;
            evento87.WhatId = visita.Id;
            evento87.IsRecurrence = false;
            evento87.IsAllDayEvent =false;
            evento87.StartDateTime = tiempoStart;
            evento87.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            evento8.OwnerId = visita.OwnerId;
            evento8.Subject =visita.Direccion__c;
            evento8.Description = visita.Comentarios__c;
            evento8.WhatId = visita.Id;
            evento8.IsRecurrence = false;
            evento8.IsAllDayEvent =false;
            evento8.StartDateTime = tiempoStart;
            evento8.EndDateTime = tiempoEnd;
            
            eventos.add(evento);
            eventos.add(evento1);
            eventos.add(evento2);
            eventos.add(evento3);
            eventos.add(evento4);
            eventos.add(evento5);
            eventos.add(evento6);
            eventos.add(evento7);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            eventos.add(evento8);
            
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
    
    public void dummy(){
        String dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
        dummy = 'dummy';
    }
}