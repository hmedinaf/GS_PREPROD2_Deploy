@isTest
public with sharing class ReferenciaDePago_Test {
    @isTest
    private static void test1(){
        test.startTest();
        System.assertEquals('00001591041813161',ReferenciaDePago.generarReferencia('1-5910418131'));
        test.stopTest();
    }
    @isTest
    private static void test2(){
        test.startTest();
        System.assertEquals('00001591041800105',ReferenciaDePago.generarReferencia('1-5910418001'));
        test.stopTest();
    }
}