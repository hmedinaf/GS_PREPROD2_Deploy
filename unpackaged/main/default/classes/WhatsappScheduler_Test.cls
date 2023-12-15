@isTest
public class WhatsappScheduler_Test {
    static TestMethod void testScheduledJob() {
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
        WhatsApp__c wp = new WhatsApp__c();
        wp.Message__c = 'tset';
        wp.Prospect__c = acc.Id ;
        insert wp;
        WhatsApp__c wp1 = new WhatsApp__c();
        wp1.Message__c = 'test';
        wp1.Prospect__c = acc.Id ;
        insert wp1;
        Attachment att = new Attachment();
        att.Body = Blob.valueOf('test');
        att.ParentId = wp.id;
        att.Description = 'Whatsapp media - ';
        att.Name = 'test';
        att.isprivate = false;
        insert att; 
        Attachment att1 = new Attachment();
        att1.Body = Blob.valueOf('test');
        att1.ParentId = wp1.id;
        att1.Description = 'Whatsapp media - ';
        att1.Name = 'test';
        att1.isprivate = false;
        insert att1; 
        Datetime scheduleTime = Datetime.now().addSeconds(55);
        String cronExpression = '0 ' + scheduleTime.minute() + ' ' + scheduleTime.hour() + ' ' + scheduleTime.day() + ' ' + scheduleTime.month() + ' ? ' + scheduleTime.year();
        Test.startTest();
        String jobId = System.schedule('Test Job', cronExpression, new WhatsappScheduler());
        Test.stopTest();
        
    }
}