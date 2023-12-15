/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Handler de ContentDocumentLinkTrigger
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      21/02/2021
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class ContentDocumentLinkHandler extends TriggerHandler {
    
    private Map<Id, ContentDocumentLink> newMap;
    private Map<Id, ContentDocumentLink> oldMap;
    private List<ContentDocumentLink> newList;
    private List<ContentDocumentLink> oldList;
    
    public ContentDocumentLinkHandler() {
        this.newMap = (Map<Id, ContentDocumentLink>) trigger.newMap;
        this.oldMap = (Map<Id, ContentDocumentLink>) trigger.oldMap;
        this.newList = (List<ContentDocumentLink>) trigger.new;
        this.oldList = (List<ContentDocumentLink>) trigger.old;
    }

    public override void beforeDelete() {
        validarPerfil();
    }

    public void validarPerfil(){
        List<GroupMember> members = [SELECT UserOrGroupId, Group.Name FROM GroupMember WHERE Group.Name = 'Jefes de Entrega' AND UserOrGroupId =: UserInfo.getUserId()];
        if(members.isEmpty()){
            for(ContentDocumentLink oldLink : oldList){
                oldLink.addError('No tiene sufientes permisos para elimnar este documento');
            }
        }
    }
}