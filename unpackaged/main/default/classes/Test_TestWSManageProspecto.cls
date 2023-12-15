@isTest
public class Test_TestWSManageProspecto {
    static testMethod void mainCuentasUser(){
        Test.startTest();
        CuentasByUserWS c = new CuentasByUserWS();
        c.method();
        Test.stopTest();
    }
    
    static testMethod void mainGeo(){
        Test.startTest();
        geolocalizacion_ctr c = new geolocalizacion_ctr();
        c.method();
        Test.stopTest();
    }
    
    static testMethod void mainCuenta(){
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.parse('11/09/1991');
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        
    }
    static testMethod void main(){
        Test.startTest();
        Date pruebaDate = date.today();
        pruebadate.addYears(-21);
        TestWSManageProspecto javer = new TestWSManageProspecto();
        list<TestWSManageProspecto.ObjetoRespuesta> resp = new List<TestWSManageProspecto.ObjetoRespuesta>();
        TestWSManageProspecto.ObjetoRespuesta obj = new TestWSManageProspecto.ObjetoRespuesta();
        javer.requestObj = new ConsultaWS__c(
            Nombre__c = 'CLASETEST',
            Apellido_Materno__C = 'ApellidoM',
            Apellido_Paterno__C = 'ApellidoP',
            Fecha_Nacimiento__c = pruebaDate,
            NSS__c = '00000000000'
        );
        resp.add(obj);
        Javer.listResponse = resp;
        ConsultaWS__c con = new ConsultaWS__c(); insert con;
        ApexPages.StandardController controller = new ApexPages.StandardController(con);
        TestWSManageProspecto javer1 = new TestWSManageProspecto(controller);
        Javer.consultar();
        javer.method();
        javer.guardarNuevo();
        List<Account> cuentaBorrar = [SELECT Id, Name FROM Account WHERE Nombre_cta__c = 'CLASETEST'];
        if(!cuentaBorrar.isEmpty()){
            delete cuentaBorrar;    
        }
        esbJaverComManageprospecto manage2 = new esbJaverComManageprospecto();
        esbJaverComManageprospectoTypes manage3 = new esbJaverComManageprospectoTypes();
        esbJaverComCommon manage4 = new esbJaverComCommon();
        manage2.method();
        manage3.method();
        manage4.method();
        recursionCheck.canIRun();
        recursionCheck.stopRecursion();
        recursionCheck.allowTorun();
        Acentos.removeAcentos('Á'); 
        GuardarMasComercialAsync.guardar(new List<String>(), 'CLASETEST');
        Test.stopTest();
    }
}