trigger trg_Comision_AU_CambEstatus on Comision__c (after update) {
    try{
    List<Comision__c> list_Comision = new List<Comision__c>();
    for(Comision__c Comision: trigger.new) {
            Comision__c Comision_Old = Trigger.oldMap.get(Comision.Id);
            //System.Debug('***Comision*** '+ Comision);
            //System.Debug('***Comision_Old*** '+ Comision_Old);
            if  (Comision_Old.Estatus__c==null ){
                if  (Comision.Estatus__c!=null ){
                    list_Comision.add(Comision);
                }
            }
    }
    if ( !list_Comision.IsEmpty() ){
        for(Comision__c Comision: list_Comision ) {
            //if (!Test.isRunningTest()) { 
                Javer_Util.Envia_Respuesta(Comision.Token__c, Comision.Accion_Formula__c, Comision.Id);
            //} 
        }
    }
    
 } catch (Exception error) {for (Comision__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Comision_AU_CambEstatus : '+error.getMessage());}}
}