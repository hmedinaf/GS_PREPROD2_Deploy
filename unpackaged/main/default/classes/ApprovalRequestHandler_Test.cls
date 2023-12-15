@isTest
public class ApprovalRequestHandler_Test {
    @isTest
    static void test1(){
        pagereference pf = Page.ApproveRequestHandler;
        Test.setCurrentPageReference(pf);
        Plan_de_Venta__c p = new Plan_de_Venta__c();
        insert p;
        Test.startTest();
        ApexPages.currentPage().getParameters().put('id', p.id) ;
        ApexPages.currentPage().getParameters().put('action', 'Approve') ;
        ApprovalRequestHandler pc = new ApprovalRequestHandler();
        ApprovalRequestHandler.doInit();
        Test.stopTest();
    }
}