@isTest
public class TestDataFactory {

    public static List<Account> createPersonAccounts(Integer num) {
        List<Account> newAccounts = new List<Account>();

        Id rtATC = [SELECT Id FROM RecordType WHERE Name LIKE 'Clientes ATC%' AND IsPersonType=True LIMIT 1].Id;
        
        for(Integer i=0; i<num; i++) {
            Account account = new Account();
            account.isATC__c = true;
            account.Numerodecliente__c = 'AA';
            account.Nombre_cta__c = 'TEST' + i;
            account.Apellidopaterno_cta__c = 'TEST';
            account.Apellidomaterno_cta__c = 'TEST';
            account.ProductoFinanciero__c = 'TEST';
            account.TipoCredito__c = 'BANJERCITO';
            account.CorreoElectronico__c = 'TEST@test.com';
            account.Notaria__c = 'TEST';
            account.Notario__c = 'TEST';
            account.ReferenciaBancariaCliente__c = 'TEST';
            account.FirstName = 'TEST' + i;
            /*account.MiddleName = 'TEST' + i;*/
            account.LastName = 'TEST' + i;
            account.RecordTypeId = rtATC;
            account.Phone = '+8888888888';
            newAccounts.add(account);
        }

        return newAccounts;
    }
    
    public static List<Account> createPersonAccounts1(Integer num) {
        List<Account> newAccounts = new List<Account>();
        Id idTipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
        Fraccionamiento__c f1 = new Fraccionamiento__c(name = 'ACACIAS');
        insert f1;
        for(Integer i=0; i<num; i++) {
            Account account = new Account();
            Account.TelefonoCelular__c = '+525656566567';
            Account.phone = '+525656566567';
            account.isATC__c = true;
            account.Numerodecliente__c = 'AA';
            account.Nombre_cta__c = 'TEST' + i;
            account.Apellidopaterno_cta__c = 'TEST';
            account.Apellidomaterno_cta__c = 'TEST';
            account.ProductoFinanciero__c = 'TEST';
            account.TipoCredito__c = 'BANJERCITO';
            account.CorreoElectronico__c = 'TEST@test.com';
            account.Notaria__c = 'TEST';
            account.Notario__c = 'TEST';
            account.ReferenciaBancariaCliente__c = 'TEST';
            account.FirstName = 'TEST' + i;
            /*account.MiddleName = 'TEST' + i;*/
            account.LastName = 'TEST' + i;
            account.Canal_de_Venta__c = 'MEDIOS DIGITALES';
            account.Sub_canal_de_venta__c = '';
            account.Check_Apellido__c = true;
            account.RecordTypeId = idTipoRegistroProspectoPersonaMoral;
            newAccounts.add(account);
        }

        return newAccounts;
    }

    public static List<Fraccionamiento__c> createFraccionamientos(Integer num) {
        List<Fraccionamiento__c> newFraccionamientos = new List<Fraccionamiento__c>();
        
        for(Integer i=0; i<num; i++) {
            Fraccionamiento__c fraccionamiento = new Fraccionamiento__c();
            fraccionamiento.Name = 'TEST' + i;
            fraccionamiento.Residente1__c = UserInfo.getUserId();
            newFraccionamientos.add(fraccionamiento);
        }

        return newFraccionamientos;
    }

    public static List<Inventario__c> createInventarios(Integer num) {

        List<Inventario__c> newInventarios = new List<Inventario__c>();

        List<Account> accounts = createPersonAccounts1(1);
        insert accounts;

        List<Fraccionamiento__c> fraccionamientos = createFraccionamientos(1);
        insert fraccionamientos;

        for(Integer i=0; i<num; i++) {
            Inventario__c inventario = new Inventario__c();
            inventario.Condominio__c = 'Condominio';
            inventario.Name = 'AABBCCDDEE-Prueba';
            inventario.Fracc__c = fraccionamientos[0].Id;
            inventario.Entregada__c = 'Por Entregar';
            inventario.FechaHabitabilidad__c = System.today().format();
            inventario.PorcentajeCheckList__c = 0;
            inventario.FechadeHabitabilidad__c = System.today();
            inventario.Cuenta__c = accounts[0].Id;
            inventario.Revisiones_en_Vivienda__c = '3';
            newInventarios.add(inventario);
        }

        return newInventarios;
    }

    public static List<Casos_Residente__c> createCasosATC(Integer num) {

        List<Casos_Residente__c> newCasosATC = new List<Casos_Residente__c>();

        List<Account> accounts = createPersonAccounts1(1);
        insert accounts;

        List<Inventario__c> inventarios = createInventarios(1);
        insert inventarios;
        
        for(Integer i=0; i<num; i++) {
            Casos_Residente__c caso = new Casos_Residente__c();
            caso.Detalledelreporte__c = 'asdasd';
            caso.Cuenta__c = accounts[0].Id;
            caso.ViviendaProceso__c = inventarios[0].Id;
            caso.ContactEmail__c = 'correo@prueba.com';
            caso.Origendegarantia__c = 'Producto';
            caso.ContactMobile__c = '88888888';
            caso.OwnerId = UserInfo.getUserId();
            caso.Fecha_Cierre_Cancelacion__c = System.today()-1;
            newCasosATC.add(caso);
        }

        return newCasosATC;
    }

    public static List<Visita__c> createVisitas(Integer num) {

        List<Visita__c> newVisitas = new List<Visita__c>();

        Id visitaRecordTypeId = Schema.SObjectType.Visita__c.getRecordTypeInfosByName().get('Visita').getRecordTypeId();
        
        for(Integer i=0; i<num; i++) {
            Visita__c visita = new Visita__c();
            visita.Fechaprogramadadevisita__c = System.today()+2;
            visita.Horaprogramadadevisita__c = time.newInstance(15, 0, 0, 0);
            visita.Horafindevisita__c = time.newInstance(17, 0, 0, 0);
            visita.OwnerId = UserInfo.getUserId();
            visita.RecordTypeId = visitaRecordTypeId;
            newVisitas.add(visita);
        }

        return newVisitas;
    }

    public static List<Event> createEvents(Integer num) {

        List<Event> newEvents = new List<Event>();

        List<Visita__c> visitas = createVisitas(1);
        insert visitas;
        
        for(Integer i=0; i<num; i++) {
            Event event = new Event();
            event.Subject =visitas[0].Direccion__c;
            event.Description = visitas[0].Comentarios__c;
            event.WhatId = visitas[0].Id;
            event.IsRecurrence = false;
            event.IsAllDayEvent =false;
            event.StartDateTime = Datetime.newInstanceGmt(System.today(), Time.newInstance(5, 0, 0, 0));
            event.DurationInMinutes = 45;
            event.OwnerId = UserInfo.getUserId();
            newEvents.add(event);
        }

        return newEvents;
    }
}