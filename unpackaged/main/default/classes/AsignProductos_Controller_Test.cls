@isTest
public class AsignProductos_Controller_Test {
    static TestMethod void testMethod1() {
        Product2 p = new Product2();
        p.name = 'pro';
        p.Precio_Venta__c = 12;
        p.Description = 'Description';
        insert p;
        PricebookEntry st = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = p.Id, UnitPrice = 100 ,IsActive = true );
        insert st;
        Plaza__c plaza = new Plaza__c(name = 'Nuevo León');
        insert plaza;
        Fraccionamiento__c f = new Fraccionamiento__c(Estado_fracc__c = plaza.name, Plaza_Relacionada__c = plaza.id, Activo_frac__c=true, Id_Mas_Comercial__c='MAS-123456', Muni_fracc__c='San Pedro', Webfracc_frac__c='www.bosquereal.com.mx', Plaza__c='Nuevo León', Segmento__c='Residencial', Tipode_vivienda__c='Residencial', Fecha_Vigencia__c=date.today().addmonths(16),
                                                      Sin_Vigencia__c=true, Codigo_Fraccionamiento__c='66278', Plaza_Filtro__c='Nuevo León', Name='BOSQUE REAL');
        insert f;
        Pricebook2 pb1  = new Pricebook2();
        pb1.Name = 'Standard';
        pb1.Description = 'test';
        pb1.Fraccionamiento__c = f.Id;
        pb1.Periodo_Inicio__c='JUNIO 2023';
        pb1.Periodo_Fin__c='JUNIO 2023';
        pb1.Vigente_Desde__c = system.today() ;
        pb1.Vigente_Hasta__c= Date.newInstance(2023, 06, 30);
        pb1.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosBydevelopername().get('Producto_Generico').getRecordTypeId();
        insert pb1;
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pb1.Id, Product2Id = p.Id, UnitPrice = 100 ,IsActive = true ,UseStandardPrice = false);
        Boolean exceptionThrown2 = false;
        try {
            insert standardPrice;
        } 
        catch (Exception e) {
            exceptionThrown2 = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('anterior al día de hoy')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        List<Map<String, Object>> selectedRecords = new List<Map<String, Object>>();
        Map<String, Object> selectedRecord = new Map<String, Object>();
        selectedRecord.put('Id', P.id);
        selectedRecords.add(selectedRecord);
        Test.startTest();
        try {
            AsignProductos_Controller.asignaProductos(pb1.Id, selectedRecords);
        } 
        catch (Exception e) {
            exceptionThrown2 = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('anterior al día de hoy')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        AsignProductos_Controller.getProductos(pb1.id, p.Name);
        Test.stopTest();
    }
}