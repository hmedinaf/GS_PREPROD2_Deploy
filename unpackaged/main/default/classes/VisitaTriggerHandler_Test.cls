@isTest
public without sharing class VisitaTriggerHandler_Test {

    @testSetup
    public static void setup(){
    }

    @isTest
    private static void VisitaTriggerHandler_Test(){
        Test.startTest();

        List<Visita__c> visitas = TestDataFactory.createVisitas(1);
        insert visitas;

        visitas[0].Estatus__c = 'Cancelada';
        update visitas;

        Test.stopTest();
    }
}