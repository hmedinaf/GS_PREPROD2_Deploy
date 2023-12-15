@isTest
public class Test_SolicitudTerrenoWS{

  static List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> prepareData() {

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperList = new List<SolicitudTerrenoWS.SolicitudTerrenoWrapper>();

    for (Integer i = 0; i < 5; i++) {

      SolicitudTerrenoWS.SolicitudTerrenoWrapper wrapper = new SolicitudTerrenoWS.SolicitudTerrenoWrapper();
      SolicitudTerreno__c solicitud = new SolicitudTerreno__c(Name = 'TEST' + i, NombreDeDocumento__c = String.valueOf(i));
      List<Mezcla__c> mixList = new List<Mezcla__c>();

      for (Integer j = 0; j < 3; j++) {
        Mezcla__c mix = new Mezcla__c(Name = 'TEST ' + i + j);
        mixList.add(mix);
      }

      wrapper.solicitudTerreno = solicitud;
      wrapper.mezclas = mixList;
      wrapperList.add(wrapper);
    }

    return wrapperList;
  }

  static testMethod void testSuccessCreate(){

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperList = prepareData();

    List<ResponseWS> response = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperList);

    System.assertEquals(response.size(), wrapperList.size());

    for (Integer i = 0; i < response.size(); i++) {
      System.assert(response[i].success.contains('200'));
      System.assert(response[i].id != null);
    }

    Integer insertedRequest = [SELECT Count() FROM SolicitudTerreno__c];

    System.assertEquals(insertedRequest, wrapperList.size());

