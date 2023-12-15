global class SolicitudTerrenoWS {

//PASO 1: agregar listas de objetos relacionados
  global class SolicitudTerrenoWrapper {
    webservice SolicitudTerreno__c solicitudTerreno;
    webservice List<Mezcla__c> mezclas;
    webservice List<Factura__c> facturas;
  }

  webservice static List<ResponseWS> upsertSolicitudesTerrenos(List<SolicitudTerrenoWrapper> solicitudes) {

    List<ResponseWS> responseList = new List<ResponseWS>();
    List<Bitacora__c> logs = new List<Bitacora__c>();
    List<SolicitudTerrenoWrapper> solicitudesWithExternalId = new List<SolicitudTerrenoWrapper>();

    // Determine which records need to be inserted and which updated by looking for external Ids
    Set<String> externalIds = new Set<String>();
    for (SolicitudTerrenoWrapper wrap : solicitudes) {
      if (wrap.solicitudTerreno.NombreDeDocumento__c != null) {
        externalIds.add(wrap.solicitudTerreno.NombreDeDocumento__c);
        solicitudesWithExternalId.add(wrap);
      } else {
        responseList.add(new ResponseWS(null, 'MISSING FIELDS', 400, 'No se especificó identificador externo (NombreDeDocumento__c)', null));
      }
    }

    List<SolicitudTerreno__c> existingSolicitudes = [SELECT NombreDeDocumento__c FROM SolicitudTerreno__c WHERE NombreDeDocumento__c IN :externalIds];

    List<SolicitudTerrenoWrapper> wrapperToInsert = new List<SolicitudTerrenoWrapper>();
    List<SolicitudTerreno__c> solicitudToUpdate = new List<SolicitudTerreno__c>();
    List<SolicitudTerreno__c> solicitudToUpdateAprobacion = new List<SolicitudTerreno__c>();
    

    for (SolicitudTerrenoWrapper wrap : solicitudesWithExternalId) {
      Boolean exist = false;
      for (SolicitudTerreno__c existing : existingSolicitudes) {
        if (existing.NombreDeDocumento__c == wrap.solicitudTerreno.NombreDeDocumento__c) {
          exist = true;
          if (wrap.solicitudTerreno.EstadodeSolicitud__c == null && wrap.solicitudTerreno.AprobadorIDExterno__c == null) {
            responseList.add(new ResponseWS(existing.Id, 'MISSING FIELDS', 400, 'No se especificó ningún campo compatible con actualización (EstadodeSolicitud__c, AprobadorIDExterno__c)', 'Actualización'));
          } else {
            SolicitudTerreno__c updatable = new SolicitudTerreno__c(Id = existing.Id, EstadodeSolicitud__c = wrap.solicitudTerreno.EstadodeSolicitud__c, 
            AprobadorIDExterno__c = wrap.solicitudTerreno.AprobadorIDExterno__c, Aprobacion_Externa__c = true);
            solicitudToUpdate.add(updatable);
            
            SolicitudTerreno__c updatableAprobacion = new SolicitudTerreno__c(Id = existing.Id, Aprobacion_Externa__c = true, StatusInternoAprobacion__c = null);
            solicitudToUpdateAprobacion.add(updatableAprobacion);
          }
          break;
        }
      }

      if (!exist) {
        if(wrap.solicitudTerreno.EstadodeSolicitud__c == 'Aprobado'  
        || wrap.solicitudTerreno.EstadodeSolicitud__c == 'Rechazado')
          responseList.add(new ResponseWS(wrap.solicitudTerreno.NombreDeDocumento__c, 'INVALID STATUS', 400, 'La solicitud no tiene una aprobación pendiente.', 'Creación'));
        else
          wrapperToInsert.add(wrap);
      }
    }
    
    Database.SaveResult[] updateResultSolicitudes = Database.Update(solicitudToUpdateAprobacion, false);

    responseList.addAll(processInsert(wrapperToInsert));

    responseList.addAll(processUpdate(solicitudToUpdate));

    // create logs
    for (ResponseWS resp : responseList) {
      Bitacora__c log = new Bitacora__c(CodigoDeError__c = String.valueOf(resp.codigo_de_error), Estado__c = resp.success,
                                        Fecha__c = Date.today(), id__c = resp.id, Mensaje__c = resp.mensaje, Operacion__c = resp.getAction(),
                                        Origen__c = 'Sharepoint', ServicioWeb__c = 'Servicio de Solicitudes de Terrenos en Salesforce',
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


  private static List<ResponseWS> processInsert(List<SolicitudTerrenoWrapper> wrapperToInsert) {

    List<ResponseWS> innerResponseList = new List<ResponseWS>();

    //PASO 2: Declarar mapa de objeto relacionado para acceder facilmente a sus registros.
    Map<String, List<Mezcla__c>> relatedObjectMap = new Map<String, List<Mezcla__c>>();
    Map<String, List<Factura__c>> relatedFacturaMap = new Map<String, List<Factura__c>>();
    List<SolicitudTerreno__c> terrenosToInsert = new List<SolicitudTerreno__c>();

    Map<String, Schema.RecordTypeInfo> solicitudRecordTypeInfo = SolicitudTerreno__c.SObjectType.getDescribe().getRecordTypeInfosByName();

   
    for (SolicitudTerrenoWrapper wrap : wrapperToInsert) {

       //PASO A: Agregar el tipo de registro nuevo como una nueva condición dentro del siguiente bloque:
      if(wrap.solicitudTerreno.Tipo__c == 'Adquisición'){
	  	  wrap.solicitudTerreno.RecordTypeId = solicitudRecordTypeInfo.get('Adquisiciones').getRecordTypeId();
      }else if(wrap.solicitudTerreno.Tipo__c == 'PagoParcial' || wrap.solicitudTerreno.Tipo__c == 'Pago Parcial' || wrap.solicitudTerreno.Tipo__c == 'Fideicomiso' || wrap.solicitudTerreno.Tipo__c == 'Anticipo' || wrap.solicitudTerreno.Tipo__c == 'Honorarios'){
	  	  wrap.solicitudTerreno.RecordTypeId = solicitudRecordTypeInfo.get('Pagos').getRecordTypeId();
      }else{
          wrap.solicitudTerreno.RecordTypeId = solicitudRecordTypeInfo.get('Anterior - Pagos').getRecordTypeId();
      }

      wrap.solicitudTerreno.Name = wrap.solicitudTerreno.NombreDeDocumento__c;
      terrenosToInsert.add(wrap.solicitudTerreno);

      //PASO 3: consolidar los registros relacionados en lista de cada tipo de objeto.
      List<Mezcla__c> mixes = new List<Mezcla__c>();
      List<Factura__c> facturas = new List<Factura__c>();

      if (wrap.mezclas != null) {
        for (Mezcla__c mix : wrap.mezclas) {
          mixes.add(mix);
        }
      }

      if (wrap.facturas != null){
        for(Factura__c fac : wrap.facturas){
          facturas.add(fac);
        }
      }

      //PASO 4: Agregar los registros relacionados al mapa correspondiente
      relatedObjectMap.put(wrap.solicitudTerreno.NombreDeDocumento__c, mixes);
      relatedFacturaMap.put(wrap.solicitudTerreno.NombreDeDocumento__c, facturas);

    }

    if (terrenosToInsert.size() > 0) {
    	Set<String> usersToLook = new Set<String>();

	    // look for appovers
	    for (SolicitudTerreno__c solicitud : terrenosToInsert) {
	      if (solicitud.AprobadorIDExterno__c != null) {
	        usersToLook.add(solicitud.AprobadorIDExterno__c);
	      }
	    }
	
	    List<SolicitudTerreno__c> validSolicitudes = new List<SolicitudTerreno__c>();
	
	    //List<User> approvers = [SELECT Alias FROM User WHERE Alias IN :usersToLook];
	    List<User> approvers = [SELECT CommunityNickName FROM User WHERE CommunityNickName IN :usersToLook];
	    
	
	    for (SolicitudTerreno__c solicitud : terrenosToInsert) {
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
	          innerResponseList.add(new ResponseWS(solicitud.NombreDeDocumento__c, 'BAD REFERENCE', 400, 'Se especificó un identificador externo de un aprobador que no existe: ' + solicitud.AprobadorIDExterno__c, 'Aprobación'));
	        }
	      } else {
	        validSolicitudes.add(solicitud);
	      }
	    }
    	
      // insert solicitud records
      Database.SaveResult[] insertResultSolicitudes = Database.Insert(validSolicitudes, false);

      //PASO 5: preparar listas de registros relacionados para insertar.
      List<Mezcla__c> mezclasToInsert = new List<Mezcla__c>();
      List<Factura__c> facturasToInsert = new List<Factura__c>();

      List<SolicitudTerreno__c> successTerrenos = new List<SolicitudTerreno__c>();

      // verify which succeeded and which failed
      for (Integer i = 0; i < validSolicitudes.size(); i++) {

        Database.SaveResult resultTerreno = insertResultSolicitudes[i];

        if (resultTerreno.isSuccess()) {

          successTerrenos.add(validSolicitudes[i]);

          //PASO 6: relacionar registros con solicitud de terreno
          List<Mezcla__c> innerMixes = relatedObjectMap.get(validSolicitudes[i].NombreDeDocumento__c);
          List<Factura__c> innerFacturas = relatedFacturaMap.get(validSolicitudes[i].NombreDeDocumento__c);

          for (Mezcla__c mix : innerMixes) {
            mix.Solicitud__c = resultTerreno.getId();
            mezclasToInsert.add(mix);
          }
          for (Factura__c fac : innerFacturas){
            fac.Solicitud_de_Terreno__c = resultTerreno.getId();
            facturasToInsert.add(fac);
          }

        } else {
          Database.Error err = resultTerreno.getErrors()[0];
          innerResponseList.add(new ResponseWS(validSolicitudes[i].NombreDeDocumento__c, 'DB ERROR', 500, 'Error insertando solicitud: ' + err.getMessage(), 'Creación'));
        }
      }

      Map<Id, List<ResponseWS>> failedSolicitudesByRelatedRecords = new Map<Id, List<ResponseWS>>();

      //PASO 7: intentar insertar registros relacionados
      if (mezclasToInsert.size() > 0) {
        Database.SaveResult[] insertResultMezclas = Database.Insert(mezclasToInsert, false);

        // verify which succeeded and which failed
        for (Integer i = 0; i < mezclasToInsert.size(); i++) {
          Database.SaveResult resultMezcla = insertResultMezclas[i];

          if (!resultMezcla.isSuccess()) {
            Database.Error err = resultMezcla.getErrors()[0];
            ResponseWS errResp = new ResponseWS(mezclasToInsert[i].Solicitud__c, 'DB ERROR', 500, 'Solicitud registrada, pero error insertando mezcla: ' + err.getMessage(), 'Creación');
            addRelatedRecordError(failedSolicitudesByRelatedRecords, ((Mezcla__c)mezclasToInsert[0]).Solicitud__c, errResp);
          }
        }
      }

      if (facturasToInsert.size() > 0) {
        Database.SaveResult[] insertResultFacturas = Database.Insert(facturasToInsert, false);

        // verify which succeeded and which failed
        for (Integer i = 0; i < facturasToInsert.size(); i++) {
          Database.SaveResult resultFactura = insertResultFacturas[i];

          if (!resultFactura.isSuccess()) {
            Database.Error err = resultFactura.getErrors()[0];
            ResponseWS errResp = new ResponseWS(facturasToInsert[i].Solicitud_de_Terreno__c, 'DB ERROR', 500, 'Solicitud registrada, pero error insertando factura: ' + err.getMessage(), 'Creación');
            addRelatedRecordError(failedSolicitudesByRelatedRecords, ((Factura__c)facturasToInsert[0]).Solicitud_de_Terreno__c, errResp);
          }
        }
      }

      // iterate over succesful solicitudes and verify existence in failedSolicitudesByMixes map
      for (SolicitudTerreno__c solicitud : successTerrenos) {
        if (failedSolicitudesByRelatedRecords.containsKey(solicitud.Id)) {
          innerResponseList.addAll(failedSolicitudesByRelatedRecords.get(solicitud.Id));
        } else {
          innerResponseList.add(new ResponseWS(solicitud.Id, 'Creación'));
        }
      }

    }

    return innerResponseList;
  }

  private static Map<Id, List<ResponseWS>> addRelatedRecordError(Map<Id, List<ResponseWS>> relatedErrors, Id solicitudId, ResponseWS error){
    if(relatedErrors.containsKey(solicitudId)){
      relatedErrors.get(solicitudId).add(error);
    }else{
      relatedErrors.put(solicitudId, new List<ResponseWS>{ error });
    }
    return relatedErrors;
  }
  private static List<ResponseWS> processUpdate(List<SolicitudTerreno__c> solicitudesToUpdate) {

    List<ResponseWS> innerResponseList = new List<ResponseWS>();

    Set<String> usersToLook = new Set<String>();

    // look for appovers
    for (SolicitudTerreno__c solicitud : solicitudesToUpdate) {
      if (solicitud.AprobadorIDExterno__c != null) {
        usersToLook.add(solicitud.AprobadorIDExterno__c);
      }
    }

    List<SolicitudTerreno__c> validSolicitudes = new List<SolicitudTerreno__c>();

    //List<User> approvers = [SELECT Alias FROM User WHERE Alias IN :usersToLook];
    List<User> approvers = [SELECT CommunityNickName FROM User WHERE CommunityNickName IN :usersToLook];

    for (SolicitudTerreno__c solicitud : solicitudesToUpdate) {
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
          innerResponseList.add(new ResponseWS(solicitud.Id, 'BAD REFERENCE', 400, 'Se especificó un identificador externo de un aprobador que no existe: ' + solicitud.AprobadorIDExterno__c, 'Aprobación'));
        }
      } else {
        validSolicitudes.add(solicitud);
      }
    }

    if (validSolicitudes.size() > 0) {
      Map<Id,ResponseWS> errorResponses = manageApprovalProcesses(validSolicitudes);
      if(!errorResponses.isEmpty()){
        innerResponseList.addAll(errorResponses.values());
        for(Integer i = 0; i < validSolicitudes.size(); i++){
          if(errorResponses.containsKey(validSolicitudes[i].Id))
            validSolicitudes.remove(i);
        }
      }
      Database.SaveResult[] updateResultSolicitudes = Database.Update(validSolicitudes, false);

      // verify which succeeded and which failed
      List<SolicitudTerreno__c> succeeded = new List<SolicitudTerreno__c>();

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


  private static Map<Id,ResponseWS> manageApprovalProcesses(List<SolicitudTerreno__c> solicitudes) {

    Set<Id> resultIds = (new Map<Id,SolicitudTerreno__c>(solicitudes)).keySet();
    Map<Id,ResponseWS> errorResponses = new Map<Id,ResponseWS>(); 
    List<ProcessInstanceWorkitem> pendingApprovalProcesses = [SELECT ProcessInstance.TargetObjectId  FROM ProcessInstanceWorkItem WHERE ProcessInstance.TargetObjectId = :resultIds];

    List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest> ();

    for (SolicitudTerreno__c solicitud : solicitudes) {
      boolean tuvoAprobacionesPendientes = false;
      for (ProcessInstanceWorkitem process : pendingApprovalProcesses) {
        if (process.ProcessInstance.TargetObjectId == solicitud.Id) {
          tuvoAprobacionesPendientes = true;
          if (solicitud.EstadodeSolicitud__c == 'Rechazado') {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Rechazado por servicio web');
            req.setAction('Reject');
            req.setWorkitemId(process.Id);
            requests.add(req);
          } else if (solicitud.EstadodeSolicitud__c == 'Aprobado') {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Aprobado por servicio web');
            req.setAction('Approve');
            req.setWorkitemId(process.Id);
            requests.add(req);
          }
        }
      }
      if(!tuvoAprobacionesPendientes && (solicitud.EstadodeSolicitud__c == 'Aprobado'
        || solicitud.EstadodeSolicitud__c == 'Rechazado'))
        errorResponses.put(solicitud.Id, new ResponseWS(solicitud.Id, 'INVALID STATUS', 400, 'La solicitud no tiene una aprobación pendiente.', 'Actualización'));
    }

    if (requests.size() > 0) {
      Approval.ProcessResult[] processResults =  Approval.process(requests, false);

      for (Integer i = 0; i < requests.size(); i++) {
        if (!processResults[i].isSuccess()) {
          errorResponses.put(processResults[i].getEntityId(), new ResponseWS(processResults[i].getEntityId(), 'APPROVAL FAIL', 400, 'El proceso de aprobación generó un error: ' + processResults[i].getErrors()[0].getMessage(), 'Actualización'));
          System.debug(System.LoggingLevel.ERROR, 'Error approving/rejecting approval process: ' + processResults[i].getErrors()[0].getMessage());
        }
      }
    }
    return errorResponses;
  }
}