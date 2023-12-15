/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Handler de ContentDocumentTrigger
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      21/02/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class ContentDocumentTriggerHandler extends TriggerHandler {
    
    private Map<Id, ContentDocument> newMap;
    private Map<Id, ContentDocument> oldMap;
    private List<ContentDocument> newList;
    private List<ContentDocument> oldList;
    
    public ContentDocumentTriggerHandler() {
        this.newMap = (Map<Id, ContentDocument>) trigger.newMap;
        this.oldMap = (Map<Id, ContentDocument>) trigger.oldMap;
        this.newList = (List<ContentDocument>) trigger.new;
        this.oldList = (List<ContentDocument>) trigger.old;
    }
    
    public override void afterUpdate() {
        createLink();
    }

    public override void beforeDelete() {
        validarPerfil();
    }

    public void createLink(){
        try{
           List< ContentWorkspace > contentWorkspace = [SELECT Id, RootContentFolderId FROM ContentWorkspace WHERE Name = 'All Files'];
            List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
            List<ContentVersion> contentVersions = [SELECT Id, ContentDocumentId, VersionData FROM ContentVersion WHERE ContentDocumentId IN: newList];
            for(ContentVersion cv : contentVersions){
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.ContentDocumentId = cv.ContentDocumentId;
                cdl.ShareType = 'I';
                cdl.Visibility = 'AllUsers';
                cdl.LinkedEntityId = contentWorkspace[0].Id; 
                contentDocumentLinks.add(cdl);
            }

            if(!contentDocumentLinks.isEmpty()){
                insert contentDocumentLinks;
            }
        }catch(Exception e){
            System.debug(e);
        }
    }

    public void validarPerfil(){
        List<GroupMember> members = [SELECT UserOrGroupId, Group.Name FROM GroupMember WHERE Group.Name = 'Jefes de Entrega' AND UserOrGroupId =: UserInfo.getUserId()];
        if(members.isEmpty()){
            for(ContentDocument oldDoc : oldList){
                oldDoc.addError('No tiene sufientes permisos para elimnar este documento');
            }
        }
    }
}