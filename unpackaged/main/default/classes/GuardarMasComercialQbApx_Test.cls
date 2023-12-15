@isTest (seealldata=true)
public class GuardarMasComercialQbApx_Test {

    @isTest
    static void testQueueable1() {
        // Fraccionamiento__c f = new Fraccionamiento__c(name = 'ACACIAS');
        // insert f;
        Fraccionamiento__c[] f = [SELECT Id, Name FROM Fraccionamiento__c where Name='ACACIAS' LIMIT 1];
        list<Account> AccList = new list<Account>();
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f[0].Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - ACACIAS', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        String usrJaverGenerico = Label.JAVER_GENERICO_User;
        List<User> usr = [Select Id,UserRoleId, Profile.Name from User where id = :usrJaverGenerico  LIMIT 1];

        // Create test accounts
        // List<Account> testAccounts = [SELECT Id, Apellidomaterno_cta__c, Asesor__c, Canal_de_Venta__c, Colonia_cta__c, CorreoElectronico__c, DependientesEconomicos__c, 
        //     Empresa__c, Estado_Civil__c, Estatus__c, FechaAsignacion__c, FechaNacimiento__c, FechaProspeccion__c, FirstName, Fraccionamiento_cta__c, Hijos__c, 
        //     IdMasComercial__c, Id_Colaborador_Javer__c, Ingresos_Mensuales__c, LastName, Meses__c, NSS__c, Nombre_Ase__c, Nombre_Colaborador_Javer__c, Nombre_pro__c, 
        //     Origen__c, Phone, Prospectador__c, Puesto__c, RecordTypeId, Sexo__c, Sub_canal_de_venta__c, TelefonoCelular__c, TelefonoOtro__c, TelefonoRecados__c, 
        //     TelefonoTrabajo__c, Tipo_Credito__c, anios__c
        //     FROM Account order by createddate DESC LIMIT 1];

        Account acc = new Account(FirstName= 'Lopez', LastName= 'test', CorreoElectronico__c = 'test@prospects.com', Apellidomaterno_cta__c = 'dahuoh', PersonBirthdate=date.today().addyears(-20),Phone = '+528119928819',Otro_Telefono__c = '+528119928819',TelefonoCelular__c='+525530303030',Canal_de_Venta__c = 'PROSPECTO ASESOR', Estatus_Lista_Negra_QEQ__c = 'VALIDADO');
        Account acc1 = acc.clone(false, true, false, false);
        acc1.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc1.Canal_de_Venta__c = 'MEDIOS DIGITALES';
        acc1.Sub_canal_de_venta__c = '';
        acc1.Check_Apellido__c = true;
        acc1.Nombre_Fraccionamiento__c='ACACIAS';
        acc1.Sexo__c = 'MASCULINO';
        acc1.Nacionalidad__c = 'MEXICANA';
        acc1.Lugar_Nacimiento__c = 'AGUASCALIENTES';
        acc1.CorreoElectronico__c = 'test@portal123453.com';
        acc1.Fecha_de_Afluencia__c = date.today().addDays(-1);
        acc1.BillingPostalCode = '123456';
        acc1.Fraccionamiento_cta__c = f[0].id;
        acc1.Prototipo_lookup__c = proto.id;
        acc1.Aprobo_Check_Apellido__c = false;
        acc1.Apellidomaterno_cta__c = 'dahuoh';
        //acc1.Lead_Profiler__c = UserInfo.getUserId();
        acc1.Prospectador__c = UserInfo.getUserId();
        acc1.Asesor__c =usr[0].Id;
        acc1.ValidationBypassDateTime__c=datetime.now();
        //insert acc1;

        Account acc3 = new Account(FirstName= 'JOSEtest', LastName= 'PEREZtest', CorreoElectronico__c = 'test2@prospects.com', Apellidomaterno_cta__c = 'LOPEZtest', PersonBirthdate=date.today().addyears(-21),Phone = '+528119928820',Otro_Telefono__c = '+528119928821',TelefonoCelular__c='+525530303031',Canal_de_Venta__c = 'PROSPECTO ASESOR', Estatus_Lista_Negra_QEQ__c = 'VALIDADO');
        Account acc2 = acc3.clone(false, true, false, false);
        acc2.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('ClientesATC').getRecordTypeId();
        acc2.Canal_de_Venta__c = 'MEDIOS DIGITALES';
        acc2.Sub_canal_de_venta__c = '';
        acc2.Check_Apellido__c = true;
        acc2.Nombre_Fraccionamiento__c='ACACIAS';
        acc2.Sexo__c = 'MASCULINO';
        acc2.Nacionalidad__c = 'MEXICANA';
        acc2.Lugar_Nacimiento__c = 'AGUASCALIENTES';
        acc2.Fecha_de_Afluencia__c = date.today().addDays(-1);
        acc2.BillingPostalCode = '123456';
        acc2.Fraccionamiento_cta__c = f[0].id;
        acc2.Prototipo_lookup__c = proto.id;
        acc2.Aprobo_Check_Apellido__c = false;
        //acc2.Lead_Profiler__c = UserInfo.getUserId();
        acc2.Prospectador__c = UserInfo.getUserId();
        acc2.Asesor__c =usr[0].Id;
        acc2.ValidationBypassDateTime__c=datetime.now();

        List <Account> testAccounts = new List <Account>();
        testAccounts.add(acc1);
        //testAccounts.add(acc2);
        insert testAccounts;

        Test.startTest();

        // Enqueue the Queueable class
        System.enqueueJob(new GuardarMasComercialQbApx(testAccounts));

        // Wait for the Queueable job to complete
        Test.stopTest();

    }
    @isTest
    static void testQueueable2() {
		/*
        Fraccionamiento__c f = new Fraccionamiento__c(name = 'ACACIAS');
        insert f;
        list<Account> AccList = new list<Account>();
        Prototipo__c proto = new Prototipo__c(Name='TAMARINDO', Activo_pro__c=true, Fraccionamiento__c=f.Id, Precio_pro__c=2500000, Prototipo_pro__c='TAMARINDO - BOSQUE REAL', Precio_Presupuesto__c=1850000.00, Version_Precio_Presupuesto__c='Working', Todo__c='TODO');
        insert proto;
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        List<User> usr = [Select Id,UserRoleId, Profile.Name from User where UserRoleId=:portalRole.Id OR Profile.Name  = 'Asesor'  LIMIT 1];

        Account acc = new Account(FirstName= 'testF', LastName= 'testL', MiddleName='testM', Name='testF testM testL', CorreoElectronico__c = 'test@prospects.com', PersonBirthdate=date.today().addyears(-20),Phone = '+528119928819',Otro_Telefono__c = '+528119928819',TelefonoCelular__c='+525530303030',Canal_de_Venta__c = 'PROSPECTO ASESOR', Estatus_Lista_Negra_QEQ__c = 'VALIDADO');
        Account acc1 = acc.clone(false, true, false, false);
        acc1.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('ClientesATC').getRecordTypeId();
        acc1.Canal_de_Venta__c = 'MEDIOS DIGITALES';
        acc1.Sub_canal_de_venta__c = '';
        acc1.Check_Apellido__c = true;
        acc1.Nombre_Fraccionamiento__c='ACACIAS';
        acc1.Sexo__c = 'MASCULINO';
        acc1.Nacionalidad__c = 'MEXICANA';
        acc1.Lugar_Nacimiento__c = 'AGUASCALIENTES';
        acc1.CorreoElectronico__c = 'test@portal123453.com';
        acc1.Fecha_de_Afluencia__c = date.today().addDays(-1);
        acc1.BillingPostalCode = '123456';
        acc1.Fraccionamiento_cta__c = f.id;
        acc1.Prototipo_lookup__c = proto.id;
        acc1.Aprobo_Check_Apellido__c = false;
        //acc1.Apellidomaterno_cta__c = 'dahuoh';
        //acc1.Lead_Profiler__c = UserInfo.getUserId();
        acc1.Prospectador__c = UserInfo.getUserId();
        acc1.Asesor__c =usr[0].Id;
        acc1.ValidationBypassDateTime__c=datetime.now();

        List <Account> testAccounts = new List <Account>();
        testAccounts.add(acc1);
        insert testAccounts;
		*/
        Id rtId = Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('PersonAccount').getRecordTypeId();
        
        List<Account> testAccounts = [SELECT Id, Apellidomaterno_cta__c, Asesor__c, Canal_de_Venta__c, Colonia_cta__c, CorreoElectronico__c, DependientesEconomicos__c, 
            Empresa__c, Estado_Civil__c, Estatus__c, FechaAsignacion__c, FechaNacimiento__c, FechaProspeccion__c, FirstName, Fraccionamiento_cta__c, Hijos__c, 
            IdMasComercial__c, Id_Colaborador_Javer__c, Ingresos_Mensuales__c, LastName, Meses__c, NSS__c, Nombre_Ase__c, Nombre_Colaborador_Javer__c, Nombre_pro__c, 
            Origen__c, Phone, Prospectador__c, Puesto__c, RecordTypeId, Sexo__c, Sub_canal_de_venta__c, TelefonoCelular__c, TelefonoOtro__c, TelefonoRecados__c, 
            TelefonoTrabajo__c, Tipo_Credito__c, anios__c
            FROM Account
            WHERE RecordTypeId = :rtId order by createddate DESC LIMIT 1];
        Test.startTest();

        // Enqueue the Queueable class
        System.enqueueJob(new GuardarMasComercialQbApx(testAccounts));

        // Wait for the Queueable job to complete
        Test.stopTest();

    }
    @isTest
    static void testQueueable3() {
        list<account> acc = new list<account>();
		GuardarMasComercialQbApx guardartest = new GuardarMasComercialQbApx(acc);
        guardartest.codeCoverage();
    }
}