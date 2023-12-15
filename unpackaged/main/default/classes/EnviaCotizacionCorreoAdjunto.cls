public class EnviaCotizacionCorreoAdjunto {
    public class InputVariables {
        @InvocableVariable
        public String AccountId;
        @InvocableVariable
        public String DocumentId;
        @InvocableVariable
        public String ToEmail;
        @InvocableVariable
        public String Subject;
        @InvocableVariable
        public String bodyTemplate;
    }

    @InvocableMethod(label='Enviar Cotizacion por mail' description='Enviar Cotizacion por mail')
    public static void Envia(List <InputVariables> InputVariables) {
        //String toAddress, String subject, String body) 
        String toAddress = InputVariables[0].ToEmail;
        String subject = InputVariables[0].Subject;
        String docId = InputVariables[0].DocumentId;
        //String body='<p>Envío Cotización solicitada.</p><br /><p>Atentamente:</p><p>'+AsesorName+'</p>';
        String body = InputVariables[0].bodyTemplate;
        system.debug('to:'+toAddress);
        system.debug('docId:'+docId);
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {toAddress};
        email.setToAddresses(toAddresses);
        email.setSubject(subject);
        //email.setPlainTextBody(body);
        email.setHtmlBody(body);

        List<String> contentVersionIds =  new List<String>();

        for(ContentDocumentLink thisCdl : [
                SELECT ContentDocument.LatestPublishedVersionId 
                FROM ContentDocumentLink 
                WHERE Id = :docId]) {
            contentVersionIds.add(thisCdl.ContentDocument.LatestPublishedVersionId);
        }
        system.debug('**** contentVersionIds: '+contentVersionIds);

        email.setEntityAttachments(contentVersionIds);

        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        if (results[0].isSuccess()) {
            System.debug('Email sent successfully');
        } else {
            System.debug('Email sending failed');
        }
    }
}