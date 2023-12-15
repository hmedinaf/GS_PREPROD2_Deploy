/*
----------------------------------------------------------
* Nombre: LeadHandler_test
* Autor Saúl González   
* Proyecto: Javer
* Descripción : Clase con metódos test 
* --------------------------------------------------------------------------------
* Versión       Fecha           Autor                   Desripción<p />
* --------------------------------------------------------------------------------
* 1.0           19/03/2021     Saúl González            Creación
* --------------------------------------------------------------------------------
*/
@isTest
private class LeadHandler_test {
    
    
     /*@description Method que ejecuta setup
    
   @testSetup static void setup() {
        Account a = new Account();
        a.PersonEmail = 'noventa@javer.com.mx';
        a.CorreoElectronico__c = 'noventa@javer.com.mx';
        a.LastName = 'NOVENTA';
        a.FirstName = 'REGISTRO';
        a.MiddleName = 'SALES';
        a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Clientes ATC').getRecordTypeId();
        insert a;
        
        
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
        //l.MiddleName = 'SALES';
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
        insert l;        
    }
    
    static testMethod void testDoPost(){
        
        List<Lead> lstLead = [SELECT Id, JMC_Analisisinterno__c, status, JMC_ValidardatosSiebel__c FROM Lead WHERE ID_CUENTA__c='1-TEST1234'];
        Map<Id, Lead> mapLead = new Map<Id, Lead>(lstLead);
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        LeadHandler_cls.valWSUpd(lstlead, lstlead, mapLead, mapLead);
        Test.stopTest();
    }   
    
    static testMethod void executeWS(){
        Id idOpp = [SELECT Id FROM Lead WHERE ID_CUENTA__c='1-TEST1234' limit 1].Id;
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        LeadHandler_cls.executeWS(idOpp);
        Test.stopTest();
    } 
    
    static testMethod void convert(){
        Lead l =  UtilsTEST_test.getObjLeadAcct('1-TEST1234');
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        LeadHandler_cls.convert(l);
        Test.stopTest();
    } 
    
    static testMethod void validMail(){
        
        Lead l =  UtilsTEST_test.getObjLeadAcct('1-TEST1234');
        List<Lead> lstLead = new List<Lead>();
        Lead newLead1 = new Lead(Email='noventa1@javer.com.mx',
                                FirstName='noventa1@javer.com.mx',
                                LastName='noventa1@javer.com.mx',
                                JMC_Analisisinterno__c='Perfilado',
                                Status='Envío MAS Comercial',
                                JMC_ProspectadorMASComercial__c = userInfo.getName());
        insert newLead1;
        lstLead.add(newLead1);
        
        Lead newLead2 = new Lead(Email='novent1a@javer.com.mx',
                                FirstName='novent1a@javer.com.mx',
                                LastName='novent1a@javer.com.mx',
                                JMC_Analisisinterno__c='Perfilado',
                                Status='Envío MAS Comercial',
                                JMC_ProspectadorMASComercial__c = userInfo.getName());
        insert newLead2;
        lstLead.add(newLead2);
        
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        LeadHandler_cls.validMail(lstLead);
        Test.stopTest();
    } 
    static testMethod void validPM(){
        Lead l =  UtilsTEST_test.getObjLeadAcct('1-TEST1234');
        List<Lead> lstLead = new List<Lead>();
        Lead newLead = new Lead(Email='noventa@javer.com.mx',
                                FirstName='noventa@javer.com.mx',
                                LastName='noventa@javer.com.mx',
                                JMC_Analisisinterno__c='Perfilado',
                                Status='Perfilamiento');
        //insert newLead;
        lstLead.add(newLead);
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        Test.stopTest();
    } 
    
    
    static testMethod void convertTwo(){
        Lead l =  UtilsTEST_test.getObjLeadAcct('1-TEST1234');
        
        List<Lead> lstLead = new List<Lead>{l};
            
        map<Id,Lead> mapLead = new map<Id,Lead>(lstLead);
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        Test.stopTest();
    } 
    
    static testMethod void sendNotInif(){
        Lead objLead =  UtilsTEST_test.getObjLeadAcct('1-TEST1234');
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        set<String> lstId = new set<String>();
        lstId.add(UserInfo.getUserId());
        LeadHandler_cls.sendNotInif(objLead, 'test', 'test', objLead.Id, lstId);
        Test.stopTest();
    } 
    
    static testMethod void sendNotDin(){
        Lead objLead =  UtilsTEST_test.getObjLeadAcct('1-TEST1234');
        Test.startTest();
        LeadHandler_cls lH = new LeadHandler_cls();
        set<String> lstId = new set<String>(); 
        lstId.add(UserInfo.getUserId());
        LeadHandler_cls.sendNotDin(objLead, 'tittle', 'body', objLead.Id, 'Respuesta_WS_Lad');
        LeadService_SOAP lS = new LeadService_SOAP();
        lH.doTest();
        Test.stopTest();
    } 
    
    static testMethod void mergeAccount(){
        
        Id ussId  =  UserInfo.getUserId();
        User usr = [SELECT id, name, JMC_ContadorLeads__c, JMC_FechaActividadContador__c, Id_Lead_Profiler__c FROM User Where Id =:ussId limit 1];
        usr.Id_Lead_Profiler__c = 1;
        update usr;
        Lead l =  UtilsTEST_test.getObjLeadAcct('1-TEST1234');
        Test.startTest();
        List<Lead> arrLeadsN = new List<Lead>();
        Set<Id> idsAct = new Set<Id>();
        
        Map<Id, Lead> adLead = new Map<Id, Lead>();
        adLead.put(l.Id,l);
        Account a = [SELECT Id, Name FROM Account Where CorreoElectronico__c = 'noventa@javer.com.mx' limit 1];
        idsAct.add(a.Id); 
        Map<String,Lead> newLeadsCon = new Map<String,Lead>();
        newLeadsCon.put(l.Email, l);
        LeadHandler_cls lH = new LeadHandler_cls();
        //lH.mergeAccount(idsAct, newLeadsCon);
        LeadHandler_cls.valLeadP(arrLeadsN, null, adLead, adLead);
        LeadHandler_cls.executeLeadProf(l.id);
        Set<Integer> intIdsSiebel = new Set<Integer>();
        intIdsSiebel.add(1);
        LeadHandler_cls.recDate(intIdsSiebel, l);
        Test.stopTest();
    }  */
    
    
}