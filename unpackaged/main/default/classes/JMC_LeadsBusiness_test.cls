/*
----------------------------------------------------------
* Nombre: JMC_LeadsBusiness_test
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
private class JMC_LeadsBusiness_test {
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
        l.JMC_Fraccionamiento__c = f.Id;
        l.JMC_IdDelete__c = false;
        l.Phone = '8111336699';
        l.JMC_Re_Registro__c = false;
        l.JMC_UEN__c = 'UEN3 - JALISCO';
        l.JMC_FechaAsignacion__c = date.valueof('2021-03-19T00:00:00.000Z');
        l.JMC_EstatusLead__c = 'Perfilado';
        l.JCM_Carga_inicial__c = true;
        insert l;        
        
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.today().addyears(-20);
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+525530303030'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
        insert acc; 
    }
    static testMethod void mapConstLead(){
        Lead objLead =UtilsTEST_test.getObjLeadName('1-2MAANPJ');
        Test.startTest();
        JMC_LeadsBusiness_ctrl lH = new JMC_LeadsBusiness_ctrl();
        lH.mapConstLead(objLead);
        Test.stopTest();
    }  
    
    static testMethod void upLead(){
        Lead objLead =UtilsTEST_test.getObjLeadName('1-2MAANPJ');
        Test.startTest();
        JMC_LeadsBusiness_ctrl lH = new JMC_LeadsBusiness_ctrl();
        Map<String, Object> mapObj = new Map<String, Object>();
        mapObj.put('numeroProceso','123');
        mapObj.put('rowId','1-2M9SAMA');
        mapObj.put('createdDateMC','');
        mapObj.put('createdByMC','');
        mapObj.put('lastUPD','');
        mapObj.put('lastUPDBy','');
        mapObj.put('modificationNum','');
        mapObj.put('conflictId','');
        mapObj.put('dBLastUPD','');
        mapObj.put('fechaNac','1990-03-09');
        mapObj.put('fechaNacRecom','');
        mapObj.put('idCliente','');
        mapObj.put('accountRating','');
        mapObj.put('aceptoPoliticas','');
        mapObj.put('apellidoMaterno','AP');
        mapObj.put('apellidoPaterno','AP');
        mapObj.put('asesor','GUSTAVO ARECHAVALETA VILLARREAL');
        mapObj.put('asunto','');
        mapObj.put('canalVenta','Medios Digitales');
        mapObj.put('capacidadCompra','');
        mapObj.put('comentarios','');
        mapObj.put('createdByELQ','');
        mapObj.put('estado','');
        mapObj.put('estatus','');
        mapObj.put('estatusCliente','Afluente');
        mapObj.put('estatusProceso','PRUEBA PROCESO23');
        mapObj.put('fraccionamiento','');
        mapObj.put('fraccRecom','');
        mapObj.put('fuente','');
        mapObj.put('genero','Masculino');
        mapObj.put('leadProfiler','');
        mapObj.put('linkdIn','');
        mapObj.put('location','');
        mapObj.put('mailLead','PRUEBA100@JAVERPR.COM.MX');
        mapObj.put('mailRecom','');
        mapObj.put('nombre','');
        mapObj.put('nombreCompleto','');
        mapObj.put('nombreRecom','');
        mapObj.put('nss','32165498714');
        mapObj.put('nssRecom','');
        mapObj.put('perfilado','');
        mapObj.put('phone','+528111336699');
        mapObj.put('sblAccntId','1-2M9SZI7');
        mapObj.put('sistemaOrigen','SIEBEL');
        mapObj.put('subCanal','Facebook');
        mapObj.put('telefono','9654853215');
        mapObj.put('telRecom','');
        mapObj.put('tieneInfonavit','');
        mapObj.put('tipoCredito','SHF/BANCO');
        mapObj.put('tipoIpWarning','');
        mapObj.put('twitterHandle','');
        mapObj.put('twitterId','');
        mapObj.put('twitterProfURL','');
        mapObj.put('uen','');
        mapObj.put('checkSum','');
        mapObj.put('fechaAfluencia','2021-03-18');
        mapObj.put('fechaVisita','2021-03-18');
        mapObj.put('fraccProcANT','2021-03-18');
        mapObj.put('estatusCita','');
        mapObj.put('fechaCita','2021-03-18');
        mapObj.put('fechaEntrega','2021-03-18');
        mapObj.put('fechaHabilidad','2021-03-18');
        mapObj.put('lote','s');
        mapObj.put('manzana','s');
        mapObj.put('numeroCliente','TEST1234');
        mapObj.put('numeroInterior','2');
        mapObj.put('unidadPrivativa','');
        mapObj.put('fechaCancelacion','2021-03-18');
        mapObj.put('fechaEscrituracion','2021-03-18');
        mapObj.put('fraccionProceso','');
        mapObj.put('statusTransaction','');
        mapObj.put('msgResponse','');
        mapObj.put('createdBy','');
        mapObj.put('idSF','');
        mapObj.put('lastModifiedById','');
        mapObj.put('edad','');
        mapObj.put('fechaReserva','TEST1234');
        mapObj.put('fechaFormalizacion','TEST1234');
        string jsonString = JSON.serialize(mapObj);
        System.debug(jsonString);
        lH.upLead(JSON.serialize(mapObj));
        Test.stopTest();
    }  
    static testMethod void leadBot(){    
        Lead objLead =UtilsTEST_test.getObjLeadName('1-2MAANPJ');
        Test.startTest();
        JMC_LeadsBusiness_ctrl lH = new JMC_LeadsBusiness_ctrl();
        Map<String, Object> mapObj = new Map<String, Object>();
        mapObj.put('numeroProceso','123');
        mapObj.put('email','PRUEBA100@JAVERPR.COM.MX');
        mapObj.put('firstName','AP');
        /*mapObj.put('middleName','AP');*/
        mapObj.put('lastName','AP');
        mapObj.put('rowId','1-2MAANPJ');
        mapObj.put('phone','8111336699');
        mapObj.put('fraccionamiento','');
        mapObj.put('fechaNacimiento','1990-03-09');
        mapObj.put('tipoCredito','SHF/BANCO');
        mapObj.put('nss','32165498714');
        mapObj.put('curp','');
        mapObj.put('fuente','');
        mapObj.put('canal','');
        mapObj.put('subCanalVenta','');
        mapObj.put('presupuestoCompra','');
        mapObj.put('analisisInterno','');
        mapObj.put('comentarios','');
        mapObj.put('capacidadCompra','');
        mapObj.put('leadProfiler','');
        string jsonString = JSON.serialize(mapObj);
        System.debug(jsonString);
        lH.leadBot(JSON.serialize(mapObj));
        Test.stopTest();
    }  
    static testMethod void sendCalloutREST(){
        Lead objLead =UtilsTEST_test.getObjLeadName('1-2MAANPJ');
        Test.startTest();
        JMC_LeadsBusiness_ctrl lH = new JMC_LeadsBusiness_ctrl();
        lH.sendCalloutREST(objLead.Id);
        LeadsBusiness_ctrl lb = new LeadsBusiness_ctrl();
        lb.mapConstLead(objLead.Id);
        Test.stopTest();
    }  
}