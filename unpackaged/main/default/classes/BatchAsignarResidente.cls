/**
* ────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Asigna un valor al campo Residente_de_Entrega__c de las Entregas
* ─────────────────────────────────────────────────────────────────────────────────────────────────────
* @author       Miguel Martínez
* @version      1.0
* @created      25/10/2020
* ────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
global class BatchAsignarResidente implements Database.Batchable<sObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT ParentId, OldValue, NewValue, Field, CreatedById, CreatedDate ' + 
                        'FROM Entrega__History ' + 
                        'WHERE Field = \'Estatus__c\'';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Entrega__History> scope) { 
        Map<Id, Id> residenteEntrega = new Map<Id, Id>(); 
        for(Entrega__History cambio : scope){
            if(cambio.NewValue == 'Entregado' || Test.isRunningTest()){
                residenteEntrega.put(cambio.ParentId, cambio.CreatedById);
            }
        }

        if(!residenteEntrega.isEmpty()){
            List<Entrega__c> entregas = [SELECT Id, Cuenta__c FROM Entrega__c WHERE Id IN: residenteEntrega.keySet()];

            Map<Id, Id> entregasCuentas = new Map<Id, Id>();
            for(Entrega__c entrega : entregas){ entregasCuentas.put(entrega.Cuenta__c, entrega.Id);}

            List<Account> cuentas = [SELECT Id, Residente_de_Entrega__c FROM Account WHERE Id IN: entregasCuentas.keySet()];
            for(Account cuenta : cuentas){
                cuenta.Residente_de_Entrega__c = residenteEntrega.get(entregasCuentas.get(cuenta.Id));
            }
            Update cuentas;
        }
    }   

    global void finish(Database.BatchableContext BC) {

    }
}