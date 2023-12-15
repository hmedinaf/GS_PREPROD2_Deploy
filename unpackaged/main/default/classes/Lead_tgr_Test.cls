@isTest
public class Lead_tgr_Test {
    static TestMethod void testMethod1() {
         Fraccionamiento__c f = new Fraccionamiento__c();
        f.Name = 'ALVENTO';
        insert f;
        
        Lead l = new Lead();
        l.JMC_WSResponseEx__c = false;
        l.JMC_FechaNacimiento__c = date.valueof('1980-03-21T00:00:00.000Z');
        l.JMC_FraccionamientoInterno__c = 'ALVENTO';
        l.JMC_Estado__c = 'Jalisco';
        l.JMC_FechaCaptura__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.JMC_FechaProspeccion__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.MsgResponseWS__c = 'Cuenta Creada Exitos'; 
        l.JMC_TipoCredito__c = 'CONTADO';
        l.Status = 'Envío MAS Comercial';
        l.JMC_Analisisinterno__c = 'Perfilado';
        l.JMC_EstatusLead__c = 'Perfilado';
        l.JMC_FechaVencimiento__c = date.valueof('2021-04-03T00:00:00.000Z');
        l.JMC_AsesorAsignado__c = 'TEST Asesor Asignado';
        l.FirstName = 'REGISTRO';
        /*l.MiddleName = 'SALES';*/
        l.LastName = 'NOVENTA';
        l.JMC_Genero__c = 'Masculino';
        l.Email = 'noventa@javer.com.mx';
        l.JMC_Fraccionamiento__c = f.Id;
        l.JMC_CanalVenta__c = 'Medios Digitales';
        l.JMC_SubCanalVenta__c = 'Facebook';
        l.JMC_Edad__c = 41;
        l.JMC_Perfilar__c = false;
        l.DeleteMailDuplicate__c = false;
        l.ID_CUENTA__c = '1-TEST1234';
        l.LeadSource = 'Prospección';
        l.JMC_IdDelete__c = false;
        l.Phone = '8111336699';
        l.MobilePhone = '8111336699';
        l.JMC_Re_Registro__c = false;
        l.JMC_UEN__c = 'UEN3 - JALISCO';
        l.JMC_FechaAsignacion__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.JMC_ProspectadorMASComercial__c = userInfo.getUserId();       
        Test.startTest();
        insert l;        
        Test.stopTest();
    }
}