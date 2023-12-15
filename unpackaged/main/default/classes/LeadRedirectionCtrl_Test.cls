@isTest 
public without sharing class LeadRedirectionCtrl_Test {

    @testSetup
    public static void setup(){

    }

    @isTest
    private static void LeadRedirectionCtrl(){
        test.startTest();
        LeadRedirectionCtrl.getLead('test');
        test.stopTest();
    }
}