global class EncuestaAnual implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global Integer recordsProcessed = 0;
    global LogATC__c log = new LogATC__c();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'EncuestasMensual';
        Date StartDate = date.today().addMonths(-12).toStartofMonth();
        Date EndDate = date.today().addMonths(-11).toStartofMonth().addDays(-1);
        //Survey S2 = [Select Id from Survey where Name =: 'Entrega 3 meses vivienda'];
        return Database.getQueryLocator([
            SELECT Id, NumeroInterior__c, Cuenta__c, 
            Email__c, Fracc__c,
            Cuenta__r.CorreoElectronico__c
            FROM Inventario__c 
            WHERE Cuenta__r.CorreoElectronico__c != NULL
            AND FechaEntrega__c >=: StartDate 
            AND FechaEntrega__c <=: EndDate
        	AND Entregada__c != 'Cancelado']);
    }
    
    global void execute(Database.BatchableContext bc, List<Inventario__c> scope){
        for (Inventario__c PATC : scope) {
            try{
                Survey S3 = [Select Id from Survey where Name =: 'Entrega 1 año'];
                Network CMT = [SELECT Id, Name FROM Network WHERE Name = 'Encuestas'];
                SurveyInvitation newSI = new SurveyInvitation();
                newSI.Name = 'Encuesta 3 para Proceso ' + PATC.NumeroInterior__c;
                newSI.SurveyId = S3.Id;
                newSI.Proceso_ATC__c = PATC.Id;
                newSI.CommunityId = CMT.Id;
                newSI.Cuenta__c = PATC.Cuenta__c;
                newSI.Email__c = PATC.Cuenta__r.CorreoElectronico__c;
                newSI.Fraccionamiento__c = PATC.Fracc__c;
                newSI.OptionsAllowGuestUserResponse = True;
                newSI.OptionsCollectAnonymousResponse = True;
                insert newSI;
                
            }catch(Exception e){
                system.debug(e);
                log.Mensaje__c = 'Error: ' + e;
            }
            recordsProcessed = recordsProcessed + 1;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        log.Mensaje__c += '\r\n';
        log.Mensaje__c += recordsProcessed + ' records processed.';
        System.debug(log.Mensaje__c);
        insert log;
        System.debug(recordsProcessed + ' records processed. Shazam!');
    }    
    
}