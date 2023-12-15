global class SCHED_Staging_Proceso_Venta implements Schedulable{
    /* Run every 20 mins:
    System.schedule('Staging Proceso Venta 1', '0 0 * * * ?', new SCHED_Staging_Proceso_Venta());
    System.schedule('Staging Proceso Venta 2', '0 15 * * * ?', new SCHED_Staging_Proceso_Venta());
    System.schedule('Staging Proceso Venta 3', '0 30 * * * ?', new SCHED_Staging_Proceso_Venta());
    System.schedule('Staging Proceso Venta 4', '0 45 * * * ?', new SCHED_Staging_Proceso_Venta());
    */

    global void execute(SchedulableContext ctx) {
        List <Opportunity> listUpdOpp;
        Map <Id, Opportunity> mapOpps = new Map <Id, Opportunity>();
        
        List <Update_Statging_Table__c> lStaging = [
            SELECT Estatus_UST__c,
                Opportunity_Id__c,
                Valor_del_Estatus__c,
                Fecha__c
            FROM Update_Statging_Table__c
            WHERE Estatus_UST__c IN ('Nuevo','Falló')
            AND Opportunity_Id__c != null
            ORDER BY Estatus_UST__c DESC
            LIMIT 100];
              
        for (Update_Statging_Table__c s : lStaging) {
            // OP Id repetido?
            if (!mapOpps.containsKey(s.Opportunity_Id__c)) {
                Opportunity updOpp = new Opportunity();
                // Asignaciones
                updOpp.Id = s.Opportunity_Id__c;
                updOpp.StageName = s.Valor_del_Estatus__c;
                updOpp.Fecha_Escrituracion__c = s.Fecha__c;
                updOpp.ValidationBypassDateTime__c = datetime.now();
        
                mapOpps.put(s.Opportunity_Id__c, updOpp);
            }
        }
        listUpdOpp = mapOpps.values();
        system.debug ('*** listUpdOpp: '+listUpdOpp);
        
        // Update proceso venta
        map <Id, String> mapProc = new Map<Id,String>();
        if (listUpdOpp.size()>0) {
            Database.SaveResult[] saveResults = Database.update (listUpdOpp, false);
            //update listUpdOpp;
            
            for (Integer i = 0; i < saveResults.size(); i++) {
                if (saveResults.get(i).isSuccess()) {
                    mapProc.put(saveResults.get(i).Id, 'Actualizado');
                } else {
                    mapProc.put(saveResults.get(i).Id, 'Falló');
                }
            }
        }
        
        system.debug ('*** mapProc: '+mapProc);
        
        // Marcar Actualizado el procesado
        for (Update_Statging_Table__c s : lStaging) {
            if (mapProc.containsKey(s.Opportunity_Id__c)) {
                s.Estatus_UST__c = mapProc.get(s.Opportunity_Id__c);
            }
        }
        update lStaging;
        system.debug ('*** lStaging: '+lStaging);
    }
}