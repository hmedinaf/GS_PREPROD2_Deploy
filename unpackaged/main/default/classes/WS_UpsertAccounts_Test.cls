@isTest 
public class WS_UpsertAccounts_Test {
    static testMethod void Testmethod1() {
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
        Opportunity opp = new Opportunity(Name = 'Test Opportunity');
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        opp.AccountId = acc.Id;
        update opp;
        Consumo_Servicios__c CS = new Consumo_Servicios__c();
        CS.Cuenta__c = acc.id;
        CS.Nombre_del_servicio__c = 'test Nombre_del_servicio__c';
        CS.Proceso_de_Venta__c = opp.id;
        insert CS;
        WS_UpsertAccounts.AccountItem AccIt = new WS_UpsertAccounts.AccountItem();
        AccIt.ID_CLIENTE_AR = 12;
        AccIt.ID_PROCESO_AR = 12;
        AccIt.IdInterfaceCrm = CS.id;
        AccIt.MENSAJE_API = 'test';
        AccIt.RESPUESTA_API = 'test';
        List<WS_UpsertAccounts.AccountItem> CUENTAS = new list<WS_UpsertAccounts.AccountItem>();
        CUENTAS.add(AccIt);
        WS_UpsertAccounts.RequestService reqServ= new WS_UpsertAccounts.RequestService(CUENTAS);
        WS_UpsertAccounts.RequestService reqServ1= new WS_UpsertAccounts.RequestService();
        WS_UpsertAccounts.ResponseService resServ= new WS_UpsertAccounts.ResponseService();
        WS_UpsertAccounts.ResponseService resServ1= new WS_UpsertAccounts.ResponseService(CUENTAS,'test',400);
        RestRequest req = new RestRequest(); 
        req.addHeader('httpMethod', 'POST');
        req.requestUri = '/services/apexrest/RestService/Accounts/';   
        WS_UpsertAccounts.updateCuentas(reqServ);
    }
}