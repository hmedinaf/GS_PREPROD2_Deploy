/******* Author : Ajay Choudhary (ajay@wakencode.com, Wakencode Technologies)*********
 ******* Last Updated Date : 17th August 2023 ****************************************
 ******* Info : Controller Class used in LWCMassApproval component *******************

 ******* Update 1 : Added queue ids of current user in the query to fetch all approval request assigned to
 ********current user and queue he/she is memeber of - getAllProcessItems method - 14th Sept 2023 - (Ajay Choudhary)  ***********

 ******* Update 2 : Added ProcessWorkItems to the query to fetch only related approval requests for a user - getAllProcessItems
 ******* 15th Sept 2023 - (Ajay Choudhary)
 *************************************************************************************/

public class MassApproval {
    @AuraEnabled
    public static List<Mass_Approval_Config__mdt> getObjectConfigs(){
        List<Mass_Approval_Config__mdt> allObjectConfigs = new List<Mass_Approval_Config__mdt>();
        allObjectConfigs = [SELECT MasterLabel, Approval_Process_Name__c, Display_Chatter__c, Display_Comments__c, Display_View__c, Object_Api_Name__c FROM Mass_Approval_Config__mdt];
        return allObjectConfigs;
    }

    @AuraEnabled
    public static List<ApprovalRequestData> getAllProcessItems(String objectName, Mass_Approval_Config__mdt config, String status){
        Set<Id> allProcessesId = new Set<Id>();
        List<ApprovalRequestData> allApprovalRequest = new List<ApprovalRequestData>();
        String pdQuery = 'SELECT Id FROM ProcessDefinition WHERE Type = \'Approval\' AND TableEnumOrId =:objectName AND State = \'Active\'';
        if(String.isNotBlank(config.Approval_Process_Name__c)){
            pdQuery += ' AND DeveloperName =:config.Approval_Process_Name__c';
        }
        for(ProcessDefinition pd : Database.query(pdQuery)){
            allProcessesId.add(pd.Id);
        }
        String currentUserId = UserInfo.getUserId();
        Set<Id> allActorIds = New Set<Id>();
        allActorIds.add(currentUserId);
        for(GroupMember member : [SELECT Group.Name, GroupId FROM GroupMember WHERE Group.Type = 'Queue' AND UserOrGroupId =:currentUserId]){
            allActorIds.add(member.GroupId);
        }
        Set<Id> processInstanceIds = new Set<Id>();
        String piQuery = 'SELECT Id, CreatedBy.Name, CreatedDate, TargetObjectId, TargetObject.Name, LastActor.Name, LastActor.Id, (SELECT ProcessInstance.TargetObjectId, Actor.Name, Actor.Id FROM Workitems';
        if(Test.isRunningTest()){
            
			piQuery += '), (SELECT Id, Actor.Name, Actor.Id, StepStatus, Comments FROM Steps) FROM ProcessInstance WHERE ProcessDefinitionId IN:allProcessesId And Status = \'Pending\' ORDER BY CreatedDate DESC';
        }
        else{
            if(status == 'All'){
                piQuery += ' WHERE ActorId IN:allActorIds), (SELECT Id, Actor.Name, Actor.Id, StepStatus, Comments FROM Steps WHERE ActorId IN:allActorIds ORDER BY CreatedDate DESC) FROM ProcessInstance WHERE ProcessDefinitionId IN:allProcessesId ORDER BY CreatedDate DESC';
            }
            else{
                piQuery += ' WHERE ActorId IN:allActorIds), (SELECT Id, Actor.Name, Actor.Id, StepStatus, Comments FROM Steps WHERE ActorId IN:allActorIds ORDER BY CreatedDate DESC) FROM ProcessInstance WHERE ProcessDefinitionId IN:allProcessesId And Status =: status ORDER BY CreatedDate DESC';
            }
            
        }
        for(ProcessInstance pi : Database.query(piQuery)){
            if(status == 'Pending' || status == 'All'){
                if(pi.Workitems.size() > 0){
                    ApprovalRequestData request = new ApprovalRequestData();
                    request.createdDate = Date.valueOf(pi.CreatedDate);
                    request.actorName = pi.Workitems[0].Actor.Name;
                    request.actorId = pi.Workitems[0].Actor.Id;
                    request.createdByName = pi.CreatedBy.Name;
                    request.comments = pi.steps.size() > 0 ? pi.steps[0].Comments : '';
                    request.processInstanceId = pi.Id;
                    request.recordId = pi.TargetObjectId;
                    request.recordName = pi.TargetObject.Name;
                    allApprovalRequest.add(request);
                }
            }
            else{
                if(allActorIds.contains(pi.LastActor.Id)){
                    ApprovalRequestData request = new ApprovalRequestData();
                    request.createdDate = Date.valueOf(pi.CreatedDate);
                    request.actorName = pi.LastActor.Name;
                    request.actorId = pi.LastActor.Id;
                    request.createdByName = pi.CreatedBy.Name;
                    request.comments = pi.steps.size() > 0 ? pi.steps[0].Comments : '';
                    request.processInstanceId = pi.Id;
                    request.recordId = pi.TargetObjectId;
                    request.recordName = pi.TargetObject.Name;
                    allApprovalRequest.add(request);
                }
            }
        }
        return allApprovalRequest;
    }

