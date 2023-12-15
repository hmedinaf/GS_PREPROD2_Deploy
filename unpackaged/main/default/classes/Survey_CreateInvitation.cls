public class Survey_CreateInvitation {
    public Inventario__c inventario {get;set;}
    
    public Survey_CreateInvitation(String idInv){
        inventario = new Inventario__c();
        inventario.Id = idInv;
    }
    
    @future(callout = true)
    public static void run(String idInv){
        System.debug('Survey_CreateInvitation');
        Map<String, Object> params = new Map<String, Object>();
        params.put('PATCId', idInv);
        Flow.Interview.PATCSurveyFlow SurveyFlow = new Flow.Interview.PATCSurveyFlow(params);
        SurveyFlow.start();
    }
}