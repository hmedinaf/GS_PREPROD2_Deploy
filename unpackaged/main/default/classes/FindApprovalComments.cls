public with sharing class FindApprovalComments {
	public string objId { get; set; }
	public string StepStatusMessage { get; set; }
    public List<ProcessInstanceStep> approvalComments{
        get{
            return new List<ProcessInstanceStep>([Select p.Comments, p.ProcessInstance.TargetObjectId, p.Actor.Name from ProcessInstanceStep p  WHERE p.ProcessInstance.TargetObjectID = :objId AND StepStatus =:StepStatusMessage ]);          
        }
        private set;
    }
}