    Integer mixCounter = 0;
    for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperList) {
      mixCounter += wrap.mezclas.size();
    }

    Integer insertedMix = [SELECT Count() FROM Mezcla__c];

    System.assertEquals(insertedMix, mixCounter);

    Integer logs = [SELECT Count() FROM Bitacora__c];

    System.assertEquals(logs, response.size());
  }


  static testMethod void testSuccessUpdateStatus(){

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToInsert = prepareData();
    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToUpdate = prepareData();

    for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperListToUpdate) {
      wrap.solicitudTerreno.EstadodeSolicitud__c = 'Pendiente';
    }

    List<ResponseWS> responseInsert = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToInsert);
    List<ResponseWS> responseUpdate = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToUpdate);

    for (Integer i = 0; i < responseUpdate.size(); i++) {
      System.assert(responseUpdate[i].success.contains('200'));
      System.assert(responseUpdate[i].id != null);
    }

    List<SolicitudTerreno__c> updatedRequests = [SELECT Id FROM SolicitudTerreno__c WHERE EstadodeSolicitud__c = 'Pendiente'];

    System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());

    Set<Id> resultIds = (new Map<Id,SolicitudTerreno__c>(updatedRequests)).keySet();

    List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];

    System.assertEquals(pendingApprovalProcesses.size(), 0);

    Integer logs = [SELECT Count() FROM Bitacora__c];

    System.assertEquals(logs, responseInsert.size() + responseUpdate.size());
  }


  static testMethod void testSuccessUpdateApprover(){

    String approverId = 'test';

    Profile profile = [SELECT Id FROM Profile WHERE  Name = 'System Administrator'];

    User user = new User(CommunityNickName = approverId, Alias = approverId, Email='test@test.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                      LocaleSidKey='en_US', ProfileId = profile.Id, TimeZoneSidKey='America/Caracas', UserName='tesst@mytesting.com');

    insert user;

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToInsert = prepareData();
    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToUpdate = prepareData();

    for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperListToUpdate) {
      wrap.solicitudTerreno.AprobadorIDExterno__c = approverId;
    }

    List<ResponseWS> responseInsert = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToInsert);
    List<ResponseWS> responseUpdate = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToUpdate);

    for (Integer i = 0; i < responseUpdate.size(); i++) {
      System.assert(responseUpdate[i].success.contains('200'));
      System.assert(responseUpdate[i].id != null);
    }

    List<SolicitudTerreno__c> updatedRequests = [SELECT Id FROM SolicitudTerreno__c WHERE Aprobador__c = :user.Id];

    System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());


  }


  static testMethod void testSuccessUpdateApproverAndStatus(){

    String approverId = 'test';

    Profile profile = [SELECT Id FROM Profile WHERE Name   = 'System Administrator'];

    User user = new User(CommunityNickName = approverId, Alias = approverId, Email='test@test.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                      LocaleSidKey='en_US', ProfileId = profile.Id, TimeZoneSidKey='America/Caracas', UserName='test@mytestinng.com');

    insert user;

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToInsert = prepareData();
    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToUpdate = prepareData();

    for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperListToInsert) {
      wrap.solicitudTerreno.AprobadorIDExterno__c = approverId;
    }
      
    for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperListToUpdate) {
      wrap.solicitudTerreno.EstadodeSolicitud__c = 'Rechazado';
    }

    List<ResponseWS> responseInsert = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToInsert);
    List<ResponseWS> responseUpdate = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToUpdate);

    for (Integer i = 0; i < responseUpdate.size(); i++) {
      System.assert(responseUpdate[i].success.contains('200'));
      System.assert(responseUpdate[i].id != null);
    }

    List<SolicitudTerreno__c> updatedRequests = [SELECT Id FROM SolicitudTerreno__c WHERE Aprobador__c = :user.Id AND EstadodeSolicitud__c = 'Rechazado'];

    System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());

    Set<Id> resultIds = (new Map<Id,SolicitudTerreno__c>(updatedRequests)).keySet();

    List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];

    System.assertEquals(pendingApprovalProcesses.size(), 0);
  }


  static testMethod void testMissingExternalId(){

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToInsert = prepareData();

    for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperListToInsert) {
      wrap.solicitudTerreno.NombreDeDocumento__c = null;
    }

    List<ResponseWS> responseInsert = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToInsert);

    for (Integer i = 0; i < responseInsert.size(); i++) {
      System.assert(responseInsert[i].success.contains('400'));
      System.assert(responseInsert[i].id == null);
    }

    Integer insertedRequest = [SELECT Count() FROM SolicitudTerreno__c];

    System.assertEquals(insertedRequest, 0);

    Integer insertedMixes = [SELECT Count() FROM Mezcla__c];

    System.assertEquals(insertedMixes, 0);
  }


  static testMethod void testMissingUpdateFields(){

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToInsert = prepareData();
    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToUpdate = prepareData();

    List<ResponseWS> responseInsert = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToInsert);
    List<ResponseWS> responseUpdate = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToUpdate);

    for (Integer i = 0; i < responseUpdate.size(); i++) {
      System.assert(responseUpdate[i].success.contains('400'));
      System.assert(responseUpdate[i].id != null);
    }

    Integer originalRecords = [SELECT Count() FROM SolicitudTerreno__c WHERE AprobadorIDExterno__c = null AND EstadodeSolicitud__c = null];

    System.assertEquals(originalRecords, wrapperListToInsert.size());
  }


  static testMethod void testNoApproverExternalId(){

    String approverId = 'test';

    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToInsert = prepareData();
    List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToUpdate = prepareData();

    for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperListToUpdate) {
      wrap.solicitudTerreno.AprobadorIDExterno__c = approverId;
    }

    List<ResponseWS> responseInsert = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToInsert);
    List<ResponseWS> responseUpdate = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToUpdate);

    for (Integer i = 0; i < responseUpdate.size(); i++) {
      System.assert(responseUpdate[i].success.contains('400'));
      System.assert(responseUpdate[i].id != null);
    }

    List<SolicitudTerreno__c> updatedRequests = [SELECT Id FROM SolicitudTerreno__c WHERE Aprobador__c = null];

    System.assertEquals(updatedRequests.size(), wrapperListToUpdate.size());
  }

    static testmethod void testInnerApproval() {
        String approverId = 'test';

        Profile profile = [SELECT Id FROM Profile WHERE  Name = 'System Administrator'];
    
        User user = new User(CommunityNickName = approverId, Alias = approverId, Email='test@test.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = profile.Id, TimeZoneSidKey='America/Caracas', UserName='testt@mytesting.com');
    
        insert user;
    
        List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToInsert = prepareData();
        List<SolicitudTerrenoWS.SolicitudTerrenoWrapper> wrapperListToUpdate = prepareData();
    
        for (SolicitudTerrenoWS.SolicitudTerrenoWrapper wrap : wrapperListToUpdate) {
          wrap.solicitudTerreno.AprobadorIDExterno__c = approverId;
        }
    
        List<ResponseWS> responseInsert = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToInsert);
        List<ResponseWS> responseUpdate = SolicitudTerrenoWS.upsertSolicitudesTerrenos(wrapperListToUpdate);
    
        List<SolicitudTerreno__c> updatedRequests = [SELECT Id, Aprobacion_Externa__c FROM SolicitudTerreno__c WHERE Aprobador__c = :user.Id];
    	System.assertEquals(responseUpdate.size(), updatedRequests.size());
        
        for(SolicitudTerreno__c soli : updatedRequests){
            soli.Aprobacion_Externa__c = false;
            update soli;
        }
        Set<Id> resultIds = (new Map<Id,SolicitudTerreno__c>(updatedRequests)).keySet();
    	
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
        AprobacionTerrenosWS.getXMLDocument('<env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope" xmlns:wsa="http://www.w3.org/2005/08/addressing"><env:Header/><env:Body><UpdateApprovalStatusRs ResponseDate="2015-07-03T15:00:43.200-05:00" Success="true" ESB_Id="123456" xmlns="http://esb.javer.com/ManageApproval/types"/></env:Body></env:Envelope>');  
    }
}