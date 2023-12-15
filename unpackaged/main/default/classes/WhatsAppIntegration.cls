public class WhatsAppIntegration {
    
    @AuraEnabled
    public static void sendSms(String contactId){
        String contactNumber = [SELECT Id, MobilePhone FROM Contact WHERE Id =:contactId].MobilePhone;
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndPoint('https://graph.facebook.com/v15.0/101413582762776/messages');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer EAAHQIlOh1ioBAGUiCKTJnh7pa8mbq02o0pYBynDF6G5T9dyc5g04lyGXinXw6EEqA8BH8cGn7DwZCwe4XVFOfRQRKRQbCG9fwUZBWrrk8hZBZBAcdGMjLaiisXOlpig01ZCcEoV8OinPMZAM5FnZANpZB41MREQotYSg6VGc4seaGK7gqxp8yZAYvJJuNMTyczyPJ3GxdnbYTvgZDZD');
        req.setBody('{"messaging_product":"whatsapp", "to": '+contactNumber+', "type" : "template", "template" : {"name" : "welcome", "language" : {"code" : "en_US"}}}');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug(res.getStatusCode());
        system.debug(res.getStatus());
        system.debug(res.getBody());
    }
    
}