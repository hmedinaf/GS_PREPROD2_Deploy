@isTest
public class trg_Aprobacion_SolicitudTyT_Test {
    static TestMethod void testMethod1() {
        SolicitudesTramitesYTransferencias__c solicitud = new SolicitudesTramitesYTransferencias__c();
        solicitud.Name = 'TEST' ;
        solicitud.Numero__c = 'test';
        solicitud.StatusInternoAprobacion__c = 'xxxxxx';
        solicitud.RecordTypeId =Schema.sObjectType.SolicitudesTramitesYTransferencias__c.getRecordTypeInfosBydevelopername().get('Transferencia').getRecordTypeId();
        insert solicitud;
        Test.startTest();
        solicitud.StatusInternoAprobacion__c = 'Aprobado';
        solicitud.Aprobacion_Externa__c = false;
        update solicitud;
        Test.stopTest();
    }
    static TestMethod void testMethod2() {
        SolicitudesTramitesYTransferencias__c solicitud = new SolicitudesTramitesYTransferencias__c();
        solicitud.Name = 'TEST' ;
        solicitud.Numero__c = 'test';
        solicitud.StatusInternoAprobacion__c = 'xxxxxx';
        solicitud.RecordTypeId =Schema.sObjectType.SolicitudesTramitesYTransferencias__c.getRecordTypeInfosBydevelopername().get('Transferencia').getRecordTypeId();
        insert solicitud;
        Test.startTest();
        solicitud.StatusInternoAprobacion__c = 'Aprobado';
        solicitud.Aprobacion_Externa__c = true;
        update solicitud;
        Test.stopTest();
    }
}