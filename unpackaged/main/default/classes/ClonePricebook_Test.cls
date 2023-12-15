@isTest
public class ClonePricebook_Test {
    static TestMethod void testMethod1() {
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        insert prod1;
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = prod1.Id, UnitPrice = 100, IsActive  = true );
        insert standardPrice;
        Pricebook2 pb1  = new Pricebook2();
        pb1.Name = 'Standard';
        pb1.Description = 'test';
        pb1.Periodo_Inicio__c='JUNIO 2023';
        pb1.Periodo_Fin__c='DICIEMBRE 2023';
        pb1.Vigente_Desde__c = system.today() ;
        pb1.Vigente_Hasta__c= Date.newInstance(2023, 08, 30);
        pb1.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosBydevelopername().get('Producto_Generico').getRecordTypeId();
        insert pb1;
        Test.startTest();
        ClonePricebook.clonePb(pb1.Id, Date.today()-1, Date.today()+7) ;
        Test.stopTest();
    }
    static TestMethod void testMethod2() {
        Product2 prod1 = new Product2();
        prod1.name = 'test11';
        prod1.Numero_Filtro__c = 2;
        prod1.IsActive = true;
        prod1.Precio_Venta__c = 10.0;
        prod1.Description = 'test';
        prod1.RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosBydevelopername().get('Productos_Genericos').getRecordTypeId();
        insert prod1;
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = prod1.Id, UnitPrice = 100, IsActive  = true );
        insert standardPrice;
        Pricebook2 pb1  = new Pricebook2();
        pb1.Name = 'Standard';
        pb1.Description = 'test';
        pb1.Periodo_Inicio__c='2023-06-03';
        pb1.Periodo_Fin__c='2023-12-03';
        pb1.Vigente_Desde__c = system.today() ;
        pb1.Vigente_Hasta__c= Date.newInstance(2023, 08, 30);
        pb1.RecordTypeId = Schema.SObjectType.Pricebook2.getRecordTypeInfosBydevelopername().get('Producto_Generico').getRecordTypeId();
        insert pb1;
        Test.startTest();
        ClonePricebook.clonePb(pb1.Id, Date.today()-1, Date.today()+7) ;
        Test.stopTest();
    }
}