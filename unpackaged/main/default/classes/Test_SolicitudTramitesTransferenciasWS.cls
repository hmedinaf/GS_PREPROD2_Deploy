@isTest
public class Test_SolicitudTramitesTransferenciasWS{
    
    static List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> prepareData() {
        
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperList = new List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper>();
        
        for (Integer i = 0; i < 5; i++) {
            
            SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrapper = new SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper();
            SolicitudesTramitesYTransferencias__c solicitud = new SolicitudesTramitesYTransferencias__c(Name = 'TEST' + i, Numero__c = String.valueOf(i));
            
            List<DetalleTramite__c> detailList = new List<DetalleTramite__c>();
            
            for (Integer j = 0; j < 3; j++) {
                DetalleTramite__c detail = new DetalleTramite__c(Name = 'TEST ' + i + j);
                detailList.add(detail);
            }
            
            List<Tramites__c> tramiteList = new List<Tramites__c>();
            
            for (Integer k = 0; k < 3; k++) {
                Tramites__c tramite = new Tramites__c(Name = 'TEST ' + i + k);
                tramiteList.add(tramite);
            }
            wrapper.solicitudTramiteTransfer = solicitud;
            wrapper.detalleTramite = detailList;
            wrapper.tramite = tramiteList;
            wrapperList.add(wrapper);
        }
        return wrapperList;
    }
    static testMethod void testSuccessCreate(){
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperList = prepareData();
        List<ResponseWS> response = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperList);
        
        System.assertEquals(response.size(), wrapperList.size());
        
        for (Integer i = 0; i < response.size(); i++) {
            System.assert(response[i].success.contains('200'));
            System.assert(response[i].id != null);
        }
        
        Integer insertedRequest = [SELECT Count() FROM SolicitudesTramitesYTransferencias__c];
        
        System.assertEquals(insertedRequest, wrapperList.size());
        
