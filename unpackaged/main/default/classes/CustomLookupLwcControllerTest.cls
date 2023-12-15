@isTest
public class CustomLookupLwcControllerTest {
    
    static testMethod void testController(){
        CustomLookupLwcController.fetchLookupData(UserInfo.getFirstName(), 'User');
        CustomLookupLwcController.fetchDefaultRecord(UserInfo.getUserId(), 'User');

    }

}