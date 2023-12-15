@isTest
public class WS_ManageViviendas_Test {
    static TestMethod void testMethod1() {
          Test.setMock(HttpCalloutMock.class, new MockHttpWorkday()); 
        Test.startTest();
        WS_ManageViviendas.ExtractViviendas();
        Test.stopTest();
    }
    
}