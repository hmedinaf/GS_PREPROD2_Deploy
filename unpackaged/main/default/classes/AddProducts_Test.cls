@isTest
public class AddProducts_Test {
    @isTest(seeAllData=true)
    public static void testMethod1() {
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.ProductCode = 'Pro-X';
        prod1.Precio_Venta__c = 10.0;
        prod1.RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        insert prod1;
        Pricebook2 pb1  = new Pricebook2();
        pb1.Name = 'Standard Price Book1';
        pb1.Description = 'test';
        pb1.Periodo_Inicio__c='JUNIO 2023';
        pb1.Periodo_Fin__c='JUNIO 2023';
        pb1.Vigente_Desde__c = system.today() ;
        pb1.Vigente_Hasta__c= Date.newInstance(2023, 08, 30);
        pb1.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosBydevelopername().get('Producto_Generico').getRecordTypeId();
        insert pb1;
        Test.startTest();
        AddProducts.fetchProducts();
        AddProducts.fetchPbRecords(prod1.Id);
        AddProducts.updateProdRecords(pb1.Id, prod1.Id);
        Test.stopTest();
    }
}