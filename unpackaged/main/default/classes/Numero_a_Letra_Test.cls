@isTest
public with sharing class Numero_a_Letra_Test {
    @isTest
    static void testConversion1(){
        test.startTest();
        String n = Numero_a_Letra.convertir(3028521.20);
        test.stopTest();
        System.assertEquals(' (TRES MILLONES VEINTIOCHO MIL QUINIENTOS VEINTIUN PESOS 20/100 M.N.),', n);
    }
    @isTest
    static void testConversion2(){
        test.startTest();
        String n = Numero_a_Letra.convertir(214748364.7);
        test.stopTest();
        System.assertEquals(' (DOSCIENTOS CATORCE MILLONES SETECIENTOS CUARENTA Y OCHO MIL TRECIENTOS SESENTA Y CUATRO PESOS 70/100 M.N.),', n);
    }
    @isTest
    static void testConversion3(){
        test.startTest();
        String n = Numero_a_Letra.convertir(0);
        test.stopTest();
        System.assertEquals(' (CERO PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion4(){
        test.startTest();
        String n = Numero_a_Letra.convertir(1000120);
        test.stopTest();
        System.assertEquals(' (UN MILLON CIENTO VEINTE PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion5(){
        test.startTest();
        String n = Numero_a_Letra.convertir(1100);
        test.stopTest();
        System.assertEquals(' (MIL CIEN PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion6(){
        test.startTest();
        String n = Numero_a_Letra.convertir(222);
        test.stopTest();
        System.assertEquals(' (DOSCIENTOS VEINTIDOS PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion7(){
        test.startTest();
        String n = Numero_a_Letra.convertir(23);
        test.stopTest();
        System.assertEquals(' (VEINTITRES PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion8(){
        test.startTest();
        String n = Numero_a_Letra.convertir(24);
        test.stopTest();
        System.assertEquals(' (VEINTICUATRO PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion9(){
        test.startTest();
        String n = Numero_a_Letra.convertir(25);
        test.stopTest();
        System.assertEquals(' (VEINTICINCO PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion10(){
        test.startTest();
        String n = Numero_a_Letra.convertir(26);
        test.stopTest();
        System.assertEquals(' (VEINTISEIS PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion11(){
        test.startTest();
        String n = Numero_a_Letra.convertir(27);
        test.stopTest();
        System.assertEquals(' (VEINTISIETE PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion12(){
        test.startTest();
        String n = Numero_a_Letra.convertir(29);
        test.stopTest();
        System.assertEquals(' (VEINTINUEVE PESOS 00/100 M.N.),', n);
    }
    @isTest
    static void testConversion13(){
        test.startTest();
        String n = Numero_a_Letra.convertir(4);
        test.stopTest();
        System.assertEquals(' (CUATRO PESOS 00/100 M.N.),', n);
    }
}