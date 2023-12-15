@isTest
private class trg_AllTrg_SharePointObjs_AU_Test {
    ///////////////////////////////////////
    // Clase de prueba para probar el funcionamiento de
    // los triggers
    // 'trg_Cancelacion_AU_CambEstatus'
    //
    //
    ///////////////////////////////////////
    
    
    //Proveedor
    static testMethod void runTest_trg_Provee_AU_CambEstatus() {
        Test.startTest();
        String strName = 'Test';
        String strEstatusAprobacion = 'Aprobado';
        String strToken = '987654321';
        Proveedor__c Proveedor_new = new Proveedor__c(name=strName, Token__c=strToken  );
        try {
            insert Proveedor_new;
        } 
        catch (DmlException e) {
            //System.Debug( e.getMessage() );
            //  System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
        } //catch
        
        List <Proveedor__c> Proveedor_edit = [select id, name, Estatus__c, Token__c from Proveedor__c where name=:strName LIMIT 1];
        if(Proveedor_edit != null && Proveedor_edit.size()>0){
            Proveedor_edit[0].Estatus__c = strEstatusAprobacion;
            try { 
                update Proveedor_edit;
            } 
            catch (DmlException e) {
                //System.Debug( e.getMessage() );
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
        }
        List<Proveedor__c> list_Proveedor=[SELECT Id, Name FROM Proveedor__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
        Test.stopTest();
    }
    
    //Contrato
    static testMethod void runTest_trg_Contrato_AU_CambEstatus() {
        Test.startTest();
        String strName = 'Test';
        String strEstatusAprobacion = 'Aprobado';
        String strToken = '987654321';
        Contrato__c Contrato_new = new Contrato__c(name=strName, Token__c=strToken  );
        try { insert Contrato_new;
            } catch (DmlException e) {
                //System.Debug( e.getMessage() );
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
        
        Contrato__c Contrato_edit = [select id, name, Estatus__c, Token__c from Contrato__c where name=:strName LIMIT 1];
        Contrato_edit.Estatus__c = strEstatusAprobacion;
        try { update Contrato_edit;
            } catch (DmlException e) {
                //System.Debug( e.getMessage() );
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
        
        List<Contrato__c> list_Contrato=[SELECT Id, Name FROM Contrato__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
        System.assertEquals(1, list_Contrato.size());
        Test.stopTest();
    }
    
    //Insumo
    static testMethod void runTest_trg_Insumo_AU_CambEstatus() {
        Test.startTest();
        String strName = 'Test';
        String strEstatusAprobacion = 'Aprobado';
        String strToken = '987654321';
        Insumo__c Insumo_new = new Insumo__c(name=strName, Token__c=strToken  );
        try { insert Insumo_new;
            } catch (DmlException e) {
                //System.Debug( e.getMessage() );
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
        
        Insumo__c Insumo_edit = [select id, name, Estatus__c, Token__c from Insumo__c where name=:strName LIMIT 1];
        Insumo_edit.Estatus__c = strEstatusAprobacion;
        try { update Insumo_edit;
            } catch (DmlException e) {
                //System.Debug( e.getMessage() );
                System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION' , e.getDmlStatusCode(0) );
            } //catch
        
        List<Insumo__c> list_Insumo=[SELECT Id, Name FROM Insumo__c WHERE Name=:strName AND Estatus__c=:strEstatusAprobacion  AND Token__c=:strToken ];
        System.assertEquals(1, list_Insumo.size());
        Test.stopTest();
    }
    
}