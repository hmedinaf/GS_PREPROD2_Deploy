@isTest
public class CrearCasoController_Test {
    @isTest
    static void testGuardar() {
        Inventario__c inventario = new Inventario__c();
        inventario.Name = 'Test Inventario';
        insert inventario;
        Casos_Residente__c caso = new Casos_Residente__c();
        caso.Clasificacion__c = 'A1. Corto circuito';
        caso.Tipo__c = 'A. Instalación eléctrica';
        
        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventario.Id;
        entrega.FechaEntrega__c = Date.today().addDays(-15);
        insert entrega;
        caso.ViviendaProceso__c = entrega.Inventario__c;
        insert caso;
       	Vencimiento__c v = new Vencimiento__c(Clasificacion__c = caso.Clasificacion__c,VencimientoDias__c = 1);
        insert v;
        Test.setCurrentPageReference(new PageReference('/apex/SomePage?i=' + entrega.Inventario__c));
        ApexPages.Message expectedErrorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'La vivienda no está entregada.');
        ApexPages.StandardController controller = new ApexPages.StandardController(caso);
        CrearCasoController crearCasoController = new CrearCasoController(controller);
        PageReference result = crearCasoController.guardar();
        Casos_Residente__c updatedCaso = [SELECT Nomenclatura__c, Garantiavencida__c, DiasVencimiento__c FROM Casos_Residente__c WHERE Id = :caso.Id];
    }

}