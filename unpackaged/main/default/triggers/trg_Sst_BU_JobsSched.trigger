trigger trg_Sst_BU_JobsSched on Sistema__c (before update) {
    try{
        
        String fecha;
        String jobNewId;
        String jobOldId;
        
        for(Sistema__c Sistema: trigger.new) {
            Sistema__c Sistema_Old = Trigger.oldMap.get(Sistema.Id);
            if (Sistema_Old.Limpieza_de_Aprob_Agendada__c==false && Sistema.Limpieza_de_Aprob_Agendada__c==true ){
                if (Sistema.Max_antiguedad_sin_resolucion__c == null || Sistema.Max_antiguedad_sin_resolucion__c < 1 ) {
                    Sistema.AddError('En el campo "Máx.antigüedad sin resolución" es necesario declarar un valor mayor a 0.');
                } else  { 
                    if (Sistema.Name.contains('ShPn') ){
                        jobNewId = LimpiezaShPnObjSchClass.LimpiezaShPnObjSchMe(Sistema.Limpieza_Recurrencia__c);
                    }else{
                        jobNewId = LimpiezaAprobSchClass.LimpiezaAprobSchMe(Sistema.Limpieza_Recurrencia__c);
                    }
                    
                    Sistema.Limpieza_Job_Id__c = jobNewId;
                }
            } else if (Sistema_Old.Limpieza_de_Aprob_Agendada__c==true && Sistema.Limpieza_de_Aprob_Agendada__c==false ){
                jobOldId =  Sistema.Limpieza_Job_Id__c;
                Javer_Util_Future.DetenerJob(jobOldId);
                Sistema.Limpieza_Job_Id__c = null;
            } 
            
   
        }
        
        
    } catch (Exception error) {for (Sistema__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Sst_BU_JobsSched : '+error.getMessage());}}
}