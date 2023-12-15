/*
----------------------------------------------------------
* Nombre: classLeadsUtils_test
* Autor Saúl González   
* Proyecto: Kavak
* Descripción : Clase con metódos test 
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           19/03/2021     Saúl González            Creación
* --------------------------------------------------------------------------------
*/
@isTest
private class LeadsUtils_test {
    @testSetup static void setup() {
        Fraccionamiento__c f = new Fraccionamiento__c();
        f.Name = 'ALVENTO';
        insert f;
        
        Lead l = new Lead();
        l.JMC_WSResponseEx__c = false;
        l.Email = 'noventa@javer.com.mx';
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
        l.JMC_AsesorAsignado__c = 'ADMINISTRADOR GENERA';
        l.JMC_ProspectadorMASComercial__c = 'LAURA VERONICA LOPEZ';
        l.LastName = 'NOVENTA';
        l.JMC_Fraccionamiento__c = f.Id;
        l.JMC_IdDelete__c = false;
        l.Phone = '528111336699';
        l.JMC_Re_Registro__c = false;
        l.FirstName = 'REGISTRO';
        /*l.MiddleName = 'SALES';*/
        l.JMC_UEN__c = 'UEN3 - JALISCO';
        l.JMC_FechaAsignacion__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.JMC_EstatusLead__c = 'Perfilado';
        insert l;        
    }
    static testMethod void getFracc(){
        Set<Integer> leadset =  new Set<Integer>();
        leadset.add(1);
        Id idOpp = [SELECT Id FROM Lead WHERE ID_CUENTA__c='1-2MAANPJ' limit 1].Id;
        String nF = [SELECT Id, Name FROM Fraccionamiento__c limit 1].Name;
        User usr = [SELECT id, name, JMC_ContadorLeads__c, JMC_FechaActividadContador__c, Id_Lead_Profiler__c FROM User Where Id =: UserInfo.getUserId()];
        usr.Id_Lead_Profiler__c = 1;
        update usr;
        Test.startTest();
        LeadsUtils_ctrl lH = new LeadsUtils_ctrl();
        LeadsUtils_ctrl.getFracc(nF);
        LeadsUtils_ctrl.getOwLead(UserInfo.getUserId());
        LeadsUtils_ctrl.getObjLead(idOpp);
        LeadsUtils_ctrl.getUsersIdSiebel(leadset);
        Test.stopTest();
    } 
    static testMethod void getObjLeadMail(){
        String email = [SELECT Id, email FROM Lead WHERE ID_CUENTA__c='1-2MAANPJ' limit 1].email;
        Test.startTest();
        LeadsUtils_ctrl lH = new LeadsUtils_ctrl();
        LeadsUtils_ctrl.getObjLeadMail(email);
        LeadsUtils_ctrl.validaDatoVacio('');
        LeadsUtils_ctrl.getDataTime('');
        LeadsUtils_ctrl.getDate('');
        LeadsUtils_ctrl.getDecimal('');
        LeadsUtils_ctrl.getDobDecimal(null);
        LeadsUtils_ctrl.getStringDec(null);
        LeadsUtils_ctrl.getDouString(null);
        LeadsUtils_ctrl.getStrToMap('');
        LeadsUtils_ctrl.getAllLabels('Account');
        LeadsUtils_ctrl.getUser(UserInfo.getName());
        LeadsUtils_ctrl.getFilteredPhone('+3216549871');
        LeadsUtils_ctrl.getNewData('','a');
        Test.stopTest();
    }
}