    @AuraEnabled
    public static List<ProcessInstanceStep> getAllProcessSteps(String processInstanceId){
        return [SELECT Id, Actor.Name, Actor.Id, StepStatus, Comments, CreatedDate FROM ProcessInstanceStep WHERE ProcessInstanceId =:processInstanceId ORDER BY CreatedDate DESC];
    }
    @AuraEnabled
    public static void approveRejectRecords(String data, String action){
        List<ApprovalRequestData> selectedApprovalData = (List<ApprovalRequestData>)JSON.deserialize(data, List<ApprovalRequestData>.class);
        Set<String> processInstanceIds = new Set<String>();
        List<Approval.ProcessWorkitemRequest> requestsToApprove = new List<Approval.ProcessWorkitemRequest>();
        for (ApprovalRequestData ap :selectedApprovalData) {
            processInstanceIds.add(ap.processInstanceId);
        }
        for(ProcessInstanceWorkitem item : [SELECT Id, ProcessInstanceId  FROM ProcessInstanceWorkitem WHERE ProcessInstanceId IN:processInstanceIds]){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(item.Id);
            if(action == 'Approve'){
                req.setAction('Approve');
            }
            else{
                req.setAction('Reject');
            }
            
            requestsToApprove.add(req);
        }
         Approval.ProcessResult[] processResults = Approval.process(requestsToApprove);


    }

    @AuraEnabled
    public static void reAssignProcessItems(String data){
        List<ApprovalRequestData> selectedApprovalData = (List<ApprovalRequestData>)JSON.deserialize(data, List<ApprovalRequestData>.class);
        Set<String> processInstanceIds = new Set<String>();
        for (ApprovalRequestData ap :selectedApprovalData) {
            processInstanceIds.add(ap.processInstanceId);
        }
        List<ProcessInstanceWorkitem> workItemsToUpdate = new List<ProcessInstanceWorkitem>();
        for(ProcessInstanceWorkitem item : [SELECT Id, ProcessInstanceId  FROM ProcessInstanceWorkitem WHERE ProcessInstanceId IN:processInstanceIds]){
            item.ActorId = selectedApprovalData[0].actorId;
            workItemsToUpdate.add(item);
        }
        if(workItemsToUpdate.size() > 0){
            update workItemsToUpdate;
        }
    }

    public class ApprovalRequestData{
        @AuraEnabled public Date createdDate;
        @AuraEnabled public String actorName;
        @AuraEnabled public String actorId;
        @AuraEnabled public String createdByName;
        @AuraEnabled public String comments;
        @AuraEnabled public String processInstanceId;
        @AuraEnabled public String recordId;
        @AuraEnabled public String recordName;
    }

}