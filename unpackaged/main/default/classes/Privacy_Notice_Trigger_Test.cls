@isTest
public class Privacy_Notice_Trigger_Test {
    static TestMethod void Test1() {
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('COMPAÑÍA JAVER').getRecordTypeId();
        Account acc = new Account();
        acc.name= 'COMPAÑÍA';
        acc.RecordtypeId= accRecordTypeId;
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819'; 
        acc.Apellidomaterno_cta__c = 'materno';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        Privacy_Notice__c pn = new  Privacy_Notice__c();
        pn.Account__c = acc.Id;
        pn.Active__c = true;
        pn.Notice_Text__c = 'test ||TODAY||';
        pn.Type__c = 'Aviso de Inicio';
        insert pn;
        pn.Active__c = false;
        update pn;
    }
    static TestMethod void Test2() {
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('COMPAÑÍA JAVER').getRecordTypeId();
        Account acc = new Account();
        acc.RecordtypeId= accRecordTypeId;
        acc.name= 'COMPAÑÍA';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819'; 
        acc.Apellidomaterno_cta__c = 'materno';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        Privacy_Notice__c pn = new  Privacy_Notice__c();
        pn.Account__c = acc.Id;
        pn.Active__c = true;
        pn.Notice_Text__c = 'test ||TODAY||';
        pn.Type__c = 'Aviso de Empresa';
        insert pn;
         Privacy_Notice__c pn1 = new  Privacy_Notice__c();
        pn1.Account__c = acc.Id;
        pn1.Active__c = true;
        pn1.Notice_Text__c = 'test ||TODAY||';
        pn1.Type__c = 'Aviso de Empresa';
        insert pn1;
        update pn;
    }
}