@isTest
public class ApproveEventHandler_Test {
    @isTest
    static void test1(){
        Plan_de_Venta__c p = new Plan_de_Venta__c();
        insert p;
        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        app.setObjectId(p.id);
        Approval.ProcessResult result = Approval.process(app);
        Test.startTest();
        List<ProcessInstanceWorkitem> testWorkItems =  [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :p.id];
        List<ApproveEventHandler.InputVariables> inputList = new List<ApproveEventHandler.InputVariables>();
        ApproveEventHandler.InputVariables input = new ApproveEventHandler.InputVariables();
        input.workItems = testWorkItems;
        input.Action = 'approve';
        inputList.add(input);
        ApproveEventHandler.ApproveEvent(inputList);
        Test.stopTest();
    }
}