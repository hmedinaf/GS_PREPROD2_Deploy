trigger trg_Aprobacion_SolicitudTerreno on SolicitudTerreno__c (after update) {
    SolicitudTerreno__c[] Solicitudes = Trigger.new;
    
    for(SolicitudTerreno__c SolicitudNew : Solicitudes )
    {
        SolicitudTerreno__c SolicitudOld = Trigger.oldmap.get(SolicitudNew .Id);
        if(SolicitudNew.StatusInternoAprobacion__c != SolicitudOld.StatusInternoAprobacion__c &&
          (SolicitudNew.StatusInternoAprobacion__c == 'Aprobado' || SolicitudNew.StatusInternoAprobacion__c == 'Rechazado')
          && SolicitudNew.Aprobacion_Externa__c == false
          )
        {
            //llamar clase que ejecutara el web services
            String ApprovalType, ApprovalId, SourceSystem, Status, Approver, FlowCheckpoint,UEN;
            ApprovalType = 'TERRENO';
            ApprovalId = SolicitudNew.NombreDeDocumento__c;
            SourceSystem = '5';
            Status = SolicitudNew.StatusInternoAprobacion__c == 'Aprobado' ? '1' : '0';
            FlowCheckpoint = SolicitudNew.EstadodeSolicitud__c == null ? SolicitudNew.StatusInternoAprobacion__c : SolicitudNew.EstadodeSolicitud__c;
            
            AprobacionTerrenosWS.ActualizaTerrenos(ApprovalType, ApprovalId, SourceSystem, Status, FlowCheckpoint, SolicitudNew.Id);
        }
        else if (SolicitudNew.Aprobacion_Externa__c)
        {
        	AprobacionTerrenosWS.ActualizaRegistro(SolicitudNew.Id);
        }
    }
}