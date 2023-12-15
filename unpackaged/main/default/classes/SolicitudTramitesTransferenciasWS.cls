global class SolicitudTramitesTransferenciasWS {

  global class SolicitudTramitesTransferenciasWrapper {
    webservice SolicitudesTramitesYTransferencias__c solicitudTramiteTransfer;
    webservice List<DetalleTramite__c> detalleTramite;
    webservice List<Tramites__c> tramite;
  }

  webservice static List<ResponseWS> upsertSolicitudesTramitesTransferencias(List<SolicitudTramitesTransferenciasWrapper> solicitudes) {

    List<ResponseWS> responseList = new List<ResponseWS>();
    List<Bitacora__c> logs = new List<Bitacora__c>();
    List<SolicitudTramitesTransferenciasWrapper> solicitudesWithExternalId = new List<SolicitudTramitesTransferenciasWrapper>();

    // Determine which records need to be inserted and which updated by looking for external Ids
    Set<String> externalIds1 = new Set<String>();
    Set<String> externalIds2 = new Set<String>();

    for (SolicitudTramitesTransferenciasWrapper wrap : solicitudes) {
      if (wrap.solicitudTramiteTransfer.Numero__c != null) {
        externalIds1.add(wrap.solicitudTramiteTransfer.Numero__c);
        solicitudesWithExternalId.add(wrap);
      } else if (wrap.solicitudTramiteTransfer.NumerodeSolicitud__c != null) {
        externalIds2.add(wrap.solicitudTramiteTransfer.NumerodeSolicitud__c);
        solicitudesWithExternalId.add(wrap);
      } else {
        responseList.add(new ResponseWS(null, 'MISSING FIELDS', 400, 'No se especificó identificador externo (Numero__c, NumerodeSolicitud__c)', null));
      }
    }

    List<SolicitudesTramitesYTransferencias__c> existingSolicitudes = [SELECT Numero__c, NumerodeSolicitud__c FROM SolicitudesTramitesYTransferencias__c
                                                                        WHERE Numero__c IN :externalIds1 OR NumerodeSolicitud__c IN :externalIds2];

    List<SolicitudTramitesTransferenciasWrapper> wrapperToInsert = new List<SolicitudTramitesTransferenciasWrapper>();
    List<SolicitudesTramitesYTransferencias__c> solicitudToUpdate = new List<SolicitudesTramitesYTransferencias__c>();
    List<SolicitudesTramitesYTransferencias__c> solicitudToUpdateAprobacion = new List<SolicitudesTramitesYTransferencias__c>();

    for (SolicitudTramitesTransferenciasWrapper wrap : solicitudesWithExternalId) {
      Boolean exist = false;
      for (SolicitudesTramitesYTransferencias__c existing : existingSolicitudes) {
        if ((existing.Numero__c != null && existing.Numero__c == wrap.solicitudTramiteTransfer.Numero__c) 
         || (existing.NumerodeSolicitud__c != null && existing.NumerodeSolicitud__c == wrap.solicitudTramiteTransfer.NumerodeSolicitud__c)) {
          exist = true;
          if (wrap.solicitudTramiteTransfer.EstadodeSolicitud__c == null && wrap.solicitudTramiteTransfer.AprobadorIDExterno__c == null) {
            responseList.add(new ResponseWS(existing.Id, 'MISSING FIELDS', 400, 'No se especificó ningún campo compatible con actualización (EstadodeSolicitud__c, AprobadorIDExterno__c)', 'Actualización'));
          } else {
            SolicitudesTramitesYTransferencias__c updatable = new SolicitudesTramitesYTransferencias__c(Id = existing.Id, EstadodeSolicitud__c = wrap.solicitudTramiteTransfer.EstadodeSolicitud__c, 
            AprobadorIDExterno__c = wrap.solicitudTramiteTransfer.AprobadorIDExterno__c, Aprobacion_Externa__c = true, StatusInternoAprobacion__c = null);
            
            SolicitudesTramitesYTransferencias__c updatableAprobacion = new SolicitudesTramitesYTransferencias__c(Id = existing.Id, Aprobacion_Externa__c = true, StatusInternoAprobacion__c = null);
            
            solicitudToUpdate.add(updatable);
            solicitudToUpdateAprobacion.add(updatableAprobacion);
          }
          break;
        }
      }

      if (!exist) {
        wrapperToInsert.add(wrap);
      }
    }

    responseList.addAll(processInsert(wrapperToInsert));
    
    Database.SaveResult[] updateResultSolicitudes = Database.Update(solicitudToUpdateAprobacion, false);

    responseList.addAll(processUpdate(solicitudToUpdate));

    // create logs
    for (ResponseWS resp : responseList) {
      Bitacora__c log = new Bitacora__c(CodigoDeError__c = String.valueOf(resp.codigo_de_error), Estado__c = resp.success,
                                        Fecha__c = Date.today(), id__c = resp.id, Mensaje__c = resp.mensaje, Operacion__c = resp.getAction(),
                                        Origen__c = 'Oracle', ServicioWeb__c = 'Servicio de Solicitudes de Trámites y Transferencias en Salesforce',
                                        TipoDeError__c = resp.tipo_de_error);
      logs.add(log);
    }

    if (logs.size() > 0) {
      try {
        insert logs;
      } catch (DMLException e) {
        System.debug(System.LoggingLevel.ERROR, 'Error inserting webservice logs: ' + e.getDmlMessage(0));
      }
    }

    return responseList;
  }



  private static List<ResponseWS> processInsert(List<SolicitudTramitesTransferenciasWrapper> wrapperToInsert) {

    List<ResponseWS> innerResponseList = new List<ResponseWS>();

    // for records being inserted, insert copying identifier to Name field then group related object for later Id assignment
    Map<String, List<DetalleTramite__c>> relatedObjectMap1 = new Map<String, List<DetalleTramite__c>>();
    Map<String, List<Tramites__c>> relatedObjectMap2 = new Map<String, List<Tramites__c>>();
	Map<String, SolicitudesTramitesYTransferencias__c> solicitudesWithApprover = new Map<String, SolicitudesTramitesYTransferencias__c>();
    List<SolicitudesTramitesYTransferencias__c> solicitudesToInsert = new List<SolicitudesTramitesYTransferencias__c>();

    for (SolicitudTramitesTransferenciasWrapper wrap : wrapperToInsert) {

      String key;
	  Map<String, Schema.RecordTypeInfo> solicitudRecordTypeInfo =
                SolicitudesTramitesYTransferencias__c.SObjectType.getDescribe().getRecordTypeInfosByName();
	  if(wrap.solicitudTramiteTransfer.Numero__c != null){
	  	key = wrap.solicitudTramiteTransfer.Numero__c;
	  	wrap.solicitudTramiteTransfer.RecordTypeId = solicitudRecordTypeInfo.get('Transferencias').getRecordTypeId();
	  }else{
	  	key = wrap.solicitudTramiteTransfer.NumerodeSolicitud__c;
	  	wrap.solicitudTramiteTransfer.RecordTypeId = solicitudRecordTypeInfo.get('Trámites').getRecordTypeId();
	  }
      wrap.solicitudTramiteTransfer.Name = key;
      solicitudesToInsert.add(wrap.solicitudTramiteTransfer);

      List<DetalleTramite__c> details = new List<DetalleTramite__c>();

      if (wrap.detalleTramite != null) {
        for (DetalleTramite__c detail : wrap.detalleTramite) {
          details.add(detail);
        }
      }

      relatedObjectMap1.put(key, details);

      List<Tramites__c> tramites = new List<Tramites__c>();

      if (wrap.tramite != null) {
        for (Tramites__c tramite : wrap.tramite) {
          tramites.add(tramite);
        }
      }

      relatedObjectMap2.put(key, tramites);


    }

    if (solicitudesToInsert.size() > 0) {
    	Set<String> usersToLook = new Set<String>();

	    // look for appovers
	    for (SolicitudesTramitesYTransferencias__c solicitud : solicitudesToInsert) {
	      if (solicitud.AprobadorIDExterno__c != null) {
	        usersToLook.add(solicitud.AprobadorIDExterno__c);
	      }
	    }
	
	    List<SolicitudesTramitesYTransferencias__c> validSolicitudes = new List<SolicitudesTramitesYTransferencias__c>();
		
	    //List<User> approvers = [SELECT Alias FROM User WHERE Alias IN :usersToLook];
	    List<User> approvers = [SELECT CommunityNickName FROM User WHERE CommunityNickName IN :usersToLook];
	
	    for (SolicitudesTramitesYTransferencias__c solicitud : solicitudesToInsert) {
	      if (solicitud.AprobadorIDExterno__c != null) {
	        Boolean exist = false;
	        for (User user : approvers) {
	          if (user.CommunityNickName == solicitud.AprobadorIDExterno__c) {
	          	validSolicitudes.add(solicitud);
	            solicitudesWithApprover.put(solicitud.Name, new SolicitudesTramitesYTransferencias__c(Name = solicitud.Name, Aprobador__c = user.Id));
	            exist = true;	            
	          }
	        }
	
	        if (!exist) {
	          innerResponseList.add(new ResponseWS(solicitud.Name, 'BAD REFERENCE', 400, 'Se especificó un identificador externo de un aprobador que no existe', 'Aprobación'));
	        }
	      } else {
	        validSolicitudes.add(solicitud);
	      }
	    }
    	
    	
      // insert solicitud records
      Database.SaveResult[] insertResultSolicitudes = Database.Insert(validSolicitudes, false);

      List<DetalleTramite__c> detailsToInsert = new List<DetalleTramite__c>();
      List<Tramites__c> tramitesToInsert = new List<Tramites__c>();
	  List<SolicitudesTramitesYTransferencias__c> approvalsToUpdate = new List<SolicitudesTramitesYTransferencias__c>();
      List<SolicitudesTramitesYTransferencias__c> successRequests = new List<SolicitudesTramitesYTransferencias__c>();
	  Map<Id, ResponseWS> failedSolicitudesByApproval = new Map<Id, ResponseWS>();
      // verify which succeeded and which failed
      for (Integer i = 0; i < validSolicitudes.size(); i++) {
		
        Database.SaveResult resultRequest = insertResultSolicitudes[i];

        String key = (validSolicitudes[i].Numero__c != null) ? validSolicitudes[i].Numero__c : validSolicitudes[i].NumerodeSolicitud__c;

        if (resultRequest.isSuccess()) {

          successRequests.add(validSolicitudes[i]);

          List<DetalleTramite__c> innerDetails = relatedObjectMap1.get(key);

          for (DetalleTramite__c detail : innerDetails) {
            detail.Solicitud__c = resultRequest.getId();
            detail.Name = key;
            detailsToInsert.add(detail);
          }

          List<Tramites__c> innerTramites = relatedObjectMap2.get(key);

          for (Tramites__c tramite : innerTramites) {
            tramite.Solicitud__c = resultRequest.getId();
            tramitesToInsert.add(tramite);
          }
          
          SolicitudesTramitesYTransferencias__c solicitudToApprove = solicitudesWithApprover.get(key);
          if(solicitudToApprove != null){          	
          	solicitudToApprove.Id = resultRequest.getId();
          	approvalsToUpdate.add(solicitudToApprove);
          }
        
        } else {
          Database.Error err = resultRequest.getErrors()[0];
          innerResponseList.add(new ResponseWS(key, 'DB ERROR', 500, 'Error insertando solicitud: ' + err.getMessage(), 'Creación'));
        }
      }

      Map<Id, ResponseWS> failedSolicitudesByDetails = new Map<Id, ResponseWS>();

      if (detailsToInsert.size() > 0) {
        Database.SaveResult[] insertResultDetails = Database.Insert(detailsToInsert, false);

        // verify which succeeded and which failed
        for (Integer i = 0; i < detailsToInsert.size(); i++) {
          Database.SaveResult resultDetail = insertResultDetails[i];

          if (!resultDetail.isSuccess()) {
            Database.Error err = resultDetail.getErrors()[0];
            ResponseWS errResp = new ResponseWS(detailsToInsert[i].Solicitud__c, 'DB ERROR', 500, 'Solicitud registrada, pero error insertando detalle de trámite: ' + err.getMessage(), 'Creación');
            failedSolicitudesByDetails.put(((DetalleTramite__c)detailsToInsert[0]).Solicitud__c, errResp);
          }
        }
      }


      Map<Id, ResponseWS> failedSolicitudesByTramite = new Map<Id, ResponseWS>();

      if (tramitesToInsert.size() > 0) {
        Database.SaveResult[] insertResultTramites = Database.Insert(tramitesToInsert, false);

        // verify which succeeded and which failed
        for (Integer i = 0; i < tramitesToInsert.size(); i++) {
          Database.SaveResult resultTramite = insertResultTramites[i];

          if (!resultTramite.isSuccess()) {
            Database.Error err = resultTramite.getErrors()[0];
            ResponseWS errResp = new ResponseWS(tramitesToInsert[i].Solicitud__c, 'DB ERROR', 500, 'Solicitud registrada, pero error insertando trámite: ' + err.getMessage(), 'Creación');
            failedSolicitudesByTramite.put(((Tramites__c)tramitesToInsert[0]).Solicitud__c, errResp);
          }
        }
      }
	  if(approvalsToUpdate.size() > 0){		  
          failedSolicitudesByApproval = triggerApproval(approvalsToUpdate);	
	  }
      // iterate over succesful solicitudes and verify existence of related records fails
      for (SolicitudesTramitesYTransferencias__c solicitud : successRequests) {
      	if (failedSolicitudesByApproval.containsKey(solicitud.Id)) {
          innerResponseList.add(failedSolicitudesByApproval.get(solicitud.Id));
        } 
        if (failedSolicitudesByDetails.containsKey(solicitud.Id)) {
          innerResponseList.add(failedSolicitudesByDetails.get(solicitud.Id));
        } else if (failedSolicitudesByTramite.containsKey(solicitud.Id)) {
          innerResponseList.add(failedSolicitudesByTramite.get(solicitud.Id));
        } else {
          innerResponseList.add(new ResponseWS(solicitud.Id, 'Creación'));
        }
      }

    }

    return innerResponseList;
  }

  private static Map<Id, ResponseWS> triggerApproval(List<SolicitudesTramitesYTransferencias__c> solicitudesToCreate){
  	List<SolicitudesTramitesYTransferencias__c> solicitudesRequireApproval = new List<SolicitudesTramitesYTransferencias__c>();
  	Map<Id, ResponseWS> failedSolicitudesByApproval = new Map<Id, ResponseWS>();
  	for (SolicitudesTramitesYTransferencias__c solicitud : solicitudesToCreate){
  		if(solicitud.Aprobador__c != null){
  			SolicitudesTramitesYTransferencias__c solicitudWithApprover = new SolicitudesTramitesYTransferencias__c(Id = solicitud.Id, 
            Aprobador__c = solicitud.Aprobador__c);
            solicitudesRequireApproval.add(solicitudWithApprover);
  		}
  	}
  	if(solicitudesRequireApproval.size() > 0){
  		Database.SaveResult[] updateResultSolicitudes = Database.Update(solicitudesRequireApproval, false);

      // verify which failed
      List<SolicitudesTramitesYTransferencias__c> succeeded = new List<SolicitudesTramitesYTransferencias__c>();

      for (Integer i = 0; i < solicitudesRequireApproval.size(); i++) {

        Database.SaveResult resultSolicitud = updateResultSolicitudes[i];

        if (!resultSolicitud.isSuccess()) {
          Database.Error err = resultSolicitud.getErrors()[0];
          failedSolicitudesByApproval.put(solicitudesRequireApproval[i].Id, new ResponseWS(solicitudesRequireApproval[i].Id, 'DB ERROR', 500, 'Solicitud registrada, pero error iniciando proceso de aprobación: ' + err.getMessage(), 'Creación'));
        }
      }
  	}
  	return failedSolicitudesByApproval;
  }
  
  private static List<ResponseWS> processUpdate(List<SolicitudesTramitesYTransferencias__c> solicitudesToUpdate) {

    List<ResponseWS> innerResponseList = new List<ResponseWS>();

    Set<String> usersToLook = new Set<String>();

    // look for appovers
    for (SolicitudesTramitesYTransferencias__c solicitud : solicitudesToUpdate) {
      if (solicitud.AprobadorIDExterno__c != null) {
        usersToLook.add(solicitud.AprobadorIDExterno__c);
      }
    }

    List<SolicitudesTramitesYTransferencias__c> validSolicitudes = new List<SolicitudesTramitesYTransferencias__c>();

    //List<User> approvers = [SELECT Alias FROM User WHERE Alias IN :usersToLook];
    List<User> approvers = [SELECT CommunityNickName FROM User WHERE CommunityNickName IN :usersToLook];

    for (SolicitudesTramitesYTransferencias__c solicitud : solicitudesToUpdate) {
      if (solicitud.AprobadorIDExterno__c != null) {
        Boolean exist = false;
        for (User user : approvers) {
          if (user.CommunityNickName == solicitud.AprobadorIDExterno__c) {
            solicitud.Aprobador__c = user.Id;
            exist = true;
            validSolicitudes.add(solicitud);
          }
        }

        if (!exist) {
          innerResponseList.add(new ResponseWS(solicitud.Id, 'BAD REFERENCE', 400, 'Se especificó un identificador externo de un aprobador que no existe', 'Aprobación'));
        }
      } else {
        validSolicitudes.add(solicitud);
      }
    }
    
    if (validSolicitudes.size() > 0) {
      	manageApprovalProcesses(validSolicitudes);
      	      	
      	Database.SaveResult[] updateResultSolicitudes = Database.Update(validSolicitudes, false);

      // verify which succeeded and which failed
      List<SolicitudesTramitesYTransferencias__c> succeeded = new List<SolicitudesTramitesYTransferencias__c>();

      for (Integer i = 0; i < validSolicitudes.size(); i++) {

        String operation = (validSolicitudes[i].Aprobador__c != null) ? 'Actualización' : 'Aprobación';

        Database.SaveResult resultSolicitud = updateResultSolicitudes[i];

        if (resultSolicitud.isSuccess()) {
          succeeded.add(validSolicitudes[i]);
          innerResponseList.add(new ResponseWS(validSolicitudes[i].Id, operation));
        } else {
          Database.Error err = resultSolicitud.getErrors()[0];
          innerResponseList.add(new ResponseWS(validSolicitudes[i].Id, 'DB ERROR', 500, 'Error actualizando solicitud: ' + err.getMessage(), operation));
        }
      }
    }

    return innerResponseList;
  }


  private static void manageApprovalProcesses(List<SolicitudesTramitesYTransferencias__c> solicitudes) {

    Set<Id> resultIds = (new Map<Id,SolicitudesTramitesYTransferencias__c>(solicitudes)).keySet();

    List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];

    List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest> ();

    for (SolicitudesTramitesYTransferencias__c solicitud : solicitudes) {
    	System.Debug('solicitud.EstadodeSolicitud__c: ' + solicitud.EstadodeSolicitud__c + ' solicitud.Aprobacion_Externa__c: ' + solicitud.Aprobacion_Externa__c);
      for (ProcessInstanceWorkitem process : pendingApprovalProcesses) {
        if (process.ProcessInstance.TargetObjectId == solicitud.Id) {
          if (solicitud.EstadodeSolicitud__c == 'Rechazado' && solicitud.Aprobacion_Externa__c == true) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Rechazado por servicio web');
            req.setAction('Reject');
            req.setWorkitemId(process.Id);
            requests.add(req);
          } else if (solicitud.EstadodeSolicitud__c == 'Aprobado' && solicitud.Aprobacion_Externa__c == true) {
          	System.Debug('solicitud.Aprobador__c: ' + solicitud.Aprobador__c);
          	System.Debug('solicitud.Aprobacion_Externa__c: ' + solicitud.Aprobacion_Externa__c);
	            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
	            req.setComments('Aprobado por servicio web');
	            req.setAction('Approve');
	            req.setWorkitemId(process.Id);
	            requests.add(req);
          }
        }
      }
    }

    if (requests.size() > 0) {
    	System.Debug('requests: ' + requests.size());
    	Approval.ProcessResult[] processResults;
    	try
    	{
      		processResults =  Approval.process(requests, false);
    	}catch(Exception ex)
    	{
    		System.Debug('Exception: ' + ex.getMessage());
    	}

      for (Integer i = 0; i < requests.size(); i++) {
        if (!processResults[i].isSuccess()) {
          System.debug(System.LoggingLevel.ERROR, 'Error approving/rejecting approval process: ' + processResults[i].getErrors()[0].getMessage());
        }
      }
    }
  }
}