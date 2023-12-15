@isTest
public class BatchContactPhoneUpdate_Test {
    @testSetup
    public static void setup(){
        List<talkdesk__Talkdesk_Activity__c> activities = new List<talkdesk__Talkdesk_Activity__c>();
        for (Integer i = 0; i < 200; i++) {
            talkdesk__Talkdesk_Activity__c activity = new talkdesk__Talkdesk_Activity__c(talkdesk__Contact_Phone__c = '+123456789099', talkdesk__Talkdesk_Id__c = 'tesr567'+i);
            activities.add(activity);
        }
        insert activities;
    }
    @isTest
    static void testBatchContactPhoneUpdate() {
        Test.startTest();
        BatchContactPhoneUpdate batch = new BatchContactPhoneUpdate();
        Database.executeBatch(batch);
        Test.stopTest();
        List<talkdesk__Talkdesk_Activity__c> updatedActivities = [SELECT talkdesk__Contact_Phone__c, talkdesk__Talkdesk_Id__c
                                                                  FROM talkdesk__Talkdesk_Activity__c
                                                                  WHERE talkdesk__Talkdesk_Id__c LIKE 'tesr%' Limit 1];
        for (talkdesk__Talkdesk_Activity__c activity : updatedActivities) {
            System.assertEquals('+3456789099', activity.talkdesk__Contact_Phone__c, 'Contact Phone should be updated with the correct format');
        }
    }
}