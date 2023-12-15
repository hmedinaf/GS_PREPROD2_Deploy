public class EnvioCheckList {
    public String mje { get; set; }
    public void corre(){
        try{
            String idCheckList = Apexpages.currentPage().getparameters().get('id');
            System.debug(idCheckList);
            Check_List__c checklist = [SELECT Id,Name, CorreEnvio__c FROM Check_List__c WHERE Id =: idCheckList];
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            for(ContentDocumentLink doc : [SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId =: idCheckList]){
                for(ContentVersion dCont: [SELECT ContentDocumentId,VersionData,FileExtension,FileType,Id,Title FROM ContentVersion where ContentDocumentId =:doc.ContentDocumentId]){
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setFileName(dCont.Title+'.'+dCont.FileExtension);
                    efa.setBody(dCont.VersionData);
                    fileAttachments.add(efa);
                }
            }
            List<String> toaddress = new List<String>();
            if(!String.isEmpty(checklist.CorreEnvio__c)){
                for(String c : checklist.CorreEnvio__c.split(';')){
                    if(validateEmail(c.trim()))
                        toaddress.add(c.trim());
                }
            }
            Id templateId = [select id from EmailTemplate where Name='CheckList'].id;
            Contact cnt = [select id, Email from Contact where Name = 'Test Contact' limit 1];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(templateId);
            mail.setWhatId(checklist.Id);
            mail.setTargetObjectId(cnt.id);
            mail.setToAddresses(toaddress);
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Soporte Casas JAVER'];
            if(!owea.isEmpty()){
                mail.setOrgWideEmailAddressId(owea[0].Id);
            }
            fileAttachments.add(getChecklist(idCheckList,checklist.Name));
            mail.setFileAttachments(fileAttachments);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            mje = 'Correo enviado correctamente';
        } catch(Exception e){
            mje = 'Error al enviar el checklist';
            System.debug(e.getMessage());
        }
    }
    @testVisible
    private Messaging.EmailFileAttachment getChecklist(String idCheckList, String checklistName){
        Messaging.EmailFileAttachment attachCheckList = new Messaging.EmailFileAttachment();
        try{
            PageReference pdf = new PageReference('/apex/CheckList_Report');
            pdf.getParameters().put('id',idCheckList);
            attachCheckList.setContentType('application/pdf');
            attachCheckList.setFileName(checklistName + '.pdf');
            attachCheckList.setInline(false);
            attachCheckList.Body = pdf.getContent();
            System.debug(attachCheckList);
        } catch(Exception e){
            System.debug(e.getMessage());
        }
        return attachCheckList;
    }
    public static Boolean validateEmail(String email) {
        Boolean res = false;
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: <a href="http://www.regular-expressions.info/email.html" target="_blank" rel="nofollow">http://www.regular-expressions.info/email.html</a>
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);
        if (MyMatcher.matches()) 
            res = true;
        return res;	
    }
}