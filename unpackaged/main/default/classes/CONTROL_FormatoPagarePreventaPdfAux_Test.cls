@isTest
public with sharing class CONTROL_FormatoPagarePreventaPdfAux_Test {
    @isTest
    static void test1(){
        CONTROL_FormatoPagarePreventaPdfAux aux = New CONTROL_FormatoPagarePreventaPdfAux('2022 11 0002', 6423.00,'15/11/2022');
        // System.assertEquals('2022 11 0002',aux.numero);
        // System.assertEquals('$6,423.00',aux.importe);
        // System.assertEquals('15/11/2022',aux.fecha);
    }
}