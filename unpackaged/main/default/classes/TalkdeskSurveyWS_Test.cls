@IsTest
public class TalkdeskSurveyWS_Test {
    @isTest static void testUpdateTDAFields() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/TalkdeskSurveyWS/test';
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"ATC_Survey_Response_1__c" : "No","Sales_Survey_Response_1__c" : "Si","Sales_Survey_Response_2__c" : "No"}');
        RestContext.request = request;
        // Update status of existing record to Working
        TalkdeskSurveyWS.updateTDSurvey();
    }  
    // Helper method
    static Id createTestRecord() {
        // Create test record
        talkdesk__Talkdesk_Activity__c tda = new talkdesk__Talkdesk_Activity__c(talkdesk__Talkdesk_Id__c='test', talkdesk__Call_Id__c='test');
        insert tda;
        return tda.Id;
    } 

}