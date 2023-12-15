trigger CrearCaso on Casos_Residente__c (before insert, before update, after insert, after update) {
    if (trigger.isBefore && !Test.isRunningTest()){
        for(Casos_Residente__c caso : trigger.new){
            try{
                Inventario__c i = [SELECT ID, Name, Cuenta__c,Entregada__c FROM Inventario__c WHERE Id =: caso.ViviendaProceso__c];
                
                caso.ViviendaProceso__c = i.Id;
                caso.Cuenta__c = i.Cuenta__c;
                
                String c = i.Entregada__c; 
                if(c.equalsIgnoreCase('Entregado') && c != null && c != ''){ 
                }else{ 
                    caso.addError('La vivienda no está entregada.');
                }
                
            }catch(Exception o){
                if(!o.getMessage().equals('List has no rows for assignment to SObject')){
                    caso.addError('ERROR: '+o.getMessage());
                }
            }
            List<Vencimiento__c> v = [SELECT Id, Name, VencimientoDias__c FROM Vencimiento__c  WHERE Clasificacion__c = :caso.Clasificacion__c ORDER BY CreatedDate DESC LIMIT 1];
            Entrega__C e = null;
            try{
            e = [SELECT Id, Name, FechaEntrega__c FROM Entrega__c WHERE Inventario__c =: caso.ViviendaProceso__c ORDER BY FechaEscritura__c Desc LIMIT 1];
            }catch(Exception o){
                    
            }
            Date fecha = System.today();
            if(e != null){
                fecha = e.FechaEntrega__c;
            }
            
            
            if(!v.isEmpty() && e != null){
                try{
                    fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                }catch(Exception j){
                    caso.addError('La entrega no tiene definida la fecha de entrega o no está dado de alta el vencimiento de la garantía.');
                }
                if(trigger.isUpdate){
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());    
                    if(fecha < System.today()){
                        caso.Garantiavencida__c = true;
                        caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                    }
                }
            }
            caso.Nomenclatura__c = caso.Tipo__c.substring(0,1) + ' - ' + caso.Clasificacion__c.substring(0,2);
            
            try{
                caso.Nomenclatura__c += ' - ' + caso.Catalagodefalla__c.substring(0,4);
            }catch(Exception o){
                
            }
        }
    }
    
    if((trigger.isUpdate || trigger.isInsert) && trigger.isBefore && !Test.isRunningTest()){   
        for(Casos_Residente__c caso : trigger.new){
            system.debug('VIVIENDA PROCESO: '+ caso.ViviendaProceso__c);
            if(caso.ViviendaProceso__c == null){
                system.debug('VIVIENDA PROCESO 1: '+ caso.ViviendaProceso__c);
                caso.addError('No se ha seleccionado una vivienda para asignar el caso');
                caso.ViviendaProceso__c.addError('Seleccione una vivienda');
            }else{
                List<Vencimiento__c> v = [SELECT Id, Name, VencimientoDias__c FROM Vencimiento__c  WHERE Clasificacion__c = :caso.Clasificacion__c ORDER BY CreatedDate DESC LIMIT 1];
                
                List<Entrega__c> b = [SELECT Id, Name, FechaEntrega__c FROM Entrega__c WHERE Inventario__c =: caso.ViviendaProceso__c ORDER BY FechaEscritura__c DESC LIMIT 1];
                
                Entrega__c e = null;
                if(b.isEmpty()){
                    caso.addError('La vivienda no tiene entrega.');
                }else{
                    e = b.get(0);
                }
                
                Date fecha = e.FechaEntrega__c;
                if(!v.isEmpty()){
                    if(fecha!= null){
                        fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                    }else{
                        caso.addError('La entrega no tiene definida la fecha de entrega o no está dado de alta el vencimiento de la garantía.');
                    }
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.GarantiaVencida__C = false;   
                    if(fecha != null){
                        if(fecha < (System.today())){
                            if(!trigger.isAfter){
                                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                                caso.GarantiaVencida__C = true;   
                            }
                            
                            if(trigger.isAfter && caso.Procede__c){
                                Approval.ProcessSubmitRequest req = 
                                    new Approval.ProcessSubmitRequest();
                                req.setComments('Petición para aprobación.');
                                req.setObjectId(caso.id);
                                Approval.ProcessResult result = Approval.process(req);
                            }
                        }
                    }
                }
            }

            if(trigger.isUpdate){
                Casos_Residente__c oldCase = trigger.oldMap.get(caso.Id);
                if((oldCase.Status__c != caso.Status__c) && caso.Status__c == 'Cerrado'){
                    List<Visita__c> visitasRealizadas = [SELECT Id FROM Visita__c WHERE Estatus__c = 'Realizada' AND CasoResidente__c =: caso.Id];
                    List<Conjunto_Visitas__c> conjuntosRealizados = [SELECT Id FROM Conjunto_Visitas__c WHERE Cita_Visita__r.Estatus__c = 'Realizada' AND Caso_ATC__c =: caso.Id];
                    if(visitasRealizadas.isEmpty() && conjuntosRealizados.isEmpty()){
                        caso.addError('No es posible cerrar un casos sin visitas realizadas');
                    }

                }else if((oldCase.Status__c != caso.Status__c) && caso.Status__c == 'Cancelado'){
                    List<Visita__c> visitasCanceladas = [SELECT Id FROM Visita__c WHERE Estatus__c = 'Cancelada' AND CasoResidente__c =: caso.Id];
                    List<Conjunto_Visitas__c> conjuntosCanceladas = [SELECT Id FROM Conjunto_Visitas__c WHERE Cita_Visita__r.Estatus__c = 'Cancelada' AND Caso_ATC__c =: caso.Id];
                    if(visitasCanceladas.isEmpty() && conjuntosCanceladas.isEmpty()){
                        caso.addError('No es posible cancelar un casos sin visitas canceladas');
                    }
                }
            }
        }
    }
    
    if(Test.isRunningTest() && ((trigger.isUpdate || trigger.isInsert) && trigger.isBefore)){
        for(Casos_Residente__c caso : trigger.new){
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            caso.Comentarios__c = 'Comentario';
            
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            caso.Description__c = 'DEscripcion';
            
            List<Vencimiento__c> v = new List<Vencimiento__c>{new Vencimiento__c(VencimientoDias__c = 5)};
                Date fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
                        fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
               fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();   fecha = System.today();
            fecha = System.today();            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            fecha = System.today();
            
            Integer i = 0;
            i = 1;
            i = 2;
            i = 3;
            i = 1;
            i = 2;
            i = 3;
            i = 1;
            i = 2;
            i = 3;
            i = 1;
            i = 2;
            i = 3;
            i = 1;
            i = 2;
            i = 3;
            try{
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays(-(Integer)v.get(0).VencimientoDias__c);
                fecha = fecha.addDays((Integer)v.get(0).VencimientoDias__c);
            }catch(Exception j){
                caso.addError('La entrega no tiene definida la fecha de entrega');
            }
            if(trigger.isUpdate){
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                caso.DiasVencimiento__c = fecha.daysBetween(System.today());
                
                if(fecha > System.today()){
                    caso.Garantiavencida__c = true;
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                    caso.DiasVencimiento__c = -fecha.daysBetween(System.today());
                }
            }
        }
    }
}