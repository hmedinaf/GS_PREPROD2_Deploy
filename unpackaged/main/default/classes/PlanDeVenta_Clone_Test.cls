@isTest
public class PlanDeVenta_Clone_Test {
    static testmethod void testMigrate1(){
        
        Plan_de_Venta__c p = new Plan_de_Venta__c();
        insert p;
        Id pricebookId = Test.getStandardPricebookId();
        
        //Create your product
        Product2 prod = new Product2(
            Name = 'Product X',
            ProductCode = 'Pro-X',
            isActive = true,
            Precio_Venta__c = 10.0,
            Description = 'test'
        );
        insert prod;
        
        //Create your pricebook entry
        PricebookEntry pbEntry = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id = prod.Id,
            UnitPrice = 100.00,
            IsActive = true
        );
        insert pbEntry;
        
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        
        //create your opportunity line item.  This assumes you already have an opportunity created, called opp
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = opp.Id,
            Quantity = 5,
            PricebookEntryId = pbEntry.Id
        );
        oli.TotalPrice = oli.quantity * pbEntry.UnitPrice;
        insert oli;
        
        Producto_de_Plan_de_Venta__c prodPlan = new Producto_de_Plan_de_Venta__c();
        prodPlan.Plan_de_Venta__c = p.id;
        prodPlan.Producto_de_oportunidad__c = Oli.id;
        prodPlan.Cantidad__c = 12;
        insert prodPlan;
        test.startTest();
        PlanDeVenta_Clone.clonePDV(p.id);
        test.stopTest();
    }
     static testmethod void testMigrate2(){
         test.startTest();
        PlanDeVenta_Clone.clonePDV('string');
        test.stopTest();
     }
}