trigger CPPT_Aprobacion_LP on Aprobacion_Lista_de_Precios__c (before insert, before update, after insert, after update) {
/*    if(Trigger.isBefore){
        if(Trigger.isInsert){
            
        }else if(Trigger.isUpdate){
            for(Aprobacion_Lista_de_Precios__c alp : Trigger.New){
                if(alp.Solicitud_Pendiente__c == false){
                    // Creando petición para el proceso de aprobación
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                    req1.setObjectId(alp.id);
                    
                    // Se define el usuario que solicita la aprobación, será el usuario que manipula el registro
                    String user1 = UserInfo.getUserId();
                    req1.setSubmitterId(user1); 
                    
                    // Se manda el registro al proceso correspondiente y se omiten los criterios
                    if(alp.Tipo_de_Registro__c == 'Vivienda'){
                        req1.setProcessDefinitionNameOrId('Aprobaci_n_Lista_de_precios_Vivienda');
                        req1.setComments('Enviando proceso de aprobación lista de precios Vivienda');
                        req1.setSkipEntryCriteria(true);
                    }else if(alp.Tipo_de_Registro__c == 'Paquete'){
                        req1.setProcessDefinitionNameOrId('Aprobacion_Lista_de_precios_Paquetes');
                        req1.setComments('Enviando proceso de aprobación lista de precios Paquete');
                        req1.setSkipEntryCriteria(true);
                    }else if(alp.Tipo_de_Registro__c == 'Promoción Venta'){
                        req1.setProcessDefinitionNameOrId('Aprobacion_Lista_de_precios_Prom_Vta');
                        req1.setComments('Enviando proceso de aprobación lista de precios Promoción de Venta');
                        req1.setSkipEntryCriteria(true);
                    }else if(alp.Tipo_de_Registro__c == 'Regalo MKT'){
                        req1.setProcessDefinitionNameOrId('Aprobacion_Lista_de_precios_Regalos_MKT');
                        req1.setComments('Enviando proceso de aprobación lista de precios REgalo MKT');
                        req1.setSkipEntryCriteria(true);
                    }else if(alp.Tipo_de_Registro__c == 'Promoción Precio'){
                        req1.setProcessDefinitionNameOrId('Aprobacion_Lista_de_precios_Prom_Precio');
                        req1.setComments('Enviando proceso de aprobación lista de precios Promoción de Precio');
                        req1.setSkipEntryCriteria(true);
                    }
                    
                    //Se envía la petición del proceso de aprobación
                    Approval.ProcessResult result = Approval.process(req1);
                    
                    //Se verifica el resultado
                    System.assert(result.isSuccess());
                    System.assertEquals('Pending', result.getInstanceStatus(),'Instance Status'+result.getInstanceStatus());
                    
                    alp.Solicitud_Pendiente__c = true;
                }
                System.debug('Se solicita la aprobación');                
            }
        }else if(Trigger.isAfter){
            if(Trigger.isInsert){
                
            }else if(Trigger.isUpdate){
                for(Aprobacion_Lista_de_Precios__c alp : Trigger.New){
                    Pricebook2 pb = [SELECT Id, Estatus__c FROM Pricebook2 WHERE Id =: alp.Lista_de_Precios__c LIMIT 1];
                    if(alp.Estatus_Aprobaci_n__c == 'Aprobado'){
                        pb.Estatus__c = 'Aprobado';   
                    }else if(alp.Estatus_Aprobaci_n__c == 'Rechazado'){
                        pb.Estatus__c = 'Rechazado';
                    }
                    
                    update pb;
                }
            }
        }
    }*/
}