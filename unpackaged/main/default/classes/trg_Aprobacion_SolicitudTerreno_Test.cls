@isTest
public class trg_Aprobacion_SolicitudTerreno_Test {
    static TestMethod void testMethod1() {
        SolicitudTerreno__c solicitud = new SolicitudTerreno__c();
        solicitud.Name = 'TEST' ;
        solicitud.NombreDeDocumento__c = 'test';
        solicitud.StatusInternoAprobacion__c = 'xxxxxx';
        insert solicitud;
        Test.startTest();
        solicitud.StatusInternoAprobacion__c = 'Aprobado';
        solicitud.Aprobacion_Externa__c = false;
        update solicitud;
        Test.stopTest();
    }
     static TestMethod void testMethod2() {
        SolicitudTerreno__c solicitud = new SolicitudTerreno__c();
        solicitud.Name = 'TEST' ;
        solicitud.NombreDeDocumento__c = 'test';
        solicitud.StatusInternoAprobacion__c = 'xxxxxx';
        insert solicitud;
        Test.startTest();
        solicitud.StatusInternoAprobacion__c = 'Aprobado';
        solicitud.Aprobacion_Externa__c = true;
        update solicitud;
        Test.stopTest();
    }
}