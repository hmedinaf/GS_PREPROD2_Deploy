@isTest
public class WhatsappIntegrationController_test {
    @testSetup
    static void setup() {
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+525530303030'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
    }
    @isTest static  void testGetCallout() {
        Account acc = [Select Id , FirstName from Account where FirstName = 'Lopez' ];  
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.addHeader('httpMethod', 'POST');
        req.requestUri = '/services/apexrest/whatsappnotification/'; 
        // String pd = '{"object":"whatsapp_business_account","entry":[{"id":"113236441562722","changes":[{"value":{"messaging_product":"whatsapp","metadata":{"display_phone_number":"15550748223","phone_number_id":"101413582762776"},"contacts":[{"profile":{"name":"Ajay Choudhary"},"wa_id":"918696659400"}],"messages":[{"from":"918696659400","id":"wamid.HBgMOTE4Njk2NjU5NDAwFQIAEhgSOTM5MkUxOUQ4MEU4REI5REE5AA==","timestamp":"1679469539","type":"document","document":{"caption":"Testing Image","filename":"Screenshot_20221125_122341.png","mime_type":"image\/png","sha256":"wr0YMgDBuon+V5yiQZwBi1\/yX9fDZ4wsW2TbLtZmPEw=","id":"3128484443964773"}}]},"field":"messages"}]}]}';
        String postData = '{"object":"whatsapp_business_account","entry":[{"id":"113236441562722","changes":[{"value":{"messaging_product":"whatsapp","metadata":{"display_phone_number":"15550748223","phone_number_id":"101413582762776"},"contacts":[{"profile":{"name":"test"},"wa_id":"+525530303030"}],"statuses":[{"id":"wamid.HBgNNTIxNTUyNzM3MTc2MhUCABEYEjcxNEVGNkNCRjQ4OTZGOUFDMAA=","status":"delivered","timestamp":"1676616917","recipient_id":"5215527371762","conversation":{"id":"e925329ad15bf5028f430883d2d8d12b","origin":{"type":"business_initiated"}},"pricing":{"billable":true,"pricing_model":"CBP","category":"business_initiated"}}]},"field":"messages"}]}]}';
        req.requestBody = Blob.valueof(postData);
        RestContext.request = req; 
        RestContext.response= res;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockWhatsappResponse());
        WhatsappIntegrationController.handelWebhook();
        WhatsappIntegrationController.handelGetWebhook();
        WhatsappIntegrationController.getMedia('testUrl');
        WhatsappIntegrationController.getMediaUrl('test','test');
        WhatsappIntegrationController.saveTheFile(Blob.Valueof('test'),'test','media test',acc.id);
        Test.StopTest();
    }
    @isTest static  void testGetCallout1() {
        Account acc = [Select Id , FirstName from Account where FirstName = 'Lopez' ];  
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.addHeader('httpMethod', 'POST');
        req.requestUri = '/services/apexrest/whatsappnotification/';
        String pd = '{"object":"whatsapp_business_account","entry":[{"id":"113236441562722","changes":[{"value":{"messaging_product":"whatsapp","metadata":{"display_phone_number":"15550748223","phone_number_id":"101413582762776"},"contacts":[{"profile":{"name":"Ajay Choudhary"},"wa_id":"+525530303030"}],"messages":[{"from":"525530303030","id":"wamid.HBgMOTE4Njk2NjU5NDAwFQIAEhgSOTM5MkUxOUQ4MEU4REI5REE5AA==","timestamp":"1679469539","type":"document","document":{"caption":"Testing Image","filename":"Screenshot_20221125_122341.png","mime_type":"image","sha256":"wr0YMgDBuon+V5yiQZwBi1yX9fDZ4wsW2TbLtZmPEw=","id":"3128484443964773"}}]},"field":"messages"}]}]}';
        req.requestBody = Blob.valueof(pd);
        RestContext.request = req; 
        RestContext.response= res;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockWhatsappResponse());
        WhatsappIntegrationController.handelWebhook();
        WhatsappIntegrationController.handelGetWebhook();
        Test.stopTest();
    }
    @isTest static  void testGetCallout2() {
        Account acc = [Select Id , FirstName from Account where FirstName = 'Lopez' ];  
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.addHeader('httpMethod', 'POST');
        req.requestUri = '/services/apexrest/whatsappnotification/';
        String pd = '{"object":"whatsapp_business_account","entry":[{"id":"113236441562722","changes":[{"value":{"messaging_product":"whatsapp","metadata":{"display_phone_number":"15550748223","phone_number_id":"101413582762776"},"contacts":[{"profile":{"name":"Ajay Choudhary"},"wa_id":"+525530303030"}],"messages":[{"from":"525530303030","id":"wamid.HBgMOTE4Njk2NjU5NDAwFQIAEhgSMTNBOTVGMDVBRThGRDgwQkFDAA==","timestamp":"1679469508","text":{"body":"Hi, This is test message"},"type":"text"}]},"field":"messages"}]}]}';
        req.requestBody = Blob.valueof(pd);
        RestContext.request = req; 
        RestContext.response= res;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockWhatsappResponse());
        WhatsappIntegrationController.handelWebhook();
        WhatsappIntegrationController.handelGetWebhook();
        Test.stopTest();
    }
}