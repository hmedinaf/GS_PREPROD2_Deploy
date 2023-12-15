@isTest
public class CrearVisita_Test {
    static TestMethod void testMethod1() {
        Inventario__c inventario = new Inventario__c();
        inventario.Name = 'Test Inventario';
        insert inventario;
        Casos_Residente__c caso = new Casos_Residente__c();
        caso.Clasificacion__c = 'A1. Corto circuito';
        caso.Tipo__c = 'A. Instalación eléctrica';
        Entrega__c entrega = new Entrega__c();
        entrega.Inventario__c = inventario.Id;
        entrega.FechaEntrega__c = Date.today();
        insert entrega;
        caso.ViviendaProceso__c = entrega.Inventario__c;
        insert caso;
        Visita__c v1 = new Visita__c();
        v1.Fechaprogramadadevisita__c = System.today()+1;
        v1.Horaprogramadadevisita__c = time.newInstance(15, 0, 0, 0);
        v1.Horafindevisita__c = time.newInstance(17, 0, 0, 0);        
        v1.CasoResidente__c = caso.Id;
        insert v1;
        Event ev = new Event(EndDateTime =system.today().addDays(+5) ,WhatId=caso.Id, StartDateTime =system.today().addDays(+3),Subject = 'test');
        insert ev;
        delete ev;
    }
    static TestMethod void testMethod2() {
        Event ev = new Event(EndDateTime =system.today().addDays(+5) , StartDateTime =system.today().addDays(+3),Subject = 'test');
        insert ev;
        delete ev;
    }
}