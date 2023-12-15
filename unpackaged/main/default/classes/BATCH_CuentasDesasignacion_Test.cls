@isTest
public class BATCH_CuentasDesasignacion_Test {
    @testSetup
    public static void setup(){
        profile p = [Select Id From Profile Where Name='System Administrator'];
        User user = new User();
        user.ProfileID = p.id;
        user.EmailEncodingKey = 'ISO-8859-1';
        user.LanguageLocaleKey = 'en_US';
        user.TimeZoneSidKey = 'America/New_York';
        user.LocaleSidKey = 'en_US';
        user.is_Data_Migration_User__c = true;
        user.FirstName = 'first';
        user.LastName = 'last';
        user.Username = 'test@portal123453.com';
        user.CommunityNickname = 'testUser123';
        user.Alias = 't1';
        user.Email = 'no@email.com';
        user.IsActive = true;
        user.FRACCIONAMIENTOS__c = 'ACACIAS;ACACIAS II';
        user.FraccionamientoAutorizados__c = 'ACACIAS';
        insert user;
        System.runAs(user){    
            Colaborador_Javer__c col = new Colaborador_Javer__c();
            insert col;
            Id idTipoRegistroProspectoPersonaFisica = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Fisica').getRecordTypeId();
            //Id idTipoRegistroProspectoPersonaMoral = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Prospecto_Persona_Moral').getRecordTypeId();
            Fraccionamiento__c f = new Fraccionamiento__c(name = 'frac');insert f;
            Fraccionamiento__c f1 = new Fraccionamiento__c(name = 'ACACIAS');insert f1;
            Account acc = new Account(Apellidomaterno_cta__c = 'materno',FirstName = 'fName',LastName = 'lName',Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES',
                                      TelefonoCelular__c = '+525656566567',phone = '+525656566567',Sub_canal_de_venta__c = 'COLABORADOR JAVER',
                                      Fraccionamiento_cta__c = f1.id,RecordTypeId = idTipoRegistroProspectoPersonaFisica);
            Account acc1 = acc.clone(false, true, false, false);
            acc1.Canal_de_Venta__c = 'MEDIOS DIGITALES';
            acc1.Sub_canal_de_venta__c = '';
            acc1.Check_Apellido__c = true;
            acc1.Fecha_Asignacion_Asesor__c = Date.today().addDays(-20);
            acc1.Fecha_Prospeccion__c = Date.today().addDays(-20);
            acc1.Fecha_LP__c = Date.today().addDays(-20);
            acc1.Fecha_Colaborador_Javer__c = Date.today().addDays(-5000);
            acc1.Colaborador_Javer__c = col.Id;
            insert acc1;
            Inventario__c inventario = new Inventario__c(Condominio__c = 'Condominio', Entregada__c = 'Entregado', Cuenta__c = acc1.Id, Revisiones_en_Vivienda__c = '3');
            insert inventario;
            acc1.Apellidomaterno_cta__c = 'test';
            acc1.Aprobo_Check_Apellido__c  = false;
            acc1.Vivienda_Mas_Reciente__c = inventario.Id;
            update acc1;
             Account acc0 = new Account(Apellidomaterno_cta__c = 'materno',FirstName = 'fName',LastName = 'lName',Canal_de_Venta__c = 'PROGRAMAS INSTITUCIONALES',
                                      TelefonoCelular__c = '+525656566568',phone = '+525656566568',Sub_canal_de_venta__c = 'COLABORADOR JAVER',
                                      Fraccionamiento_cta__c = f1.id,RecordTypeId = idTipoRegistroProspectoPersonaFisica);
            Account acc2 = acc0.clone(false, true, false, false);
            acc2.Canal_de_Venta__c = 'MEDIOS DIGITALES';
            acc2.Sub_canal_de_venta__c = '';
            acc2.Check_Apellido__c = true;
            acc2.Fecha_Asignacion_Asesor__c = Date.today().addDays(-20);
            acc2.Fecha_Prospeccion__c = Date.today().addDays(-20);
            acc2.Fecha_LP__c = Date.today().addDays(-20);
            acc2.Fecha_Colaborador_Javer__c = Date.today().addDays(-5000);
            acc2.Colaborador_Javer__c = col.Id;
            insert acc2;
        }
    }  
    @isTest
    static void testBATCHCuentasDesasignacion() {
        User u = [SELECT Id, Name FROM User WHERE LastName = 'last' LIMIT 1];
        System.runAs(u){ 
            Test.startTest();
            BATCH_CuentasDesasignacion bCD = new BATCH_CuentasDesasignacion();
            Id batchId3 = Database.executeBatch(bCD,10);
            SCHEDULE_CuentasDesasignacion sCD = new SCHEDULE_CuentasDesasignacion();
            String sch = '0 30 * * * ?';
            System.schedule('BATCH_CuentasDesasignacion', sch, sCD);
            Test.stopTest();
        }
    }
    @isTest
    static void testBATCHCuentasDesasignacion1() {
        User u = [SELECT Id, Name FROM User WHERE LastName = 'last' LIMIT 1];
        Account acc1 = [SELECT Id, Apellidomaterno_cta__c, Aprobo_Check_Apellido__c, Vivienda_Mas_Reciente__c  FROM Account WHERE LastName = 'lName' LIMIT 1];
        System.runAs(u){ 
            Inventario__c inventario = new Inventario__c(Condominio__c = 'Condominio', Entregada__c = 'Entregado', Cuenta__c = acc1.Id, Revisiones_en_Vivienda__c = '3');
            insert inventario;
            acc1.Apellidomaterno_cta__c = 'test';
            acc1.Aprobo_Check_Apellido__c  = false;
            acc1.Vivienda_Mas_Reciente__c = inventario.Id;
            update acc1;
            Test.startTest();
            BATCH_CuentasDesasignacion bCD = new BATCH_CuentasDesasignacion();
            Id batchId3 = Database.executeBatch(bCD,10);
            SCHEDULE_CuentasDesasignacion sCD = new SCHEDULE_CuentasDesasignacion();
            String sch = '0 30 * * * ?';
            System.schedule('BATCH_CuentasDesasignacion', sch, sCD);
            Test.stopTest();
        }
    }
}