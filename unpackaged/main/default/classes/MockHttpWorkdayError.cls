@isTest
global class MockHttpWorkdayError implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"ESB_Id":"what@sapp","ResponseDate":"","response":{"Messages":[{"Message":[{"Key":"234","MessagesValue":"fghjk"}]}],"Success":true,"Output":[{"Row":[{"Name":"Account Name","Value":"value"}, {"Name":"Account Code","Value":"Value"}, {"Name":"Level Name","Value":"66278"}, {"Name":"Name","Value":"23"}, {"Name":"Prototipo","Value":"4567"}]}]},"Success":true}');
        res.setStatusCode(200);
        return res;
    }
}