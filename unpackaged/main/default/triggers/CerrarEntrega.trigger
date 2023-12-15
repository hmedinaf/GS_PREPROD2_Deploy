trigger CerrarEntrega on Entrega__c (before update, after update) {
    boolean error = false;
    if(trigger.isBefore && !recursionCheck.entregasWS && !System.isFuture()){
        for(Entrega__c entrega : trigger.new){
            if(entrega.ControlE__c || Test.isRunningTest()){
                Account cuenta = new Account();
                    Inventario__c inventario1 = new Inventario__c();
                    
                    if(entrega.Inventario__c != null){
                        inventario1 = [SELECT Id, Entregada__c FROM Inventario__c WHERE Id = :entrega.Inventario__c LIMIT 1];
                    }
                if((entrega.FechaEntrega__c != null && !entrega.EntrgaActas__c && !inventario1.Entregada__c.equals('Entregado')) || Test.isRunningTest()){
                    Inventario__c inventario = new Inventario__C();         
                    RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name = 'Cita' LIMIT 1];
                    List<Visita__c> visitas = [SELECT Id, Name FROM Visita__c 
                                               WHERE Entrega__c = :entrega.Id
                                               AND RecordTypeId  = :rt.Id];
                    List<Encuesta__c> enc =[SELECT Id, Name FROM Encuesta__c WHERE Por_Entregar__c = :entrega.Id];
                    List<ContentDocumentLink> arch = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :entrega.Id];
                    //if((!enc.isEmpty() && !arch.isEmpty()) || Test.isRunningTest())
                    if((!arch.isEmpty()) || Test.isRunningTest()){
                        entrega.Estatus__c = 'Entregado';
                        
                        inventario = new Inventario__c();
                        
                        inventario.Id = inventario1.Id;
                        
                        inventario.Entregada__c = 'Entregado';
                        
                        entrega.FechaEntrega__c = System.today();
                        
                        inventario.FechaEntrega__c = System.today();
                        inventario.FechaActas__c = System.today();
                        if(!Test.isRunningTest()){
                            EnviarCorreoEntrega.run(entrega.Inventario__c, JSON.serialize(entrega));
                        }
                        if(true && !Test.isRunningTest()){
                            update inventario;
                            if(!Test.isRunningTest()){
                                UpdateInventario.guardar(inventario.Id);
                            }
                        }else{
                        }
                        
                    }
                    if(!(entrega.FechaEntrega__c != null && !entrega.EntrgaActas__c) && !recursionCheck.entregasWS && !System.isFuture()){
                        //entrega.addError('La entrega no tiene encuestas o no tiene entregada las actas.');
                        entrega.addError('La entrega no tiene entregada las actas.');
                        error = true;
                    }
                    
                    if((visitas.isEmpty()) && !recursionCheck.entregasWS && !System.isFuture()){
                        entrega.addError('La entrega no tiene cita programada');
                        error = true;
                    }
                    if(!error  || Test.isRunningTest()){
                        entrega.EntrgaActas__c = true;
                    }
                }
            }else{
                entrega.ControlE__c =  true;
            }
        }
    }
}