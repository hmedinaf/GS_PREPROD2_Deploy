@isTest
public without sharing class VisitaCitaController_Test {
    @isTest
    private static void VisitaCitaController_Test(){
        Test.startTest();

        List<Inventario__c> inventarios = TestDataFactory.createInventarios(1);
        insert inventarios;

        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventarios[0].Id;
        entrega.FechaEntrega__c = Date.today();
        insert entrega; 
        
        List<Visita__c> visitas = TestDataFactory.createVisitas(1);
        insert visitas;

        List<Casos_Residente__c> casos = TestDataFactory.createCasosATC(1);
        insert casos;

        List<Event> events = TestDataFactory.createEvents(1);
        events[0].WhatId = null;
        insert events;

        PageReference page = Page.VisitaCita;
        page.getParameters().put('caso', 'NA');
        Test.setCurrentPageReference(page);

        page.getParameters().put('e', inventarios[0].Id);
        Test.setCurrentPageReference(page);

        ApexPages.StandardController sc = new ApexPages.StandardController(visitas[0]);
        VisitaCitaController vs = new VisitaCitaController(sc);
        vs.userElegido = UserInfo.getUserId();
        vs.guardar();
        vs.cancel();

        page.getParameters().put('caso', casos[0].Id);
        Test.setCurrentPageReference(page);

        page.getParameters().put('e', inventarios[0].Id);
        Test.setCurrentPageReference(page);

        ApexPages.StandardController sc2 = new ApexPages.StandardController(visitas[0]);
        VisitaCitaController vs2 = new VisitaCitaController(sc2);
        vs.userElegido = UserInfo.getUserId();
        vs.guardar();
        vs.cancel();
        vs.entrega = new Entrega__c();
        vs.visitador = new User();
        Test.stopTest();
    }
    @isTest
    private static void VisitaCitaController_Test1(){
        Test.startTest();

        List<Inventario__c> inventarios = TestDataFactory.createInventarios(1);
        inventarios[0].PorcentajeCheckList__c = null;
        insert inventarios;
        
        List<Visita__c> visitas = TestDataFactory.createVisitas(1);
        insert visitas;

        List<Casos_Residente__c> casos = TestDataFactory.createCasosATC(1);
        insert casos;

        List<Event> events = TestDataFactory.createEvents(1);
        events[0].WhatId = null;
        insert events;

        PageReference page = Page.VisitaCita;
        page.getParameters().put('caso', 'NA');
        Test.setCurrentPageReference(page);

        page.getParameters().put('e', inventarios[0].Id);
        Test.setCurrentPageReference(page);

        ApexPages.StandardController sc = new ApexPages.StandardController(visitas[0]);
        VisitaCitaController vs = new VisitaCitaController(sc);
        vs.userElegido = UserInfo.getUserId();
        vs.guardar();
        vs.cancel();

        page.getParameters().put('caso', casos[0].Id);
        Test.setCurrentPageReference(page);

        page.getParameters().put('e', inventarios[0].Id);
        Test.setCurrentPageReference(page);

        ApexPages.StandardController sc2 = new ApexPages.StandardController(visitas[0]);
        VisitaCitaController vs2 = new VisitaCitaController(sc2);
        vs.userElegido = UserInfo.getUserId();
        vs.guardar();
        vs.cancel();
        vs.entrega = new Entrega__c();
        vs.visitador = new User();
        Test.stopTest();
    }
}