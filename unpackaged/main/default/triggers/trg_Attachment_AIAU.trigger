trigger trg_Attachment_AIAU on Attachment (after insert, after update) {
    List<Id> list_idParentXMLSiebel = new List<Id>();
    List<Id> list_idParentXMLSharePoint = new List<Id>();
    try {
        
                //revisa cada attachment
                for(Attachment attachment : trigger.new){
                    //comprobacion de tipo de objeto          
                    system.debug('*** attachment*** ' + attachment);
                    String objectAPIName = attachment.ParentId.getSObjectType().getDescribe().getName();
                    system.debug('----------------------------------- objeto = ' + objectAPIName);
                    if (objectAPIName == 'XML_Siebel__c'){
                        list_idParentXMLSiebel.add(attachment.ParentId);
                    } else if (objectAPIName == 'XML_SharePoint__c'){
                        list_idParentXMLSharePoint.add(attachment.ParentId);
                    }
                }
                
                if (!list_idParentXMLSiebel.IsEmpty()){
                    for(Id idXMLSiebel : list_idParentXMLSiebel){
                        Javer_Util.buscarYProcesarArchivo(idXMLSiebel);
                    }
                } else if (!list_idParentXMLSharePoint.IsEmpty()){
                    for(Id idXMLSharepoint : list_idParentXMLSharePoint){
                        Javer_ShPn_Util.buscarYProcesarArchivoSP(idXMLSharepoint);
                    }
                }
    
    
    } catch (Exception error) {for (Attachment e : (Trigger.isBefore && Trigger.isDelete)?Trigger.old:Trigger.new) {e.addError('Please contact support and mention the exception trg_Attachment_AIAU : '+error.getMessage());}}
}