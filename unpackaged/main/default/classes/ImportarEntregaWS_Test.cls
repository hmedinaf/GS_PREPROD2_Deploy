@isTest 
public without sharing class ImportarEntregaWS_Test {

    @testSetup
    public static void setup(){
    }

    @isTest
    private static void ImportarEntregaWS_Test(){
        Test.startTest();
        EntregaWSSchedule en = new EntregaWSSchedule();
        en.execute(null);
        ImportarEntregaWS.run(1);
        Test.stopTest();
    }
}