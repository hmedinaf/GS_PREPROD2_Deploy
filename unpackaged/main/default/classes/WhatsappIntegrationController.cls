@RestResource(urlMapping='/whatsappnotification/*')
global without sharing class WhatsappIntegrationController {
    public static String mediaContentType = ''; 
    public static String accessToken = System.Label.WhatsappToken;
    @HttpPost
    global static void handelWebhook(){
        List<WhatsApp__c> wplist = new List<WhatsApp__c>();    List<Attachment> attlist = new List<Attachment>(); List<Attachment> attlist1 = new List<Attachment>();
        List<WhatsApp__c> wpatt1 = new List<WhatsApp__c>();    List<WhatsApp__c> wpdoc1 = new List<WhatsApp__c>();
        try{
            RestRequest request = RestContext.request;
            Blob body = request.requestBody;
            String requestString = body.toString();               
            RequestWrapper rw = (RequestWrapper)JSON.deserialize(requestString,RequestWrapper.class);
            system.debug('rw'+rw);
            system.debug('request post ---> ' + rw.entry[0].changes[0].value.contacts[0].wa_id);    
            String PhoneNumber = rw.entry[0].changes[0].value.contacts[0].wa_id;
            PhoneNumber = PhoneNumber.substring(3, PhoneNumber.length());
            PhoneNumber = '+52'+PhoneNumber;
            // PhoneNumber = '+'+PhoneNumber;
            system.debug('PhoneNumber'+PhoneNumber);
            string ClientName =  rw.entry[0].changes[0].value.contacts[0].profile.name;
            String phoneNumberId = rw.entry[0].changes[0].value.metadata.phone_number_id;
            String str = rw.entry[0].changes[0].value.contacts[0].wa_id;
            Integer ln = str.Length();
            String PhonelikeStr = '%'+str.subString(ln-10, ln-7)+'%'+str.subString(ln-7, ln-4) +'%'+ str.subString(ln-4);
            List<Account> accountList = [Select Id,Phone,Name From Account Where TelefonoCelular__c =: PhoneNumber AND isPersonAccount = true];
            if(accountList != null && accountList.size()>0){
                String caption= '';  String mediaId = '';  Blob mediaBody ;  String mediaId1 = '';  String mediaName1 = '';  Blob mediaBody1 ;
                if(rw.entry[0].changes[0].value.messages[0].type == 'image'){
                    caption = rw.entry[0].changes[0].value.messages[0].image.caption;
                    mediaId = rw.entry[0].changes[0].value.messages[0].image.id;
                    mediaBody = getMedia(getMediaUrl(mediaId, phoneNumberId));
                }
                if(rw.entry[0].changes[0].value.messages[0].type == 'document'){
                    mediaId1 = rw.entry[0].changes[0].value.messages[0].document.id;
                    mediaName1 = rw.entry[0].changes[0].value.messages[0].document.fileName;
                    mediaBody1 = getMedia(getMediaUrl(mediaId1, phoneNumberId));
                }
                for(Account acc : accountList){
                    if(rw.entry[0].changes[0].value.messages[0].type == 'text'){
                        WhatsApp__c wa = new WhatsApp__c();
                        wa.Message__c = rw.entry[0].changes[0].value.messages[0].text.body ;
                        wa.Prospect__c = acc.id;
                        wplist.add(wa);
                    }
                    if(rw.entry[0].changes[0].value.messages[0].type == 'image'){
                        WhatsApp__c wa = new WhatsApp__c();
                        wa.Message__c = '' ;
                        wa.Prospect__c = acc.id;
                        wa.Attachment_Caption__c = caption;
                        wpatt1.add(wa);
                    }
                    if(rw.entry[0].changes[0].value.messages[0].type == 'document'){
                        WhatsApp__c wa = new WhatsApp__c();
                        wa.Message__c = '' ;
                        wa.Prospect__c = acc.id;
                        wa.Attachment_Caption__c = mediaName1;
                        wpdoc1.add(wa);
                    }
                }
                if(wpatt1 != null && wpatt1.size()>0){
                    insert wpatt1; 
                    for(WhatsApp__c wp : wpatt1){
                        Attachment a =  saveTheFile(mediaBody, String.isNotBlank(caption) ? caption : 'Whatsapp Image From'+PhoneNumber, String.isNotBlank(caption) ? caption : 'Whatsapp Image From'+PhoneNumber, wp.id);
                        attlist.add(a);
                    }
                }
                if(wpdoc1 != null && wpdoc1.size()>0){
                    insert wpdoc1; 
                    for(WhatsApp__c wp : wpdoc1){
                        Attachment a1 = saveTheFile(mediaBody1, String.isNotBlank(mediaName1) ? mediaName1 : 'Whatsapp Image From'+PhoneNumber, 'Whatsapp document From'+PhoneNumber, wp.id);
                        attlist1.add(a1);
                    }
                }
                if(wplist != null && wplist.size()>0){
                    insert wplist; 
                }
                if(attlist != null && attlist.size()>0){
                    insert attlist; 
                }
                if(attlist1 != null && attlist1.size()>0){
                    insert attlist1; 
                } 
            }
            RestResponse response = RestContext.response;
        }
        catch(Exception e){
            system.debug('Exception Happened: ' + e.getMessage()+'::at line number:::'+e.getLineNumber());
        }
    }
    public static Attachment saveTheFile(Blob body, String fileName, String dsc, String parentId){
        Attachment att = new Attachment();
        att.Body = body;
        att.ContentType = mediaContentType;
        att.ParentId = parentId;
        att.Description = 'Whatsapp media - '+dsc;
        att.Name = fileName;
        att.isprivate = false;
        return att; 
    }
    public static String getMediaUrl(String mediaId, String phoneNumberId){
        String endPoint =  System.Label.Media_Endpoint; 
        endpoint =  endPoint+'/'+mediaId+'?phone_number_id='+phoneNumberId;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+accessToken);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        response = http.send(req);
        if(response.getStatusCode() == 200){
            string body = response.getBody();
            MediaUrl mu = (MediaUrl)JSON.deserialize(body, MediaUrl.class);
            if(mu.file_size <= 6000000){
                return mu.url;
            }
            else{
                return null;
            }
        }
        else{
            return null;
        }
    }
    public static Blob getMedia(String mediaUrl){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(mediaUrl);
        req.setHeader('Authorization', 'Bearer '+accessToken);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        response = http.send(req);
        if(response.getStatusCode() == 200){
            mediaContentType = response.getHeader('Content-Type');
            return response.getBodyAsBlob();
            
        }
        else{
            return null;
        }
    }
    @HttpGet
    global static void handelGetWebhook(){
        try{
            RestRequest request = RestContext.request;
            system.debug('request Get' + RestContext.request.params.get('hub.challenge'));
            RestResponse response = RestContext.response;
            try {                
                response.responseBody = Blob.valueOf(RestContext.request.params.get('hub.challenge'));
                response.statusCode = 200;
            } catch (Exception e) {
                response.responseBody = Blob.valueOf(e.getMessage());
                response.statusCode = 500;
            }
        }catch(Exception e){
            system.debug('Exception Happened: ' + e.getMessage());
        }
    }    
    
    public class MediaUrl{
        public String url;	//https://lookaside.fbsbx.com/whatsapp_business/attachments/?mid=570778648419546&ext=1676451810&hash=ATsUh1EWxWE4ThB_2uMptRbHK5BQsSEs4uNNV4Gk0eeqEw
        public String mime_type;	//application/pdf
        public String sha256;	//cfc2705f2d01409f2ec079b3f8fe38a68b9cc581b383c43ebc2b5556c75c825e
        public Integer file_size;	//90515
        public String id;	//570778648419546
        public String messaging_product;	//whatsapp
    }
    public class RequestWrapper{
        // public String object;
        public cls_entry[] entry;             
    }    
    class cls_entry{
        public String id;    //105707265513096
        public cls_changes[] changes;
    }
    class cls_changes {
        public cls_value value;
        public String field;    //messages
    }
    class cls_value {
        public String messaging_product;    //whatsapp
        public cls_metadata metadata;
        public cls_contacts[] contacts;
        public cls_messages[] messages;
    }
    class cls_metadata {
        public String display_phone_number;    //918929761823
        public String phone_number_id;    //104869622265008
    }
    class cls_contacts {
        public cls_profile profile;
        public String wa_id;    //917017563013
    }
    class cls_profile {
        public String name;    //
    }
    class cls_messages {
        //public String from;    //917017563013
        public String id;    //wamid.HBgMOTE3MDE3NTYzMDEzFQIAEhggRDQxN0MzMDlCNzlGN0MxNzQ4RDIxNDRFQTgwNDM3MTkA
        public String timestamp;    //1656516182
        public cls_text text;
        public cls_image image;
        public cls_document document;
        public String type;    //text
    }
    class cls_text {
        public String body;    //Tt
    }
    class cls_image {
        public String mime_type;	//image/jpeg
        public String sha256;	//GwuZ3ZmMxS27mEuQe8qCOCi1yTmKODAKaExa4NhyXqo=
        public String id;	//753414176512108
        public String caption;
    }
    class cls_document {
        public String filename;	//SamplePromo.pdf
        public String mime_type;	//application/pdf
        public String sha256;	//z8JwXy0BQJ8uwHmz+P44poucxYGzg8Q+vCtVVsdcgl4=
        public String id;	//570778648419546
    }
}