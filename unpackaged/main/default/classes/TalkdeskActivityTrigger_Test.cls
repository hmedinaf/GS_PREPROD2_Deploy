@isTest 
public without sharing class TalkdeskActivityTrigger_Test {

    @testSetup
    public static void setup(){
        profile p = [Select Id From Profile Where Name='System Administrator'];
        User user = new User(ProfileID = p.id, EmailEncodingKey = 'ISO-8859-1', LanguageLocaleKey = 'en_US', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US', is_Data_Migration_User__c = true, 
                             FirstName = 'first', LastName = 'last', Username = 'test@portal123453.com', CommunityNickname = 'testUser123', Alias = 't1', Email = 'no@email.com', IsActive = true,
                             FRACCIONAMIENTOS__c = 'ACACIAS;ACACIAS II', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        System.runAs(user){    
            Id idTipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
            Fraccionamiento__c f = new Fraccionamiento__c(name = 'frac');insert f;
            Fraccionamiento__c f1 = new Fraccionamiento__c(name = 'ACACIAS');insert f1;
            Account acc = new Account(Apellidomaterno_cta__c = 'materno',FirstName = 'fName',LastName = 'lName',Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES',
                                      TelefonoOtro__c = '+123456789099', TelefonoCelular__c = '+123456789099',phone = '+123456789099',Sub_canal_de_venta__c = 'COLABORADOR JAVER',
                                      Fraccionamiento_cta__c = f1.id,RecordTypeId = idTipoRegistroProspectoPersonaFisica);
            Account acc1 = acc.clone(false, true, false, false);
            acc1.Canal_de_Venta__c = 'MEDIOS DIGITALES';
            acc1.Sub_canal_de_venta__c = '';
            acc1.Check_Apellido__c = true;
            insert acc1;
            Inventario__c inventario = new Inventario__c(Condominio__c = 'Condominio', Entregada__c = 'Entregado', Cuenta__c = acc1.Id, Revisiones_en_Vivienda__c = '3');
            insert inventario;
            Fraccionamiento__c fracc = new Fraccionamiento__c(Name = 'Test', Jefe_Atencion_Clientes__c = user.Id, Programadora_de_Vivienda__c = user.Id, Residente1__c = user.Id);
            insert fracc;
            inventario.Fraccionamiento__c = fracc.Id;
            update inventario;
            talkdesk__Talkdesk_Activity__c tda = new talkdesk__Talkdesk_Activity__c(Name = 'test', talkdesk__Contact_Phone__c = '+123456789099', talkdesk__Talkdesk_Id__c = 'tesr567');
            insert tda;
            Task task = new Task(Tipificacion_nivel_1__c = 'Entrega', Tipificacion_nivel_2__c = 'Solicita Fecha de Entrega', Telefono__c = '88888888', TD_Tiempo_Inicio_de_Llamada__c = '1608768656', OwnerId = user.Id);
            insert task;
            task.talkdesk__Talkdesk_Id__c = 'test';
            update task;
        }
    }
    @isTest
    private static void BatchLinkTalkdeskActivity(){
        user u = [SELECT Id, Name FROM User WHERE LastName = 'last' LIMIT 1];
        System.runAs(u){    
            Test.startTest();
            BatchContactPhoneUpdate BIR = new BatchContactPhoneUpdate();
            Id batchId = Database.executeBatch(BIR,200);
            Test.stopTest();
        }
    }
}