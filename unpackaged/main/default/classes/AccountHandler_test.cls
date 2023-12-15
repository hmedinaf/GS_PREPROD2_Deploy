/*
----------------------------------------------------------
* Nombre: AccountHandler_test
* Autor Saúl González   
* Proyecto: Javer
* Descripción : Clase con metódos test 
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           20/03/2021     Saúl González            Creación
* --------------------------------------------------------------------------------
*/
@isTest
private class AccountHandler_test {
    
    /*
* @description Method que ejecuta setup
*/
    @testSetup static void setup() {
        Fraccionamiento__c f = new Fraccionamiento__c();
        f.Name = 'ALVENTO';
        insert f;
        
        Lead l = new Lead();
        l.Email = 'noventa@javer.com.mx';
        l.LastName = 'NOVENTA';
        l.FirstName = 'REGISTRO';
        /*l.MiddleName = 'SALES';*/
        l.JMC_WSResponseEx__c = false;
        l.JMC_FechaNacimiento__c = date.valueof('1980-03-21T00:00:00.000Z');
        l.ErrorCodeResponseSOAP__c = '0';
        l.JMC_FraccionamientoInterno__c = 'ALVENTO';
        l.JMC_Genero__c = 'Masculino';
        l.JMC_Estado__c = 'Jalisco';
        l.JMC_FechaCaptura__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.JMC_FechaProspeccion__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.JMC_CanalVenta__c = 'Medios Digitales';
        l.MsgResponseWS__c = 'Cuenta Creada Exitos';
        l.JMC_SubCanalVenta__c = 'Facebook';
        l.JMC_TipoCredito__c = 'CONTADO';
        l.Status = 'Envío MAS Comercial';
        l.JMC_Edad__c = 41;
        l.JMC_FechaVencimiento__c = date.valueof('2021-04-03T00:00:00.000Z');
        l.JMC_Perfilar__c = false;
        l.JMC_Analisisinterno__c = 'Perfilado';
        l.DeleteMailDuplicate__c = false;
        l.ID_CUENTA__c = '1-2MAANPJ';
        l.LeadSource = 'Prospección';
        l.JMC_Fraccionamiento__c = f.Id;
        l.JMC_IdDelete__c = false;
        l.Phone = '8111336699';
        l.JMC_Re_Registro__c = false;
        l.JMC_UEN__c = 'UEN3 - JALISCO';
        l.JMC_FechaAsignacion__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.JMC_EstatusLead__c = 'Perfilado';
        insert l;        
        
        Account acc = new Account();
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.Phone = '+528119928819';
        acc.Check_Apellido__c = true;
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Fraccionamiento_cta__c = f.id;
        insert acc;
        Account ac = new Account();
        ac.name= 'test';
        ac.Phone = '+528119928819';
        ac.Otro_Telefono__c = '+528119928819'; 
        ac.Apellidomaterno_cta__c = 'materno';
        ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert ac;
    }
    
    static testMethod void valWSUpd(){
        Account cta = [SELECT Id, CorreoElectronico__c FROM Account WHERE CorreoElectronico__c='noventa@javer.com.mx' limit 1];
        List<Lead> lstLeads = [SELECT Id, Email, JMC_Analisisinterno__c, status, JMC_ValidardatosSiebel__c  FROM Lead WHERE Email='noventa@javer.com.mx' ];
        map<Id,Lead> mapLeads = new map<Id,Lead>(lstLeads);
        String nF = [SELECT Id, Name FROM Fraccionamiento__c limit 1].Name;
        Test.startTest();
        AccountHandler_ctrl lH = new AccountHandler_ctrl();
        AccountHandler_ctrl.valWSUpd(lstLeads, lstLeads, mapLeads, mapLeads);
        Test.stopTest();
    } 
    
    static testMethod void upAccount(){
        Map<String, Object> mapJson  = new Map<String, Object>();
        mapJson.put('mailLead', 'prueba11atv@javer.com.mx');
        AccountHandler_ctrl ah = new AccountHandler_ctrl();
        ah.upAccount(mapJson);
    }
    
    static testMethod void upAccountP(){
        Map<String, Object> mapJson  = new Map<String, Object>();
        mapJson.put('mailLead', 'noventa@javer.com.mx');
        AccountHandler_ctrl ah = new AccountHandler_ctrl();
        ah.upAccount(mapJson);
    }
    
    static testMethod void mapConstLead(){
        AccountHandler_ctrl ah = new AccountHandler_ctrl();
        List<Account> lstAcct = AccountUtils_ctrl.getObjAccount('noventa@javer.com.mx');
        ah.mapConstLead(lstAcct[0]);
    }
    
}