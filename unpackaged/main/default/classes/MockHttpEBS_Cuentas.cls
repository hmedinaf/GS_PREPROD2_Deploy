@isTest
global class MockHttpEBS_Cuentas implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"MensajeApi":"testApi","RespuestaApi":"testApi","IdClienteAr":123,"IdProcesoAr":43}');
        res.setStatusCode(200);
        return res;
    }
}