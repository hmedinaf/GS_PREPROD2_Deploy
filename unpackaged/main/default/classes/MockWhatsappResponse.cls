@isTest
global class MockWhatsappResponse implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse response = new HttpResponse();
        response.setBody('{"url":"https://lookaside.fbsbx.com/whatsapp_business/attachments/?mid=570778648419546&ext=1676451810&hash=ATsUh1EWxWE4ThB_2uMptRbHK5BQsSEs4uNNV4Gk0eeqEw","mime_type":"application/pdf","sha256":"cfc2705f2d01409f2ec079b3f8fe38a68b9cc581b383c43ebc2b5556c75c825e","file_size":90515,"id":"570778648419546","messaging_product":"whatsapp"}');
        response.setStatusCode(200);
        return response;
    }
}