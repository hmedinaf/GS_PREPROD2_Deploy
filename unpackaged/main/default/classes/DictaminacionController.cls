public class DictaminacionController {
    public Boolean showMessage { get; private set; }
    public String errorMessage { get; private set; }

    public String accountId { get; set; }
    public String oppId { get; set; }
    public Boolean navigateToDictaminacion { get; private set; }
    public String dictaminacionUrl { get; private set; }
    private ApexPages.StandardController standardController;
    
    public DictaminacionController(ApexPages.StandardController controller) {
       standardController = controller;
       Opportunity opportunityRecord = (Opportunity)controller.getRecord();
       oppId = opportunityRecord.Id;
       accountId = [SELECT AccountId, Id FROM Opportunity WHERE Id = :oppId].AccountId;
       system.debug('*** oppId: '+oppId);
       system.debug('*** accId: '+accountId);
    }
    
    public void createDictaminacion() {
        // Query to check if a Dictaminacion record already exists for the Opportunity.
        // Replace "Dictaminacion__c" with the actual API name of your Dictaminacion object.
        List<Dictaminacion__c> existingDictaminaciones = [SELECT Id FROM Dictaminacion__c WHERE Oportunidad__c = :standardController.getId() LIMIT 1];

        if (existingDictaminaciones.isEmpty()) {

            String AsesorName = [SELECT Asesor__r.Name FROM Account WHERE id = :accountId].Asesor__r.Name;
            system.debug ('*** AsesorName: '+AsesorName);
            Dictaminacion__c dictaminacion = new Dictaminacion__c();
            dictaminacion.Account__c = accountId;
            dictaminacion.Oportunidad__c = oppId;
            dictaminacion.Asesor__c = AsesorName;
            insert dictaminacion;
            
            navigateToDictaminacion = true;
            dictaminacionUrl = '/' + dictaminacion.Id;
        } else {
            showMessage = true;
            errorMessage = 'Ya existe una Dictaminación para este Proceso de Venta.';
        }
    }

}

/*
public class DictaminacionController {
    private ApexPages.StandardController stdController;
    public Boolean showMessage { get; private set; }
    public String errorMessage { get; private set; }

    public DictaminacionController(ApexPages.StandardController controller) {
        stdController = controller;
        showMessage = false;
        errorMessage = '';
    }

    public PageReference createDictaminacion() {
        // Query to check if a Dictaminacion record already exists for the Opportunity.
        // Replace "Dictaminacion__c" with the actual API name of your Dictaminacion object.
        List<Dictaminacion__c> existingDictaminaciones = [SELECT Id FROM Dictaminacion__c WHERE Opportunity__c = :stdController.getId() LIMIT 1];

        if (existingDictaminaciones.isEmpty()) {
            // Create a new Dictaminacion record.
            Dictaminacion__c newDictaminacion = new Dictaminacion__c();
            newDictaminacion.Opportunity__c = stdController.getId(); // Set the Opportunity reference and other required fields.
            insert newDictaminacion;
        } else {
            showMessage = true;
            errorMessage = 'A Dictaminacion record already exists for this Opportunity.';
        }

        return null;
    }
}
*/