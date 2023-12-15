trigger trg_Cancelacion_AU_CambEstatus on Cancelacion__c (after update) {
    try{
    List<Cancelacion__c> list_Cancelacion = new List<Cancelacion__c>();
    for(Cancelacion__c Cancelacion: trigger.new) {
            Cancelacion__c Cancelacion_Old = Trigger.oldMap.get(Cancelacion.Id);
            //System.Debug('***Cancelacion*** '+ Cancelacion);
            //System.Debug('***Cancelacion_Old*** '+ Cancelacion_Old);
            if  (Cancelacion_Old.Estatus__c==null ){
                if  (Cancelacion.Estatus__c!=null ){
                    list_Cancelacion.add(Cancelacion);
                }
            }
    }
    if ( !list_Cancelacion.IsEmpty() ){
        for(Cancelacion__c Cancelacion: list_Cancelacion ) {
            //if (!Test.isRunningTest()) { 
                Javer_Util.Envia_Respuesta(Cancelacion.Token__c, Cancelacion.Accion_Formula__c,Cancelacion.Id );
            //} 
        }
    }
    
 } catch (Exception error) {for (Cancelacion__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Cancelacion_AU_CambEstatus : '+error.getMessage());}}
}