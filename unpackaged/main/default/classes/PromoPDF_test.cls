@isTest
public class PromoPDF_test {
@isTest
    static void test1(){
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;               
        Promocion__c promo = new Promocion__c(Fraccionamiento__c = f.id, Imagen__c = '<p> <img src="https://example.com/image.png"></p>');
        insert promo;
        pagereference pf = Page.PromoPDF;
        Test.setCurrentPageReference(pf);
        ApexPages.currentPage().getParameters().put('id', promo.id) ;
        Test.startTest();
        PromoPDF pc = new PromoPDF();
        Test.stopTest();
    }
}