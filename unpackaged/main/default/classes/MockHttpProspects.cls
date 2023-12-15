@isTest
global class MockHttpProspects implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"messaging_product":"whatsapp","contacts":[{"input":"918696659400","wa_id":"918696659400"}],"messages":[{"id":"wamid.HBgMOTE4Njk2NjU5NDAwFQIAERgSRjFBODA2NDRBRjYyODdGMkU3AA=="}]}');
        res.setStatusCode(200);
        return res;
    }
}