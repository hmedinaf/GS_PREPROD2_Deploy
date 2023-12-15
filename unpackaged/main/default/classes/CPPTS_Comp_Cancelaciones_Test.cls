@isTest
public class CPPTS_Comp_Cancelaciones_Test {
    @isTest
    static void testMeth1() {
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        CPPT_Cancelacion__c canc = new CPPT_Cancelacion__c();
        canc.CPPTS_Oportunidad__c = opp.Id;
        insert canc;
        Test.startTest();
        CPPTS_Comp_Cancelaciones.obtenerBooleanos(canc.Id); 
        CPPTS_Comp_Cancelaciones.cancelaProceso(canc.Id); 
        CPPTS_Comp_Cancelaciones.calculaGasto(canc.Id);
        CPPTS_Comp_Cancelaciones.reprocesaReembolso(canc.Id);
        Test.stopTest();
    }
    @isTest
    static void testMeth2() {
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Entregado';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        Fraccionamiento__c f = new Fraccionamiento__c(name = 'test');
        insert f;
        Prototipo__c p = new Prototipo__c(name = 'test',Fraccionamiento__c = f.id);
        insert p;
        Pricebook2 pb5= new Pricebook2(name = 'test',Fraccionamiento__c = f.id,Vigente_Desde__c = system.today(),Vigente_Hasta__c= Date.newInstance(2023, 06, 30),
                                       Cantidad__c = 12, Description = 'test', Precio_Lista__c = 950000,Prototipo__c = p.id);
        insert pb5;
        CPPT_Cancelacion__c canc = new CPPT_Cancelacion__c();
        canc.CPPTS_Oportunidad__c = opp.Id;
        canc.CPPTS_Saldo_a_Cuenta__c = 600000;
        insert canc;
        Plan_de_Venta__c pdv = New Plan_de_Venta__c();
        pdv.Plazo__c = 10;
        pdv.Frecuencia__c = 'Semanal';
        pdv.Modificacion_Automatica__c = 10;
        pdv.Estatus_Plan_de_venta__c = 'En Progreso';
        pdv.Fecha_de_Vencimiento__c = system.today().addDays(1);
        pdv.Fecha_de_Inicio_de_Cobranza__c = system.today();
        pdv.Lista_de_Precios_Vivienda__c = pb5.Id;
        pdv.Oportunidad__c = opp.Id;
        insert pdv;
        Test.startTest();
        CPPTS_Comp_Cancelaciones.cancelaProceso(canc.Id); 
        CPPTS_Comp_Cancelaciones.calculaGasto(canc.Id);
        Test.stopTest();
    }
     @isTest
    static void testMeth3() {
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Reservado';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        CPPT_Cancelacion__c canc = new CPPT_Cancelacion__c();
        canc.CPPTS_Oportunidad__c = opp.Id;
        insert canc;
        Test.startTest();
        CPPTS_Comp_Cancelaciones.cancelaProceso(canc.Id); 
        CPPTS_Comp_Cancelaciones.calculaGasto(canc.Id);
        Test.stopTest();
    }
   
}