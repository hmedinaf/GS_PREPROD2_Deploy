@isTest
public class TRIGGER_Dictaminacion_Test {
    @isTest
    static void testMeth() {
        List<Contract> contracts = new List<Contract>();
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
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        for (Integer i = 0; i < 5; i++) {
            contracts.add(new Contract(Name = 'Test Contract ' + i, AccountId = acc.Id, Oportunidad__c = opp.id));
        }
        insert contracts;

        List<Direcciones__c> addresses = new List<Direcciones__c>();
        for (Contract contract : contracts) {
            addresses.add(new Direcciones__c(Contrato__c = contract.Id, Tipo__c = 'Dirección Principal'));
        }
        insert addresses;
         opportunity opp1 = new opportunity();
        opp1.Name = 'Test';
        opp1.StageName = 'Validación';
        opp1.CloseDate = Date.today().adddays(10);
        insert opp1;
        Contract con = new Contract(Name = 'Test Contract ', AccountId = acc.Id, Oportunidad__c = opp1.id);
        insert con;
        List<Contract> contractsToUpdate = new List<Contract>();
        Contract contract1 = contracts[0];
        contract1.Description = 'Updated description';
        contract1.Oportunidad__c = opp1.Id;
        contractsToUpdate.add(contract1);
        
        Test.startTest();
        try{
           update contractsToUpdate; 
        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('Solo puede existir una dictaminacion por proceso de venta.') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        Test.stopTest();

        List<Contract> updatedContracts = [SELECT Id, Direccion_Empresa__c FROM Contract WHERE Id IN :contracts];
        for (Contract contract : updatedContracts) {
            System.assertNotEquals('Same value', contract.Direccion_Empresa__c);
        }
    }
    @isTest
    static void testMeth1() {
        List<Contract> contracts = new List<Contract>();
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
        opportunity opp = new opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Validación';
        opp.CloseDate = Date.today().adddays(10);
        insert opp;
        for (Integer i = 0; i < 5; i++) {
            contracts.add(new Contract(Name = 'Test Contract ' + i, AccountId = acc.Id, Oportunidad__c = opp.id));
        }
        Test.startTest();
        insert contracts;
        CLASS_Dictaminacion triggerClass = new CLASS_Dictaminacion();
        triggerClass.validaExistenciaDictaminacion(contracts);
        Test.stopTest();
    }
}