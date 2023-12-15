@RestResource(urlMapping='/TalkdeskSurveyWS/*')
global with sharing class TalkdeskSurveyWS {

    /*@HttpPut
    global static String updateTDSurveyTest(String talkdeskId, String csat_clientes_pregunta, String lead_csat_1, String lead_csat_2) {
        talkdesk__Talkdesk_Activity__c tda = [SELECT Id, talkdesk__Talkdesk_Id__c FROM talkdesk__Talkdesk_Activity__c 
                                                WHERE talkdesk__Talkdesk_Id__c =: talkdeskId];
        if(tda != null){
            if(!String.isBlank(csat_clientes_pregunta)){
                tda.ATC_Survey_Response_1__c = csat_clientes_pregunta == '1' ? 'Si' : 'No';
            }else if(!String.isBlank(lead_csat_1) && !String.isBlank(lead_csat_2)){
                tda.Sales_Survey_Response_1__c = lead_csat_1 == '1' ? 'Si' : 'No';
                tda.Sales_Survey_Response_2__c = lead_csat_2 == '1' ? 'Si' : 'No';
            }
        }
        update tda;
        return 'The following activity has been updated: ' + tda.Id;
    }*/
    
    @HttpPatch
    global static String updateTDSurvey() {
        RestRequest request = RestContext.request;
        String talkdeskId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        talkdesk__Talkdesk_Activity__c tda = [SELECT Id, talkdesk__Talkdesk_Id__c, talkdesk__Call_Id__c FROM talkdesk__Talkdesk_Activity__c 
                                                WHERE talkdesk__Call_Id__c =: talkdeskId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            tda.put(fieldName, params.get(fieldName));
        }
        update tda;
        return 'The following activity has been updated: ' + tda.Id;
    }    

}