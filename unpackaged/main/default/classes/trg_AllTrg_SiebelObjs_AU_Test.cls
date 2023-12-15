@isTest
private class trg_AllTrg_SiebelObjs_AU_Test {
///////////////////////////////////////
// Clase de prueba para probar el funcionamiento de
// los triggers
// 'trg_Cancelacion_AU_CambEstatus'
//
//
///////////////////////////////////////
    //Cancelacion
    static testMethod void runTest_trg_Cancelacion_AU_CambEstatus() {
        Test.startTest();
            String strName = 'Test';
            String strEstatusAprobacion = 'Aprobada';
            String strToken = '987654321';
            Cancelacion__c Cancelacion_new = new Cancelacion__c(name=strName, Token__c=strToken  );
            try { insert Cancelacion_new;
                } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch

            Cancelacion__c Cancelacion_edit = [select id, name, Estatus__c, Token__c from Cancelacion__c where name=:strName LIMIT 1];
            Cancelacion_edit.Estatus__c = strEstatusAprobacion;
            try { update Cancelacion_edit;
            } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
            
            List<Cancelacion__c> list_Cancelacion=[SELECT Id, Name FROM Cancelacion__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
            System.assertEquals(1, list_Cancelacion.size());
        Test.stopTest();
    }
    //Comision
    static testMethod void runTest_trg_Comision_AU_CambEstatus() {
        Test.startTest();
            String strName = 'Test';
            String strEstatusAprobacion = 'Aprobada';
            String strToken = '987654321';
            Comision__c Comision_new = new Comision__c(name=strName, Token__c=strToken  );
            try { insert Comision_new;
                } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch

            Comision__c Comision_edit = [select id, name, Estatus__c, Token__c from Comision__c where name=:strName LIMIT 1];
            Comision_edit.Estatus__c = strEstatusAprobacion;
            try { update Comision_edit;
            } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
            
            List<Comision__c> list_Comision=[SELECT Id, Name FROM Comision__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
            System.assertEquals(1, list_Comision.size());
        Test.stopTest();
    }
    
    //Venta
    static testMethod void runTest_trg_Venta_AU_CambEstatus() {
        Test.startTest();
            String strName = 'Test';
            String strEstatusAprobacion = 'Aprobada';
            String strToken = '987654321';
            Venta__c Venta_new = new Venta__c(name=strName, Token__c=strToken  );
            try { insert Venta_new;
                } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch

            Venta__c Venta_edit = [select id, name, Estatus__c, Token__c from Venta__c where name=:strName LIMIT 1];
            Venta_edit.Estatus__c = strEstatusAprobacion;
            try { update Venta_edit;
            } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
            
            List<Venta__c> list_Venta=[SELECT Id, Name FROM Venta__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
            System.assertEquals(1, list_Venta.size());
        Test.stopTest();
    }
    
    //Pre Venta
    static testMethod void runTest_trg_Pre_Venta_AU_CambEstatus() {
        Test.startTest();
            String strName = 'Test';
            String strEstatusAprobacion = 'Aprobada';
            String strToken = '987654321';
            Pre_Venta__c Pre_Venta_new = new Pre_Venta__c(name=strName, Token__c=strToken  );
            try { insert Pre_Venta_new;
                } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch

            Pre_Venta__c Pre_Venta_edit = [select id, name, Estatus__c, Token__c from Pre_Venta__c where name=:strName LIMIT 1];
            Pre_Venta_edit.Estatus__c = strEstatusAprobacion;
            try { update Pre_Venta_edit;
            } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
            
            List<Pre_Venta__c> list_Pre_Venta=[SELECT Id, Name FROM Pre_Venta__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
            System.assertEquals(1, list_Pre_Venta.size());
        Test.stopTest();
    }
    
    
    //Post Venta
    static testMethod void runTest_trg_Post_Venta_AU_CambEstatus() {
        Test.startTest();
            String strName = 'Test';
            String strEstatusAprobacion = 'Aprobada';
            String strToken = '987654321';
            Post_Venta__c Post_Venta_new = new Post_Venta__c(name=strName, Token__c=strToken  );
            try { insert Post_Venta_new;
                } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch

            Post_Venta__c Post_Venta_edit = [select id, name, Estatus__c, Token__c from Post_Venta__c where name=:strName LIMIT 1];
            Post_Venta_edit.Estatus__c = strEstatusAprobacion;
            try { update Post_Venta_edit;
            } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
            
            List<Post_Venta__c> list_Post_Venta=[SELECT Id, Name FROM Post_Venta__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
            System.assertEquals(1, list_Post_Venta.size());
        Test.stopTest();
    }
    
    //Planning
    static testMethod void runTest_trg_Planning_AU_CambEstatus() {
        Test.startTest();
            String strName = 'Test';
            String strEstatusAprobacion = 'Aprobado';
            String strToken = '987654321';
            Planning__c Planning_new = new Planning__c(name=strName, Token__c=strToken  );
            try { insert Planning_new;
                } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch

            Planning__c Planning_edit = [select id, name, Estatus__c, Token__c from Planning__c where name=:strName LIMIT 1];
            Planning_edit.Estatus__c = strEstatusAprobacion;
            try { update Planning_edit;
            } catch (DmlException e) {
                    //System.Debug( e.getMessage() );
                    System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
            
            List<Planning__c> list_Planning=[SELECT Id, Name FROM Planning__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
            System.assertEquals(1, list_Planning.size());
        Test.stopTest();
    }
}