@isTest(SeeAllData = true)
public class EntregasWS_Queueable_Test {
    
    static testmethod void test() {   
        LogATC__c log = new LogATC__c();
        log.FechaHora__c = Datetime.now();
        log.Metodo__c = 'ImportarEntregaWS';
        
        Map<String, Account> mapAyudaCuenta = new Map<String, Account>();
        
        Map<String, Account> rCuenta = new Map<String, Account>();
        
        Map<String, Inventario__c> rInventario = new Map<String, Inventario__c>();
        
        EntregaWS_Schedulable EM = new EntregaWS_Schedulable();
        EM.execute(null);
        
        EntregaWS_Schedulable_1Day EM1 = new EntregaWS_Schedulable_1Day();
        EM1.execute(null);
        
        EntregasWSInventario_Queueable EntregasWSInventario_Queueable = new EntregasWSInventario_Queueable(1, log, mapAyudaCuenta);
        ID jobID = System.enqueueJob(EntregasWSInventario_Queueable);
        
        EntregasWSEntregas_Queueable EntregasWSEntregas_Queueable = new EntregasWSEntregas_Queueable(1, log, rCuenta, rInventario);
        ID jobID2 = System.enqueueJob(EntregasWSEntregas_Queueable);
    }
    
}