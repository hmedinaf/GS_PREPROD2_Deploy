@isTest
public class CLASS_RelacionPrecioProducto_Test {
    static TestMethod void Test1() {
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        insert prod1;
        PricebookEntry st = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = prod1.Id, UnitPrice = 100 ,IsActive = true );
        insert st;
        Pricebook2 pb1  = new Pricebook2();
        pb1.Name = 'Standard';
        pb1.Description = 'test';
        pb1.Periodo_Inicio__c='JUNIO 2023';
        pb1.Periodo_Fin__c='JUNIO 2023';
        pb1.Vigente_Desde__c = system.today() ;
        pb1.Vigente_Hasta__c= Date.newInstance(2023, 08, 30);
        pb1.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosBydevelopername().get('Producto_Generico').getRecordTypeId();
        insert pb1;
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pb1.Id, Product2Id = prod1.Id, UnitPrice = 100 ,IsActive = true ,UseStandardPrice = false);
         Boolean exceptionThrown2 = false;
        try {
            insert standardPrice;
        } 
        catch (Exception e) {
            exceptionThrown2 = true;
            Boolean expectedExceptionThrown =  (e.getMessage().contains('anterior al día de hoy')) ? true : false; 
            System.AssertEquals(true, expectedExceptionThrown, e.getMessage()); 
        } 
        Test.startTest();
        CLASS_RelacionPrecioProducto.getProductos(pb1.Id);
        CLASS_RelacionPrecioProducto.getProductosVivienda(pb1.Id);
        CLASS_RelacionPrecioProducto.getRelatedList(pb1.Id);
        Test.stopTest();
    }
}