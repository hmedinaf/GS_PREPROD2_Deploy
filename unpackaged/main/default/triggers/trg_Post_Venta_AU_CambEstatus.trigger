trigger trg_Post_Venta_AU_CambEstatus on Post_Venta__c (after update) {
    try{
    List<Post_Venta__c> list_Post_Venta = new List<Post_Venta__c>();
    for(Post_Venta__c Post_Venta: trigger.new) {
            Post_Venta__c Post_Venta_Old = Trigger.oldMap.get(Post_Venta.Id);
            //System.Debug('***Post_Venta*** '+ Post_Venta);
            //System.Debug('***Post_Venta_Old*** '+ Post_Venta_Old);
            if  (Post_Venta_Old.Estatus__c==null ){
                if  (Post_Venta.Estatus__c!=null ){
                    list_Post_Venta.add(Post_Venta);
                }
            }
    }
    if ( !list_Post_Venta.IsEmpty() ){
        for(Post_Venta__c Post_Venta: list_Post_Venta ) {
            //if (!Test.isRunningTest()) { 
                Javer_Util.Envia_Respuesta(Post_Venta.Token__c, Post_Venta.Accion_Formula__c, Post_Venta.Id);
            //} 
        }
    }
    
 } catch (Exception error) {for (Post_Venta__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Post_Venta_AU_CambEstatus : '+error.getMessage());}}
}