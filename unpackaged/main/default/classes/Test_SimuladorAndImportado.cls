@isTest
public class Test_SimuladorAndImportado {
    static testMethod void mainNSS(){
        Test.startTest();
        NSSController simu = new NSSController();
        simu.redirect();
        Test.stopTest();
    }
    
    static testMethod void mainSimulador(){
        Test.startTest();
        SimuladorController simu = new SimuladorController();
        simu.method();
        Test.stopTest();
    }
    
    static testMethod void mainFraccionamiento(){
        Test.startTest();
        FraccionamientoWSController simu = new FraccionamientoWSController();
        esbJaverComCatfraccionamientos wsPro 
            = new esbJaverComCatfraccionamientos();
        esbJaverComCatfraccionamientosTypes fraccionamientos = new esbJaverComCatfraccionamientosTypes();
        esbJaverComCommonFraccionamiento mm = new esbJaverComCommonFraccionamiento();
        
        mm.method();
        wsPro.method();
        fraccionamientos.method();
        simu.method();
        Test.stopTest();
    }
    
     static testMethod void mainComision(){
        Test.startTest();
        ImportarComisionesWS simu = new ImportarComisionesWS();
        esbJaverComMxCommiss wsPort =  new esbJaverComMxCommiss();
        esbJaverComCommiss mm = new esbJaverComCommiss();
        
        simu.method();
        wsPort.method();
        mm.method();
        
        Test.stopTest();
    }
    
    static testMethod void mainMetas(){
        Test.startTest();
        ImportarMetasWS simu = new ImportarMetasWS();
        esbJaverComMxRptmetas wsPort =  new esbJaverComMxRptmetas();
        esbJaverComMetasMont mm1 = new esbJaverComMetasMont();
        esbJaverComMxReportsRptmetas mm2 = new esbJaverComMxReportsRptmetas();
        esbJaverComReportsMetasbycurrentmont mm3 = new esbJaverComReportsMetasbycurrentmont();
        
        wsPort.method();
        mm1.method();
        mm2.method();
        mm3.method();
        simu.method();
        
        Test.stopTest();
    }
    
    static testMethod void mainDescenso(){
        Test.startTest();
        ImportarTablaDescensoWS simu = new ImportarTablaDescensoWS();
        esbJaverComMxReportsRptdescenso mm = new esbJaverComMxReportsRptdescenso();
        esbJaverComReportsDescensoTypes mm1 = new esbJaverComReportsDescensoTypes();
        
        mm1.method();
        mm.method();
        simu.method();
        Test.stopTest();
    }


    static testMethod void mainPrototipos(){
        Test.startTest();
        ImportarPrototiposWS simu = new ImportarPrototiposWS();
        esbJaverComCatprototipos mm = new esbJaverComCatprototipos();
        esbJaverComCatprototiposTypes mm1 = new esbJaverComCatprototiposTypes();
        esbJaverComCommonPrototipos mm2 = new esbJaverComCommonPrototipos();
        
        
        simu.method();
        mm.method();
        mm1.method();
        mm2.method();
        Test.stopTest();
    }

}