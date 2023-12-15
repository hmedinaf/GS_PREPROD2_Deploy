public class NuevoProcesoVentaButtonAuraController {
    @AuraEnabled
    public static Id createOpportunityApex(Id recordId) {
       Opportunity newOpportunity = new Opportunity (
            Name = 'Por asignar',
            AccountId = recordId,
            StageName = 'Validación',
            Probability = 0.2,
            CloseDate = Date.Today()+7,
            Amount = 0);
 
       insert newOpportunity;

       // Obtener nuevo Name
       List <Opportunity> opp = [SELECT Id, Name, Numero_Proceso_de_Venta__c FROM Opportunity WHERE Id = :newOpportunity.Id];
       opp[0].Name = opp[0].Numero_Proceso_de_Venta__c;
       opp[0].Referencia_Bancaria__c = CLASS_Oportunidad.CalculaDigitoVerificador(Opp[0].Numero_Proceso_de_Venta__c);
       update opp;

       return newOpportunity.Id;
    }
 }