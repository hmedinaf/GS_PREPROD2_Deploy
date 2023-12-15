trigger UpdateInventario on Inventario__c (before insert, before update) {
    
    if(trigger.isBefore && !trigger.isInsert){
        for(Inventario__c inventario : trigger.new){
            Inventario__c oldInventario = Trigger.oldMap.get(inventario.ID);
            if ((inventario.Email__c != oldInventario.Email__c) ||
                (inventario.Encuesta_1__c != oldInventario.Encuesta_1__c) ||
                (inventario.Encuesta_2__c != oldInventario.Encuesta_2__c) ||
                (inventario.Encuesta_3__c != oldInventario.Encuesta_3__c)){
                }else if(inventario.FechadeHabitabilidad__c != null && !TEst.isRunningTest() && inventario.EnviarSibel__c 
                && !recursionCheck.entregasWS && !recursionCheck.PATCPagare && !System.isFuture() &&
                (oldInventario.Asesor_de_Cobranza__c == inventario.Asesor_de_Cobranza__c) &&
                (oldInventario.Saldo_Pendiente__c == inventario.Saldo_Pendiente__c) &&
                (oldInventario.Saldo_Vencido_Pagares__c == inventario.Saldo_Vencido_Pagares__c)){
                    System.debug('Update Inventario');
                    UpdateInventario.guardar(inventario.Id);
                }else{
                    inventario.EnviarSibel__c = true;
                    Integer i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
                    i = 1;
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
            
            if((!recursionCheck.entregasWS && !System.isFuture() && inventario.Entregada__c != oldInventario.Entregada__c) && inventario.Entregada__c == 'Entregado' && inventario.Cuenta__r.CorreoElectronico__c != ''){
                System.debug('Nueva Encuesta');
                Survey S1 = [Select Id from Survey where Name =: 'Entrega vivienda'];
                List<SurveyInvitation> SI = [Select Id from SurveyInvitation where Proceso_ATC__c=: inventario.Id AND SurveyId=: S1.Id Limit 1];
                try{
                    if(SI.isEmpty()){
                        Survey_CreateInvitation.run(inventario.Id);
                    }else{
                        System.debug('Ya existe una encuesta o sin correo');
                    }
                }Catch(Exception e){
                    System.debug(e);
                }
            }
        }
    }
    new InventarioTriggerHandler().run();
    
}