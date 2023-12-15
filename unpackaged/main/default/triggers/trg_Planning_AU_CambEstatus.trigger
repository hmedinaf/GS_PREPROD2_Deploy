trigger trg_Planning_AU_CambEstatus on Planning__c (after update) {
    try{
    List<Planning__c> list_Planning = new List<Planning__c>();
    for(Planning__c Planning: trigger.new) {
            Planning__c Planning_Old = Trigger.oldMap.get(Planning.Id);
            //System.Debug('***Planning*** '+ Planning);
            //System.Debug('***Planning_Old*** '+ Planning_Old);
            if  (Planning_Old.Estatus__c==null){
                if  (Planning.Estatus__c!=null ){
                    list_Planning.add(Planning);
                }
                
            }
    }
    if ( !list_Planning.IsEmpty() ){
        for(Planning__c Planning: list_Planning ) {
            //if (!Test.isRunningTest()) { 
                Javer_Util.Envia_Respuesta(Planning.Token__c, Planning.Accion_Formula__c, Planning.Id);
            //} 
        }
    }
    
 } catch (Exception error) {for (Planning__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Planning_AU_CambEstatus : '+error.getMessage());}}
}