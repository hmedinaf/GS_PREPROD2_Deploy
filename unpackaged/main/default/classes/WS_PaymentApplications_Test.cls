@isTest
public class WS_PaymentApplications_Test {
    static TestMethod void testMethod1() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        WS_PaymentApplications.ApplicationItem appItem = new WS_PaymentApplications.ApplicationItem();
        appItem.CONFLICT_ID = '123';
        appItem.CREATED = system.today();	
        appItem.CREATED_BY = 'test';
        appItem.DB_LAST_UPD = system.today();	
        appItem.DB_LAST_UPD_SRC = 'test';
        appItem.FECHA_APLICACION = system.today();	
        appItem.FECHA_CONTABLE =system.today();	
        appItem.ID_APLICACION_AR  = 10;		
        appItem.ID_CLIENTE_AR = 10;		
        appItem.ID_FACTURA_AR  = 10;		
        appItem.ID_INTERFACE = 10;		
        appItem.ID_INTERFACE_CRM  = 10;		
        appItem.ID_NOTA_CRED_AR = 10;		
        appItem.ID_PROCESO_AR = 10;		
        appItem.ID_RECIBO_AR = 10;		
        appItem.IMPORTE_A_CUENTA = 10;		
        appItem.IMPORTE_ANTICIPO  = 10;		
        appItem.IMPORTE_APLICADO  = 10;		
        appItem.IMPORTE_FUNCIONAL  = 10;		
        appItem.IMPORTE_NO_APLICADO  = 10;		
        appItem.IMPORTE_NO_IDENTIFICADO = 10;		
        appItem.IMPORTE_ORIGINAL  = 10;		
        appItem.IMPORTE_RECLAMO = 10;		
        appItem.IMPORTE_RESTO  = 10;		
        appItem.LAST_UPD = System.today();
        appItem.LAST_UPD_BY = 'test';
        appItem.MENSAJE_API = 'test';
        appItem.MODIFICATION_NUM  = 10;		
        appItem.NUM_PROCESO = 'test';
        appItem.REQUISICION_CRM = 'test';
        appItem.RESPUESTA_API = 'test';
        appItem.RETRY_COUNT = 10;		
        appItem.ROW_ID = 'test';
        appItem.TIPO_APLICATION = 'test';
        WS_PaymentApplications.RequestService request1 = new WS_PaymentApplications.RequestService();
        WS_PaymentApplications.RequestService request = new WS_PaymentApplications.RequestService(new List<WS_PaymentApplications.ApplicationItem>{appItem});
        WS_PaymentApplications.RequestService request2 = new WS_PaymentApplications.RequestService(new List<WS_PaymentApplications.ApplicationItem>{});
        WS_PaymentApplications.ResponseService resp = new WS_PaymentApplications.ResponseService(new List<WS_PaymentApplications.ApplicationItem>{appItem},'mensaje',201);
        Test.startTest();
        WS_PaymentApplications.upsertApplications(request);
        
        Test.stopTest();
    }
}