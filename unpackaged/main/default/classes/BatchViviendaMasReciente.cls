/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Asigna un valor al campo ViviendaMasReciente__c de las Cuentas
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      15/10/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
global class BatchViviendaMasReciente implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {

        String query = 'SELECT Id, Cuenta__c FROM Inventario__c WHERE Cuenta__c != null';

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Inventario__c> scope) {  
        Map<Id, Id> cuentasInventarios = new Map<Id, Id>();
        for(Inventario__c inventario : scope){ cuentasInventarios.put(inventario.Cuenta__c, inventario.Id);}

        List<Account> cuentas = [SELECT Id, Vivienda_Mas_Reciente__c FROM Account WHERE Id IN: cuentasInventarios.keySet()];
        for(Account cuenta : cuentas){ cuenta.Vivienda_Mas_Reciente__c = cuentasInventarios.get(cuenta.Id); }
        update cuentas;

    }   

    global void finish(Database.BatchableContext BC) {

    }
}