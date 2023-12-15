@isTest 
private class Javer_Util_Test {
    
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
            
            Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
            //Javer_Util_Future.updatePermissionSet(user.Id);
            PermissionSet ps = [Select Id, Name, Label, Description FROM PermissionSet WHERE Name = 'Usuario_Siebel' LIMIT 1];
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
    
    private static String generateRandomString() {
        return '' + math.rint( math.random() * 100000 );
    }
    
    private static Sistema__c CreateSistemaTest(String strName){
        
        Sistema__c Sistema = new Sistema__c();
        
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
        insert Sistema;
        return Sistema;
    }
    
    
    static testMethod void CedulaAsesor_Test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.CedulaAsesor_Test();
       test.stopTest();
    }
    
    static testMethod void CedulaAsesor_XTest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.CedulaAsesor_XTest();
       test.stopTest();
    }
    
    static testMethod void CedulaProspector_Test() {
        User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
        //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
        test.startTest();
        Javer_Util JaverUtil = new Javer_Util();
        Javer_Util.CedulaProspector_Test();
        test.stopTest();
    }
    
    static testMethod void CedulaProspector_XTest() {
        User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
        //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
        test.startTest();
        Javer_Util JaverUtil = new Javer_Util();
        Javer_Util.CedulaProspector_XTest();
        test.stopTest();
    }
    
    static testMethod void PlanComAsesor_Test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanComAsesor_Test();
       test.stopTest();
    }
    
    static testMethod void PlanComAsesor_XTest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanComAsesor_XTest();
       test.stopTest();
    }
    
    static testMethod void PlanComPrsp_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanComPrsp_test();
       test.stopTest();
    }
    
    static testMethod void PlanComPrsp_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanComPrsp_Xtest();
       test.stopTest();
    }
    
    static testMethod void PlanBonoAsesor_Test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBonoAsesor_Test();
       test.stopTest();
    }
    
    static testMethod void PlanBonoAsesor_XTest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBonoAsesor_XTest();
       test.stopTest();
    }
    
    static testMethod void PlanBonoColJaver_Test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBonoColJaver_Test();
       test.stopTest();
    }
    
    static testMethod void PlanBonoColJaver_XTest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBonoColJaver_XTest();
       test.stopTest();
    }
    
    static testMethod void PlanBonoProspectador_Test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBonoProspectador_Test();
       test.stopTest();
    }
    
    static testMethod void PlanBonoProspectador_XTest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBonoProspectador_XTest();
       test.stopTest();
    }
    
    static testMethod void PlanBono_ColJaver_Test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBono_ColJaver_Test();
       test.stopTest();
    }
    
    static testMethod void PlanBono_ColJaver_XTest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PlanBono_ColJaver_XTest();
       test.stopTest();
    }
    
    static testMethod void ExtPeriodos_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ExtPeriodos_test();
       test.stopTest();
    }
    
    static testMethod void ExtPeriodos_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ExtPeriodos_Xtest();
       test.stopTest();
    }
    
     static testMethod void BonBatch_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.BonBatch_test();
       test.stopTest();
    }
    
    static testMethod void BonBatch_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.BonBatch_Xtest();
       test.stopTest();
    }
    
    static testMethod void ListBonBatch_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListBonBatch_test();
       test.stopTest();
    }
    
    static testMethod void ListBonBatch_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListBonBatch_Xtest();
       test.stopTest();
    }
    
    static testMethod void ListFinBatch_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListFinBatch_test();
       test.stopTest();
    }
    
    static testMethod void ListFinBatch_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListFinBatch_Xtest();
       test.stopTest();
    }
    
    static testMethod void ListaPreciosBatchProds_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListaPreciosBatchProds_test();
       test.stopTest();
    }
    
    static testMethod void ListaPreciosBatchProds_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListaPreciosBatchProds_Xtest();
       test.stopTest();
    }
    
    static testMethod void ListaPreciosBatch_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListaPreciosBatch_test();
       test.stopTest();
    }
    
    static testMethod void ListaPreciosBatch_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListaPreciosBatch_Xtest();
       test.stopTest();
    }
    
    static testMethod void ListaPrecios_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListaPrecios_test();
       test.stopTest();
    }
    
    static testMethod void ListaPrecios_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ListaPrecios_Xtest();
       test.stopTest();
    }
    
    static testMethod void BonEmpPlanVta_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.BonEmpPlanVta_test();
       test.stopTest();
    }
    
    static testMethod void BonEmpPlanVta_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.BonEmpPlanVta_Xtest();
       test.stopTest();
    }
    
    static testMethod void ExcBonEmpColJaver_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ExcBonEmpColJaver_test();
       test.stopTest();
    }
    
    static testMethod void ExcBonEmpColJaver_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.ExcBonEmpColJaver_Xtest();
       test.stopTest();
    }
    
    static testMethod void BonPlanVta_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.BonPlanVta_test();
       test.stopTest();
    }
    
    static testMethod void BonPlanVta_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.BonPlanVta_Xtest();
       test.stopTest();
    }
    
    static testMethod void FinPlanVta_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinPlanVta_test();
       test.stopTest();
    }
    
    static testMethod void FinPlanVta_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinPlanVta_Xtest();
       test.stopTest();
    }
    
    static testMethod void PaqPlanVta_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PaqPlanVta_test();
       test.stopTest();
    }
    
    static testMethod void PaqPlanVta_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.PaqPlanVta_Xtest();
       test.stopTest();
    }
    
    static testMethod void VOMenPres_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.VOMenPres_test();
       test.stopTest();
    }
    
    static testMethod void VOMenPres_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.VOMenPres_Xtest();
       test.stopTest();
    }
    
    static testMethod void FinPostVta_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinPostVta_test();
       test.stopTest();
    }
    
    static testMethod void FinPostVta_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinPostVta_Xtest();
       test.stopTest();
    }
    
    static testMethod void FinPVColJaver_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinPVColJaver_test();
       test.stopTest();
    }
    
    static testMethod void FinPVColJaver_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinPVColJaver_Xtest();
       test.stopTest();
    }
    
        
    static testMethod void FinReestructuraPV_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinReestructuraPV_test();
       test.stopTest();
    }
    
    static testMethod void FinReestructuraPV_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.FinReestructuraPV_Xtest();
       test.stopTest();
    }
    
    static testMethod void Subsidio_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.Subsidio_test();
       test.stopTest();
    }
    
    static testMethod void Subsidio_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.Subsidio_Xtest();
       test.stopTest();
    }
    
    static testMethod void Garantia_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.Garantia_test();
       test.stopTest();
    }
    
    static testMethod void Garantia_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.Garantia_Xtest();
       test.stopTest();
    }
    
    static testMethod void CancEscritura_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.CancEscritura_test();
       test.stopTest();
    }
    
    static testMethod void CancEscritura_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.CancEscritura_Xtest();
       test.stopTest();
    }
    
    static testMethod void CancFormalizacion_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.CancFormalizacion_test();
       test.stopTest();
    }
    
    static testMethod void CancFormalizacion_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.CancFormalizacion_Xtest();
       test.stopTest();
    }
    
    static testMethod void GastosAdmin_test() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.GastosAdmin_test();
       test.stopTest();
    }
    
    static testMethod void GastosAdmin_Xtest() {
       User userSiebel = CreateUserTest('Force.com - A.S.Aprobador');
       //Sistema__c Sistema = CreateSistemaTest('Configuracion en Javer Util-Test');
       test.startTest();
       Javer_Util JaverUtil = new Javer_Util();
       Javer_Util.GastosAdmin_Xtest();
       test.stopTest();
    }
    
    /*
    
    
    */
    
}