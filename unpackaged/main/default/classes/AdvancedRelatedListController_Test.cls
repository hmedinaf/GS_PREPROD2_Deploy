@isTest
public class AdvancedRelatedListController_Test {
    static TestMethod void testMethod1() {
        Opportunity opp = new Opportunity(Name = 'Test Opportunity');
        opp.StageName = 'Reservado';
        opp.CloseDate = Date.today().adddays(10);
        insert opp; 

        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 10;
        pdv.Frecuencia__c = 'Quincenal';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Estatus_Plan_de_venta__c = 'En Progreso';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        pdv.Subsidio__c  = 10;
        pdv.Anticipo__c = 20;
        pdv.Oportunidad__c = opp.Id;
        insert pdv;
        Pagare_Preventa__c p1 = new Pagare_Preventa__c();
        p1.Plan_de_Venta__c = pdv.id;
        p1.Fecha_de_Vencimiento__c = system.today().addDays(1);
        p1.Eliminado_Manualmente__c = true;
        p1.Modificado_Manualmente_Importe__c = true;
        p1.Creado_Manualmente__c = true;
        p1.Importe__c = 10.0;
        insert p1;
        // pdv.Anticipo__c = 30;
        //    update pdv;
        Pagare_Preventa__c pagares = new Pagare_Preventa__c();
        pagares.Plan_de_Venta__c = pdv.id;
        pagares.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pagares.Importe__c = 10.0;
        pagares.Eliminado_Manualmente__c = true;
        insert pagares; 
        List<String> fieldList = new List<String>();
        fieldList.add('Name');  fieldList.add('Tipo_Documento__c');
        String f  = String.join(fieldList, ',');
        
        Map<String, Object> recordData = new Map<String, Object>();  Map<String, Object> recordDataOriginal = new Map<String, Object>();
        recordData.put('Id', pagares.Id);    recordDataOriginal.put('Id', pagares.Id);
        recordData.put('Tipo_Documento__c', 'Factura'); recordDataOriginal.put('Tipo_Documento__c', 'Nota de Crédito');
        
        Test.startTest();
        AdvancedRelatedListController.fetchRecords(pdv.Id, 'Pagare_Preventa__c', f, 'false');
        AdvancedRelatedListController.saveRecord('Pagare_Preventa__c', JSON.serialize(recordData) , JSON.serialize(recordDataOriginal));
        AdvancedRelatedListController.enableCreateRecordStages(pdv.Id);
        AdvancedRelatedListController.enableCreateRecordAmounts(pdv.Id);
        AdvancedRelatedListController.enableDeleteRecords(pdv.Id);
        AdvancedRelatedListController.enableUpdateRecord(pdv.Id);
        AdvancedRelatedListController.deleteRecord('Pagare_Preventa__c', pagares.Id, pdv.Id);
        AdvancedRelatedListController.deleteRecord('contact', pagares.Id, pdv.Id);
        AdvancedRelatedListController.PagaresPreventaOriginales paga = new AdvancedRelatedListController.PagaresPreventaOriginales();
        
        Boolean exceptionThrown = false;
        try {
            AdvancedRelatedListController.deleteRecords('Pagare_Preventa__c', pdv.Id);
            
        } 
        catch (Exception e) {
            exceptionThrown = true;
        }  
        try {
            AdvancedRelatedListController.deleteRecord(null, pagares.Id, pdv.Id);
            
        } 
        catch (Exception e) {
            exceptionThrown = true;
            system.debug('getMessage'+e.getMessage());
        }  
        try {
           AdvancedRelatedListController.fetchRecords(pdv.Id, null, f, 'false');
            
        } 
        catch (Exception e) {
            exceptionThrown = true;
        }
        try {
           AdvancedRelatedListController.fetchRecords(pdv.Id, 'contact', f, 'false');
            
        } 
        catch (Exception e) {
            exceptionThrown = true;
        }
        try {
           AdvancedRelatedListController.saveRecord('null', JSON.serialize(recordData) , JSON.serialize(recordDataOriginal));
            
        } 
        catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();
    }
}