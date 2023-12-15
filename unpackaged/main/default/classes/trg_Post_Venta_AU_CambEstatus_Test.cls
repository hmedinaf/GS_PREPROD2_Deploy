@isTest
public class trg_Post_Venta_AU_CambEstatus_Test {
	static TestMethod void Test1() {
        Post_Venta__c post = new Post_Venta__c(name = 'test');
        insert post;
        Test.startTest();
        post.Estatus__c = 'Aprobada';
        update post;
        Test.stopTest();
    }
}