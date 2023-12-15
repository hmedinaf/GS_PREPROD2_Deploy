@isTest
private class ReferenciasFamiliaresTrigger_Test {
    @isTest
    static void testTriggerLogic() {
        List<Referencia_familiar__c> references = new List<Referencia_familiar__c>();
        Account acc = new Account();
        acc.FirstName= 'Lopez';
        acc.LastName= 'test';
        acc.RecordTypeId =Schema.sObjectType.Account.getRecordTypeInfosBydevelopername().get('Prospecto_Persona_Fisica').getRecordTypeId();
        acc.CorreoElectronico__c = 'test@prospects.com';
        acc.Apellidomaterno_cta__c = 'dahuoh';
        acc.PersonBirthdate=date.today().addyears(-20);
        acc.Phone = '+528119928819';
        acc.Otro_Telefono__c = '+528119928819';
        acc.TelefonoCelular__c='+525530303030'; 
        acc.Canal_de_Venta__c = 'PROSPECTO ASESOR';
        acc.Estatus_Lista_Negra_QEQ__c = 'VALIDADO';
        insert acc;
        Contract contract = new Contract();
        contract.AccountId = acc.Id;
        insert contract;
        
        for (Integer i = 0; i < 3; i++) {
            Referencia_familiar__c reference = new Referencia_familiar__c();
            reference.Contrato__c = contract.Id;
            reference.Apellido_Paterno__c = 'test';
            reference.Apellido_Materno__c = 'Test';
            reference.Telefono_1__c = '+525530303030';
            reference.Telefono_2__c = '+528119928819'; 
            references.add(reference);
        }
        
        Test.startTest();
        insert references;
        Test.stopTest();
        
        
    }
}