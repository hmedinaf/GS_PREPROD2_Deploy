@isTest
public class Homepageclass_Test {
    @isTest
    public static void Test2() {
        Test.startTest();
        Homepageclass.fetchUser(false);
        Test.stopTest();
    }
    @isTest
    public static void Test3() {
        Homepageclass.logoutFromSite();
    }
}