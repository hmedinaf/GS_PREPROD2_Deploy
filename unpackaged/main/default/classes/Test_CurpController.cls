@isTest
public class Test_CurpController {
	static testMethod void redirect(){
        Test.startTest();
		CurpController javer = new CurpController();
        javer.redirect();
        Test.stopTest();
    }
}