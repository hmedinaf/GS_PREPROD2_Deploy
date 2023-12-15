@isTest
public class FindApprovalComments_Test {
    @isTest
    static void test1(){
        Test.startTest();
        Account acc = new Account();
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c = f.id;
        insert acc;
        
        Approval.ProcessSubmitRequest req1 =   new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId( acc.Id);
        req1.setSubmitterId(userInfo.getUserId()); 
        req1.setProcessDefinitionNameOrId('Aprobacion_Check_Apellido');
        req1.setSkipEntryCriteria(true);
        Approval.ProcessResult result = Approval.process(req1);
        
        FindApprovalComments findComments = new FindApprovalComments();
        findComments.objId = acc.Id;
        findComments.StepStatusMessage = 'Pending';
        List<ProcessInstanceStep> comments1 = findComments.approvalComments;
        Test.stopTest();
    }
}