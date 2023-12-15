@isTest
public class CLASS_PopulateNewRecords_Test {
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
            addresses.add(new Direcciones__c(Contrato__c = contract.Id, Tipo__c = 'Dirección Laboral'));
        }
        insert addresses; 
        Cesion_a_Otra_Persona_Fisica_o_Moral__c cesiOtra = new Cesion_a_Otra_Persona_Fisica_o_Moral__c();
        cesiOtra.Contrato__c = contracts[0].Id;
        insert cesiOtra;
        Test.startTest();
        CLASS_PopulateNewRecords.populaCamposContrato(opp.Id);
        CLASS_PopulateNewRecords.populaCamposDictaminacion(opp.Id);
        CLASS_PopulateNewRecords.populaCamposInformacionRep(cesiOtra.Id);
        Test.stopTest();
    }
}