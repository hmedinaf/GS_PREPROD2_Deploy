@isTest
public class RegistrationPage_Test {
    @testSetup static void setup() {
        Fraccionamiento__c f = new Fraccionamiento__c(Name = 'ACACIAS');
        insert f;
        Account acc = new Account();
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.FirstName= 'Lopez';
        acc.LastName = 'test';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819'; 
        acc.Apellidomaterno_cta__c = 'materno';
        acc.BillingCity = 'test';
        acc.BillingState = 'test';
        acc.BillingCountry = 'test';
        acc.BillingPostalCode = '456';
        acc.BillingColony__c = 'tst';
        acc.BillingStreet = 'test';
        acc.Zona__c = '23434';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Empresa__c = 'test';
        acc.Puesto__c = 'test';
        insert acc; 
        
        Account ac = new Account();
        ac.name= 'test';
        ac.Phone = '+528119928819';
        ac.Otro_Telefono__c = '+528119928819'; 
        ac.Apellidomaterno_cta__c = 'materno';
        ac.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert ac;
        Contact con = new Contact(LastName ='testCon',AccountId = ac.Id);
        insert con; 
        
    }
    static TestMethod void Test1() { 
        Account upAcc = [select Id,Zona__c,QUOTE_Nombre_Fracc__c,PersonMobilePhone,Tipo__c,Tipo_de_Direccion__c,Sexo__c,FechaNacimiento__c,Canal_de_Venta__c,Sub_canal_de_venta__c,BillingColony__c,BillingCity,BillingState,BillingCountry,BillingStreet,NumeroExterior__c,NumeroInterior__c,
                         CorreoElectronico__c,TelefonoCelular__c,Otro_Telefono__c,Colonia_cta__c,MANAGEAPPROVALS__Active__c,FirstName,Lastname ,Name,Phone, RecordTypeName__c,Apellidomaterno_cta__c,RecordType.Name,Fraccionamiento_cta__c,Fraccionamiento_cta__r.Name ,
                         Prospectador__c,BillingPostalCode,Prospectador__r.Name,Estatus_Prospectador__c,Fecha_Prospeccion__c,Fecha_Vencimiento_Prospectador__c,Asesor__c,Asesor__r.Name,Estatus_Asesor__c,FechaAsignacion__c,Ingresos_Mensuales__c,
                         Fecha_Vencimiento_Asesor__c,Colaborador_Javer__c,Estatus_Colaborador_Javer__c, Fecha_Colaborador_Javer__c ,Fecha_Vencimiento_Colaborador_Javer__c,Empresa__c,Puesto__c,TelefonoTrabajo__c,anios__c,Meses__c,
                         NSS__c,QUOTE_Lote_Tipo__c,QUOTE_Construccion__c,QUOTE_Esquina__c,QUOTE_Terreno_Excedente__c,QUOTE_Ubicacion_Especial__c,QUOTE_Otros__c,QUOTE_Precio_de_Lista__c,QUOTE_Paquete_Descripcion__c,Estado_Civil__c,Hijos__c,
                         QUOTE_Total_Paquete__c,QUOTE_Bonificacion__c,QUOTE_Promocion__c,QUOTE_Gastos__c,Tipo_Credito__c,QUOTE_Credito_Bancario__c,QUOTE_Credito_INFONAVIT__c,QUOTE_Subcuenta__c,QUOTE_Mensualidad_Banco__c,DependientesEconomicos__c,
                         QUOTE_Mensualidad_INFONAVIT__c,QUOTE_Ingreso_Solicitado__c,Prototipo_lookup__c, Nombre__c, QUOTE_Total_Atributos__c,QUOTE_m2_Excedentes__c from Account Where FirstName= 'Lopez'];
        Date dt = Date.newInstance(2005, 02, 02);
        
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'JAVER - Generico' LIMIT 1].Id;
        UserRole userrole = [Select Id, DeveloperName From UserRole Where PortalType= 'None' Limit 1];
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserroleId = userrole.id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        Test.startTest();
        System.runAs(user){
            try  {
                RegistrationPage.createAccRecord(upAcc,'FName','ACACIAS','LastName','MName',dt,'12345678901','+525656565656','','test@mail.com','+525656565656','+525656565656','',false);
                RegistrationPage.createPrivacyRecord(true, 'test');
            }
            catch(exception e) {}   
        }
        Test.stopTest();
    }
    
    static TestMethod void Test_createAccRecordProspectator() { 
        Account upAcc = [select Id,Zona__c,QUOTE_Nombre_Fracc__c,PersonMobilePhone,Tipo__c,Tipo_de_Direccion__c,Sexo__c,FechaNacimiento__c,Canal_de_Venta__c,Sub_canal_de_venta__c,BillingColony__c,BillingCity,BillingState,BillingCountry,BillingStreet,NumeroExterior__c,NumeroInterior__c,
                         CorreoElectronico__c,TelefonoCelular__c,Otro_Telefono__c,Colonia_cta__c,MANAGEAPPROVALS__Active__c,FirstName,Lastname ,Name,Phone, RecordTypeName__c,Apellidomaterno_cta__c,RecordType.Name,Fraccionamiento_cta__c,Fraccionamiento_cta__r.Name ,
                         Prospectador__c,BillingPostalCode,Prospectador__r.Name,Estatus_Prospectador__c,Fecha_Prospeccion__c,Fecha_Vencimiento_Prospectador__c,Asesor__c,Asesor__r.Name,Estatus_Asesor__c,FechaAsignacion__c,Ingresos_Mensuales__c,
                         Fecha_Vencimiento_Asesor__c,Colaborador_Javer__c,Estatus_Colaborador_Javer__c, Fecha_Colaborador_Javer__c ,Fecha_Vencimiento_Colaborador_Javer__c,Empresa__c,Puesto__c,TelefonoTrabajo__c,anios__c,Meses__c,
                         NSS__c,QUOTE_Lote_Tipo__c,QUOTE_Construccion__c,QUOTE_Esquina__c,QUOTE_Terreno_Excedente__c,QUOTE_Ubicacion_Especial__c,QUOTE_Otros__c,QUOTE_Precio_de_Lista__c,QUOTE_Paquete_Descripcion__c,Estado_Civil__c,Hijos__c,
                         QUOTE_Total_Paquete__c,QUOTE_Bonificacion__c,QUOTE_Promocion__c,QUOTE_Gastos__c,Tipo_Credito__c,QUOTE_Credito_Bancario__c,QUOTE_Credito_INFONAVIT__c,QUOTE_Subcuenta__c,QUOTE_Mensualidad_Banco__c,DependientesEconomicos__c,
                         QUOTE_Mensualidad_INFONAVIT__c,QUOTE_Ingreso_Solicitado__c,Prototipo_lookup__c, Nombre__c, QUOTE_Total_Atributos__c,QUOTE_m2_Excedentes__c from Account Where FirstName= 'Lopez'];
        Date dt = Date.newInstance(2005, 02, 02);
        
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Prospectador' LIMIT 1].Id;
        UserRole userrole = [Select Id, DeveloperName From UserRole Where PortalType= 'None' Limit 1];
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserRoleId = userrole.Id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,ContactId =con.id,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        Test.startTest();
        System.runAs(user){
            try  {
                RegistrationPage.createAccRecord(upAcc,'FName','ACACIAS','LastName','MName',dt,'12345678901','+525656565656','','test@mail.com','+525656565656','+525656565656','',false);
                RegistrationPage.createPrivacyRecord(true, 'test');
            }
            catch(exception e) {}   
        }
        Test.stopTest();
    }
    
    static TestMethod void Test_createAccRecordCollaborator() { 
        Account upAcc = [select Id,Zona__c,QUOTE_Nombre_Fracc__c,PersonMobilePhone,Tipo__c,Tipo_de_Direccion__c,Sexo__c,FechaNacimiento__c,Canal_de_Venta__c,Sub_canal_de_venta__c,BillingColony__c,BillingCity,BillingState,BillingCountry,BillingStreet,NumeroExterior__c,NumeroInterior__c,
                         CorreoElectronico__c,TelefonoCelular__c,Otro_Telefono__c,Colonia_cta__c,MANAGEAPPROVALS__Active__c,FirstName,Lastname ,Name,Phone, RecordTypeName__c,Apellidomaterno_cta__c,RecordType.Name,Fraccionamiento_cta__c,Fraccionamiento_cta__r.Name ,
                         Prospectador__c,BillingPostalCode,Prospectador__r.Name,Estatus_Prospectador__c,Fecha_Prospeccion__c,Fecha_Vencimiento_Prospectador__c,Asesor__c,Asesor__r.Name,Estatus_Asesor__c,FechaAsignacion__c,Ingresos_Mensuales__c,
                         Fecha_Vencimiento_Asesor__c,Colaborador_Javer__c,Estatus_Colaborador_Javer__c, Fecha_Colaborador_Javer__c ,Fecha_Vencimiento_Colaborador_Javer__c,Empresa__c,Puesto__c,TelefonoTrabajo__c,anios__c,Meses__c,
                         NSS__c,QUOTE_Lote_Tipo__c,QUOTE_Construccion__c,QUOTE_Esquina__c,QUOTE_Terreno_Excedente__c,QUOTE_Ubicacion_Especial__c,QUOTE_Otros__c,QUOTE_Precio_de_Lista__c,QUOTE_Paquete_Descripcion__c,Estado_Civil__c,Hijos__c,
                         QUOTE_Total_Paquete__c,QUOTE_Bonificacion__c,QUOTE_Promocion__c,QUOTE_Gastos__c,Tipo_Credito__c,QUOTE_Credito_Bancario__c,QUOTE_Credito_INFONAVIT__c,QUOTE_Subcuenta__c,QUOTE_Mensualidad_Banco__c,DependientesEconomicos__c,
                         QUOTE_Mensualidad_INFONAVIT__c,QUOTE_Ingreso_Solicitado__c,Prototipo_lookup__c, Nombre__c, QUOTE_Total_Atributos__c,QUOTE_m2_Excedentes__c from Account Where FirstName= 'Lopez'];
        Date dt = Date.newInstance(2005, 02, 02);
        
        Contact con  = [Select Id, Name from contact where LastName = 'testCon'];
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Colaborador' LIMIT 1].Id;
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        User user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserRoleId = portalRole.Id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,ContactId =con.id,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        Test.startTest();
        System.runAs(user){
            try  {
                RegistrationPage.createAccRecord(upAcc,'FName','ACACIAS','LastName','MName',dt,'12345678901','+525656565656','','test@mail.com','+525656565656','+525656565656','',false);
                RegistrationPage.createPrivacyRecord(true, 'test');
            }
            catch(exception e) {}   
        }
        Test.stopTest();
    }    
    
    static testmethod void test2(){
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Asesor' LIMIT 1].Id;         
        Account acc = new Account();
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Company_Javer').getRecordTypeId();
        acc.name= 'Lopez S';
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819'; 
        acc.Apellidomaterno_cta__c = 'materno';
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        insert acc;
        Contact con = new Contact(LastName ='testCon',AccountId = acc.Id);
        insert con; 
        Privacy_Notice__c pn = new  Privacy_Notice__c();
        pn.Account__c = acc.Id;
        pn.Active__c = true;
        pn.Notice_Text__c = 'test ||TODAY||';
        pn.Type__c = 'Aviso de Inicio';
        insert pn;
        User user ;
        System.runAs(new User(Id = UserInfo.getUserId())) {
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
             user = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',UserRoleId = portalRole.Id,
                             localesidkey='en_US', profileid = profileId, country='United States',IsActive =true,ContactId =con.id,
                             timezonesidkey='America/Los_Angeles', username='testUserInfo@email.com',FRACCIONAMIENTOS__c = 'ACACIAS;BOSQUES DEL NEVADO',
                             Fraccionamiento_autorizado__c = 'ACACIAS', FraccionamientoAutorizados__c = 'ACACIAS');
        insert user;
        }
        System.runAs(user) {
            Test.startTest();
            RegistrationPage.createPrivacyRecord(false, 'test');
            RegistrationPage.PrivacyRecord(true,'ACACIAS');
            RegistrationPage.logoutFromSite();
            Test.stopTest();
        }
    } 
    static testmethod void test3(){
        Account upAcc = [select Id,Zona__c,QUOTE_Nombre_Fracc__c,PersonMobilePhone,Tipo__c,Tipo_de_Direccion__c,Sexo__c,FechaNacimiento__c,Canal_de_Venta__c,Sub_canal_de_venta__c,BillingColony__c,BillingCity,BillingState,BillingCountry,BillingStreet,NumeroExterior__c,NumeroInterior__c,
                         CorreoElectronico__c,TelefonoCelular__c,Otro_Telefono__c,Colonia_cta__c,MANAGEAPPROVALS__Active__c,Phone, RecordTypeName__c,Apellidomaterno_cta__c,RecordType.Name,Fraccionamiento_cta__c,Fraccionamiento_cta__r.Name ,
                         Prospectador__c,BillingPostalCode,Prospectador__r.Name,Estatus_Prospectador__c,Fecha_Prospeccion__c,Fecha_Vencimiento_Prospectador__c,Asesor__c,Asesor__r.Name,Estatus_Asesor__c,FechaAsignacion__c,Ingresos_Mensuales__c,
                         Fecha_Vencimiento_Asesor__c,Colaborador_Javer__c,Estatus_Colaborador_Javer__c, Fecha_Colaborador_Javer__c ,Fecha_Vencimiento_Colaborador_Javer__c,Empresa__c,Puesto__c,TelefonoTrabajo__c,anios__c,Meses__c,
                         NSS__c,QUOTE_Lote_Tipo__c,QUOTE_Construccion__c,QUOTE_Esquina__c,QUOTE_Terreno_Excedente__c,QUOTE_Ubicacion_Especial__c,QUOTE_Otros__c,QUOTE_Precio_de_Lista__c,QUOTE_Paquete_Descripcion__c,Estado_Civil__c,Hijos__c,
                         QUOTE_Total_Paquete__c,QUOTE_Bonificacion__c,QUOTE_Promocion__c,QUOTE_Gastos__c,Tipo_Credito__c,QUOTE_Credito_Bancario__c,QUOTE_Credito_INFONAVIT__c,QUOTE_Subcuenta__c,QUOTE_Mensualidad_Banco__c,DependientesEconomicos__c,
                         QUOTE_Mensualidad_INFONAVIT__c,QUOTE_Ingreso_Solicitado__c,Prototipo_lookup__c, Nombre__c, QUOTE_Total_Atributos__c,QUOTE_m2_Excedentes__c from Account Where FirstName= 'Lopez'];
        Fraccionamiento__c f = [Select Id, Name from Fraccionamiento__c Where Name = 'ACACIAS'];
        string fId = f.id;
        Test.startTest();
        Date dt = Date.newInstance(2005, 02, 02);
        RegistrationPage.updateAccRecord(upAcc, upAcc.Id);
        RegistrationPage.SeachProsRecords('test', 'test1', fId,'test','test', String.valueOf(dt),'23454534341');
        Test.stopTest();
    } 
    
}