        Integer detailCounter = 0;
        Integer tramiteCounter = 0;
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperList) {
            detailCounter += wrap.detalleTramite.size();
            tramiteCounter += wrap.tramite.size();
        }
        
        Integer insertedDetails = [SELECT Count() FROM DetalleTramite__c];
        
        System.assertEquals(insertedDetails, detailCounter);
        
        Integer insertedTramites = [SELECT Count() FROM Tramites__c];
        
        System.assertEquals(insertedTramites, tramiteCounter);
        
        Integer logs = [SELECT Count() FROM Bitacora__c];
        
        System.assertEquals(logs, response.size());
    }
    
    
    static testMethod void testSuccessUpdateStatus(){
        
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToUpdate = prepareData();
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToUpdate) {
            wrap.solicitudTramiteTransfer.EstadodeSolicitud__c = 'Pendiente';
        }
        
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToUpdate);
        
        for (Integer i = 0; i < responseUpdate.size(); i++) {
            System.assert(responseUpdate[i].success.contains('200'));
            System.assert(responseUpdate[i].id != null);
        }
        
        List<SolicitudesTramitesYTransferencias__c> updatedRequests = [SELECT Id FROM SolicitudesTramitesYTransferencias__c WHERE EstadodeSolicitud__c = 'Pendiente'];
        
        System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());
        
        Set<Id> resultIds = (new Map<Id,SolicitudesTramitesYTransferencias__c>(updatedRequests)).keySet();
        
        List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];
        
        System.assertEquals(pendingApprovalProcesses.size(), 0);
        
        Integer logs = [SELECT Count() FROM Bitacora__c];
        
        System.assertEquals(logs, responseInsert.size() + responseUpdate.size());
    }
    
    
    static testMethod void testSuccessUpdateOtherIdentifier(){
        
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToUpdate = prepareData();
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToUpdate) {
            wrap.solicitudTramiteTransfer.NumerodeSolicitud__c = wrap.solicitudTramiteTransfer.Numero__c;
            wrap.solicitudTramiteTransfer.Numero__c = null;
            wrap.solicitudTramiteTransfer.EstadodeSolicitud__c = 'Pendiente';
        }
        
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToUpdate);
        
        for (Integer i = 0; i < responseUpdate.size(); i++) {
            System.assert(responseUpdate[i].success.contains('200'));
            System.assert(responseUpdate[i].id != null);
        }
        
        List<SolicitudesTramitesYTransferencias__c> updatedRequests = [SELECT Id FROM SolicitudesTramitesYTransferencias__c WHERE EstadodeSolicitud__c = 'Pendiente'];
        
        System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());
        
        Set<Id> resultIds = (new Map<Id,SolicitudesTramitesYTransferencias__c>(updatedRequests)).keySet();
        
        List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];
        
        System.assertEquals(pendingApprovalProcesses.size(), 0);
        
        Integer logs = [SELECT Count() FROM Bitacora__c];
        
        System.assertEquals(logs, responseInsert.size() + responseUpdate.size());
    }
    
    
    static testMethod void testSuccessUpdateApprover(){
        String approverId = 'test';
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User user = new User(Alias = approverId, CommunityNickName = approverId, Email='test@test.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                             LocaleSidKey='en_US', ProfileId = profile.Id, TimeZoneSidKey='America/Caracas', UserName='test@mytesting1st.com');
        
        insert user;
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToUpdate = prepareData();
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToUpdate) {
            wrap.solicitudTramiteTransfer.AprobadorIDExterno__c = approverId;
        }
        
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToUpdate);
        
        for (Integer i = 0; i < responseUpdate.size(); i++) {
            System.assert(responseUpdate[i].success.contains('200'));
            System.assert(responseUpdate[i].id != null);
        }
        
        List<SolicitudesTramitesYTransferencias__c> updatedRequests = [SELECT Id FROM SolicitudesTramitesYTransferencias__c WHERE Aprobador__c = :user.Id];
        System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());
    }
    static testMethod void testSuccessUpdateApproverAndStatus(){
        String approverId = 'test';
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User user = new User(Alias = approverId, CommunityNickName = approverId, Email='test@test.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                             LocaleSidKey='en_US', ProfileId = profile.Id, TimeZoneSidKey='America/Caracas', UserName='test@mytestingg.com');
        
        insert user;
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToUpdate = prepareData();
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToInsert) {
            wrap.solicitudTramiteTransfer.AprobadorIDExterno__c = approverId;
        }
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToUpdate) {
            wrap.solicitudTramiteTransfer.EstadodeSolicitud__c = 'Rechazado';
        }
        
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToUpdate);
        
        for (Integer i = 0; i < responseUpdate.size(); i++) {
            System.assert(responseUpdate[i].success.contains('200'));
            System.assert(responseUpdate[i].id != null);
        }
        
        List<SolicitudesTramitesYTransferencias__c> updatedRequests = [SELECT Id FROM SolicitudesTramitesYTransferencias__c WHERE Aprobador__c = :user.Id AND EstadodeSolicitud__c = 'Rechazado'];
        
        System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());
        
        Set<Id> resultIds = (new Map<Id,SolicitudesTramitesYTransferencias__c>(updatedRequests)).keySet();
        
        List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];
        
        System.assertEquals(pendingApprovalProcesses.size(), 0);
    }
    
    
    static testMethod void testMissingExternalId(){
        
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToInsert) {
            wrap.solicitudTramiteTransfer.Numero__c = null;
        }
        
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        
        for (Integer i = 0; i < responseInsert.size(); i++) {
            System.assert(responseInsert[i].success.contains('400'));
            System.assert(responseInsert[i].id == null);
        }
        
        Integer insertedRequest = [SELECT Count() FROM SolicitudesTramitesYTransferencias__c];
        
        System.assertEquals(insertedRequest, 0);
        
        Integer insertedDetails = [SELECT Count() FROM DetalleTramite__c];
        
        System.assertEquals(insertedDetails, 0);
        
        Integer insertedTramites = [SELECT Count() FROM Tramites__c];
        
        System.assertEquals(insertedTramites, 0);
    }
    
    
    static testMethod void testMissingUpdateFields(){
        
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToUpdate = prepareData();
        
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToUpdate);
        
        for (Integer i = 0; i < responseUpdate.size(); i++) {
            System.assert(responseUpdate[i].success.contains('400'));
            System.assert(responseUpdate[i].id != null);
        }
        
        Integer originalRecords = [SELECT Count() FROM SolicitudesTramitesYTransferencias__c WHERE AprobadorIDExterno__c = null AND EstadodeSolicitud__c = null];
        
        System.assertEquals(originalRecords, wrapperListToInsert.size());
    }
    
    
    static testMethod void testNoApproverExternalId(){
        
        String approverId = 'test';
        
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToUpdate = prepareData();
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToUpdate) {
            wrap.solicitudTramiteTransfer.AprobadorIDExterno__c = approverId;
        }
        
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToUpdate);
        
        for (Integer i = 0; i < responseUpdate.size(); i++) {
            System.assert(responseUpdate[i].success.contains('400'));
            System.assert(responseUpdate[i].id != null);
        }
        
        List<SolicitudesTramitesYTransferencias__c> updatedRequests = [SELECT Id FROM SolicitudesTramitesYTransferencias__c WHERE Aprobador__c = null];
        
        System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());
    }
    
    static testmethod void testInnerApproval() {
        String approverId = 'test';
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User user = new User(Alias = approverId, CommunityNickName = approverId, Email='test@test.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                             LocaleSidKey='en_US', ProfileId = profile.Id, TimeZoneSidKey='America/Caracas', UserName='test1@mytesting.com');
        insert user;
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper> wrapperListToUpdate = prepareData();
        
        for (SolicitudTramitesTransferenciasWS.SolicitudTramitesTransferenciasWrapper wrap : wrapperListToUpdate) {
            wrap.solicitudTramiteTransfer.AprobadorIDExterno__c = approverId;
        }
        List<ResponseWS> responseInsert = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTramitesTransferenciasWS.upsertSolicitudesTramitesTransferencias(wrapperListToUpdate);
        
        List<SolicitudesTramitesYTransferencias__c> updatedRequests = [SELECT Id FROM SolicitudesTramitesYTransferencias__c WHERE Aprobador__c = :user.Id];
        for(SolicitudesTramitesYTransferencias__c soli : updatedRequests){
            soli.Aprobacion_Externa__c = false;
            soli.StatusInternoAprobacion__c = 'xxxxxx';
            update soli;
        }
        for(SolicitudesTramitesYTransferencias__c soli : updatedRequests){
            soli.Aprobacion_Externa__c = false;
            soli.StatusInternoAprobacion__c = 'Aprobado';
            update soli;
        }
        Set<Id> resultIds = (new Map<Id,SolicitudesTramitesYTransferencias__c>(updatedRequests)).keySet();
        List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest> ();
        for (ProcessInstanceWorkitem process : pendingApprovalProcesses) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Aprobado por servicio web');
            req.setAction('Approve');
            req.setWorkitemId(process.Id);
            requests.add(req);
        }
        Approval.ProcessResult[] processResults =  Approval.process(requests, false);
        for (Integer i = 0; i < requests.size(); i++) {
            System.assert(processResults[i].isSuccess());
        }
    }
    static testmethod void testGetXML(){
        AprobacionTramitesTransferenciasWS.getXMLDocument('<env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope" xmlns:wsa="http://www.w3.org/2005/08/addressing"><env:Header/><env:Body><UpdateApprovalStatusRs ResponseDate="2015-07-03T15:00:43.200-05:00" Success="true" ESB_Id="123456" xmlns="http://esb.javer.com/ManageApproval/types"/></env:Body></env:Envelope>');  
    }
}