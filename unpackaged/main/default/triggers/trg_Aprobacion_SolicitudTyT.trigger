trigger trg_Aprobacion_SolicitudTyT on SolicitudesTramitesYTransferencias__c (after update) {
 SolicitudesTramitesYTransferencias__c[] Solicitudes = Trigger.new;
    
    for(SolicitudesTramitesYTransferencias__c SolicitudNew : Solicitudes )
    {
    	SolicitudesTramitesYTransferencias__c SolicitudOld = Trigger.oldmap.get(SolicitudNew .Id);
    	 
    	System.Debug('SolicitudNew.StatusInternoAprobacion__c: ' + SolicitudNew.StatusInternoAprobacion__c);
    	System.Debug('SolicitudOld.StatusInternoAprobacion__c: ' + SolicitudOld.StatusInternoAprobacion__c);
    	System.Debug('SolicitudNew.Aprobacion_Externa__c: ' + SolicitudNew.Aprobacion_Externa__c);
    	System.Debug('SolicitudOld.AprobadorIDExterno__c: ' + SolicitudOld.AprobadorIDExterno__c + ' SolicitudNew.AprobadorIDExterno__c: ' + SolicitudNew.AprobadorIDExterno__c );
       
        if(SolicitudNew.StatusInternoAprobacion__c != SolicitudOld.StatusInternoAprobacion__c &&
          (SolicitudNew.StatusInternoAprobacion__c == 'Aprobado' || SolicitudNew.StatusInternoAprobacion__c == 'Rechazado')
          && SolicitudNew.Aprobacion_Externa__c == false)
        {
            //llamar clase que ejecutara el web services
            String ApprovalType, ApprovalId, SourceSystem, Status, Approver, FlowCheckpoint, UEN;
            
            ApprovalType = SolicitudNew.RecordTypeId;//.DeveloperName;
            ApprovalId = SolicitudNew.Name;
            SourceSystem = '7';
            Status = SolicitudNew.StatusInternoAprobacion__c == 'Aprobado' ? '1' : '0';
            Approver = SolicitudNew.AprobadorIDExterno__c;
            FlowCheckpoint = SolicitudNew.EstadodeSolicitud__c == null ? SolicitudNew.StatusInternoAprobacion__c : SolicitudNew.EstadodeSolicitud__c;
            UEN = String.valueOf(SolicitudNew.UEN_Id__c);
            
            AprobacionTramitesTransferenciasWS.ActualizaTramitesTransferencias(ApprovalType, ApprovalId, SourceSystem, Status, Approver, FlowCheckpoint, UEN, SolicitudNew.Id, 'TransactionID');            
        }
        
        else if (SolicitudNew.Aprobacion_Externa__c)
        {
        	AprobacionTramitesTransferenciasWS.ActualizaRegistro(SolicitudNew.Id);
        }
        
        
    }
}