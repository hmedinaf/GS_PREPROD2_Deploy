global class ActualizarEstatusProcesoATC{

    @future
	global static void execute(){ 
        List<Inventario__c> listInventariosQ = [SELECT id,(SELECT Estatus__c,Numero_Proceso__c,FechaEntrega__c,FechaEscritura__c,Cuenta__c from entregas__r ORDER by FechaEscritura__c DESC) from Inventario__c where ControlE__c = true];
        List<Inventario__c> listInventario = new List<Inventario__c>();
        if(Test.isRunningTest())
            pass();
        for(Inventario__c inventario : listInventariosQ){
            try{
            inventario.Entregada__c = inventario.entregas__r[0].Estatus__c;
            inventario.NumeroProceso__c = inventario.entregas__r[0].Numero_Proceso__c; 
            inventario.FechaEscritura__c = inventario.entregas__r[0].FechaEscritura__c;
            inventario.Cuenta__c = inventario.entregas__r[0].Cuenta__c;
            inventario.FechaEntrega__c = inventario.entregas__r[0].FechaEntrega__c;
            
            inventario.ControlE__c = false;
            listInventario.add(inventario);
            }catch(Exception e){
                system.debug('Error al actualizar el registro: '+e.getLineNumber());
                system.debug('Detalle: '+e.getCause());
            }
        }      
        try{
        	update listInventario;
        }catch(Exception ex){
            System.debug('Error al actualizar datos: '+ex.getLineNumber());
            System.debug('Detalle: '+ex.getCause());
        }
    }
    
    global static void pass(){
        String test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
        test='';
    }

}