trigger trg_Insumo_AU_CambEstatus on Insumo__c (after update) {

    try{
    List<Insumo__c> list_Insumos = new List<Insumo__c>();
    for(Insumo__c Insumo: trigger.new) {
            Insumo__c Insumo_Old = Trigger.oldMap.get(Insumo.Id);
            //System.Debug('***Insumo*** '+ Insumo);
            //System.Debug('***Insumo_Old*** '+ Insumo_Old);
            if  (Insumo_Old.Estatus__c==null){
                if  (Insumo.Estatus__c!=null ){
                    list_Insumos.add(Insumo);
                } 
            }
    }
    if ( !list_Insumos.IsEmpty() ){
        for(Insumo__c Insumo: list_Insumos ) {
            //if (!Test.isRunningTest()) { 
                Javer_ShPn_Util.Envia_RespuestaSP(Insumo.Name, Insumo.Accion_Formula__c, Insumo.Id);
            //} 
        }
    }
    
 } catch (Exception error) {for (Insumo__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Insumo_AU_CambEstatus : '+error.getMessage());}}
}