public class Promotions {
    @AuraEnabled 
    public static list<String> userInfoMethod(){
        User  u = [Select Id,Fraccionamientos__c from User where Id=:UserInfo.getUserId()];
         List<String> fracList  = new List<String>();
        if(u.Fraccionamientos__c != null && u.Fraccionamientos__c != ''){
            fracList = u.Fraccionamientos__c.split(';');
        }
        fracList.sort();
        return fracList;
    }
    @AuraEnabled 
    public static List<Promocion__c> fetchPromotions(){
        User u =[Select Id,Name,Phone,SenderEmail,Email,state, Profile.Name,Fraccionamientos__c from User where Id=:userInfo.getUserId()];
        if(u.Fraccionamientos__c != null && u.Fraccionamientos__c != ''){
            List<String> fracList = u.Fraccionamientos__c.split(';');
            List<Promocion__c>  promlist = [Select Id ,Asunto__c, Name,Fraccionamiento__c,Imagen__c,Activo__c,Fraccionamiento__r.Name  from Promocion__c Where Fraccionamiento__r.Name IN : fracList AND Activo__c = true ];
            if(promlist != null && promlist.size()>0){
                return promlist; 
            }
            return null;
        }
        return null;
    }
    @AuraEnabled 
    public static List<Promocion__c> fetchSelectedPromotions(string selectedNeigh){
        List<Promocion__c> promlist = new List <Promocion__c>(); 
        if(selectedNeigh == 'Todos' ){
            promlist = [Select Id ,Asunto__c, Name,Fraccionamiento__c,Imagen__c,Activo__c,Fraccionamiento__r.Name  from Promocion__c Where Activo__c = true];
        }
        else{
            promlist = [Select Id ,Asunto__c, Name,Fraccionamiento__c,Imagen__c,Activo__c,Fraccionamiento__r.Name  from Promocion__c Where Fraccionamiento__r.Name =:selectedNeigh  AND Activo__c = true];
        }
        if(promlist != null && promlist.size()>0){
            return promlist; 
        }
        return null;
    }
    @AuraEnabled
    public static List<string> searchDivision(String searchValue){
        List<String> result = new list<string>();  List<String> fracList =new list<string>();
        User u =[Select Id,Name,Phone,Email,state,Profile.Name,Fraccionamientos__c from User where Id=:userInfo.getUserId()];
        if( u.Fraccionamientos__c != null){
         fracList = u.Fraccionamientos__c.split(';');
        }
        for(String frac : fracList){
            if(frac.contains(searchValue.toUppercase())){
                result.add(frac);
            }
        }
        return  result;
    }
    
    @AuraEnabled
    public static string download( string pId){
        PageReference pa = new PageReference('/apex/PromoPDF');
        pa.getParameters().put('id', pId);
        pa.getUrl();
        Blob fileAData;
        if(Test.isRunningTest()) { 
            fileAData = blob.valueOf('Unit.Test');
        } else {
            fileAData = pa.getContentAsPDF();
        }
        String base64Pdf = EncodingUtil.base64Encode(fileAData);
        return base64Pdf;
    }
    @AuraEnabled 
    public static void sendEmail(string pId, String email){
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();  
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
        List<String> address = new List<String>{email}; 
            Promocion__c  promo = [Select Id ,Asunto__c, Name,Fraccionamiento__c,Fecha_de_Inicio__c,Fecha_Final__c,Descripcion__c,Imagen__c,Activo__c,Fraccionamiento__r.Name  from Promocion__c Where Id = :pId  AND Activo__c = true];
        String inicio ; String finalDate;
        if(promo.Fecha_de_Inicio__c != null){
            inicio = String.valueOf(promo.Fecha_de_Inicio__c);  inicio = inicio.split(' ')[0];
        }
        if(promo.Fecha_Final__c != null){
            finalDate = String.valueOf(promo.Fecha_Final__c);   finalDate = finalDate.split(' ')[0];
        }
        String imageUrl = promo.Imagen__c.substringBetween('src="', '"');
        String decodedURL = imageUrl.unescapeHtml4();
        Blob blobContent ;
        if(Test.isRunningTest()) { 
            blobContent = blob.valueOf('Unit.Test');
        } 
        else {
        PageReference page = new PageReference( decodedURL );
         blobContent = page.getContent();
        }
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName(promo.Asunto__c+'.png');
        efa.setBody(blobContent);
        efa.setContentType('image/png');
        attachments.add(efa);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Material de Apoyo Javer');
        mail.setHTMLBody('<html><body><br/><b style="font-size:20px;text-align:center">' +promo.Asunto__c+'</b><br/><table><tr><td><label style="font-size:18px;">Fraccionamiento</label></td><td style="width:60%">'+promo.Fraccionamiento__r.Name+'</td> </tr> <tr>'+
                         '<td><label style="font-size:18px;">Descripción</label></td><td  style="width:60%">'+promo.Descripcion__c+'</td></tr>  <tr> <td><label style="font-size:18px;">Fecha de Inicio</label></td>'+
                         '<td  style="width:60%">'+inicio+'</td  </tr><tr> <td><label  style="font-size:18px;">Fecha Final</label></td><td  style="width:60%">'+finalDate+'</td> </tr></table></body></html>');
        mail.setToAddresses(address);
        mail.setSaveAsActivity(true);  
        mail.setFileAttachments(attachments);
        emailList.add(mail);
        if(!emailList.isEmpty()){
            Messaging.sendEmail(emailList);
        }
    } 
}