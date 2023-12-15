public class CreateNewProcesoVentaController {
    @AuraEnabled
    public static string crearNuevoProcVenta(Id accountId) {
        List <Account> lAcc = [SELECT Id, Name, Asesor__c, Fraccionamiento_cta__c,Quote_Prototipo__c, Fecha_de_Afluencia__c,Prototipo_lookup__c  FROM Account    WHERE Id = :accountId LIMIT 1];
        if (lAcc.size()>0) {
            Account acc = lAcc[0];
          
            if (acc.Prototipo_lookup__c == null) {
                CalloutException e = new CalloutException();
                e.setMessage('No se permite crear Proceso de Venta sin Prototipo asignado');
                throw e;
            } 
            if (acc.Asesor__c == null) {
                CalloutException e = new CalloutException();
                e.setMessage('No se permite crear Proceso de Venta sin Asesor asignado');
                throw e;
            } 
            Opportunity newOpp = new Opportunity (Name = 'Por asignar',AccountId = accountId,StageName = 'Validación',Probability = 0.2, CloseDate = Date.Today()+7, Amount = 0);
            insert newOpp;
            return (newOpp.Id);
        } 
        else {
            return null;
        }
    }
}