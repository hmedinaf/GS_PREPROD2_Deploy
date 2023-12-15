trigger trg_Venta_AU_CambEstatus on Venta__c (after update) {
    try{
        List<Venta__c> list_Venta = new List<Venta__c>();
        for(Venta__c Venta: trigger.new) {
                Venta__c Venta_Old = Trigger.oldMap.get(Venta.Id);
                //System.Debug('***Venta*** '+ Venta);
                //System.Debug('***Venta_Old*** '+ Venta_Old);
                if  (Venta_Old.Estatus__c==null ){
                    if  ( Venta.Estatus__c!=null ){
                        list_Venta.add(Venta);
                    }
                }
        }
        if ( !list_Venta.IsEmpty() ){
            for(Venta__c Venta: list_Venta ) {
                //if (!Test.isRunningTest()) { 
                    Javer_Util.Envia_Respuesta(Venta.Token__c, Venta.Accion_Formula__c,Venta.Id);
                //} 
            }
        }
  
    } catch (Exception error) {for (Venta__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Venta_AU_CambEstatus : '+error.getMessage());}}
}