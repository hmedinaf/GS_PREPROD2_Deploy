@isTest
public class Test_JaverController {
    static testMethod void redirect(){
        Test.startTest();
		JaverController javer = new JaverController();
        javer.redirect();
        Test.stopTest();
    }
}