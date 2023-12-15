@isTest
public class BatchViviendaMasReciente_Test {
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
                                      TelefonoCelular__c = '+525656566567',phone = '+525656566567',Sub_canal_de_venta__c = 'COLABORADOR JAVER',
                                      Fraccionamiento_cta__c = f1.id,RecordTypeId = idTipoRegistroProspectoPersonaFisica);
            Account acc1 = acc.clone(false, true, false, false);
            acc1.Canal_de_Venta__c = 'MEDIOS DIGITALES';
            acc1.Sub_canal_de_venta__c = '';
            acc1.Check_Apellido__c = true;
            insert acc1;
            Inventario__c inventario = new Inventario__c(Condominio__c = 'Condominio', Entregada__c = 'Entregado', Cuenta__c = acc1.Id, Revisiones_en_Vivienda__c = '3');
            insert inventario;
            acc1.Apellidomaterno_cta__c = 'test';
            acc1.Aprobo_Check_Apellido__c  = false;
            acc1.Vivienda_Mas_Reciente__c = inventario.Id;
            update acc1;
        }
    }
    @isTest
    private static void BatchViviendaMasReciente(){
        user u = [SELECT Id, Name FROM User WHERE LastName = 'last' LIMIT 1];
        System.runAs(u){    
            Test.startTest();
            BatchViviendaMasReciente BVMR = new BatchViviendaMasReciente();
            Id batchId3 = Database.executeBatch(BVMR,10);
            Test.stopTest();
        }
    }
}