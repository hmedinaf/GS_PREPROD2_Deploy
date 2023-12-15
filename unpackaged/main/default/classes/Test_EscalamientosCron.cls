@isTest
public class Test_EscalamientosCron {
    @testSetup static void setup() {
        EmailTemplate e = new EmailTemplate (developerName = 'CheckList',  folderId = userInfo.getUserId() , TemplateType= 'Text', Name = 'CheckList');
        insert e;
    }
    public static testMethod void testschedule() {
        Id usuar = [SELECT Id FROM User WHERE Name LIKE 'Admin%' LIMIT 1].ID;
        Id rtG ;
        List<RecordType> rtlist = [SELECT Id FROM RecordType WHERE Name LIKE 'Garantías%' LIMIT 1];
        if(rtlist != null ){
            rtG = rtlist[0].Id;
        }
        Id templateId ;
        List<EmailTemplate> etlist = [select id from EmailTemplate where developerName='CheckList' LIMIT 1];
        if(etlist != null ){
            templateId = etlist[0].Id;
        }
        Account acc = new Account();
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c = f.id;
        insert acc; 
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Name = 'AABBCCDDEE-Prueba';
        inventario.Fracc__c = f.Id;
        inventario.Entregada__c = 'Entregado';
        inventario.FechaHabitabilidad__c = System.today().format();
        inventario.PorcentajeCheckList__c = 0;
        inventario.FechadeHabitabilidad__c = System.today();
        inventario.Cuenta__c = acc.Id;
        insert inventario;
        Casos_Residente__c caso = new Casos_Residente__c();
        caso.RecordTypeId = rtG;
        caso.ViviendaProceso__c = inventario.Id;
        caso.Tipo__c = 'A. Instalación eléctrica';
        caso.Clasificacion__c = 'A1. Corto circuito';
        caso.Status__c = 'Asignado';
        insert caso;
        Escalamiento__c e = new Escalamiento__c();
        e.Clasificacion__c = 'A1. Corto circuito';
        e.Tipo__c = 'A. Instalación eléctrica';
        e.Fraccionamiento__c = f.Id;
        e.TipoServicio__c = 'Garantías';
        e.DiasEsc1__c = '0';
        e.DiasEsc1__c = '1';
        e.DiasEsc1__c = '2';
        insert e;
        Contact con = new Contact(LastName ='testCon');
        insert con; 
        Test.StartTest();
        EscalamientosCron sh1 = new EscalamientosCron();
        String sch = '0 54 17 * * ?'; 
        system.schedule('Test_EscalamientosCron', sch, sh1);
        sh1.enviarCorreo(caso.Id, 'victor.pineda@solcomla.com', 'lidia.contreras@solcomla.com', con, templateId);
        Test.stopTest(); 
    }
}