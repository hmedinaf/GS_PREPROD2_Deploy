public class EnviaNotificacionNuevoMatierial {
    @future(callout = true)
    public static void Envia(String toAddress, String subject, String body) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {toAddress};
        email.setToAddresses(toAddresses);
        email.setSubject(subject);
        //email.setPlainTextBody(body);
        email.setHtmlBody(body);

        /*
        List<String> contentVersionIds =  new List<String>();

        for(ContentDocumentLink thisCdl : [
            SELECT ContentDocument.LatestPublishedVersionId 
            FROM ContentDocumentLink 
            WHERE LinkedEntityId = '0052g000003qPSoAAM']) {
                contentVersionIds.add(thisCdl.ContentDocument.LatestPublishedVersionId);
        }
        system.debug('**** contentVersionIds: '+contentVersionIds);

        email.setEntityAttachments(contentVersionIds);
        */
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        if (results[0].isSuccess()) {
            System.debug('Email sent successfully');
        } else {
            System.debug('Email sending failed');
        }
    }
}