@isTest
public class EncuestaTrigger_Test {
    @isTest(seeAllData=true)
    public static void testTrigger() {
        Encuesta__c enc = new Encuesta__c();
        enc.Comentarios__c = 'test';
        enc.Pregunta1__c = true;
        enc.Pregunta2__c = true;
        enc.Pregunta3__c = '';
        enc.Pregunta4__c = true;
        enc.Resultado__c = 11;
        Test.startTest();
        insert enc;
        Test.stopTest();
    }
}