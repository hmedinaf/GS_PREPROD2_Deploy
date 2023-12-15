@isTest
public class Test_ActualizarEstatusProcesoATC {
    static testMethod void test(){
        
        
        
        
        Test.startTest();
        
        Inventario__c inv = new Inventario__c();
        inv.ControlE__c=true;
        insert inv;
        Entrega__c entrega = new Entrega__c();
        entrega.inventario__r = inv;
        entrega.Estatus__c = 'Entregado';
        entrega.Name = 'Prueba';
        entrega.FechaEscritura__c = Date.today();
        entrega.FechaEntrega__c = Date.today();
        
        insert entrega;
        
        SchedulableContext sc = null;
        ActualizarEstatusProcesoATCSchedule tsc = new ActualizarEstatusProcesoATCSchedule();
        tsc.execute(sc);
        Test.stopTest();
    }

}