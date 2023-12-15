public class EscalamientosCron implements Schedulable {
    public void execute(SchedulableContext ctx) {
    //public void execute(){
        List<Casos_Residente__c> casos = [SELECT LastModifiedDate, Name, Tipo__c, Cuenta__c, ViviendaProceso__r.fracc__c, RecordTypeId, Clasificacion__c, Nomenclatura__c, Origendegarantia__c, Detalledelreporte__c FROM Casos_Residente__c WHERE Status__c != 'Cerrado' AND Status__c != 'Cancelado'];
        String query = 'SELECT '+ escalamientoFieldNames() + ', Escalamiento1__r.Email, Escalamiento2__r.Email, Escalamiento3__r.Email FROM Escalamiento__c';
        List<Escalamiento__c> escalamientos = database.query(query);
        Map<Id, RecordType> ts = new Map<Id, RecordType>([SELECT Id, Name FROM RecordType]);
        Map<Id, Fraccionamiento__c> fr = new Map<Id, Fraccionamiento__c>([SELECT id, Name FROM Fraccionamiento__c]);
        Contact cnt = [select id, Email from Contact limit 1];
        Id templateId = [select id from EmailTemplate where Name='Escalamiento'].id;
        List<Messaging.SingleEmailMessage> msgListToBeSend = new List<Messaging.SingleEmailMessage>();
        for(Escalamiento__c e : escalamientos){
            for(Casos_Residente__c c : casos){
                System.debug(c.Name);
                if(c.RecordTypeId != null && c.Tipo__c != null && c.Clasificacion__c != null && c.ViviendaProceso__r.fracc__c != null){
                    /*
                    if(c.Name == 'CAS-00000155' && (c.ViviendaProceso__r.fracc__c == e.Fraccionamiento__c)){
                    System.debug(e.Id);
                    System.debug(e.TipoServicio__c +'-'+ ts.get(c.RecordTypeId).Name);
                    System.debug(e.Tipo__c +'-'+ c.Tipo__c);
                    System.debug(e.Clasificacion__c +'-'+ c.Clasificacion__c);
                    System.debug(c.ViviendaProceso__r.fracc__c +'-'+ e.Fraccionamiento__c);
                    }*/
                    if(e.TipoServicio__c == ts.get(c.RecordTypeId).Name && e.Clasificacion__c == c.Clasificacion__c && e.Tipo__c == c.Tipo__c
                       && c.ViviendaProceso__r.fracc__c == e.Fraccionamiento__c){
                           Date lmd = Date.newInstance(c.LastModifiedDate.year(), c.LastModifiedDate.month(), c.LastModifiedDate.day());
                           String dias = lmd.daysBetween(System.today()) + '';
                           System.debug(c.Name+'->'+dias);
                           //msgListToBeSend.add(enviarCorreo(c.Id, 'victor.pineda@solcomla.com', 'lidia.contreras@solcomla.com', cnt, templateId));
                           if(dias == e.DiasEsc1__c){
                               msgListToBeSend.add(enviarCorreo(c.Id, e.CorreoEsc1__c, e.Escalamiento1__r.Email, cnt, templateId));
                           } else if(dias == e.DiasEsc2__c){
                               msgListToBeSend.add(enviarCorreo(c.Id, e.CorreoEsc2__c, e.Escalamiento2__r.Email, cnt, templateId));
                           } else if(dias == e.DiasEsc3__c){
                               msgListToBeSend.add(enviarCorreo(c.Id, e.CorreoEsc3__c, e.Escalamiento3__r.Email, cnt, templateId));
                           }
                       }
                }
            }   
        }
        System.debug(msgListToBeSend);
        Messaging.sendEmail(msgListToBeSend);
    }
    public Messaging.SingleEmailMessage enviarCorreo(ID whatId, String toExtAddress, String toAddress, Contact cnt, Id template){
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.setTemplateId(template);
        msg.setWhatId(whatID);
        msg.setTargetObjectId(cnt.id);
        List<String> correos = new List<String>{};
            if(!String.isEmpty(toExtAddress))
                correos.add(toExtAddress);
            if(!String.isEmpty(toAddress))
                correos.add(toAddress);
        msg.setToAddresses(correos);
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Soporte Salesforce'];
        if(!owea.isEmpty()){
            msg.setOrgWideEmailAddressId(owea[0].Id);
        }
        System.debug('email->'+ msg.getToAddresses());
        return msg;
    }
    private String escalamientoFieldNames(){
        String names = '';
        Map<String, Schema.SObjectField> fieldsMap = Schema.SObjectType.Escalamiento__c.fields.getMap();
        for (Schema.SObjectField field : fieldsMap.values()){
            names += field.getDescribe().getName() + ',';
        }
        if (names.subString(names.Length()-1,names.Length()) == ','){
            names = names.subString(0,names.Length()-1);
        }
        return names;
    }
}