@isTest 
public without sharing class TaskTriggerHandler_Test {
    @testSetup
    public static void setup(){
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+528119928819'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        
        Inventario__c inventario = new Inventario__c();
        inventario.Condominio__c = 'Condominio';
        inventario.Entregada__c = 'Entregado';
        inventario.Cuenta__c = acc.Id;
        inventario.Revisiones_en_Vivienda__c = '3';
        insert inventario;
        
        acc.Vivienda_Mas_Reciente__c = inventario.Id;
        update acc;
        
        Fraccionamiento__c fracc = new Fraccionamiento__c();
        fracc.Name = 'Test';
        fracc.Jefe_Atencion_Clientes__c = UserInfo.getUserId();
        fracc.Programadora_de_Vivienda__c = UserInfo.getUserId();
        fracc.Residente1__c = UserInfo.getUserId();
        insert fracc;
        
        inventario.Fraccionamiento__c = fracc.Id;
        update inventario;
        
    }
    
    @isTest
    private static void TaskTriggerHandler(){
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+528119928819'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        
        talkdesk__Talkdesk_Activity__c tda = new talkdesk__Talkdesk_Activity__c();
        tda.Name = 'test';
        tda.talkdesk__Talkdesk_Id__c = 'test';
        insert tda;
        
        Visita__c v = new Visita__c();
        v.Fechaprogramadadevisita__c = System.today()+1;
        v.Horaprogramadadevisita__c = time.newInstance(15, 0, 0, 0);
        v.Horafindevisita__c = time.newInstance(17, 0, 0, 0);
        v.Cuenta__c = acc.id;
        insert v;
        Task task = new Task();
        task.Tipificacion_nivel_1__c = 'Entrega';
        task.Tipificacion_nivel_2__c = 'Solicita Fecha de Entrega';
        task.Telefono__c = '+528119928819';
        task.talkdesk__Talkdesk_Id__c = 'test';
        task.TD_Tiempo_Inicio_de_Llamada__c = '1608768656';
        task.OwnerId = UserInfo.getUserId();
        task.Subject = 'test subject';
        task.RecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Talkdesk').getRecordTypeId();
        insert task;
        
        List <User> adminJaver = [Select Id From User Where Name Like '%Javer%'];
        if(adminJaver != null && adminJaver.size()>0){
            task.OwnerId = adminJaver[0].Id;
        }
        task.WhatId = acc.id;
        update task;
        
        delete task;
    }
}