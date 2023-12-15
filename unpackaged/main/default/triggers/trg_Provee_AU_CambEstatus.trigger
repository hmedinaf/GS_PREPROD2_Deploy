trigger trg_Provee_AU_CambEstatus on Proveedor__c (after update) {

    try{
    List<Proveedor__c> list_Proveedores = new List<Proveedor__c>();
    for(Proveedor__c Proveedor: trigger.new) {
            Proveedor__c Proveedor_Old = Trigger.oldMap.get(Proveedor.Id);
            //System.Debug('***Proveedor*** '+ Proveedor);
            //System.Debug('***Proveedor_Old*** '+ Proveedor_Old);
            if  (Proveedor_Old.Estatus__c==null){
                if  (Proveedor.Estatus__c!=null ){
                    list_Proveedores.add(Proveedor);
                }
                
            }
    }
    if ( !list_Proveedores.IsEmpty() ){
        for(Proveedor__c Proveedor: list_Proveedores ) {
            //if (!Test.isRunningTest()) { 
                Javer_ShPn_Util.Envia_RespuestaSP(Proveedor.Name, Proveedor.Accion_Formula__c, Proveedor.Id);
            //} 
        }
    }
    
 } catch (Exception error) {for (Proveedor__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Provee_AU_CambEstatus : '+error.getMessage());}}
}