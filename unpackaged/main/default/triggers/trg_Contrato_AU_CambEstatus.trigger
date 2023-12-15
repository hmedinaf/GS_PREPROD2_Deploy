trigger trg_Contrato_AU_CambEstatus on Contrato__c (after update) {

    try{
    List<Contrato__c> list_Contratos = new List<Contrato__c>();
    for(Contrato__c Contrato: trigger.new) {
            Contrato__c Contrato_Old = Trigger.oldMap.get(Contrato.Id);
            //System.Debug('***Contrato*** '+ Contrato);
            //System.Debug('***Contrato_Old*** '+ Contrato_Old);
            if  (Contrato_Old.Estatus__c==null || Contrato_Old.Estatus__c == 'INICIAL' ){
                if  (Contrato.Estatus__c!=null ){
                    list_Contratos.add(Contrato);
                } 
            }
    }
    if ( !list_Contratos.IsEmpty() ){
        for(Contrato__c Contrato: list_Contratos ) {
            //if (!Test.isRunningTest()) { 
                Javer_ShPn_Util.Envia_RespuestaSP(Contrato.Name, Contrato.Accion_Formula__c, Contrato.Id);
            //} 
        }
    }
    
 } catch (Exception error) {for (Contrato__c e : (Trigger.isBefore && Trigger.isDelete) ? Trigger.old:Trigger.new) {e.addError('Por favor contacta a soporte y menciona trg_Contrato_AU_CambEstatus : '+error.getMessage());}}
}