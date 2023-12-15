@isTest
public class Test_InfonavitController {
	static testMethod void redirect(){
        Test.startTest();
		InfonavitController javer = new InfonavitController();
        javer.redirect();
        Test.stopTest();
    }
}