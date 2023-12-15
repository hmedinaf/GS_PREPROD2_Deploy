@isTest 
public class Javer_ShPn_Util_Test {
    
    private static User CreateUserTest(String strProfile){
        Profile prof = [SELECT Id FROM Profile WHERE Name=:strProfile];
        User user = new User();
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            user.FirstName = 'Test';
            user.LastName = 'Name';
            user.CompanyName = 'IT Test Company';
            user.MobilePhone = '123-456-7890';
            user.EmpId1__c = '1-TEST';
            user.UserSharePoint__c = 'test';
            user.Username = 'testUser-' + generateRandomString() + '@test.com';
            user.Email = 'testUser-' + generateRandomString() + '@test.com';
            user.Alias = 'test';
            user.CommunityNickname = 'test1';
            user.TimeZoneSidKey = 'America/New_York';
            user.LocaleSidKey = 'en_US';
            user.EmailEncodingKey = 'UTF-8';
            user.ProfileId = prof.Id;
            user.LanguageLocaleKey = 'en_US';
            
            user.Street = '123 Test St';
            user.City = 'Testcity';
            user.State = 'va';
            user.PostalCode = '23223';
            user.Country = 'USA';
            try{ 
                insert user;
            
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.insert(newCatch,false);
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); } } 
            } //catch
            
            Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer ShPn Util-Test');
            //Javer_Util_Future.updatePermissionSet(user.Id);
            PermissionSet ps = [Select Id, Name, Label, Description FROM PermissionSet WHERE Name = 'Usuario_SharePoint' LIMIT 1];
            PermissionSetAssignment psa = new PermissionSetAssignment();
            psa.AssigneeId = user.Id;
            psa.PermissionSetId = ps.Id;
            try{ 
                insert psa;  
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.insert(newCatch,false);System.Debug('*** newCatch *** '+newCatch);
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); System.Debug('*** newCatch *** '+newCatch);} } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); System.Debug('*** newCatch *** '+newCatch);} } 
            } //catch
        }
        return user;
    }
    
    private static Sistema__c CreateSistemaTest(String strName){
        
        Sistema__c Sistema = new Sistema__c();
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        //System.runAs (thisUser) {
            Sistema.Name = strName;
            Sistema.Correo_Recep_XML_Asunto__c = 'Asunto';
            Sistema.Correo_Recep_XML_Direcciones__c = 'example@example.com';
            Sistema.Correo_Recep_XML_Mensaje__c = 'Mensaje';
            Sistema.End_Point__c = 'https://endpoint.example.com/url_wrapper';
            Sistema.End_Point_Descripcion__c = 'Direccion de EndPoint de Prueba';
            Sistema.Limpieza_de_Aprob_Agendada__c = false;
            Sistema.Limpieza_Job_Id__c = '';
            Sistema.Limpieza_Recurrencia__c ='0 41 18 * * ?';
            Sistema.Max_antiguedad_sin_resolucion__c =1;
            try{ 
                insert Sistema;  
            } catch(DmlException e) { System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPION' , e.getDmlStatusCode(0) );  String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('DmlException').getRecordTypeId(); Catch__c newCatch = new Catch__c(); newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = String.ValueOf(e.getDmlType(0)); newCatch.descripcion__c = e.getDmlMessage(0); newCatch.Campo__c = e.getDmlFieldNames(0)[0]; Database.insert(newCatch,false);System.Debug('*** newCatch *** '+newCatch);
            } catch(SObjectException e) { System.debug('SObjectException caught: ' + e.getMessage()); if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); System.Debug('*** newCatch *** '+newCatch);} } 
            } catch (Exception e) { if (e!=null){ if (e.getMessage()!=null){ Catch__c newCatch = new Catch__c(); String rtCatch = Schema.SObjectType.Catch__c.getRecordTypeInfosByName().get('Exception').getRecordTypeId(); String strCause; if (e.getCause()!=null){ Exception ExceptionCause =  e.getCause();strCause = ExceptionCause.getMessage();} newCatch.Causa__c = strCause; newCatch.RecordTypeId = rtCatch; newCatch.Tipo__c = e.getTypeName(); newCatch.descripcion__c = e.getMessage(); newCatch.Numero_de_Linea__c = e.getLineNumber(); newCatch.StackTrace__c = e.getStackTraceString(); Database.insert(newCatch,false); System.Debug('*** newCatch *** '+newCatch);} } 
            } //catch
            
        //}
        
        return Sistema;
    }
    
    private static String generateRandomString() {
        return '' + math.rint( math.random() * 100000 );
    }
    
    
    
    static testMethod void Proveedores_test() {
       
       User userSharePoint = CreateUserTest('Force.com - A.S.Aprobador');
       
       //System.Debug('*** Sistema *** '+Sistema);
       test.startTest();
       
       Javer_ShPn_Util JaverShPnUtil = new Javer_ShPn_Util();
       Javer_ShPn_Util.Proveedores_test();
       test.stopTest();
    }
    
    static testMethod void Proveedores_Xtest() {
       User userSharePoint = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer ShPn Util-Test');
       //System.Debug('*** Sistema *** '+Sistema);
        test.startTest();
       Javer_ShPn_Util JaverShPnUtil = new Javer_ShPn_Util();
       Javer_ShPn_Util.Proveedores_testX();
       test.stopTest();
    }
    
    static testMethod void Contrato_test() {
       User userSharePoint = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer ShPn Util-Test');
       test.startTest();
       Javer_ShPn_Util JaverShPnUtil = new Javer_ShPn_Util();
       Javer_ShPn_Util.Contrato_test();
       test.stopTest();
    }
    
    static testMethod void Contrato_testX() {
       User userSharePoint = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer ShPn Util-Test');
       test.startTest();
       Javer_ShPn_Util JaverShPnUtil = new Javer_ShPn_Util();
       Javer_ShPn_Util.Contrato_testX();
       test.stopTest();
    }
    
    static testMethod void Insumo_test() {
       User userSharePoint = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer ShPn Util-Test');
       test.startTest();
       Javer_ShPn_Util JaverShPnUtil = new Javer_ShPn_Util();
       Javer_ShPn_Util.Insumo_test();
       test.stopTest();
    }
    
    static testMethod void Insumo_testX() {
       User userSharePoint = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer ShPn Util-Test');
       test.startTest();
       Javer_ShPn_Util JaverShPnUtil = new Javer_ShPn_Util();
       Javer_ShPn_Util.Insumo_testX();
       test.stopTest();
    }
    
}