public class WS_ManageViviendas {
    public static void ExtractViviendas() {
        String username = '';
        String password = '';
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        
        String body = '{'+
            '"Dias" : 120,'+
            '"Estatus" : [ 17,11 ],'+
            '"IdVivienda" : "353341"'+
            '}';
        
        HttpRequest http_request = new HttpRequest();
        http_request.setEndpoint('https://qesb.javer.com.mx:11962/services/ManageViviendas/rest/ExtractViviendas');
        http_request.setMethod('POST');
        http_request.setHeader('Content-Type', 'application/json');
        http_request.setHeader('Authorization', 'Inherit auth from parent');
        http_request.setBody(body);
        Http http = new Http();
        HTTPResponse http_response = http.send(http_request);
        if(http_response.getStatusCode() == 200) {
            system.debug(http_response.getBody());
        }
        else {
            system.debug(http_response.getStatus() + ' ' + http_response.getStatusCode());
        }
    }
}