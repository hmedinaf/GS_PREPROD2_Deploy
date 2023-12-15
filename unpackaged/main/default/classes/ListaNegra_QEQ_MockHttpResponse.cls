@isTest
global class ListaNegra_QEQ_MockHttpResponse implements HttpCalloutMock {
    	global HTTPResponse respond(HTTPRequest req) {    
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"@Success": true, "ListaNegraQEQSalesforceRs": {"PagoSfCRMtoERPResponse": {"persona": [{"apellido_paterno": "Doe", "apellido_materno": "Doe", "fecha_nacimiento": "2000-01-01", "sexo": "M", "nombre": "John", "curp": "XYZ456", "rfc": "ABC123"}], "registros_encontrados": "1"}}}');
        response.setStatusCode(200);
        return response;
    }
}