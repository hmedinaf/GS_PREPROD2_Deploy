@isTest
public class shortcutsClass_Test {
    @isTest
    static void Test1() {
        Test.startTest();
        shortcutsClass.fetchShorts();
        shortcutsClass.sendEmail('testing','test');
        Test.stopTest();
    }
    @isTest
    static void Test2() {
        shortcutsClass.logoutFromSite();        
    }
}