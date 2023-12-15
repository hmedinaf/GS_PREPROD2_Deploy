public class WSCallEnviaCotizacion {
    // Replace these with your own values
    // private static final String CLIENT_ID = '3MVG9lJB4lV8F4SjfGf0sZm0U_CjpIKzJt6ipUHomkiiWpagxoa2fTitmUOUuf5vs7d5bA8xyGks_z8EUlfKf';
    // private static final String CLIENT_SECRET = 'ACF6A6502AB3FF7D9B8B94DBC4C1DB77E75FDB97E8BE47AB4CDEC272BC1D19C3';
    // private static final String USERNAME = 'wolke@javer.portal';
    // private static final String PASSWORD = 'Javer2022!123';


    public class InputVariables {
        @InvocableVariable
        public String AccountId;
    }

    @InvocableMethod(label='Llamar Servicio Envia Cotizacion' description='Llamar Servicio Envia Cotizacion')
    public static void WSCallEnviaCotizacion(List <InputVariables> InputVariables) {
        string accessToken;
        /*

        accessToken = getAuthToken();

        String accId = InputVariables[0].AccountId;

        // Define the endpoint of the REST API to call
        //String endpoint = 'https://your-salesforce-instance.com/services/apexrest/your-resource';
        String endpoint = 'https://javer--partial.sandbox.my.salesforce.com/services/apexrest/WSCreaEnviaCotizacion';
        
        // Create an HttpRequest object to send the REST API request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('PUT');
        
        // Set any necessary request headers
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setHeader('Authorization', 'Bearer ' + accessToken); //UserInfo.getSessionId());

        // Map<String, Object> params = new Map<String, String>{
        //     'RecordId' => '001D100000lrrtfIAA'
        // };
        // String requestBody = JSON.serialize(params);
        // String accId = '001D100000lrrtfIAA';
        
        // String parameter = '{"RecordId": "001D100000lrrtfIAA"}';
        String requestBody = '{"accId": "' + accId + '"}';
        req.setBody(requestBody);
        
        // Send the REST API request and capture the response
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        // Handle the response as necessary
        if (res.getStatusCode() == 200) {
            // Success! Do something with the response body.
            String responseBody = res.getBody();
            System.debug('Response body: '+responseBody);
        } else {
            // Handle any errors that occurred
            String errorMessage = 'Error making REST API call: ' + res.getStatus();
            System.debug(errorMessage);
        }
        */
    }

    
    // public static String getAuthToken() {
    //     return (null);
        /*
        //step 1 : get the access token
        String accessToken;

        Http httpCls = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://test.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        // request.setTimeout(2 * 60 * 1000);  

        request.setHeader('Content-Type','application/x-www-form-urlencoded');        
        request.setBody('grant_type=password' + 
                    '&client_id=' + CLIENT_ID + 
                    '&client_secret=' + CLIENT_SECRET + 
                    '&username=' + USERNAME + 
                    '&password=' + PASSWORD);        

        //sending the json to the request body
        httpResponse response = httpCls.send(request); 
        system.debug('## response:' + response);

        if(response.getStatusCode() == 200){            
            system.debug('## Successfully retrieving access token' ); 

            map<string,Object> resultMap = (map<string,Object>)JSON.deserializeUntyped(response.getBody());

            accesstoken = (String)resultMap.get('access_token');
            system.debug('## accessToken: '+accessToken);
            // instanceURL = (String)resultMap.get('instance_url');            

            //step 2 : use the token for the salesforce api call
            return accessToken;
        }
        else{
            system.debug('## Could not retrieve the access token' ); 
            system.debug('## response status :' + response.getStatus()); 
            system.debug('## response message :' + response.getBody()); 
            return (null);
        }
        */
    //}
}