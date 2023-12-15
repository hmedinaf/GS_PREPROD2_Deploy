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
private class  UploadLA_test {
    
    @testSetup static void setup() {
        Fraccionamiento__c f = new Fraccionamiento__c();
        f.Name = 'ALVENTO';
        insert f;
        
        Lead l = new Lead();
        l.Email = 'test@prospects.com';
        l.LastName = 'NOVENTA';
        l.FirstName = 'REGISTRO';
        /*l.MiddleName = 'SALES';*/
        l.JMC_WSResponseEx__c = false;
        l.JMC_FechaNacimiento__c = date.valueof('1980-03-21T00:00:00.000Z');
        l.ErrorCodeResponseSOAP__c = '0';
        l.JMC_FraccionamientoInterno__c = 'ALVENTO';
        l.JMC_Genero__c = 'Masculino';
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
        l.JCM_Carga_inicial__c=true;
        insert l;        
        
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.parse('11/09/1991');
        acc.Phone = '+528119928819';
        acc.TelefonoOtro__c = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.JMC_Carga_inicial__c = true;
        insert acc;
    }   
    static testMethod void valWSUpd(){
        Test.startTest();
        UploadLA obj = new UploadLA();
        DataBase.executeBatch(obj); 
        //Database.executeBatch(new UploadLA().execute(BC, scope));
        Test.stopTest();
    } 
}