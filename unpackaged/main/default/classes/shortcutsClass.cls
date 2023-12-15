public class shortcutsClass {
    @AuraEnabled 
    public static List<Shortcut__c>fetchShorts(){
        return [Select id,Asunto__c,URL__c from Shortcut__c];
    }
    @AuraEnabled 
    public static void sendEmail(string req, String sub){
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        String supportEmail  = System.Label.Support_Email;
        List<String> address = new List<String>{supportEmail}; 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject(sub);
        mail.setHTMLBody('<html><body>'+req+'</body></html>');
        mail.setToAddresses(address);
        emailList.add(mail);
        if(!emailList.isEmpty()){
            Messaging.sendEmail(emailList);
        }	   
    }
    @AuraEnabled 
    public static void logoutFromSite(){
        JaverClass.logout();
    }
}