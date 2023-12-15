trigger trg_Pre_Venta_AU_CambEstatus on Pre_Venta__c (after update) {
    try{
    List<Pre_Venta__c> list_Pre_Venta = new List<Pre_Venta__c>();
    for(Pre_Venta__c Pre_Venta: trigger.new) {
            Pre_Venta__c Pre_Venta_Old = Trigger.oldMap.get(Pre_Venta.Id);
            //System.Debug('***Pre_Venta*** '+ Pre_Venta);
            //System.Debug('***Pre_Venta_Old*** '+ Pre_Venta_Old);
            if  (Pre_Venta_Old.Estatus__c==null ){
                if  (Pre_Venta.Estatus__c!=null ){
                    list_Pre_Venta.add(Pre_Venta);
                }
            }
    }
    if ( !list_Pre_Venta.IsEmpty() ){
        for(Pre_Venta__c Pre_Venta: list_Pre_Venta ) {
            //if (!Test.isRunningTest()) { 
                Javer_Util.Envia_Respuesta(Pre_Venta.Token__c, Pre_Venta.Accion_Formula__c, Pre_Venta.Id);
            //} 
        }
    }
    
 } catch (Exception error) {for (Pre_Venta__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Pre_Venta_AU_CambEstatus : '+error.getMessage());}}
}