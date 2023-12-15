@isTest
public class AccountProcessorTest {
    
    @testSetup 
    static void setup() {
        
    }
    
    static testmethod void test() {        
        Test.startTest();
        List<ConsultaWS__c> accounts = new List<ConsultaWS__c>();
        accounts.add(new ConsultaWS__c(Name='ROCIO PRUEBA TESTCUATRO', Nombre__c='ROCIO', Apellido_Materno__c='PRUEBA', Apellido_Paterno__c='TESTCUATRO', NSS__c='01234758694', Fecha_Nacimiento__c = Date.newInstance(1990, 12, 9)));
        Database.executeBatch(new AccountProcessor(accounts), 1);  
        Test.stopTest();
    }
    
}